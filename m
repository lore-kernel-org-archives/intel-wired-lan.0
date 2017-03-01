From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 1 Mar 2017 15:15:32 -0800
Subject: [Intel-wired-lan] [net-next PATCH 2/3] ixgbe: add support for
	XDP_TX action
In-Reply-To: <CAKgT0UcSHy8EZ5kR9MFF_NSknQ=ra-Qk_8TQs=ofBCEG4YpMuw@mail.gmail.com>
References: <20170225172422.32741.67877.stgit@john-Precision-Tower-5810>
 <20170225173258.32741.31012.stgit@john-Precision-Tower-5810>
 <CAKgT0UcSHy8EZ5kR9MFF_NSknQ=ra-Qk_8TQs=ofBCEG4YpMuw@mail.gmail.com>
Message-ID: <58B75614.2000505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-02-25 02:01 PM, Alexander Duyck wrote:
> On Sat, Feb 25, 2017 at 9:32 AM, John Fastabend
> <john.fastabend@gmail.com> wrote:
>> Add support for XDP_TX action.
>>
>> A couple design choices were made here. First I use a new ring
>> pointer structure xdp_ring[] in the adapter struct instead of
>> pushing the newly allocated xdp TX rings into the tx_ring[]
>> structure. This means we have to duplicate loops around rings
>> in places we want to initialize both TX rings and XDP rings.
>> But by making it explicit it is obvious when we are using XDP
>> rings and when we are using TX rings. Further we don't have
>> to do ring arithmatic which is error prone. As a proof point
>> for doing this my first patches used only a single ring structure
>> and introduced bugs in FCoE code and macvlan code paths.
>>
>> Second I am aware this is not the most optimized version of
>> this code possible. I want to get baseline support in using
>> the most readable format possible and then once this series
>> is included I will optimize the TX path in another series
>> of patches.
> 
> Comments inline below.  There are still a few items to iron out but
> this looks pretty good.  I'll try to get to the other two patches
> tomorrow.
> 
>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   12 +
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   29 ++
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   85 +++++-
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  314 +++++++++++++++++++---
>>  4 files changed, 386 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> index 2d12c24..571a072 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> @@ -190,7 +190,10 @@ struct vf_macvlans {
>>  struct ixgbe_tx_buffer {
>>         union ixgbe_adv_tx_desc *next_to_watch;
>>         unsigned long time_stamp;
>> -       struct sk_buff *skb;
>> +       union {
>> +               struct sk_buff *skb;
>> +               void *data; /* XDP uses addr ptr on irq_clean */
>> +       };
>>         unsigned int bytecount;
>>         unsigned short gso_segs;
>>         __be16 protocol;
> 
> This actually has me wondering if we couldn't short-cut things one
> step further and just store a flag in the tx_flags portion of the
> tx_buffer to record if this is an skb or a data pointer.  I'm
> wondering if we couldn't optimize the standard transmit path to just
> take a reference on the skb->head, and drop the sk_buff itself for
> small packets since in most cases there isn't anything we really need
> to hold onto anyway.  I might have to look into that.

Perhaps, I think this is probably a follow on series if its possible.
At the moment I like how simple this is.

> >> @@ -308,6 +311,7 @@ struct ixgbe_ring {
>>         };
>>
>>         u8 dcb_tc;
>> +       bool xdp_ring;
>>         struct ixgbe_queue_stats stats;
>>         struct u64_stats_sync syncp;
>>         union {
> 
> Instead of adding a bool I would rather have this added to the ring
> state as a single bit.  That way we don't have to modify the ring
> structure here at all.

Sure.

> 
>> @@ -335,6 +339,7 @@ enum ixgbe_ring_f_enum {
>>  #define IXGBE_MAX_FCOE_INDICES         8
>>  #define MAX_RX_QUEUES                  (IXGBE_MAX_FDIR_INDICES + 1)
>>  #define MAX_TX_QUEUES                  (IXGBE_MAX_FDIR_INDICES + 1)
>> +#define MAX_XDP_QUEUES                 (IXGBE_MAX_FDIR_INDICES + 1)
>>  #define IXGBE_MAX_L2A_QUEUES           4
>>  #define IXGBE_BAD_L2A_QUEUE            3
>>  #define IXGBE_MAX_MACVLANS             31
>> @@ -578,6 +583,10 @@ struct ixgbe_adapter {
>>         __be16 vxlan_port;
>>         __be16 geneve_port;
>>
>> +       /* XDP */
>> +       int num_xdp_queues;
>> +       struct ixgbe_ring *xdp_ring[MAX_XDP_QUEUES];
>> +
>>         /* TX */
>>         struct ixgbe_ring *tx_ring[MAX_TX_QUEUES] ____cacheline_aligned_in_smp;
>>
>> @@ -624,6 +633,7 @@ struct ixgbe_adapter {
>>
>>         u64 tx_busy;
>>         unsigned int tx_ring_count;
>> +       unsigned int xdp_ring_count;
>>         unsigned int rx_ring_count;
>>
>>         u32 link_speed;
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> index d3e02ac..51efd0a 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> @@ -1031,7 +1031,7 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
>>  {
>>         struct ixgbe_adapter *adapter = netdev_priv(netdev);
>>         struct ixgbe_ring *temp_ring;
>> -       int i, err = 0;
>> +       int i, j, err = 0;
>>         u32 new_rx_count, new_tx_count;
>>
>>         if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>> @@ -1057,15 +1057,19 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
>>         if (!netif_running(adapter->netdev)) {
>>                 for (i = 0; i < adapter->num_tx_queues; i++)
>>                         adapter->tx_ring[i]->count = new_tx_count;
>> +               for (i = 0; i < adapter->num_xdp_queues; i++)
>> +                       adapter->xdp_ring[i]->count = new_tx_count;
>>                 for (i = 0; i < adapter->num_rx_queues; i++)
>>                         adapter->rx_ring[i]->count = new_rx_count;
>>                 adapter->tx_ring_count = new_tx_count;
>> +               adapter->xdp_ring_count = new_tx_count;
>>                 adapter->rx_ring_count = new_rx_count;
>>                 goto clear_reset;
>>         }
>>
>>         /* allocate temporary buffer to store rings in */
>> -       i = max_t(int, adapter->num_tx_queues, adapter->num_rx_queues);
>> +       i = max_t(int, adapter->num_tx_queues + adapter->num_xdp_queues,
>> +                 adapter->num_rx_queues);
> 
> You only need the maximum of one of the 3 values.  You don't need to
> add num_tx_queues to num_xdp_queues.
> 

hold-over from when I pushed xdp and tx queues into the same ring[] array.

>>         temp_ring = vmalloc(i * sizeof(struct ixgbe_ring));
>>
>>         if (!temp_ring) {
>> @@ -1097,12 +1101,33 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
>>                         }
>>                 }
>>
>> +               for (j = 0; j < adapter->num_xdp_queues; i++, j++) {
>> +                       memcpy(&temp_ring[i], adapter->xdp_ring[j],
>> +                              sizeof(struct ixgbe_ring));
>> +
>> +                       temp_ring[i].count = new_tx_count;
>> +                       err = ixgbe_setup_tx_resources(&temp_ring[i]);
>> +                       if (err) {
>> +                               while (i) {
>> +                                       i--;
>> +                                       ixgbe_free_tx_resources(&temp_ring[i]);
>> +                               }
>> +                               goto err_setup;
>> +                       }
>> +               }
>> +
>>                 for (i = 0; i < adapter->num_tx_queues; i++) {
>>                         ixgbe_free_tx_resources(adapter->tx_ring[i]);
>>
>>                         memcpy(adapter->tx_ring[i], &temp_ring[i],
>>                                sizeof(struct ixgbe_ring));
>>                 }
>> +               for (j = 0; j < adapter->num_xdp_queues; i++, j++) {
>> +                       ixgbe_free_tx_resources(adapter->xdp_ring[j]);
>> +
>> +                       memcpy(adapter->xdp_ring[j], &temp_ring[i],
>> +                              sizeof(struct ixgbe_ring));
>> +               }
>>
>>                 adapter->tx_ring_count = new_tx_count;
>>         }
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
>> index 1b8be7d..d9a4916 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
>> @@ -73,6 +73,11 @@ static bool ixgbe_cache_ring_dcb_sriov(struct ixgbe_adapter *adapter)
>>                         reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
>>                 adapter->tx_ring[i]->reg_idx = reg_idx;
>>         }
>> +       for (i = 0; i < adapter->num_xdp_queues; i++, reg_idx++) {
>> +               if ((reg_idx & ~vmdq->mask) >= tcs)
>> +                       reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
>> +               adapter->xdp_ring[i]->reg_idx = reg_idx;
>> +       }
>>
>>  #ifdef IXGBE_FCOE
>>         /* nothing to do if FCoE is disabled */
>> @@ -248,6 +253,12 @@ static bool ixgbe_cache_ring_sriov(struct ixgbe_adapter *adapter)
>>                 adapter->tx_ring[i]->reg_idx = reg_idx;
>>         }
>>
>> +       for (i = 0; i < adapter->num_xdp_queues; i++, reg_idx++) {
>> +               if ((reg_idx & rss->mask) >= rss->indices)
>> +                       reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
>> +               adapter->xdp_ring[i]->reg_idx = reg_idx;
>> +       }
>> +
>>  #ifdef IXGBE_FCOE
>>         /* FCoE uses a linear block of queues so just assigning 1:1 */
>>         for (; i < adapter->num_tx_queues; i++, reg_idx++)
> 
> One thing we may want to look at doing for the SR-IOV cases would be
> to steal XDP queues from an adjacent VMDq pool.  It would put a
> dependency us limiting ourselves by one additional VF, but it would
> make the logic much simpler since each VMDq pool is the same size so
> the Tx/Rx limit in one pool would be the same as the next so you could
> do twice the number of Tx queues as Rx queues.

follow on patches?

> 
>> @@ -267,12 +278,14 @@ static bool ixgbe_cache_ring_sriov(struct ixgbe_adapter *adapter)
>>   **/
>>  static bool ixgbe_cache_ring_rss(struct ixgbe_adapter *adapter)
>>  {
>> -       int i;
>> +       int i, reg_idx;
>>
>>         for (i = 0; i < adapter->num_rx_queues; i++)
>>                 adapter->rx_ring[i]->reg_idx = i;
>> -       for (i = 0; i < adapter->num_tx_queues; i++)
>> -               adapter->tx_ring[i]->reg_idx = i;
>> +       for (i = 0, reg_idx = 0; i < adapter->num_tx_queues; i++, reg_idx++)
>> +               adapter->tx_ring[i]->reg_idx = reg_idx;
>> +       for (i = 0; i < adapter->num_xdp_queues; i++, reg_idx++)
>> +               adapter->xdp_ring[i]->reg_idx = reg_idx;
>>
>>         return true;
>>  }
>> @@ -308,6 +321,14 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
>>         ixgbe_cache_ring_rss(adapter);
>>  }
>>
>> +static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
>> +{
>> +       if (nr_cpu_ids > MAX_XDP_QUEUES)
>> +               return 0;
>> +
>> +       return adapter->xdp_prog ? nr_cpu_ids : 0;
>> +}
>> +
>>  #define IXGBE_RSS_64Q_MASK     0x3F
>>  #define IXGBE_RSS_16Q_MASK     0xF
>>  #define IXGBE_RSS_8Q_MASK      0x7
>> @@ -382,6 +403,7 @@ static bool ixgbe_set_dcb_sriov_queues(struct ixgbe_adapter *adapter)
>>         adapter->num_rx_queues_per_pool = tcs;
>>
>>         adapter->num_tx_queues = vmdq_i * tcs;
>> +       adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
>>         adapter->num_rx_queues = vmdq_i * tcs;
>>
>>  #ifdef IXGBE_FCOE
>> @@ -479,6 +501,7 @@ static bool ixgbe_set_dcb_queues(struct ixgbe_adapter *adapter)
>>                 netdev_set_tc_queue(dev, i, rss_i, rss_i * i);
>>
>>         adapter->num_tx_queues = rss_i * tcs;
>> +       adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
>>         adapter->num_rx_queues = rss_i * tcs;
>>
>>         return true;
>> @@ -549,6 +572,7 @@ static bool ixgbe_set_sriov_queues(struct ixgbe_adapter *adapter)
>>
>>         adapter->num_rx_queues = vmdq_i * rss_i;
>>         adapter->num_tx_queues = vmdq_i * rss_i;
>> +       adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
>>
>>         /* disable ATR as it is not supported when VMDq is enabled */
>>         adapter->flags &= ~IXGBE_FLAG_FDIR_HASH_CAPABLE;
> 
> I'm pretty sure we are currently looking at an overly simplified
> setup.  I suspect we need to take queue limits into account for DCB
> and SR-IOV.  For example what TC are we supposed to be taking Tx
> queues from in the case of DCB? Really in order for us to support XDP
> in the DCB case we need rss_i to be equal to or less than half the
> maximum possible value.
> 

This is probably a gap in XDP in general. For example how would XDP even
push a packet at a traffic class? At least we should ensure rss_i doesn't
break something but not sure how to coexist with DCB reasonably at the
moment.

> And as I mentioned before we need to make certain in the case of
> SR-IOV w/ DCB or without that we have one pool that we set aside so
> that we can steal queues from it to support XPS.
> 

SR-IOV + XDP should work I'm a bit more skeptical about DCB at the
moment.  I'm think adding a check in rss_i to ensure we can claim
the queues ("less than half" comment above) and then sort out the
'xdp' pool concept as follow on series.

>> @@ -669,6 +693,7 @@ static bool ixgbe_set_rss_queues(struct ixgbe_adapter *adapter)
>>  #endif /* IXGBE_FCOE */
>>         adapter->num_rx_queues = rss_i;
>>         adapter->num_tx_queues = rss_i;
>> +       adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
>>
>>         return true;
>>  }
> 
> So this is the one allocation that is safe for now since the rss_i has
> an upper limit of 64.
> 
>> @@ -689,6 +714,7 @@ static void ixgbe_set_num_queues(struct ixgbe_adapter *adapter)
>>         /* Start with base case */
>>         adapter->num_rx_queues = 1;
>>         adapter->num_tx_queues = 1;
>> +       adapter->num_xdp_queues = 0;
>>         adapter->num_rx_pools = adapter->num_rx_queues;
>>         adapter->num_rx_queues_per_pool = 1;
>>
>> @@ -720,7 +746,8 @@ static int ixgbe_acquire_msix_vectors(struct ixgbe_adapter *adapter)
>>         int i, vectors, vector_threshold;
>>
>>         /* We start by asking for one vector per queue pair */
>> -       vectors = max(adapter->num_rx_queues, adapter->num_tx_queues);
>> +       vectors = max(adapter->num_rx_queues,
>> +                     adapter->num_tx_queues + adapter->num_xdp_queues);
>>
>>         /* It is easy to be greedy for MSI-X vectors. However, it really
>>          * doesn't do much good if we have a lot more vectors than CPUs. We'll
> 
> This might be overkill on the vectors.  You can stack regular Rx
> queues, Tx queues, and xdp_queues.  I would say take the maximum of
> all 3 instead of adding Tx and XPS queues.

sure.

> 
>> @@ -800,6 +827,8 @@ static void ixgbe_add_ring(struct ixgbe_ring *ring,
>>   * @v_idx: index of vector in adapter struct
>>   * @txr_count: total number of Tx rings to allocate
>>   * @txr_idx: index of first Tx ring to allocate
>> + * @xdp_count: total number of XDP rings to allocate
>> + * @xdp_idx: index of first XDP ring to allocate
>>   * @rxr_count: total number of Rx rings to allocate
>>   * @rxr_idx: index of first Rx ring to allocate
>>   *
>> @@ -808,6 +837,7 @@ static void ixgbe_add_ring(struct ixgbe_ring *ring,
>>  static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
>>                                 int v_count, int v_idx,
>>                                 int txr_count, int txr_idx,
>> +                               int xdp_count, int xdp_idx,
>>                                 int rxr_count, int rxr_idx)
>>  {
>>         struct ixgbe_q_vector *q_vector;
>> @@ -909,6 +939,33 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
>>                 ring++;
>>         }
>>
>> +       while (xdp_count) {
>> +               /* assign generic ring traits */
>> +               ring->dev = &adapter->pdev->dev;
>> +               ring->netdev = adapter->netdev;
> 
> Just a thought on all this.  I don't know if we should be setting
> ring->netdev.  We don't really have a netdevice associated with the
> XDP rings.  we have an Rx ring.
> 
> If we were to leave ring->netdev as NULL it might help us to find any
> and all places where we might have overlooked things and have XDP
> trying to tweak netdev queues.  In addition it would help to short
> circuit the flag checks in the Tx clean-up path as we could just check
> for tx_ring->netdev instead of having to check for an XDP boolean
> value.
> 

hmm not sure about this. When we dump debug statements for example on
a hung queue its helpful to have an idea what port the queues are from.
Although I guess we could print one of the other identifier strings instead.

>> +               /* configure backlink on ring */
>> +               ring->q_vector = q_vector;
>> +
>> +               /* update q_vector Tx values */
>> +               ixgbe_add_ring(ring, &q_vector->tx);
>> +
>> +               /* apply Tx specific ring traits */
>> +               ring->count = adapter->xdp_ring_count;
>> +               ring->queue_index = xdp_idx;
>> +               ring->xdp_ring = true;
>> +
>> +               /* assign ring to adapter */
>> +               adapter->xdp_ring[xdp_idx] = ring;
>> +
>> +               /* update count and index */
>> +               xdp_count--;
>> +               xdp_idx += v_count;
>> +
>> +               /* push pointer to next ring */
>> +               ring++;
>> +       }
>> +
>>         while (rxr_count) {
>>                 /* assign generic ring traits */
>>                 ring->dev = &adapter->pdev->dev;
>> @@ -1002,17 +1059,18 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
>>         int q_vectors = adapter->num_q_vectors;
>>         int rxr_remaining = adapter->num_rx_queues;
>>         int txr_remaining = adapter->num_tx_queues;
>> -       int rxr_idx = 0, txr_idx = 0, v_idx = 0;
>> +       int xdp_remaining = adapter->num_xdp_queues;
>> +       int rxr_idx = 0, txr_idx = 0, xdp_idx = 0, v_idx = 0;
>>         int err;
>>
>>         /* only one q_vector if MSI-X is disabled. */
>>         if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED))
>>                 q_vectors = 1;
>>
>> -       if (q_vectors >= (rxr_remaining + txr_remaining)) {
>> +       if (q_vectors >= (rxr_remaining + txr_remaining + xdp_remaining)) {
>>                 for (; rxr_remaining; v_idx++) {
>>                         err = ixgbe_alloc_q_vector(adapter, q_vectors, v_idx,
>> -                                                  0, 0, 1, rxr_idx);
>> +                                                  0, 0, 0, 0, 1, rxr_idx);
>>
>>                         if (err)
>>                                 goto err_out;
>> @@ -1026,8 +1084,11 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
>>         for (; v_idx < q_vectors; v_idx++) {
>>                 int rqpv = DIV_ROUND_UP(rxr_remaining, q_vectors - v_idx);
>>                 int tqpv = DIV_ROUND_UP(txr_remaining, q_vectors - v_idx);
>> +               int xqpv = DIV_ROUND_UP(xdp_remaining, q_vectors - v_idx);
>> +
>>                 err = ixgbe_alloc_q_vector(adapter, q_vectors, v_idx,
>>                                            tqpv, txr_idx,
>> +                                          xqpv, xdp_idx,
>>                                            rqpv, rxr_idx);
>>
>>                 if (err)
>> @@ -1036,14 +1097,17 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
>>                 /* update counts and index */
>>                 rxr_remaining -= rqpv;
>>                 txr_remaining -= tqpv;
>> +               xdp_remaining -= xqpv;
>>                 rxr_idx++;
>>                 txr_idx++;
>> +               xdp_idx++;
>>         }
>>
>>         return 0;
>>
>>  err_out:
>>         adapter->num_tx_queues = 0;
>> +       adapter->num_xdp_queues = 0;
>>         adapter->num_rx_queues = 0;
>>         adapter->num_q_vectors = 0;
>>
>> @@ -1066,6 +1130,7 @@ static void ixgbe_free_q_vectors(struct ixgbe_adapter *adapter)
>>         int v_idx = adapter->num_q_vectors;
>>
>>         adapter->num_tx_queues = 0;
>> +       adapter->num_xdp_queues = 0;
>>         adapter->num_rx_queues = 0;
>>         adapter->num_q_vectors = 0;
>>
>> @@ -1172,9 +1237,10 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter)
>>
>>         ixgbe_cache_ring_register(adapter);
>>
>> -       e_dev_info("Multiqueue %s: Rx Queue count = %u, Tx Queue count = %u\n",
>> +       e_dev_info("Multiqueue %s: Rx Queue count = %u, Tx Queue count = %u XDP Queue count = %u\n",
>>                    (adapter->num_rx_queues > 1) ? "Enabled" : "Disabled",
>> -                  adapter->num_rx_queues, adapter->num_tx_queues);
>> +                  adapter->num_rx_queues,
>> +                  adapter->num_tx_queues, adapter->num_xdp_queues);
>>
>>         set_bit(__IXGBE_DOWN, &adapter->state);
>>
> 
> I think I would have preferred to see us leave tx_queues, and
> rx_queues on the same line and add num_xdp_queues on a line by itself.

really :/ it seems a bit cleaner to have them all on one line IMO it fits on an
80 char screen fairly sure.

> 
>> @@ -1195,6 +1261,7 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter)
>>  void ixgbe_clear_interrupt_scheme(struct ixgbe_adapter *adapter)
>>  {
>>         adapter->num_tx_queues = 0;
>> +       adapter->num_xdp_queues = 0;
>>         adapter->num_rx_queues = 0;
>>
>>         ixgbe_free_q_vectors(adapter);
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index ec2c38f..227caf8 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -594,6 +594,19 @@ static void ixgbe_regdump(struct ixgbe_hw *hw, struct ixgbe_reg_info *reginfo)
>>
>>  }
>>
>> +static void ixgbe_print_buffer(struct ixgbe_ring *ring, int n)
>> +{
>> +       struct ixgbe_tx_buffer *tx_buffer;
>> +
>> +       tx_buffer = &ring->tx_buffer_info[ring->next_to_clean];
>> +       pr_info(" %5d %5X %5X %016llX %08X %p %016llX\n",
>> +                  n, ring->next_to_use, ring->next_to_clean,
>> +                  (u64)dma_unmap_addr(tx_buffer, dma),
>> +                  dma_unmap_len(tx_buffer, len),
>> +                  tx_buffer->next_to_watch,
>> +                  (u64)tx_buffer->time_stamp);
>> +}
>> +
>>  /*
>>   * ixgbe_dump - Print registers, tx-rings and rx-rings
>>   */
>> @@ -603,7 +616,7 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
>>         struct ixgbe_hw *hw = &adapter->hw;
>>         struct ixgbe_reg_info *reginfo;
>>         int n = 0;
>> -       struct ixgbe_ring *tx_ring;
>> +       struct ixgbe_ring *ring;
>>         struct ixgbe_tx_buffer *tx_buffer;
>>         union ixgbe_adv_tx_desc *tx_desc;
>>         struct my_u0 { u64 a; u64 b; } *u0;
>> @@ -644,14 +657,13 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
>>                 "Queue [NTU] [NTC] [bi(ntc)->dma  ]",
>>                 "leng", "ntw", "timestamp");
>>         for (n = 0; n < adapter->num_tx_queues; n++) {
>> -               tx_ring = adapter->tx_ring[n];
>> -               tx_buffer = &tx_ring->tx_buffer_info[tx_ring->next_to_clean];
>> -               pr_info(" %5d %5X %5X %016llX %08X %p %016llX\n",
>> -                          n, tx_ring->next_to_use, tx_ring->next_to_clean,
>> -                          (u64)dma_unmap_addr(tx_buffer, dma),
>> -                          dma_unmap_len(tx_buffer, len),
>> -                          tx_buffer->next_to_watch,
>> -                          (u64)tx_buffer->time_stamp);
>> +               ring = adapter->tx_ring[n];
>> +               ixgbe_print_buffer(ring, n);
>> +       }
>> +
>> +       for (n = 0; n < adapter->num_xdp_queues; n++) {
>> +               ring = adapter->xdp_ring[n];
>> +               ixgbe_print_buffer(ring, n);
>>         }
>>
>>         /* Print TX Rings */
>> @@ -696,28 +708,28 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
>>          */
>>
>>         for (n = 0; n < adapter->num_tx_queues; n++) {
>> -               tx_ring = adapter->tx_ring[n];
>> +               ring = adapter->tx_ring[n];
>>                 pr_info("------------------------------------\n");
>> -               pr_info("TX QUEUE INDEX = %d\n", tx_ring->queue_index);
>> +               pr_info("TX QUEUE INDEX = %d\n", ring->queue_index);
>>                 pr_info("------------------------------------\n");
>>                 pr_info("%s%s    %s              %s        %s          %s\n",
>>                         "T [desc]     [address 63:0  ] ",
>>                         "[PlPOIdStDDt Ln] [bi->dma       ] ",
>>                         "leng", "ntw", "timestamp", "bi->skb");
>>
>> -               for (i = 0; tx_ring->desc && (i < tx_ring->count); i++) {
>> -                       tx_desc = IXGBE_TX_DESC(tx_ring, i);
>> -                       tx_buffer = &tx_ring->tx_buffer_info[i];
>> +               for (i = 0; ring->desc && (i < ring->count); i++) {
>> +                       tx_desc = IXGBE_TX_DESC(ring, i);
>> +                       tx_buffer = &ring->tx_buffer_info[i];
>>                         u0 = (struct my_u0 *)tx_desc;
>>                         if (dma_unmap_len(tx_buffer, len) > 0) {
>>                                 const char *ring_desc;
>>
>> -                               if (i == tx_ring->next_to_use &&
>> -                                   i == tx_ring->next_to_clean)
>> +                               if (i == ring->next_to_use &&
>> +                                   i == ring->next_to_clean)
>>                                         ring_desc = " NTC/U";
>> -                               else if (i == tx_ring->next_to_use)
>> +                               else if (i == ring->next_to_use)
>>                                         ring_desc = " NTU";
>> -                               else if (i == tx_ring->next_to_clean)
>> +                               else if (i == ring->next_to_clean)
>>                                         ring_desc = " NTC";
>>                                 else
>>                                         ring_desc = "";
>> @@ -987,6 +999,10 @@ static void ixgbe_update_xoff_rx_lfc(struct ixgbe_adapter *adapter)
>>         for (i = 0; i < adapter->num_tx_queues; i++)
>>                 clear_bit(__IXGBE_HANG_CHECK_ARMED,
>>                           &adapter->tx_ring[i]->state);
>> +
>> +       for (i = 0; i < adapter->num_xdp_queues; i++)
>> +               clear_bit(__IXGBE_HANG_CHECK_ARMED,
>> +                         &adapter->xdp_ring[i]->state);
>>  }
>>
>>  static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
>> @@ -1031,6 +1047,14 @@ static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
>>                 if (xoff[tc])
>>                         clear_bit(__IXGBE_HANG_CHECK_ARMED, &tx_ring->state);
>>         }
>> +
>> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +               struct ixgbe_ring *xdp_ring = adapter->xdp_ring[i];
>> +
>> +               tc = xdp_ring->dcb_tc;
>> +               if (xoff[tc])
>> +                       clear_bit(__IXGBE_HANG_CHECK_ARMED, &xdp_ring->state);
>> +       }
>>  }
>>
>>  static u64 ixgbe_get_tx_completed(struct ixgbe_ring *ring)
>> @@ -1137,6 +1161,11 @@ static int ixgbe_tx_maxrate(struct net_device *netdev,
>>         return 0;
>>  }
>>
>> +static bool ixgbe_txring_is_xdp(struct ixgbe_ring *tx_ring)
>> +{
>> +       return tx_ring->xdp_ring;
>> +}
>> +
>>  /**
>>   * ixgbe_clean_tx_irq - Reclaim resources after transmit completes
>>   * @q_vector: structure containing interrupt and ring information
>> @@ -1182,7 +1211,10 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>>                 total_packets += tx_buffer->gso_segs;
>>
>>                 /* free the skb */
>> -               napi_consume_skb(tx_buffer->skb, napi_budget);
>> +               if (ixgbe_txring_is_xdp(tx_ring))
>> +                       page_frag_free(tx_buffer->data);
>> +               else
>> +                       napi_consume_skb(tx_buffer->skb, napi_budget);
>>
>>                 /* unmap skb header data */
>>                 dma_unmap_single(tx_ring->dev,
>> @@ -1243,7 +1275,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>>         if (check_for_tx_hang(tx_ring) && ixgbe_check_tx_hang(tx_ring)) {
>>                 /* schedule immediate reset if we believe we hung */
>>                 struct ixgbe_hw *hw = &adapter->hw;
>> -               e_err(drv, "Detected Tx Unit Hang\n"
>> +               e_err(drv, "Detected Tx Unit Hang %s\n"
>>                         "  Tx Queue             <%d>\n"
>>                         "  TDH, TDT             <%x>, <%x>\n"
>>                         "  next_to_use          <%x>\n"
>> @@ -1251,13 +1283,16 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>>                         "tx_buffer_info[next_to_clean]\n"
>>                         "  time_stamp           <%lx>\n"
>>                         "  jiffies              <%lx>\n",
>> +                       ixgbe_txring_is_xdp(tx_ring) ? "(XDP)" : "",
>>                         tx_ring->queue_index,
>>                         IXGBE_READ_REG(hw, IXGBE_TDH(tx_ring->reg_idx)),
>>                         IXGBE_READ_REG(hw, IXGBE_TDT(tx_ring->reg_idx)),
>>                         tx_ring->next_to_use, i,
>>                         tx_ring->tx_buffer_info[i].time_stamp, jiffies);
>>
>> -               netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
>> +               if (!ixgbe_txring_is_xdp(tx_ring))
>> +                       netif_stop_subqueue(tx_ring->netdev,
>> +                                           tx_ring->queue_index);
>>
>>                 e_info(probe,
>>                        "tx hang %d detected on queue %d, resetting adapter\n",
>> @@ -1270,6 +1305,9 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
>>                 return true;
>>         }
>>
>> +       if (ixgbe_txring_is_xdp(tx_ring))
>> +               return !!budget;
>> +
>>         netdev_tx_completed_queue(txring_txq(tx_ring),
>>                                   total_packets, total_bytes);
>>
>> @@ -2160,10 +2198,16 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>>         return skb;
>>  }
>>
>> -static int ixgbe_run_xdp(struct ixgbe_ring  *rx_ring,
>> +static int ixgbe_xmit_xdp_ring(struct xdp_buff *xdp,
>> +                              struct ixgbe_adapter *adapter,
>> +                              struct ixgbe_ring *tx_ring);
>> +
>> +static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>> +                        struct ixgbe_ring  *rx_ring,
>>                          struct ixgbe_rx_buffer *rx_buffer,
>>                          unsigned int size)
>>  {
>> +       struct ixgbe_ring *xdp_ring;
>>         struct bpf_prog *xdp_prog;
>>         struct xdp_buff xdp;
>>         void *addr;
>> @@ -2183,9 +2227,18 @@ static int ixgbe_run_xdp(struct ixgbe_ring  *rx_ring,
>>         switch (act) {
>>         case XDP_PASS:
>>                 return 0;
>> +       case XDP_TX:
>> +               xdp_ring = adapter->xdp_ring[smp_processor_id()];
>> +
>> +               /* XDP_TX is not flow controlled */
>> +               if (!xdp_ring) {
>> +                       WARN_ON(1);
>> +                       break;
>> +               }
>> +               ixgbe_xmit_xdp_ring(&xdp, adapter, xdp_ring);
>> +               break;
> 
> So just for the sake of future compatibility I would say you might
> look at instead just passing a netdev and the XDP buffer.  Then your
> transmit routine can make the decision on using smp_processor_id and
> grab the xdp_ring it wants.  No point in having us make the decision
> in the Rx path.  That way things stay closer to how the transmit path
> already works.
> 
> Also shouldn't you return some sort of notification as to if you
> completed the xmit successfully?  It almost seems like maybe we should
> fall through to an XDP_ABORTED case if we didn't transmit the frame
> since we might end up leaking the memory otherwise.

Yep. Fixing.

> 
>>         default:
>>                 bpf_warn_invalid_xdp_action(act);
>> -       case XDP_TX:
>>         case XDP_ABORTED:
>>                 trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
>>                 /* fallthrough -- handle aborts by dropping packet */
>> @@ -2214,8 +2267,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>                                const int budget)
>>  {
>>         unsigned int total_rx_bytes = 0, total_rx_packets = 0;
>> -#ifdef IXGBE_FCOE
>>         struct ixgbe_adapter *adapter = q_vector->adapter;
>> +#ifdef IXGBE_FCOE
>>         int ddp_bytes;
>>         unsigned int mss = 0;
>>  #endif /* IXGBE_FCOE */
>> @@ -2248,7 +2301,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>>
>>                 rcu_read_lock();
>> -               consumed = ixgbe_run_xdp(rx_ring, rx_buffer, size);
>> +               consumed = ixgbe_run_xdp(adapter, rx_ring, rx_buffer, size);
>>                 rcu_read_unlock();
>>
>>                 if (consumed) {
> 
> You probably don't need the adapter struct.  If you have the rx_ring
> it should have a netdev structure and from that you can get to the
> adapter struct via netdev_priv.

Its easy to pass it through the function though and avoid priv(rx_ring->adapter)
line.

> 
>> @@ -2914,6 +2967,15 @@ static irqreturn_t ixgbe_msix_other(int irq, void *data)
>>                                                        &ring->state))
>>                                         reinit_count++;
>>                         }
>> +
>> +                       for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +                               struct ixgbe_ring *ring = adapter->xdp_ring[i];
>> +
>> +                               if (test_and_clear_bit(__IXGBE_TX_FDIR_INIT_DONE,
>> +                                                      &ring->state))
>> +                                       reinit_count++;
>> +                       }
>> +
>>                         if (reinit_count) {
>>                                 /* no more flow director interrupts until after init */
>>                                 IXGBE_WRITE_REG(hw, IXGBE_EIMC, IXGBE_EIMC_FLOW_DIR);
> 
> We don't run flow director on the XDP queues so there is no need to
> add this bit.

Yep cut'n'paste error.

> 
>> @@ -3429,6 +3491,8 @@ static void ixgbe_configure_tx(struct ixgbe_adapter *adapter)
>>         /* Setup the HW Tx Head and Tail descriptor pointers */
>>         for (i = 0; i < adapter->num_tx_queues; i++)
>>                 ixgbe_configure_tx_ring(adapter, adapter->tx_ring[i]);
>> +       for (i = 0; i < adapter->num_xdp_queues; i++)
>> +               ixgbe_configure_tx_ring(adapter, adapter->xdp_ring[i]);
>>  }
>>
>>  static void ixgbe_enable_rx_drop(struct ixgbe_adapter *adapter,
>> @@ -5598,7 +5662,8 @@ static void ixgbe_clean_tx_ring(struct ixgbe_ring *tx_ring)
>>         }
>>
>>         /* reset BQL for queue */
>> -       netdev_tx_reset_queue(txring_txq(tx_ring));
>> +       if (!ixgbe_txring_is_xdp(tx_ring))
>> +               netdev_tx_reset_queue(txring_txq(tx_ring));
>>
>>         /* reset next_to_use and next_to_clean */
>>         tx_ring->next_to_use = 0;
>> @@ -5627,6 +5692,8 @@ static void ixgbe_clean_all_tx_rings(struct ixgbe_adapter *adapter)
>>
>>         for (i = 0; i < adapter->num_tx_queues; i++)
>>                 ixgbe_clean_tx_ring(adapter->tx_ring[i]);
>> +       for (i = 0; i < adapter->num_xdp_queues; i++)
>> +               ixgbe_clean_tx_ring(adapter->xdp_ring[i]);
>>  }
>>
>>  static void ixgbe_fdir_filter_exit(struct ixgbe_adapter *adapter)
>> @@ -5721,6 +5788,11 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
>>                 u8 reg_idx = adapter->tx_ring[i]->reg_idx;
>>                 IXGBE_WRITE_REG(hw, IXGBE_TXDCTL(reg_idx), IXGBE_TXDCTL_SWFLSH);
>>         }
>> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +               u8 reg_idx = adapter->xdp_ring[i]->reg_idx;
>> +
>> +               IXGBE_WRITE_REG(hw, IXGBE_TXDCTL(reg_idx), IXGBE_TXDCTL_SWFLSH);
>> +       }
>>
>>         /* Disable the Tx DMA engine on 82599 and later MAC */
>>         switch (hw->mac.type) {
>> @@ -6008,6 +6080,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
>>
>>         /* set default ring sizes */
>>         adapter->tx_ring_count = IXGBE_DEFAULT_TXD;
>> +       adapter->xdp_ring_count = IXGBE_DEFAULT_TXD;
>>         adapter->rx_ring_count = IXGBE_DEFAULT_RXD;
>>
>>         /* set default work limits */
> 
> I would just use the tx_ring_count value for the XDP rings.  No point
> in adding another control unless you want to add the ethtool interface
> for it.
> 

I liked that it was explicit. But its only ever used once so I'll remove it.

>> @@ -6089,7 +6162,7 @@ int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
>>   **/
>>  static int ixgbe_setup_all_tx_resources(struct ixgbe_adapter *adapter)
>>  {
>> -       int i, err = 0;
>> +       int i, j = 0, err = 0;
>>
>>         for (i = 0; i < adapter->num_tx_queues; i++) {
>>                 err = ixgbe_setup_tx_resources(adapter->tx_ring[i]);
>> @@ -6099,12 +6172,23 @@ static int ixgbe_setup_all_tx_resources(struct ixgbe_adapter *adapter)
>>                 e_err(probe, "Allocation for Tx Queue %u failed\n", i);
>>                 goto err_setup_tx;
>>         }
>> +       for (j = 0; j < adapter->num_xdp_queues; j++) {
>> +               err = ixgbe_setup_tx_resources(adapter->xdp_ring[j]);
>> +               if (!err)
>> +                       continue;
>> +
>> +               e_err(probe, "Allocation for Tx Queue %u failed\n", j);
>> +               goto err_setup_tx;
>> +       }
>> +
>>
>>         return 0;
>>  err_setup_tx:
>>         /* rewind the index freeing the rings as we go */
>>         while (i--)
>>                 ixgbe_free_tx_resources(adapter->tx_ring[i]);
>> +       while (j--)
>> +               ixgbe_free_tx_resources(adapter->xdp_ring[j]);
>>         return err;
>>  }
>>
> 
> Just for sake of symmetry I would prefer to see xdp rings freed before
> the Tx rings.

OK.

> 
>> @@ -6238,6 +6322,9 @@ static void ixgbe_free_all_tx_resources(struct ixgbe_adapter *adapter)
>>         for (i = 0; i < adapter->num_tx_queues; i++)
>>                 if (adapter->tx_ring[i]->desc)
>>                         ixgbe_free_tx_resources(adapter->tx_ring[i]);
>> +       for (i = 0; i < adapter->num_xdp_queues; i++)
>> +               if (adapter->xdp_ring[i]->desc)
>> +                       ixgbe_free_tx_resources(adapter->xdp_ring[i]);
>>  }
>>
>>  /**
>> @@ -6656,6 +6743,14 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
>>                 bytes += tx_ring->stats.bytes;
>>                 packets += tx_ring->stats.packets;
>>         }
>> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +               struct ixgbe_ring *xdp_ring = adapter->xdp_ring[i];
>> +
>> +               restart_queue += xdp_ring->tx_stats.restart_queue;
>> +               tx_busy += xdp_ring->tx_stats.tx_busy;
>> +               bytes += xdp_ring->stats.bytes;
>> +               packets += xdp_ring->stats.packets;
>> +       }
>>         adapter->restart_queue = restart_queue;
>>         adapter->tx_busy = tx_busy;
>>         netdev->stats.tx_bytes = bytes;
> 
> We may wan to look at doing a slight refactor on this to convert some
> of these stats grabs over to static functions.  We may want to also
> group these using structs instead of just doing this as individual u64
> stats.

Agreed but that is a follow on patch and not really XDP specific.

> 
>> @@ -6849,6 +6944,9 @@ static void ixgbe_fdir_reinit_subtask(struct ixgbe_adapter *adapter)
>>                 for (i = 0; i < adapter->num_tx_queues; i++)
>>                         set_bit(__IXGBE_TX_FDIR_INIT_DONE,
>>                                 &(adapter->tx_ring[i]->state));
>> +               for (i = 0; i < adapter->num_xdp_queues; i++)
>> +                       set_bit(__IXGBE_TX_FDIR_INIT_DONE,
>> +                               &adapter->xdp_ring[i]->state);
>>                 /* re-enable flow director interrupts */
>>                 IXGBE_WRITE_REG(hw, IXGBE_EIMS, IXGBE_EIMS_FLOW_DIR);
>>         } else {
> 
> I wouldn't bother with the flow director initialization for the XDP rings.
> 
> Although you may want to set __IXGBE_TX_XPS_INIT_DONE to avoid trying
> to configure XPS for the XDP rings.

So I'll leave this block then.

> 
>> @@ -6882,6 +6980,8 @@ static void ixgbe_check_hang_subtask(struct ixgbe_adapter *adapter)
>>         if (netif_carrier_ok(adapter->netdev)) {
>>                 for (i = 0; i < adapter->num_tx_queues; i++)
>>                         set_check_for_tx_hang(adapter->tx_ring[i]);
>> +               for (i = 0; i < adapter->num_xdp_queues; i++)
>> +                       set_check_for_tx_hang(adapter->xdp_ring[i]);
>>         }
>>
>>         if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED)) {
>> @@ -7112,6 +7212,13 @@ static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
>>                         return true;
>>         }
>>
>> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +               struct ixgbe_ring *ring = adapter->xdp_ring[i];
>> +
>> +               if (ring->next_to_use != ring->next_to_clean)
>> +                       return true;
>> +       }
>> +
>>         return false;
>>  }
>>
>> @@ -8072,6 +8179,99 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
>>  #endif
>>  }
>>
>> +static int ixgbe_xmit_xdp_ring(struct xdp_buff *xdp,
>> +                              struct ixgbe_adapter *adapter,
>> +                              struct ixgbe_ring *ring)
>> +{
>> +       struct ixgbe_tx_buffer *tx_buffer;
>> +       union ixgbe_adv_tx_desc *tx_desc;
>> +       u32 len, tx_flags = 0;
>> +       dma_addr_t dma;
>> +       u16 count, i;
>> +       u32 cmd_type;
>> +
>> +       len = xdp->data_end - xdp->data;
>> +       count = TXD_USE_COUNT(len);
>> +
>> +       /* record the location of the first descriptor for this packet */
>> +       tx_buffer = &ring->tx_buffer_info[ring->next_to_use];
>> +       tx_buffer->skb = NULL;
>> +       tx_buffer->bytecount = len;
>> +       tx_buffer->gso_segs = 1;
>> +       tx_buffer->protocol = 0;
>> +
>> +#ifdef CONFIG_PCI_IOV
>> +       /* Use the l2switch_enable flag - would be false if the DMA
>> +        * Tx switch had been disabled.
>> +        */
>> +       if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
>> +               tx_flags |= IXGBE_TX_FLAGS_CC;
>> +#endif
>> +
> 
> I'm pretty sure there is a bug here.  The TX_FLAGS_CC is supposed to
> notify the ring that it is supposed to populate the CC bit in olinfo
> status.  Also you need to populate a context descriptor when this is
> set since the header length recorded in the descriptor is used to
> determine the length of the header in the packet.  You can probably
> short-cut this and just add a bit of init code that just initializes
> the queue by dropping a context descriptor in the ring with a ethernet
> header length of 14 in it, and never bumping the tail.  Then if you
> see the TX_FLAGS_CC you just default to context 0 which is already
> recorded in the queue and should save you the trouble.

Rigth this is a bug. For this patch I'll put it inline and then optimize
it later with some other optimizations.

> 
>> +       tx_buffer->tx_flags = tx_flags;
>> +       i = ring->next_to_use;
>> +       tx_desc = IXGBE_TX_DESC(ring, i);
>> +
>> +       dma = dma_map_single(ring->dev, xdp->data, len, DMA_TO_DEVICE);
>> +       if (dma_mapping_error(ring->dev, dma))
>> +               goto dma_error;
>> +
>> +       dma_unmap_len_set(tx_buffer, len, len);
>> +       dma_unmap_addr_set(tx_buffer, dma, dma);
>> +       tx_buffer->data = xdp->data;
>> +       tx_desc->read.buffer_addr = cpu_to_le64(dma);
>> +
>> +       /* put descriptor type bits */
>> +       cmd_type = IXGBE_ADVTXD_DTYP_DATA |
>> +                  IXGBE_ADVTXD_DCMD_DEXT |
>> +                  IXGBE_ADVTXD_DCMD_IFCS |
>> +                  IXGBE_ADVTXD_DCMD_EOP;
> 
> The EOP is redundant, we already included it in IXGBE_TXD_CMD which
> you reference below.
> 

Thanks

>> +       cmd_type |= len | IXGBE_TXD_CMD;
>> +       tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
>> +       tx_desc->read.olinfo_status =
>> +               cpu_to_le32(len << IXGBE_ADVTXD_PAYLEN_SHIFT);
>> +
>> +       /* With normal buffer flow we would also set the time_stamp. But in
>> +        * XDP case we can safely skip it because at the moment it is not
>> +        * used anywhere.
>> +        */
>> +       tx_buffer->time_stamp = jiffies;
>> +
> 
> We should probably just drop the code from the driver that records
> jiffies.  Feel free to submit a patch to drop it and save yourself a
> few cycles.
> 

Sure.

>> +       /* Force memory writes to complete before letting h/w know there
>> +        * are new descriptors to fetch.  (Only applicable for weak-ordered
>> +        * memory model archs, such as IA-64).
>> +        *
>> +        * We also need this memory barrier to make certain all of the
>> +        * status bits have been updated before next_to_watch is written.
>> +        */
>> +       wmb();
>> +
>> +       /* set next_to_watch value indicating a packet is present */
>> +       i++;
>> +       if (i == ring->count)
>> +               i = 0;
>> +
>> +       tx_buffer->next_to_watch = tx_desc;
>> +       ring->next_to_use = i;
>> +
>> +       writel(i, ring->tail);
>> +
>> +       /* we need this if more than one processor can write to our tail
>> +        * at a time, it synchronizes IO on IA64/Altix systems
>> +        */
>> +       mmiowb();
>> +       return NETDEV_TX_OK;
>> +dma_error:
>> +       if (dma_unmap_len(tx_buffer, len))
>> +               dma_unmap_single(ring->dev,
>> +                                dma_unmap_addr(tx_buffer, dma),
>> +                                dma_unmap_len(tx_buffer, len),
>> +                                DMA_TO_DEVICE);
> 
> For now if there is a DMA error there is nothing to unmap since we
> only have the one buffer.  We might just look at returning -ENOMEM
> directly instead of jumping out for now.  As we add the ability to
> support scatter-gather for Tx then we can look at adding this clean-up
> since for now there is nothing to update.

removing it.

> 
>> +       dma_unmap_len_set(tx_buffer, len, 0);
>> +       ring->next_to_use = i;
>> +       return -ENOMEM;
>> +}
>> +
>>  netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>>                           struct ixgbe_adapter *adapter,
>>                           struct ixgbe_ring *tx_ring)
>> @@ -8363,6 +8563,23 @@ static void ixgbe_netpoll(struct net_device *netdev)
>>
>>  #endif
>>
>> +static void ixgbe_get_ring_stats64(struct rtnl_link_stats64 *stats,
>> +                                  struct ixgbe_ring *ring)
>> +{
>> +       u64 bytes, packets;
>> +       unsigned int start;
>> +
>> +       if (ring) {
>> +               do {
>> +                       start = u64_stats_fetch_begin_irq(&ring->syncp);
>> +                       packets = ring->stats.packets;
>> +                       bytes   = ring->stats.bytes;
>> +               } while (u64_stats_fetch_retry_irq(&ring->syncp, start));
>> +               stats->tx_packets += packets;
>> +               stats->tx_bytes   += bytes;
>> +       }
>> +}
>> +
>>  static void ixgbe_get_stats64(struct net_device *netdev,
>>                               struct rtnl_link_stats64 *stats)
>>  {
>> @@ -8388,18 +8605,13 @@ static void ixgbe_get_stats64(struct net_device *netdev,
>>
>>         for (i = 0; i < adapter->num_tx_queues; i++) {
>>                 struct ixgbe_ring *ring = ACCESS_ONCE(adapter->tx_ring[i]);
>> -               u64 bytes, packets;
>> -               unsigned int start;
>>
>> -               if (ring) {
>> -                       do {
>> -                               start = u64_stats_fetch_begin_irq(&ring->syncp);
>> -                               packets = ring->stats.packets;
>> -                               bytes   = ring->stats.bytes;
>> -                       } while (u64_stats_fetch_retry_irq(&ring->syncp, start));
>> -                       stats->tx_packets += packets;
>> -                       stats->tx_bytes   += bytes;
>> -               }
>> +               ixgbe_get_ring_stats64(stats, ring);
>> +       }
>> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +               struct ixgbe_ring *ring = ACCESS_ONCE(adapter->xdp_ring[i]);
>> +
>> +               ixgbe_get_ring_stats64(stats, ring);
>>         }
>>         rcu_read_unlock();
>>
>> @@ -8533,6 +8745,7 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
>>         }
>>
>>         ixgbe_validate_rtr(adapter, tc);
>> +       adapter->num_xdp_queues = adapter->xdp_prog ? nr_cpu_ids : 0;
>>
>>  #endif /* CONFIG_IXGBE_DCB */
>>         ixgbe_init_interrupt_scheme(adapter);
> 
> I'm confused about this.  Don't you overwrite this when you call
> ixgbe_init_interrupt_scheme?
> 

stale code nice catch. Originally I was doing the init directly in setup_tc.

>> @@ -9520,7 +9733,7 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>>  {
>>         int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
>>         struct ixgbe_adapter *adapter = netdev_priv(dev);
>> -       struct bpf_prog *old_adapter_prog;
>> +       struct bpf_prog *old_prog;
>>
>>         /* verify ixgbe ring attributes are sufficient for XDP */
>>         for (i = 0; i < adapter->num_rx_queues; i++) {
>> @@ -9533,12 +9746,26 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>>                         return -EINVAL;
>>         }
>>
>> -       old_adapter_prog = xchg(&adapter->xdp_prog, prog);
>> +       if (nr_cpu_ids > MAX_XDP_QUEUES)
>> +               return -ENOMEM;
>> +
>> +       old_prog = xchg(&adapter->xdp_prog, prog);
>> +
>> +       /* If transitioning XDP modes reconfigure rings */
>> +       if (!!adapter->xdp_prog != !!old_prog) {
>> +               int err = ixgbe_setup_tc(dev, netdev_get_num_tc(dev));
>> +
>> +               if (err) {
>> +                       rcu_assign_pointer(adapter->xdp_prog, old_prog);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>>         for (i = 0; i < adapter->num_rx_queues; i++)
>>                 ixgbe_setup_xdp_resource(adapter, adapter->rx_ring[i]);
>>
>> -       if (old_adapter_prog)
>> -               bpf_prog_put(old_adapter_prog);
>> +       if (old_prog)
>> +               bpf_prog_put(old_prog);
>>
>>         return 0;
>>  }
>> @@ -10044,6 +10271,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>         for (i = 0; i < adapter->num_tx_queues; i++)
>>                 u64_stats_init(&adapter->tx_ring[i]->syncp);
>>
>> +       for (i = 0; i < adapter->num_xdp_queues; i++)
>> +               u64_stats_init(&adapter->xdp_ring[i]->syncp);
>> +
>>         /* WOL not supported for all devices */
>>         adapter->wol = 0;
>>         hw->eeprom.ops.read(hw, 0x2c, &adapter->eeprom_cap);
>>

