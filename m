From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 4 Jun 2018 13:53:39 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 10/11] i40e: implement AF_XDP
 zero-copy support for Tx
In-Reply-To: <20180604120601.18123-11-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
 <20180604120601.18123-11-bjorn.topel@gmail.com>
Message-ID: <CAKgT0Ufu5DSdGwWDyL8u7Ce-TPMaRCexJkNUEAB-t3nAVej6BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 4, 2018 at 5:06 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Here, ndo_xsk_async_xmit is implemented. As a shortcut, the existing
> XDP Tx rings are used for zero-copy. This will result in other devices
> doing XDP_REDIRECT to an AF_XDP enabled queue will have its packets
> dropped.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   7 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  93 +++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  23 +++++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 140 ++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.h  |   2 +
>  include/net/xdp_sock.h                      |  14 +++
>  6 files changed, 242 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 8c602424d339..98c18c41809d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3073,8 +3073,12 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>         i40e_status err = 0;
>         u32 qtx_ctl = 0;
>
> -       if (ring_is_xdp(ring))
> +       ring->clean_tx_irq = i40e_clean_tx_irq;
> +       if (ring_is_xdp(ring)) {
>                 ring->xsk_umem = i40e_xsk_umem(ring);
> +               if (ring->xsk_umem)
> +                       ring->clean_tx_irq = i40e_clean_tx_irq_zc;

Again, I am worried what the performance penalty on this will be given
the retpoline penalty for function pointers.

> +       }
>
>         /* some ATR related tx ring init */
>         if (vsi->back->flags & I40E_FLAG_FD_ATR_ENABLED) {
> @@ -12162,6 +12166,7 @@ static const struct net_device_ops i40e_netdev_ops = {
>         .ndo_bpf                = i40e_xdp,
>         .ndo_xdp_xmit           = i40e_xdp_xmit,
>         .ndo_xdp_flush          = i40e_xdp_flush,
> +       .ndo_xsk_async_xmit     = i40e_xsk_async_xmit,
>  };
>
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 6b1142fbc697..923bb84a93ab 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -10,16 +10,6 @@
>  #include "i40e_trace.h"
>  #include "i40e_prototype.h"
>
> -static inline __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
> -                               u32 td_tag)
> -{
> -       return cpu_to_le64(I40E_TX_DESC_DTYPE_DATA |
> -                          ((u64)td_cmd  << I40E_TXD_QW1_CMD_SHIFT) |
> -                          ((u64)td_offset << I40E_TXD_QW1_OFFSET_SHIFT) |
> -                          ((u64)size  << I40E_TXD_QW1_TX_BUF_SZ_SHIFT) |
> -                          ((u64)td_tag  << I40E_TXD_QW1_L2TAG1_SHIFT));
> -}
> -
>  #define I40E_TXD_CMD (I40E_TX_DESC_CMD_EOP | I40E_TX_DESC_CMD_RS)
>  /**
>   * i40e_fdir - Generate a Flow Director descriptor based on fdata
> @@ -649,9 +639,13 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
>         if (!tx_ring->tx_bi)
>                 return;
>
> -       /* Free all the Tx ring sk_buffs */
> -       for (i = 0; i < tx_ring->count; i++)
> -               i40e_unmap_and_free_tx_resource(tx_ring, &tx_ring->tx_bi[i]);
> +       /* Cleanup only needed for non XSK TX ZC rings */
> +       if (!tx_ring->xsk_umem) {
> +               /* Free all the Tx ring sk_buffs */
> +               for (i = 0; i < tx_ring->count; i++)
> +                       i40e_unmap_and_free_tx_resource(tx_ring,
> +                                                       &tx_ring->tx_bi[i]);
> +       }
>
>         bi_size = sizeof(struct i40e_tx_buffer) * tx_ring->count;
>         memset(tx_ring->tx_bi, 0, bi_size);
> @@ -768,8 +762,40 @@ void i40e_detect_recover_hung(struct i40e_vsi *vsi)
>         }
>  }
>
> +void i40e_update_tx_stats(struct i40e_ring *tx_ring,
> +                         unsigned int total_packets,
> +                         unsigned int total_bytes)
> +{
> +       u64_stats_update_begin(&tx_ring->syncp);
> +       tx_ring->stats.bytes += total_bytes;
> +       tx_ring->stats.packets += total_packets;
> +       u64_stats_update_end(&tx_ring->syncp);
> +       tx_ring->q_vector->tx.total_bytes += total_bytes;
> +       tx_ring->q_vector->tx.total_packets += total_packets;
> +}
> +
>  #define WB_STRIDE 4
>
> +void i40e_arm_wb(struct i40e_ring *tx_ring,
> +                struct i40e_vsi *vsi,
> +                int budget)
> +{
> +       if (tx_ring->flags & I40E_TXR_FLAGS_WB_ON_ITR) {
> +               /* check to see if there are < 4 descriptors
> +                * waiting to be written back, then kick the hardware to force
> +                * them to be written back in case we stay in NAPI.
> +                * In this mode on X722 we do not enable Interrupt.
> +                */
> +               unsigned int j = i40e_get_tx_pending(tx_ring, false);
> +
> +               if (budget &&
> +                   ((j / WB_STRIDE) == 0) && (j > 0) &&
> +                   !test_bit(__I40E_VSI_DOWN, vsi->state) &&
> +                   (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
> +                       tx_ring->arm_wb = true;
> +       }
> +}
> +
>  /**
>   * i40e_clean_tx_irq - Reclaim resources after transmit completes
>   * @vsi: the VSI we care about
> @@ -778,8 +804,8 @@ void i40e_detect_recover_hung(struct i40e_vsi *vsi)
>   *
>   * Returns true if there's any budget left (e.g. the clean is finished)
>   **/
> -static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
> -                             struct i40e_ring *tx_ring, int napi_budget)
> +bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
> +                      struct i40e_ring *tx_ring, int napi_budget)
>  {
>         u16 i = tx_ring->next_to_clean;
>         struct i40e_tx_buffer *tx_buf;
> @@ -874,27 +900,9 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
>
>         i += tx_ring->count;
>         tx_ring->next_to_clean = i;
> -       u64_stats_update_begin(&tx_ring->syncp);
> -       tx_ring->stats.bytes += total_bytes;
> -       tx_ring->stats.packets += total_packets;
> -       u64_stats_update_end(&tx_ring->syncp);
> -       tx_ring->q_vector->tx.total_bytes += total_bytes;
> -       tx_ring->q_vector->tx.total_packets += total_packets;
> -
> -       if (tx_ring->flags & I40E_TXR_FLAGS_WB_ON_ITR) {
> -               /* check to see if there are < 4 descriptors
> -                * waiting to be written back, then kick the hardware to force
> -                * them to be written back in case we stay in NAPI.
> -                * In this mode on X722 we do not enable Interrupt.
> -                */
> -               unsigned int j = i40e_get_tx_pending(tx_ring, false);
>
> -               if (budget &&
> -                   ((j / WB_STRIDE) == 0) && (j > 0) &&
> -                   !test_bit(__I40E_VSI_DOWN, vsi->state) &&
> -                   (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
> -                       tx_ring->arm_wb = true;
> -       }
> +       i40e_update_tx_stats(tx_ring, total_packets, total_bytes);
> +       i40e_arm_wb(tx_ring, vsi, budget);
>
>         if (ring_is_xdp(tx_ring))
>                 return !!budget;
> @@ -2467,10 +2475,11 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>          * budget and be more aggressive about cleaning up the Tx descriptors.
>          */
>         i40e_for_each_ring(ring, q_vector->tx) {
> -               if (!i40e_clean_tx_irq(vsi, ring, budget)) {
> +               if (!ring->clean_tx_irq(vsi, ring, budget)) {
>                         clean_complete = false;
>                         continue;
>                 }
> +
>                 arm_wb |= ring->arm_wb;
>                 ring->arm_wb = false;
>         }
> @@ -3595,6 +3604,12 @@ int i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>         if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
>                 return -ENXIO;
>
> +       /* NB! For now, AF_XDP zero-copy hijacks the XDP ring, and
> +        * will drop incoming packets redirected by other devices!
> +        */
> +       if (vsi->xdp_rings[queue_index]->xsk_umem)
> +               return -ENXIO;
> +
>         if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>                 return -EINVAL;
>
> @@ -3633,5 +3648,11 @@ void i40e_xdp_flush(struct net_device *dev)
>         if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
>                 return;
>
> +       /* NB! For now, AF_XDP zero-copy hijacks the XDP ring, and
> +        * will drop incoming packets redirected by other devices!
> +        */
> +       if (vsi->xdp_rings[queue_index]->xsk_umem)
> +               return;
> +
>         i40e_xdp_ring_update_tail(vsi->xdp_rings[queue_index]);
>  }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index cddb185cd2f8..b9c42c352a8d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -426,6 +426,8 @@ struct i40e_ring {
>
>         int (*clean_rx_irq)(struct i40e_ring *ring, int budget);
>         bool (*alloc_rx_buffers)(struct i40e_ring *ring, u16 n);
> +       bool (*clean_tx_irq)(struct i40e_vsi *vsi, struct i40e_ring *ring,
> +                            int budget);
>         struct xdp_umem *xsk_umem;
>
>         struct zero_copy_allocator zca; /* ZC allocator anchor */
> @@ -506,6 +508,9 @@ int i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>                   u32 flags);
>  void i40e_xdp_flush(struct net_device *dev);
>  int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget);
> +bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
> +                      struct i40e_ring *tx_ring, int napi_budget);
> +int i40e_xsk_async_xmit(struct net_device *dev, u32 queue_id);
>
>  /**
>   * i40e_get_head - Retrieve head from head writeback
> @@ -687,6 +692,16 @@ static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
>         writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
>  }
>
> +static inline __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
> +                               u32 td_tag)
> +{
> +       return cpu_to_le64(I40E_TX_DESC_DTYPE_DATA |
> +                          ((u64)td_cmd  << I40E_TXD_QW1_CMD_SHIFT) |
> +                          ((u64)td_offset << I40E_TXD_QW1_OFFSET_SHIFT) |
> +                          ((u64)size  << I40E_TXD_QW1_TX_BUF_SZ_SHIFT) |
> +                          ((u64)td_tag  << I40E_TXD_QW1_L2TAG1_SHIFT));
> +}
> +
>  void i40e_fd_handle_status(struct i40e_ring *rx_ring,
>                            union i40e_rx_desc *rx_desc, u8 prog_id);
>  int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp,
> @@ -696,4 +711,12 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>                              u8 rx_ptype);
>  void i40e_receive_skb(struct i40e_ring *rx_ring,
>                       struct sk_buff *skb, u16 vlan_tag);
> +
> +void i40e_update_tx_stats(struct i40e_ring *tx_ring,
> +                         unsigned int total_packets,
> +                         unsigned int total_bytes);
> +void i40e_arm_wb(struct i40e_ring *tx_ring,
> +                struct i40e_vsi *vsi,
> +                int budget);
> +
>  #endif /* _I40E_TXRX_H_ */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9d16924415b9..021fec5b5799 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -535,3 +535,143 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>         return failure ? budget : (int)total_rx_packets;
>  }
>
> +/* Returns true if the work is finished */
> +static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
> +{
> +       unsigned int total_packets = 0, total_bytes = 0;
> +       struct i40e_tx_buffer *tx_bi;
> +       struct i40e_tx_desc *tx_desc;
> +       bool work_done = true;
> +       dma_addr_t dma;
> +       u32 len;
> +
> +       while (budget-- > 0) {
> +               if (!unlikely(I40E_DESC_UNUSED(xdp_ring))) {
> +                       xdp_ring->tx_stats.tx_busy++;
> +                       work_done = false;
> +                       break;
> +               }
> +
> +               if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
> +                       break;
> +
> +               dma_sync_single_for_device(xdp_ring->dev, dma, len,
> +                                          DMA_BIDIRECTIONAL);
> +
> +               tx_bi = &xdp_ring->tx_bi[xdp_ring->next_to_use];
> +               tx_bi->bytecount = len;
> +               tx_bi->gso_segs = 1;
> +
> +               tx_desc = I40E_TX_DESC(xdp_ring, xdp_ring->next_to_use);
> +               tx_desc->buffer_addr = cpu_to_le64(dma);
> +               tx_desc->cmd_type_offset_bsz = build_ctob(I40E_TX_DESC_CMD_ICRC
> +                                                       | I40E_TX_DESC_CMD_EOP,
> +                                                         0, len, 0);
> +
> +               total_packets++;
> +               total_bytes += len;
> +
> +               xdp_ring->next_to_use++;
> +               if (xdp_ring->next_to_use == xdp_ring->count)
> +                       xdp_ring->next_to_use = 0;
> +       }
> +
> +       if (total_packets > 0) {
> +               /* Request an interrupt for the last frame and bump tail ptr. */
> +               tx_desc->cmd_type_offset_bsz |= (I40E_TX_DESC_CMD_RS <<
> +                                                I40E_TXD_QW1_CMD_SHIFT);
> +               i40e_xdp_ring_update_tail(xdp_ring);
> +
> +               xsk_umem_consume_tx_done(xdp_ring->xsk_umem);
> +               i40e_update_tx_stats(xdp_ring, total_packets, total_bytes);
> +       }
> +

So this code is likely vulnerable to an issue we were seeing where the
Tx was stalling and surging when xmit_more was in use. We found the
issue was that we were only setting the RS once per ring fill. As a
result the ring was either full or empty from the drivers perspective.
This ends up with poor Tx performance when it occurs. As such you may
want to set the RS bit at least twice per fill so you may want to look
at going through the lesser of either half the ring size or the
budget, then set the RS, and repeat with whatever budget you have
remaining. That way the ring should on average be 50% utilized instead
of either 100% or 0%.

> +       return !!budget && work_done;
> +}
> +
> +bool i40e_clean_tx_irq_zc(struct i40e_vsi *vsi,
> +                         struct i40e_ring *tx_ring, int napi_budget)
> +{
> +       struct xdp_umem *umem = tx_ring->xsk_umem;
> +       u32 head_idx = i40e_get_head(tx_ring);
> +       unsigned int budget = vsi->work_limit;
> +       bool work_done = true, xmit_done;
> +       u32 completed_frames;
> +       u32 frames_ready;
> +
> +       if (head_idx < tx_ring->next_to_clean)
> +               head_idx += tx_ring->count;
> +       frames_ready = head_idx - tx_ring->next_to_clean;
> +
> +       if (frames_ready == 0) {
> +               goto out_xmit;
> +       } else if (frames_ready > budget) {
> +               completed_frames = budget;
> +               work_done = false;
> +       } else {
> +               completed_frames = frames_ready;
> +       }
> +
> +       tx_ring->next_to_clean += completed_frames;
> +       if (unlikely(tx_ring->next_to_clean >= tx_ring->count))
> +               tx_ring->next_to_clean -= tx_ring->count;
> +
> +       xsk_umem_complete_tx(umem, completed_frames);
> +
> +       i40e_arm_wb(tx_ring, vsi, budget);
> +
> +out_xmit:
> +       xmit_done = i40e_xmit_zc(tx_ring, budget);
> +
> +       return work_done && xmit_done;
> +}

I am not a fan of using head write-back. This code just seems shaky at
best to me. Am I understanding correctly that you are using the Tx
cleanup to transmit frames?

> +
> +/**
> + * i40e_napi_is_scheduled - If napi is running, set the NAPIF_STATE_MISSED
> + * @n: napi context
> + *
> + * Returns true if NAPI is scheduled.
> + **/
> +static bool i40e_napi_is_scheduled(struct napi_struct *n)
> +{
> +       unsigned long val, new;
> +
> +       do {
> +               val = READ_ONCE(n->state);
> +               if (val & NAPIF_STATE_DISABLE)
> +                       return true;
> +
> +               if (!(val & NAPIF_STATE_SCHED))
> +                       return false;
> +
> +               new = val | NAPIF_STATE_MISSED;
> +       } while (cmpxchg(&n->state, val, new) != val);
> +

This code does not belong here. This is core kernel code, not anything
driver specific. Probably not needed if you drop the call below.

> +       return true;
> +}
> +
> +int i40e_xsk_async_xmit(struct net_device *dev, u32 queue_id)
> +{
> +       struct i40e_netdev_priv *np = netdev_priv(dev);
> +       struct i40e_vsi *vsi = np->vsi;
> +       struct i40e_ring *ring;
> +
> +       if (test_bit(__I40E_VSI_DOWN, vsi->state))
> +               return -ENETDOWN;
> +
> +       if (!i40e_enabled_xdp_vsi(vsi))
> +               return -ENXIO;
> +
> +       if (queue_id >= vsi->num_queue_pairs)
> +               return -ENXIO;
> +
> +       if (!vsi->xdp_rings[queue_id]->xsk_umem)
> +               return -ENXIO;
> +
> +       ring = vsi->xdp_rings[queue_id];
> +
> +       if (!i40e_napi_is_scheduled(&ring->q_vector->napi))
> +               i40e_force_wb(vsi, ring->q_vector);

We really shouldn't have napi being scheduled by the Tx path.

> +
> +       return 0;
> +}

Again, more comments might be helpful here.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
> index 757ac5ca8511..bd006f1a4397 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
> @@ -13,5 +13,7 @@ int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
>  void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
>  bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 cleaned_count);
>  int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget);
> +bool i40e_clean_tx_irq_zc(struct i40e_vsi *vsi,
> +                         struct i40e_ring *tx_ring, int napi_budget);
>
>  #endif /* _I40E_XSK_H_ */
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ec8fd3314097..63aa05abf11d 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -103,6 +103,20 @@ static inline u64 *xsk_umem_peek_addr(struct xdp_umem *umem, u64 *addr)
>  static inline void xsk_umem_discard_addr(struct xdp_umem *umem)
>  {
>  }
> +
> +static inline void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries)
> +{
> +}
> +
> +static inline bool xsk_umem_consume_tx(struct xdp_umem *umem, dma_addr_t *dma,
> +                                      u32 *len)
> +{
> +       return false;
> +}
> +
> +static inline void xsk_umem_consume_tx_done(struct xdp_umem *umem)
> +{
> +}
>  #endif /* CONFIG_XDP_SOCKETS */
>
>  static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
> --
> 2.14.1
>
