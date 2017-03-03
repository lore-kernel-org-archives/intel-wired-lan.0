From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 3 Mar 2017 13:31:04 -0800
Subject: [Intel-wired-lan] [net-next PATCH v3 2/3] ixgbe: add support
	for XDP_TX action
In-Reply-To: <20170303175724.25015.78151.stgit@john-Precision-Tower-5810>
References: <20170303175526.25015.12183.stgit@john-Precision-Tower-5810>
 <20170303175724.25015.78151.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0UdgfdaXfE_e4FQq0TtDmySP7WwjP2wJN5uBeod_0p1MWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 3, 2017 at 9:57 AM, John Fastabend <john.fastabend@gmail.com> wrote:
> Add support for XDP_TX action.
>
> A couple design choices were made here. First I use a new ring
> pointer structure xdp_ring[] in the adapter struct instead of
> pushing the newly allocated xdp TX rings into the tx_ring[]
> structure. This means we have to duplicate loops around rings
> in places we want to initialize both TX rings and XDP rings.
> But by making it explicit it is obvious when we are using XDP
> rings and when we are using TX rings. Further we don't have
> to do ring arithmatic which is error prone. As a proof point
> for doing this my first patches used only a single ring structure
> and introduced bugs in FCoE code and macvlan code paths.
>
> Second I am aware this is not the most optimized version of
> this code possible. I want to get baseline support in using
> the most readable format possible and then once this series
> is included I will optimize the TX path in another series
> of patches.

Any performance numbers to go with this patch?  I'm just kind of curious.

Anyway comments included inline down below.  Mostly at this point it
looks like there is just some cruft we can clean out of the code to
make it a bit more coherent.

> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   18 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   25 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   87 ++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  295 +++++++++++++++++++---
>  4 files changed, 372 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 6eaf506..5551639 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -190,7 +190,10 @@ struct vf_macvlans {
>  struct ixgbe_tx_buffer {
>         union ixgbe_adv_tx_desc *next_to_watch;
>         unsigned long time_stamp;
> -       struct sk_buff *skb;
> +       union {
> +               struct sk_buff *skb;
> +               void *data; /* XDP uses addr ptr on irq_clean */

You should probably put the comment on the line above *data.

> +       };
>         unsigned int bytecount;
>         unsigned short gso_segs;
>         __be16 protocol;
> @@ -243,6 +246,7 @@ enum ixgbe_ring_state_t {
>         __IXGBE_TX_XPS_INIT_DONE,
>         __IXGBE_TX_DETECT_HANG,
>         __IXGBE_HANG_CHECK_ARMED,
> +       __IXGBE_TX_XDP_RING,
>  };
>
>  #define ring_uses_build_skb(ring) \
> @@ -269,6 +273,12 @@ struct ixgbe_fwd_adapter {
>         set_bit(__IXGBE_RX_RSC_ENABLED, &(ring)->state)
>  #define clear_ring_rsc_enabled(ring) \
>         clear_bit(__IXGBE_RX_RSC_ENABLED, &(ring)->state)
> +#define ring_is_xdp(ring) \
> +       test_bit(__IXGBE_TX_XDP_RING, &(ring)->state)
> +#define set_ring_xdp(ring) \
> +       set_bit(__IXGBE_TX_XDP_RING, &(ring)->state)
> +#define clear_ring_xdp(ring) \
> +       clear_bit(__IXGBE_TX_XDP_RING, &(ring)->state)
>  struct ixgbe_ring {
>         struct ixgbe_ring *next;        /* pointer to next ring in q_vector */
>         struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
> @@ -335,6 +345,7 @@ enum ixgbe_ring_f_enum {
>  #define IXGBE_MAX_FCOE_INDICES         8
>  #define MAX_RX_QUEUES                  (IXGBE_MAX_FDIR_INDICES + 1)
>  #define MAX_TX_QUEUES                  (IXGBE_MAX_FDIR_INDICES + 1)
> +#define MAX_XDP_QUEUES                 (IXGBE_MAX_FDIR_INDICES + 1)
>  #define IXGBE_MAX_L2A_QUEUES           4
>  #define IXGBE_BAD_L2A_QUEUE            3
>  #define IXGBE_MAX_MACVLANS             31
> @@ -578,6 +589,10 @@ struct ixgbe_adapter {
>         __be16 vxlan_port;
>         __be16 geneve_port;
>
> +       /* XDP */
> +       int num_xdp_queues;
> +       struct ixgbe_ring *xdp_ring[MAX_XDP_QUEUES];
> +
>         /* TX */
>         struct ixgbe_ring *tx_ring[MAX_TX_QUEUES] ____cacheline_aligned_in_smp;
>
> @@ -624,6 +639,7 @@ struct ixgbe_adapter {
>
>         u64 tx_busy;
>         unsigned int tx_ring_count;
> +       unsigned int xdp_ring_count;
>         unsigned int rx_ring_count;
>
>         u32 link_speed;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index cf955e69..dc1e2f7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1057,15 +1057,19 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
>         if (!netif_running(adapter->netdev)) {
>                 for (i = 0; i < adapter->num_tx_queues; i++)
>                         adapter->tx_ring[i]->count = new_tx_count;
> +               for (i = 0; i < adapter->num_xdp_queues; i++)
> +                       adapter->xdp_ring[i]->count = new_tx_count;
>                 for (i = 0; i < adapter->num_rx_queues; i++)
>                         adapter->rx_ring[i]->count = new_rx_count;
>                 adapter->tx_ring_count = new_tx_count;
> +               adapter->xdp_ring_count = new_tx_count;
>                 adapter->rx_ring_count = new_rx_count;
>                 goto clear_reset;
>         }
>
>         /* allocate temporary buffer to store rings in */
>         i = max_t(int, adapter->num_tx_queues, adapter->num_rx_queues);
> +       i = max_t(int, i, adapter->num_xdp_queues);
>         temp_ring = vmalloc(i * sizeof(struct ixgbe_ring));
>
>         if (!temp_ring) {
> @@ -1097,12 +1101,33 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
>                         }
>                 }
>
> +               for (i = 0; i < adapter->num_xdp_queues; i++) {
> +                       memcpy(&temp_ring[i], adapter->xdp_ring[i],
> +                              sizeof(struct ixgbe_ring));
> +
> +                       temp_ring[i].count = new_tx_count;
> +                       err = ixgbe_setup_tx_resources(&temp_ring[i]);
> +                       if (err) {
> +                               while (i) {
> +                                       i--;
> +                                       ixgbe_free_tx_resources(&temp_ring[i]);
> +                               }
> +                               goto err_setup;
> +                       }
> +               }
> +
>                 for (i = 0; i < adapter->num_tx_queues; i++) {
>                         ixgbe_free_tx_resources(adapter->tx_ring[i]);
>
>                         memcpy(adapter->tx_ring[i], &temp_ring[i],
>                                sizeof(struct ixgbe_ring));
>                 }
> +               for (i = 0; i < adapter->num_xdp_queues; i++) {
> +                       ixgbe_free_tx_resources(adapter->xdp_ring[i]);
> +
> +                       memcpy(adapter->xdp_ring[i], &temp_ring[i],
> +                              sizeof(struct ixgbe_ring));
> +               }
>
>                 adapter->tx_ring_count = new_tx_count;
>         }
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> index 1b8be7d..cfaa23c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> @@ -73,6 +73,11 @@ static bool ixgbe_cache_ring_dcb_sriov(struct ixgbe_adapter *adapter)
>                         reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
>                 adapter->tx_ring[i]->reg_idx = reg_idx;
>         }
> +       for (i = 0; i < adapter->num_xdp_queues; i++, reg_idx++) {
> +               if ((reg_idx & ~vmdq->mask) >= tcs)
> +                       reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
> +               adapter->xdp_ring[i]->reg_idx = reg_idx;
> +       }
>
>  #ifdef IXGBE_FCOE
>         /* nothing to do if FCoE is disabled */
> @@ -248,6 +253,12 @@ static bool ixgbe_cache_ring_sriov(struct ixgbe_adapter *adapter)
>                 adapter->tx_ring[i]->reg_idx = reg_idx;
>         }
>
> +       for (i = 0; i < adapter->num_xdp_queues; i++, reg_idx++) {
> +               if ((reg_idx & rss->mask) >= rss->indices)
> +                       reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
> +               adapter->xdp_ring[i]->reg_idx = reg_idx;
> +       }
> +
>  #ifdef IXGBE_FCOE
>         /* FCoE uses a linear block of queues so just assigning 1:1 */
>         for (; i < adapter->num_tx_queues; i++, reg_idx++)

If you don't support DCB or SR-IOV then you probably don't need the
code above.  It can probably just be dropped.

> @@ -267,12 +278,14 @@ static bool ixgbe_cache_ring_sriov(struct ixgbe_adapter *adapter)
>   **/
>  static bool ixgbe_cache_ring_rss(struct ixgbe_adapter *adapter)
>  {
> -       int i;
> +       int i, reg_idx;
>
>         for (i = 0; i < adapter->num_rx_queues; i++)
>                 adapter->rx_ring[i]->reg_idx = i;
> -       for (i = 0; i < adapter->num_tx_queues; i++)
> -               adapter->tx_ring[i]->reg_idx = i;
> +       for (i = 0, reg_idx = 0; i < adapter->num_tx_queues; i++, reg_idx++)
> +               adapter->tx_ring[i]->reg_idx = reg_idx;
> +       for (i = 0; i < adapter->num_xdp_queues; i++, reg_idx++)
> +               adapter->xdp_ring[i]->reg_idx = reg_idx;
>
>         return true;
>  }
> @@ -308,6 +321,14 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
>         ixgbe_cache_ring_rss(adapter);
>  }
>
> +static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
> +{
> +       if (nr_cpu_ids > MAX_XDP_QUEUES)
> +               return 0;
> +
> +       return adapter->xdp_prog ? nr_cpu_ids : 0;
> +}
> +
>  #define IXGBE_RSS_64Q_MASK     0x3F
>  #define IXGBE_RSS_16Q_MASK     0xF
>  #define IXGBE_RSS_8Q_MASK      0x7
> @@ -382,6 +403,7 @@ static bool ixgbe_set_dcb_sriov_queues(struct ixgbe_adapter *adapter)
>         adapter->num_rx_queues_per_pool = tcs;
>
>         adapter->num_tx_queues = vmdq_i * tcs;
> +       adapter->num_xdp_queues = 0;
>         adapter->num_rx_queues = vmdq_i * tcs;
>
>  #ifdef IXGBE_FCOE
> @@ -479,6 +501,7 @@ static bool ixgbe_set_dcb_queues(struct ixgbe_adapter *adapter)
>                 netdev_set_tc_queue(dev, i, rss_i, rss_i * i);
>
>         adapter->num_tx_queues = rss_i * tcs;
> +       adapter->num_xdp_queues = 0;
>         adapter->num_rx_queues = rss_i * tcs;
>
>         return true;
> @@ -549,6 +572,7 @@ static bool ixgbe_set_sriov_queues(struct ixgbe_adapter *adapter)
>
>         adapter->num_rx_queues = vmdq_i * rss_i;
>         adapter->num_tx_queues = vmdq_i * rss_i;
> +       adapter->num_xdp_queues = 0;
>
>         /* disable ATR as it is not supported when VMDq is enabled */
>         adapter->flags &= ~IXGBE_FLAG_FDIR_HASH_CAPABLE;
> @@ -669,6 +693,7 @@ static bool ixgbe_set_rss_queues(struct ixgbe_adapter *adapter)
>  #endif /* IXGBE_FCOE */
>         adapter->num_rx_queues = rss_i;
>         adapter->num_tx_queues = rss_i;
> +       adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
>
>         return true;
>  }
> @@ -689,6 +714,7 @@ static void ixgbe_set_num_queues(struct ixgbe_adapter *adapter)
>         /* Start with base case */
>         adapter->num_rx_queues = 1;
>         adapter->num_tx_queues = 1;
> +       adapter->num_xdp_queues = 0;
>         adapter->num_rx_pools = adapter->num_rx_queues;
>         adapter->num_rx_queues_per_pool = 1;
>
> @@ -719,8 +745,11 @@ static int ixgbe_acquire_msix_vectors(struct ixgbe_adapter *adapter)
>         struct ixgbe_hw *hw = &adapter->hw;
>         int i, vectors, vector_threshold;
>
> -       /* We start by asking for one vector per queue pair */
> +       /* We start by asking for one vector per queue pair with XDP queues
> +        * being stacked with TX queues.
> +        */
>         vectors = max(adapter->num_rx_queues, adapter->num_tx_queues);
> +       vectors = max(vectors, adapter->num_xdp_queues);
>
>         /* It is easy to be greedy for MSI-X vectors. However, it really
>          * doesn't do much good if we have a lot more vectors than CPUs. We'll
> @@ -800,6 +829,8 @@ static void ixgbe_add_ring(struct ixgbe_ring *ring,
>   * @v_idx: index of vector in adapter struct
>   * @txr_count: total number of Tx rings to allocate
>   * @txr_idx: index of first Tx ring to allocate
> + * @xdp_count: total number of XDP rings to allocate
> + * @xdp_idx: index of first XDP ring to allocate
>   * @rxr_count: total number of Rx rings to allocate
>   * @rxr_idx: index of first Rx ring to allocate
>   *
> @@ -808,6 +839,7 @@ static void ixgbe_add_ring(struct ixgbe_ring *ring,
>  static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
>                                 int v_count, int v_idx,
>                                 int txr_count, int txr_idx,
> +                               int xdp_count, int xdp_idx,
>                                 int rxr_count, int rxr_idx)
>  {
>         struct ixgbe_q_vector *q_vector;
> @@ -909,6 +941,33 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
>                 ring++;
>         }
>
> +       while (xdp_count) {
> +               /* assign generic ring traits */
> +               ring->dev = &adapter->pdev->dev;
> +               ring->netdev = adapter->netdev;
> +
> +               /* configure backlink on ring */
> +               ring->q_vector = q_vector;
> +
> +               /* update q_vector Tx values */
> +               ixgbe_add_ring(ring, &q_vector->tx);
> +
> +               /* apply Tx specific ring traits */
> +               ring->count = adapter->tx_ring_count;
> +               ring->queue_index = xdp_idx;
> +               set_ring_xdp(ring);
> +
> +               /* assign ring to adapter */
> +               adapter->xdp_ring[xdp_idx] = ring;
> +
> +               /* update count and index */
> +               xdp_count--;
> +               xdp_idx += v_count;
> +
> +               /* push pointer to next ring */
> +               ring++;
> +       }
> +
>         while (rxr_count) {
>                 /* assign generic ring traits */
>                 ring->dev = &adapter->pdev->dev;
> @@ -1002,17 +1061,18 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
>         int q_vectors = adapter->num_q_vectors;
>         int rxr_remaining = adapter->num_rx_queues;
>         int txr_remaining = adapter->num_tx_queues;
> -       int rxr_idx = 0, txr_idx = 0, v_idx = 0;
> +       int xdp_remaining = adapter->num_xdp_queues;
> +       int rxr_idx = 0, txr_idx = 0, xdp_idx = 0, v_idx = 0;
>         int err;
>
>         /* only one q_vector if MSI-X is disabled. */
>         if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED))
>                 q_vectors = 1;
>
> -       if (q_vectors >= (rxr_remaining + txr_remaining)) {
> +       if (q_vectors >= (rxr_remaining + txr_remaining + xdp_remaining)) {
>                 for (; rxr_remaining; v_idx++) {
>                         err = ixgbe_alloc_q_vector(adapter, q_vectors, v_idx,
> -                                                  0, 0, 1, rxr_idx);
> +                                                  0, 0, 0, 0, 1, rxr_idx);
>
>                         if (err)
>                                 goto err_out;
> @@ -1026,8 +1086,11 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
>         for (; v_idx < q_vectors; v_idx++) {
>                 int rqpv = DIV_ROUND_UP(rxr_remaining, q_vectors - v_idx);
>                 int tqpv = DIV_ROUND_UP(txr_remaining, q_vectors - v_idx);
> +               int xqpv = DIV_ROUND_UP(xdp_remaining, q_vectors - v_idx);
> +
>                 err = ixgbe_alloc_q_vector(adapter, q_vectors, v_idx,
>                                            tqpv, txr_idx,
> +                                          xqpv, xdp_idx,
>                                            rqpv, rxr_idx);
>
>                 if (err)
> @@ -1036,14 +1099,17 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
>                 /* update counts and index */
>                 rxr_remaining -= rqpv;
>                 txr_remaining -= tqpv;
> +               xdp_remaining -= xqpv;
>                 rxr_idx++;
>                 txr_idx++;
> +               xdp_idx++;
>         }
>
>         return 0;
>
>  err_out:
>         adapter->num_tx_queues = 0;
> +       adapter->num_xdp_queues = 0;
>         adapter->num_rx_queues = 0;
>         adapter->num_q_vectors = 0;
>
> @@ -1066,6 +1132,7 @@ static void ixgbe_free_q_vectors(struct ixgbe_adapter *adapter)
>         int v_idx = adapter->num_q_vectors;
>
>         adapter->num_tx_queues = 0;
> +       adapter->num_xdp_queues = 0;
>         adapter->num_rx_queues = 0;
>         adapter->num_q_vectors = 0;
>
> @@ -1172,9 +1239,10 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter)
>
>         ixgbe_cache_ring_register(adapter);
>
> -       e_dev_info("Multiqueue %s: Rx Queue count = %u, Tx Queue count = %u\n",
> +       e_dev_info("Multiqueue %s: Rx Queue count = %u, Tx Queue count = %u XDP Queue count = %u\n",
>                    (adapter->num_rx_queues > 1) ? "Enabled" : "Disabled",
> -                  adapter->num_rx_queues, adapter->num_tx_queues);
> +                  adapter->num_rx_queues, adapter->num_tx_queues,
> +                  adapter->num_xdp_queues);
>
>         set_bit(__IXGBE_DOWN, &adapter->state);
>
> @@ -1195,6 +1263,7 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter)
>  void ixgbe_clear_interrupt_scheme(struct ixgbe_adapter *adapter)
>  {
>         adapter->num_tx_queues = 0;
> +       adapter->num_xdp_queues = 0;
>         adapter->num_rx_queues = 0;
>
>         ixgbe_free_q_vectors(adapter);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 0a569e6..fa37d48 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -594,6 +594,19 @@ static void ixgbe_regdump(struct ixgbe_hw *hw, struct ixgbe_reg_info *reginfo)
>
>  }
>
> +static void ixgbe_print_buffer(struct ixgbe_ring *ring, int n)
> +{
> +       struct ixgbe_tx_buffer *tx_buffer;
> +
> +       tx_buffer = &ring->tx_buffer_info[ring->next_to_clean];
> +       pr_info(" %5d %5X %5X %016llX %08X %p %016llX\n",
> +                  n, ring->next_to_use, ring->next_to_clean,
> +                  (u64)dma_unmap_addr(tx_buffer, dma),
> +                  dma_unmap_len(tx_buffer, len),
> +                  tx_buffer->next_to_watch,
> +                  (u64)tx_buffer->time_stamp);
> +}
> +
>  /*
>   * ixgbe_dump - Print registers, tx-rings and rx-rings
>   */
> @@ -603,7 +616,7 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
>         struct ixgbe_hw *hw = &adapter->hw;
>         struct ixgbe_reg_info *reginfo;
>         int n = 0;
> -       struct ixgbe_ring *tx_ring;
> +       struct ixgbe_ring *ring;
>         struct ixgbe_tx_buffer *tx_buffer;
>         union ixgbe_adv_tx_desc *tx_desc;
>         struct my_u0 { u64 a; u64 b; } *u0;
> @@ -644,14 +657,13 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
>                 "Queue [NTU] [NTC] [bi(ntc)->dma  ]",
>                 "leng", "ntw", "timestamp");
>         for (n = 0; n < adapter->num_tx_queues; n++) {
> -               tx_ring = adapter->tx_ring[n];
> -               tx_buffer = &tx_ring->tx_buffer_info[tx_ring->next_to_clean];
> -               pr_info(" %5d %5X %5X %016llX %08X %p %016llX\n",
> -                          n, tx_ring->next_to_use, tx_ring->next_to_clean,
> -                          (u64)dma_unmap_addr(tx_buffer, dma),
> -                          dma_unmap_len(tx_buffer, len),
> -                          tx_buffer->next_to_watch,
> -                          (u64)tx_buffer->time_stamp);
> +               ring = adapter->tx_ring[n];
> +               ixgbe_print_buffer(ring, n);
> +       }
> +
> +       for (n = 0; n < adapter->num_xdp_queues; n++) {
> +               ring = adapter->xdp_ring[n];
> +               ixgbe_print_buffer(ring, n);
>         }
>
>         /* Print TX Rings */
> @@ -696,28 +708,28 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
>          */
>
>         for (n = 0; n < adapter->num_tx_queues; n++) {
> -               tx_ring = adapter->tx_ring[n];
> +               ring = adapter->tx_ring[n];
>                 pr_info("------------------------------------\n");
> -               pr_info("TX QUEUE INDEX = %d\n", tx_ring->queue_index);
> +               pr_info("TX QUEUE INDEX = %d\n", ring->queue_index);
>                 pr_info("------------------------------------\n");
>                 pr_info("%s%s    %s              %s        %s          %s\n",
>                         "T [desc]     [address 63:0  ] ",
>                         "[PlPOIdStDDt Ln] [bi->dma       ] ",
>                         "leng", "ntw", "timestamp", "bi->skb");
>
> -               for (i = 0; tx_ring->desc && (i < tx_ring->count); i++) {
> -                       tx_desc = IXGBE_TX_DESC(tx_ring, i);
> -                       tx_buffer = &tx_ring->tx_buffer_info[i];
> +               for (i = 0; ring->desc && (i < ring->count); i++) {
> +                       tx_desc = IXGBE_TX_DESC(ring, i);
> +                       tx_buffer = &ring->tx_buffer_info[i];
>                         u0 = (struct my_u0 *)tx_desc;
>                         if (dma_unmap_len(tx_buffer, len) > 0) {
>                                 const char *ring_desc;
>
> -                               if (i == tx_ring->next_to_use &&
> -                                   i == tx_ring->next_to_clean)
> +                               if (i == ring->next_to_use &&
> +                                   i == ring->next_to_clean)
>                                         ring_desc = " NTC/U";
> -                               else if (i == tx_ring->next_to_use)
> +                               else if (i == ring->next_to_use)
>                                         ring_desc = " NTU";
> -                               else if (i == tx_ring->next_to_clean)
> +                               else if (i == ring->next_to_clean)
>                                         ring_desc = " NTC";
>                                 else
>                                         ring_desc = "";
> @@ -987,6 +999,10 @@ static void ixgbe_update_xoff_rx_lfc(struct ixgbe_adapter *adapter)
>         for (i = 0; i < adapter->num_tx_queues; i++)
>                 clear_bit(__IXGBE_HANG_CHECK_ARMED,
>                           &adapter->tx_ring[i]->state);
> +
> +       for (i = 0; i < adapter->num_xdp_queues; i++)
> +               clear_bit(__IXGBE_HANG_CHECK_ARMED,
> +                         &adapter->xdp_ring[i]->state);
>  }
>
>  static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
> @@ -1031,6 +1047,14 @@ static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
>                 if (xoff[tc])
>                         clear_bit(__IXGBE_HANG_CHECK_ARMED, &tx_ring->state);
>         }
> +
> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
> +               struct ixgbe_ring *xdp_ring = adapter->xdp_ring[i];
> +
> +               tc = xdp_ring->dcb_tc;
> +               if (xoff[tc])
> +                       clear_bit(__IXGBE_HANG_CHECK_ARMED, &xdp_ring->state);
> +       }
>  }
>
>  static u64 ixgbe_get_tx_completed(struct ixgbe_ring *ring)
> @@ -1182,7 +1206,10 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>                 total_packets += tx_buffer->gso_segs;
>
>                 /* free the skb */
> -               napi_consume_skb(tx_buffer->skb, napi_budget);
> +               if (ring_is_xdp(tx_ring))
> +                       page_frag_free(tx_buffer->data);
> +               else
> +                       napi_consume_skb(tx_buffer->skb, napi_budget);
>
>                 /* unmap skb header data */
>                 dma_unmap_single(tx_ring->dev,
> @@ -1243,7 +1270,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>         if (check_for_tx_hang(tx_ring) && ixgbe_check_tx_hang(tx_ring)) {
>                 /* schedule immediate reset if we believe we hung */
>                 struct ixgbe_hw *hw = &adapter->hw;
> -               e_err(drv, "Detected Tx Unit Hang\n"
> +               e_err(drv, "Detected Tx Unit Hang %s\n"
>                         "  Tx Queue             <%d>\n"
>                         "  TDH, TDT             <%x>, <%x>\n"
>                         "  next_to_use          <%x>\n"
> @@ -1251,13 +1278,16 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>                         "tx_buffer_info[next_to_clean]\n"
>                         "  time_stamp           <%lx>\n"
>                         "  jiffies              <%lx>\n",
> +                       ring_is_xdp(tx_ring) ? "(XDP)" : "",
>                         tx_ring->queue_index,
>                         IXGBE_READ_REG(hw, IXGBE_TDH(tx_ring->reg_idx)),
>                         IXGBE_READ_REG(hw, IXGBE_TDT(tx_ring->reg_idx)),
>                         tx_ring->next_to_use, i,
>                         tx_ring->tx_buffer_info[i].time_stamp, jiffies);
>
> -               netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
> +               if (!ring_is_xdp(tx_ring))
> +                       netif_stop_subqueue(tx_ring->netdev,
> +                                           tx_ring->queue_index);
>
>                 e_info(probe,
>                        "tx hang %d detected on queue %d, resetting adapter\n",
> @@ -1270,6 +1300,9 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>                 return true;
>         }
>
> +       if (ring_is_xdp(tx_ring))
> +               return !!budget;
> +
>         netdev_tx_completed_queue(txring_txq(tx_ring),
>                                   total_packets, total_bytes);
>
> @@ -2170,8 +2203,13 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>
>  #define IXGBE_XDP_PASS 0
>  #define IXGBE_XDP_CONSUMED 1
> +#define IXGBE_XDP_TX 2
>
> -static struct sk_buff *ixgbe_run_xdp(struct ixgbe_ring  *rx_ring,
> +static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
> +                              struct xdp_buff *xdp);
> +
> +static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
> +                                    struct ixgbe_ring  *rx_ring,
>                                      struct ixgbe_rx_buffer *rx_buffer,
>                                      unsigned int size)
>  {
> @@ -2195,10 +2233,23 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_ring  *rx_ring,
>         act = bpf_prog_run_xdp(xdp_prog, &xdp);
>         switch (act) {
>         case XDP_PASS:
> -               goto xdp_out;
> +               break;
> +       case XDP_TX:
> +               result = ixgbe_xmit_xdp_ring(adapter, &xdp);
> +               if (result == IXGBE_XDP_TX) {
> +#if (PAGE_SIZE < 8192)
> +                       rx_buffer->page_offset ^= ixgbe_rx_pg_size(rx_ring) / 2;
> +#else
> +                       rx_buffer->page_offset += ring_uses_build_skb(rx_ring) ?
> +                                       SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) :
> +                                       SKB_DATA_ALIGN(size);
> +#endif
> +               } else {
> +                       rx_buffer->pagecnt_bias++; /* give page back */
> +               }
> +               break;
>         default:
>                 bpf_warn_invalid_xdp_action(act);
> -       case XDP_TX:
>         case XDP_ABORTED:
>                 trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
>                 /* fallthrough -- handle aborts by dropping packet */
> @@ -2230,8 +2281,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                                const int budget)
>  {
>         unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> -#ifdef IXGBE_FCOE
>         struct ixgbe_adapter *adapter = q_vector->adapter;
> +#ifdef IXGBE_FCOE
>         int ddp_bytes;
>         unsigned int mss = 0;
>  #endif /* IXGBE_FCOE */
> @@ -2262,7 +2313,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>
>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>
> -               skb = ixgbe_run_xdp(rx_ring, rx_buffer, size);
> +               skb = ixgbe_run_xdp(adapter, rx_ring, rx_buffer, size);
>                 if (IS_ERR(skb)) { /* XDP consumed buffer */
>                         total_rx_packets++;
>                         total_rx_bytes += size;
> @@ -3435,6 +3486,8 @@ static void ixgbe_configure_tx(struct ixgbe_adapter *adapter)
>         /* Setup the HW Tx Head and Tail descriptor pointers */
>         for (i = 0; i < adapter->num_tx_queues; i++)
>                 ixgbe_configure_tx_ring(adapter, adapter->tx_ring[i]);
> +       for (i = 0; i < adapter->num_xdp_queues; i++)
> +               ixgbe_configure_tx_ring(adapter, adapter->xdp_ring[i]);
>  }
>
>  static void ixgbe_enable_rx_drop(struct ixgbe_adapter *adapter,
> @@ -5604,7 +5657,8 @@ static void ixgbe_clean_tx_ring(struct ixgbe_ring *tx_ring)
>         }
>
>         /* reset BQL for queue */
> -       netdev_tx_reset_queue(txring_txq(tx_ring));
> +       if (!ring_is_xdp(tx_ring))
> +               netdev_tx_reset_queue(txring_txq(tx_ring));
>
>         /* reset next_to_use and next_to_clean */
>         tx_ring->next_to_use = 0;
> @@ -5633,6 +5687,8 @@ static void ixgbe_clean_all_tx_rings(struct ixgbe_adapter *adapter)
>
>         for (i = 0; i < adapter->num_tx_queues; i++)
>                 ixgbe_clean_tx_ring(adapter->tx_ring[i]);
> +       for (i = 0; i < adapter->num_xdp_queues; i++)
> +               ixgbe_clean_tx_ring(adapter->xdp_ring[i]);
>  }
>
>  static void ixgbe_fdir_filter_exit(struct ixgbe_adapter *adapter)
> @@ -5727,6 +5783,11 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
>                 u8 reg_idx = adapter->tx_ring[i]->reg_idx;
>                 IXGBE_WRITE_REG(hw, IXGBE_TXDCTL(reg_idx), IXGBE_TXDCTL_SWFLSH);
>         }
> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
> +               u8 reg_idx = adapter->xdp_ring[i]->reg_idx;
> +
> +               IXGBE_WRITE_REG(hw, IXGBE_TXDCTL(reg_idx), IXGBE_TXDCTL_SWFLSH);
> +       }
>
>         /* Disable the Tx DMA engine on 82599 and later MAC */
>         switch (hw->mac.type) {
> @@ -6095,7 +6156,7 @@ int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
>   **/
>  static int ixgbe_setup_all_tx_resources(struct ixgbe_adapter *adapter)
>  {
> -       int i, err = 0;
> +       int i, j = 0, err = 0;
>
>         for (i = 0; i < adapter->num_tx_queues; i++) {
>                 err = ixgbe_setup_tx_resources(adapter->tx_ring[i]);
> @@ -6105,10 +6166,21 @@ static int ixgbe_setup_all_tx_resources(struct ixgbe_adapter *adapter)
>                 e_err(probe, "Allocation for Tx Queue %u failed\n", i);
>                 goto err_setup_tx;
>         }
> +       for (j = 0; j < adapter->num_xdp_queues; j++) {
> +               err = ixgbe_setup_tx_resources(adapter->xdp_ring[j]);
> +               if (!err)
> +                       continue;
> +
> +               e_err(probe, "Allocation for Tx Queue %u failed\n", j);
> +               goto err_setup_tx;
> +       }
> +
>
>         return 0;
>  err_setup_tx:
>         /* rewind the index freeing the rings as we go */
> +       while (j--)
> +               ixgbe_free_tx_resources(adapter->xdp_ring[j]);
>         while (i--)
>                 ixgbe_free_tx_resources(adapter->tx_ring[i]);
>         return err;
> @@ -6240,6 +6312,9 @@ static void ixgbe_free_all_tx_resources(struct ixgbe_adapter *adapter)
>         for (i = 0; i < adapter->num_tx_queues; i++)
>                 if (adapter->tx_ring[i]->desc)
>                         ixgbe_free_tx_resources(adapter->tx_ring[i]);
> +       for (i = 0; i < adapter->num_xdp_queues; i++)
> +               if (adapter->xdp_ring[i]->desc)
> +                       ixgbe_free_tx_resources(adapter->xdp_ring[i]);
>  }
>
>  /**
> @@ -6659,6 +6734,14 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
>                 bytes += tx_ring->stats.bytes;
>                 packets += tx_ring->stats.packets;
>         }
> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
> +               struct ixgbe_ring *xdp_ring = adapter->xdp_ring[i];
> +
> +               restart_queue += xdp_ring->tx_stats.restart_queue;
> +               tx_busy += xdp_ring->tx_stats.tx_busy;
> +               bytes += xdp_ring->stats.bytes;
> +               packets += xdp_ring->stats.packets;
> +       }
>         adapter->restart_queue = restart_queue;
>         adapter->tx_busy = tx_busy;
>         netdev->stats.tx_bytes = bytes;
> @@ -6852,6 +6935,9 @@ static void ixgbe_fdir_reinit_subtask(struct ixgbe_adapter *adapter)
>                 for (i = 0; i < adapter->num_tx_queues; i++)
>                         set_bit(__IXGBE_TX_FDIR_INIT_DONE,
>                                 &(adapter->tx_ring[i]->state));
> +               for (i = 0; i < adapter->num_xdp_queues; i++)
> +                       set_bit(__IXGBE_TX_FDIR_INIT_DONE,
> +                               &adapter->xdp_ring[i]->state);
>                 /* re-enable flow director interrupts */
>                 IXGBE_WRITE_REG(hw, IXGBE_EIMS, IXGBE_EIMS_FLOW_DIR);
>         } else {
> @@ -6885,6 +6971,8 @@ static void ixgbe_check_hang_subtask(struct ixgbe_adapter *adapter)
>         if (netif_carrier_ok(adapter->netdev)) {
>                 for (i = 0; i < adapter->num_tx_queues; i++)
>                         set_check_for_tx_hang(adapter->tx_ring[i]);
> +               for (i = 0; i < adapter->num_xdp_queues; i++)
> +                       set_check_for_tx_hang(adapter->xdp_ring[i]);
>         }
>
>         if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED)) {
> @@ -7115,6 +7203,13 @@ static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
>                         return true;
>         }
>
> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
> +               struct ixgbe_ring *ring = adapter->xdp_ring[i];
> +
> +               if (ring->next_to_use != ring->next_to_clean)
> +                       return true;
> +       }
> +
>         return false;
>  }
>
> @@ -8075,6 +8170,85 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
>  #endif
>  }
>
> +static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
> +                              struct xdp_buff *xdp)
> +{
> +       struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
> +       struct ixgbe_tx_buffer *tx_buffer;
> +       union ixgbe_adv_tx_desc *tx_desc;
> +       u32 len, tx_flags = 0;
> +       dma_addr_t dma;
> +       u16 count, i;
> +       u32 cmd_type;
> +
> +       len = xdp->data_end - xdp->data;
> +       count = TXD_USE_COUNT(len);
> +

So you have the count, what do you plan to do with it?  I think this
is supposed to be for some form of flow control.  You might want to
add a check that compares count to ixgbe_desc_unused and returns a
notification to consume the buffer if we cannot transmit it.

> +       /* record the location of the first descriptor for this packet */
> +       tx_buffer = &ring->tx_buffer_info[ring->next_to_use];
> +       tx_buffer->skb = NULL;

This line isn't needed since it is tx_buffer->data and you populated
it down below.

> +       tx_buffer->bytecount = len;
> +       tx_buffer->gso_segs = 1;
> +       tx_buffer->protocol = 0;
> +
> +       tx_buffer->tx_flags = tx_flags;

You probably don't need to populate tx_flags or protocol for now.  The
should be initialized to 0 and will stay that way for the life of the
ring.

> +       i = ring->next_to_use;
> +       tx_desc = IXGBE_TX_DESC(ring, i);
> +
> +       dma = dma_map_single(ring->dev, xdp->data, len, DMA_TO_DEVICE);
> +       if (dma_mapping_error(ring->dev, dma))
> +               goto dma_error;

You might want to move this up to the same point where you were doing
the count check.  That way all your failure paths are taken care of
early.

> +       dma_unmap_len_set(tx_buffer, len, len);
> +       dma_unmap_addr_set(tx_buffer, dma, dma);
> +       tx_buffer->data = xdp->data;
> +       tx_desc->read.buffer_addr = cpu_to_le64(dma);
> +
> +       /* put descriptor type bits */
> +       cmd_type = IXGBE_ADVTXD_DTYP_DATA |
> +                  IXGBE_ADVTXD_DCMD_DEXT |
> +                  IXGBE_ADVTXD_DCMD_IFCS;
> +       cmd_type |= len | IXGBE_TXD_CMD;
> +       tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +       tx_desc->read.olinfo_status =
> +               cpu_to_le32(len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> +
> +#ifdef CONFIG_PCI_IOV
> +       if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) {
> +               tx_desc->read.olinfo_status |= IXGBE_ADVTXD_CC;
> +               ixgbe_tx_ctxtdesc(tx_ring, ETH_HLEN, 0, 0, 0);
> +       }
> +#endif

If we don't support SR-IOV then this code can be dropped for now.
Really to make better use of the Tx ring if we did support SR-IOV you
could make the ixgbe_tx_ctxtdesc call a part of the Tx ring
initialization.  That way you would start with the context descriptor
populated and only need the 1 for the entire life of the ring.

> +       /* Force memory writes to complete before letting h/w know there
> +        * are new descriptors to fetch.  (Only applicable for weak-ordered
> +        * memory model archs, such as IA-64).
> +        *
> +        * We also need this memory barrier to make certain all of the
> +        * status bits have been updated before next_to_watch is written.
> +        */
> +       wmb();
> +
> +       /* set next_to_watch value indicating a packet is present */
> +       i++;
> +       if (i == ring->count)
> +               i = 0;
> +
> +       tx_buffer->next_to_watch = tx_desc;
> +       ring->next_to_use = i;
> +
> +       writel(i, ring->tail);
> +
> +       /* we need this if more than one processor can write to our tail
> +        * at a time, it synchronizes IO on IA64/Altix systems
> +        */
> +       mmiowb();

Since XDP rings are 1 per CPU you probably don't need the mmiowb(),
thought it really doesn't do anything on x86 anyway.

> +       return IXGBE_XDP_TX;
> +dma_error:
> +       ring->next_to_use = i;

As long as we only map one buffer at a time you don't need to update
next_to_use as it is only updated after we took care of the mapping.
You might be better off returning IXGBE_XDP_CONSUMED directly instead
of jumping to this label.

> +       return IXGBE_XDP_CONSUMED;
> +}
> +
>  netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>                           struct ixgbe_adapter *adapter,
>                           struct ixgbe_ring *tx_ring)
> @@ -8366,6 +8540,23 @@ static void ixgbe_netpoll(struct net_device *netdev)
>
>  #endif
>
> +static void ixgbe_get_ring_stats64(struct rtnl_link_stats64 *stats,
> +                                  struct ixgbe_ring *ring)
> +{
> +       u64 bytes, packets;
> +       unsigned int start;
> +
> +       if (ring) {
> +               do {
> +                       start = u64_stats_fetch_begin_irq(&ring->syncp);
> +                       packets = ring->stats.packets;
> +                       bytes   = ring->stats.bytes;
> +               } while (u64_stats_fetch_retry_irq(&ring->syncp, start));
> +               stats->tx_packets += packets;
> +               stats->tx_bytes   += bytes;
> +       }
> +}
> +
>  static void ixgbe_get_stats64(struct net_device *netdev,
>                               struct rtnl_link_stats64 *stats)
>  {
> @@ -8391,18 +8582,13 @@ static void ixgbe_get_stats64(struct net_device *netdev,
>
>         for (i = 0; i < adapter->num_tx_queues; i++) {
>                 struct ixgbe_ring *ring = ACCESS_ONCE(adapter->tx_ring[i]);
> -               u64 bytes, packets;
> -               unsigned int start;
>
> -               if (ring) {
> -                       do {
> -                               start = u64_stats_fetch_begin_irq(&ring->syncp);
> -                               packets = ring->stats.packets;
> -                               bytes   = ring->stats.bytes;
> -                       } while (u64_stats_fetch_retry_irq(&ring->syncp, start));
> -                       stats->tx_packets += packets;
> -                       stats->tx_bytes   += bytes;
> -               }
> +               ixgbe_get_ring_stats64(stats, ring);
> +       }
> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
> +               struct ixgbe_ring *ring = ACCESS_ONCE(adapter->xdp_ring[i]);
> +
> +               ixgbe_get_ring_stats64(stats, ring);
>         }
>         rcu_read_unlock();
>
> @@ -9523,7 +9709,13 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>  {
>         int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
>         struct ixgbe_adapter *adapter = netdev_priv(dev);
> -       struct bpf_prog *old_adapter_prog;
> +       struct bpf_prog *old_prog;
> +
> +       if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
> +               return -EINVAL;
> +
> +       if (adapter->flags & IXGBE_FLAG_DCB_ENABLED)
> +               return -EINVAL;
>
>         /* verify ixgbe ring attributes are sufficient for XDP */
>         for (i = 0; i < adapter->num_rx_queues; i++) {

This should probably be part of the first patch instead of this one.
No point in leaving it enabled in the first patch just to disable it
in the second.

> @@ -9536,12 +9728,26 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>                         return -EINVAL;
>         }
>
> -       old_adapter_prog = xchg(&adapter->xdp_prog, prog);
> +       if (nr_cpu_ids > MAX_XDP_QUEUES)
> +               return -ENOMEM;
> +
> +       old_prog = xchg(&adapter->xdp_prog, prog);
> +
> +       /* If transitioning XDP modes reconfigure rings */
> +       if (!!adapter->xdp_prog != !!old_prog) {

You probably shouldn't be comparing xdp_prog.  It should probably be
"!!old_prog" and "!!prog" that you are comparing.

> +               int err = ixgbe_setup_tc(dev, netdev_get_num_tc(dev));
> +
> +               if (err) {
> +                       rcu_assign_pointer(adapter->xdp_prog, old_prog);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         for (i = 0; i < adapter->num_rx_queues; i++)
>                 xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
>
> -       if (old_adapter_prog)
> -               bpf_prog_put(old_adapter_prog);
> +       if (old_prog)
> +               bpf_prog_put(old_prog);
>
>         return 0;
>  }

Actually there is some redundancy here.  You could probably exit if no
error occurred when you called ixgbe_setup_tc.  Once you swapped the
adapter structure out calling ixgbe_setup_tc will strip the old XDP
program as it frees the resources from the rings and then reallocates
them.  The xchg loop after the setup_tc call becomes redundant.

If nothing else you might want to look at adding a jump label so you
can take care of just dropping the old_prog after ixgbe_setup_tc has
completed.

> @@ -10047,6 +10253,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         for (i = 0; i < adapter->num_tx_queues; i++)
>                 u64_stats_init(&adapter->tx_ring[i]->syncp);
>
> +       for (i = 0; i < adapter->num_xdp_queues; i++)
> +               u64_stats_init(&adapter->xdp_ring[i]->syncp);
> +
>         /* WOL not supported for all devices */
>         adapter->wol = 0;
>         hw->eeprom.ops.read(hw, 0x2c, &adapter->eeprom_cap);
>
