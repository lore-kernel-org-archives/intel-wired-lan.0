From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 15 May 2018 13:25:54 -0700
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 11/12] i40e: implement
 AF_XDP zero-copy support for Rx
In-Reply-To: <20180515190615.23099-12-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
 <20180515190615.23099-12-bjorn.topel@gmail.com>
Message-ID: <CAKgT0UdBMFtmMSXGChj_Hq0UOs1OLMEDxtQ2Lg2c-bY=oObMeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 15, 2018 at 12:06 PM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> A lot of things here. First we add support for the new
> XDP_SETUP_XSK_UMEM command in ndo_bpf. This allows the AF_XDP socket
> to pass a UMEM to the driver. The driver will then DMA map all the
> frames in the UMEM for the driver. Next, the Rx code will allocate
> frames from the UMEM fill queue, instead of the regular page
> allocator.
>
> Externally, for the rest of the XDP code, the driver the driver
> internal UMEM allocator will appear as a MEM_TYPE_ZERO_COPY.
>
> Keep in mind that having frames coming from userland requires some
> extra care taken when passing them to the regular kernel stack. In
> these cases the ZC frame must be copied.
>
> The commit also introduces a completely new clean_rx_irq/allocator
> functions for zero-copy, and means (functions pointers) to set
> allocators and clean_rx functions.
>
> Finally, a lot of this are *not* implemented here. To mention some:
>
> * No passing to the stack via XDP_PASS (clone/copy to skb).
> * No XDP redirect to other than sockets (convert_to_xdp_frame does not
>   clone the frame yet).
>
> And yes, too much C&P and too big commit. :-)
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

A few minor comments below.

> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  20 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 202 +++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 400 ++++++++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  30 ++-
>  4 files changed, 619 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 7a80652e2500..e6ee6c9bf094 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -786,6 +786,12 @@ struct i40e_vsi {
>
>         /* VSI specific handlers */
>         irqreturn_t (*irq_handler)(int irq, void *data);
> +
> +       /* AF_XDP zero-copy */
> +       struct xdp_umem **xsk_umems;
> +       u16 num_xsk_umems_used;
> +       u16 num_xsk_umems;
> +
>  } ____cacheline_internodealigned_in_smp;
>
>  struct i40e_netdev_priv {
> @@ -1090,6 +1096,20 @@ static inline bool i40e_enabled_xdp_vsi(struct i40e_vsi *vsi)
>         return !!vsi->xdp_prog;
>  }
>
> +static inline struct xdp_umem *i40e_xsk_umem(struct i40e_ring *ring)
> +{
> +       bool xdp_on = i40e_enabled_xdp_vsi(ring->vsi);
> +       int qid = ring->queue_index;
> +
> +       if (ring_is_xdp(ring))
> +               qid -= ring->vsi->alloc_queue_pairs;
> +
> +       if (!ring->vsi->xsk_umems || !ring->vsi->xsk_umems[qid] || !xdp_on)
> +               return NULL;
> +
> +       return ring->vsi->xsk_umems[qid];
> +}
> +
>  int i40e_create_queue_channel(struct i40e_vsi *vsi, struct i40e_channel *ch);
>  int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate);
>  int i40e_add_del_cloud_filter(struct i40e_vsi *vsi,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index b4c23cf3979c..dc3d668a741e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -5,6 +5,7 @@
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
>  #include <linux/bpf.h>
> +#include <net/xdp_sock.h>
>
>  /* Local includes */
>  #include "i40e.h"
> @@ -3054,6 +3055,9 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>         i40e_status err = 0;
>         u32 qtx_ctl = 0;
>
> +       if (ring_is_xdp(ring))
> +               ring->xsk_umem = i40e_xsk_umem(ring);
> +
>         /* some ATR related tx ring init */
>         if (vsi->back->flags & I40E_FLAG_FD_ATR_ENABLED) {
>                 ring->atr_sample_rate = vsi->back->atr_sample_rate;
> @@ -3163,13 +3167,31 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>         struct i40e_hw *hw = &vsi->back->hw;
>         struct i40e_hmc_obj_rxq rx_ctx;
>         i40e_status err = 0;
> +       int ret;
>
>         bitmap_zero(ring->state, __I40E_RING_STATE_NBITS);
>
>         /* clear the context structure first */
>         memset(&rx_ctx, 0, sizeof(rx_ctx));
>
> -       ring->rx_buf_len = vsi->rx_buf_len;
> +       ring->xsk_umem = i40e_xsk_umem(ring);
> +       if (ring->xsk_umem) {
> +               ring->clean_rx_irq = i40e_clean_rx_irq_zc;
> +               ring->alloc_rx_buffers = i40e_alloc_rx_buffers_zc;
> +               ring->rx_buf_len = ring->xsk_umem->props.frame_size -
> +                                  ring->xsk_umem->frame_headroom -
> +                                  XDP_PACKET_HEADROOM;
> +               ring->zca.free = i40e_zca_free;
> +               ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +                                                MEM_TYPE_ZERO_COPY,
> +                                                &ring->zca);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               ring->clean_rx_irq = i40e_clean_rx_irq;
> +               ring->alloc_rx_buffers = i40e_alloc_rx_buffers;
> +               ring->rx_buf_len = vsi->rx_buf_len;
> +       }
>
>         rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
>                                     BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
> @@ -3225,7 +3247,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>         ring->tail = hw->hw_addr + I40E_QRX_TAIL(pf_q);
>         writel(0, ring->tail);
>
> -       i40e_alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
> +       ring->alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
>
>         return 0;
>  }
> @@ -12050,6 +12072,179 @@ static int i40e_queue_pair_enable(struct i40e_vsi *vsi, int queue_pair)
>         return err;
>  }
>
> +static int i40e_alloc_xsk_umems(struct i40e_vsi *vsi)
> +{
> +       if (vsi->xsk_umems)
> +               return 0;
> +
> +       vsi->num_xsk_umems_used = 0;
> +       vsi->num_xsk_umems = vsi->alloc_queue_pairs;
> +       vsi->xsk_umems = kcalloc(vsi->num_xsk_umems, sizeof(*vsi->xsk_umems),
> +                                GFP_KERNEL);
> +       if (!vsi->xsk_umems) {
> +               vsi->num_xsk_umems = 0;
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int i40e_add_xsk_umem(struct i40e_vsi *vsi, struct xdp_umem *umem,
> +                            u16 qid)
> +{
> +       int err;
> +
> +       err = i40e_alloc_xsk_umems(vsi);
> +       if (err)
> +               return err;
> +
> +       vsi->xsk_umems[qid] = umem;
> +       vsi->num_xsk_umems_used++;
> +
> +       return 0;
> +}
> +
> +static void i40e_remove_xsk_umem(struct i40e_vsi *vsi, u16 qid)
> +{
> +       vsi->xsk_umems[qid] = NULL;
> +       vsi->num_xsk_umems_used--;
> +
> +       if (vsi->num_xsk_umems == 0) {
> +               kfree(vsi->xsk_umems);
> +               vsi->xsk_umems = NULL;
> +               vsi->num_xsk_umems = 0;
> +       }
> +}
> +
> +static int i40e_xsk_umem_dma_map(struct i40e_vsi *vsi, struct xdp_umem *umem)
> +{
> +       struct i40e_pf *pf = vsi->back;
> +       struct device *dev;
> +       unsigned int i, j;
> +       dma_addr_t dma;
> +
> +       dev = &pf->pdev->dev;
> +
> +       for (i = 0; i < umem->props.nframes; i++) {
> +               dma = dma_map_single_attrs(dev, umem->frames[i].addr,
> +                                          umem->props.frame_size,
> +                                          DMA_BIDIRECTIONAL, I40E_RX_DMA_ATTR);
> +               if (dma_mapping_error(dev, dma))
> +                       goto out_unmap;
> +
> +               umem->frames[i].dma = dma;
> +       }
> +
> +       return 0;
> +
> +out_unmap:
> +       for (j = 0; j < i; j++) {
> +               dma_unmap_single_attrs(dev, umem->frames[i].dma,
> +                                      umem->props.frame_size,
> +                                      DMA_BIDIRECTIONAL,
> +                                      I40E_RX_DMA_ATTR);
> +               umem->frames[i].dma = 0;
> +       }
> +
> +       return -1;
> +}
> +
> +static void i40e_xsk_umem_dma_unmap(struct i40e_vsi *vsi, struct xdp_umem *umem)
> +{
> +       struct i40e_pf *pf = vsi->back;
> +       struct device *dev;
> +       unsigned int i;
> +
> +       dev = &pf->pdev->dev;
> +
> +       for (i = 0; i < umem->props.nframes; i++) {
> +               dma_unmap_single_attrs(dev, umem->frames[i].dma,
> +                                      umem->props.frame_size,
> +                                      DMA_BIDIRECTIONAL,
> +                                      I40E_RX_DMA_ATTR);
> +
> +               umem->frames[i].dma = 0;
> +       }
> +}
> +
> +static int i40e_xsk_umem_enable(struct i40e_vsi *vsi, struct xdp_umem *umem,
> +                               u16 qid)
> +{
> +       bool if_running;
> +       int err;
> +
> +       if (vsi->type != I40E_VSI_MAIN)
> +               return -EINVAL;
> +
> +       if (qid >= vsi->num_queue_pairs)
> +               return -EINVAL;
> +
> +       if (vsi->xsk_umems && vsi->xsk_umems[qid])
> +               return -EBUSY;
> +
> +       err = i40e_xsk_umem_dma_map(vsi, umem);
> +       if (err)
> +               return err;
> +
> +       if_running = netif_running(vsi->netdev) && i40e_enabled_xdp_vsi(vsi);
> +
> +       if (if_running) {
> +               err = i40e_queue_pair_disable(vsi, qid);
> +               if (err)
> +                       return err;
> +       }
> +
> +       err = i40e_add_xsk_umem(vsi, umem, qid);
> +       if (err)
> +               return err;
> +
> +       if (if_running) {
> +               err = i40e_queue_pair_enable(vsi, qid);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int i40e_xsk_umem_disable(struct i40e_vsi *vsi, u16 qid)
> +{
> +       bool if_running;
> +       int err;
> +
> +       if (!vsi->xsk_umems || qid >= vsi->num_xsk_umems ||
> +           !vsi->xsk_umems[qid])
> +               return -EINVAL;
> +
> +       if_running = netif_running(vsi->netdev) && i40e_enabled_xdp_vsi(vsi);
> +
> +       if (if_running) {
> +               err = i40e_queue_pair_disable(vsi, qid);
> +               if (err)
> +                       return err;
> +       }
> +
> +       i40e_xsk_umem_dma_unmap(vsi, vsi->xsk_umems[qid]);
> +       i40e_remove_xsk_umem(vsi, qid);
> +
> +       if (if_running) {
> +               err = i40e_queue_pair_enable(vsi, qid);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
> +                              u16 qid)
> +{
> +       if (umem)
> +               return i40e_xsk_umem_enable(vsi, umem, qid);
> +
> +       return i40e_xsk_umem_disable(vsi, qid);
> +}
> +
>  /**
>   * i40e_xdp - implements ndo_bpf for i40e
>   * @dev: netdevice
> @@ -12071,6 +12266,9 @@ static int i40e_xdp(struct net_device *dev,
>                 xdp->prog_attached = i40e_enabled_xdp_vsi(vsi);
>                 xdp->prog_id = vsi->xdp_prog ? vsi->xdp_prog->aux->id : 0;
>                 return 0;
> +       case XDP_SETUP_XSK_UMEM:
> +               return i40e_xsk_umem_setup(vsi, xdp->xsk.umem,
> +                                          xdp->xsk.queue_id);
>         default:
>                 return -EINVAL;
>         }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 5efa68de935b..f89ac524652c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -5,6 +5,7 @@
>  #include <net/busy_poll.h>
>  #include <linux/bpf_trace.h>
>  #include <net/xdp.h>
> +#include <net/xdp_sock.h>
>  #include "i40e.h"
>  #include "i40e_trace.h"
>  #include "i40e_prototype.h"
> @@ -1373,31 +1374,35 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>         }
>
>         /* Free all the Rx ring sk_buffs */
> -       for (i = 0; i < rx_ring->count; i++) {
> -               struct i40e_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
> +       if (!rx_ring->xsk_umem) {
> +               for (i = 0; i < rx_ring->count; i++) {

I'm not a fan of all this extra indenting. This could be much more
easily handled with just a goto and a label.

> +                       struct i40e_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
>
> -               if (!rx_bi->page)
> -                       continue;
> -
> -               /* Invalidate cache lines that may have been written to by
> -                * device so that we avoid corrupting memory.
> -                */
> -               dma_sync_single_range_for_cpu(rx_ring->dev,
> -                                             rx_bi->dma,
> -                                             rx_bi->page_offset,
> -                                             rx_ring->rx_buf_len,
> -                                             DMA_FROM_DEVICE);
> -
> -               /* free resources associated with mapping */
> -               dma_unmap_page_attrs(rx_ring->dev, rx_bi->dma,
> -                                    i40e_rx_pg_size(rx_ring),
> -                                    DMA_FROM_DEVICE,
> -                                    I40E_RX_DMA_ATTR);
> -
> -               __page_frag_cache_drain(rx_bi->page, rx_bi->pagecnt_bias);
> +                       if (!rx_bi->page)
> +                               continue;
>
> -               rx_bi->page = NULL;
> -               rx_bi->page_offset = 0;
> +                       /* Invalidate cache lines that may have been
> +                        * written to by device so that we avoid
> +                        * corrupting memory.
> +                        */
> +                       dma_sync_single_range_for_cpu(rx_ring->dev,
> +                                                     rx_bi->dma,
> +                                                     rx_bi->page_offset,
> +                                                     rx_ring->rx_buf_len,
> +                                                     DMA_FROM_DEVICE);
> +
> +                       /* free resources associated with mapping */
> +                       dma_unmap_page_attrs(rx_ring->dev, rx_bi->dma,
> +                                            i40e_rx_pg_size(rx_ring),
> +                                            DMA_FROM_DEVICE,
> +                                            I40E_RX_DMA_ATTR);
> +
> +                       __page_frag_cache_drain(rx_bi->page,
> +                                               rx_bi->pagecnt_bias);
> +
> +                       rx_bi->page = NULL;
> +                       rx_bi->page_offset = 0;
> +               }
>         }
>
>         bi_size = sizeof(struct i40e_rx_buffer) * rx_ring->count;
> @@ -2214,8 +2219,6 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
>         if (!xdp_prog)
>                 goto xdp_out;
>
> -       prefetchw(xdp->data_hard_start); /* xdp_frame write */
> -
>         act = bpf_prog_run_xdp(xdp_prog, xdp);
>         switch (act) {
>         case XDP_PASS:
> @@ -2284,7 +2287,7 @@ static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
>   *
>   * Returns amount of work completed
>   **/
> -static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
> +int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>  {
>         unsigned int total_rx_bytes = 0, total_rx_packets = 0;
>         struct sk_buff *skb = rx_ring->skb;
> @@ -2426,6 +2429,349 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>         return failure ? budget : (int)total_rx_packets;
>  }
>

How much of the code below is actually reused anywhere else? I would
almost be inclined to say that maybe the zero-copy path should be
moved to a new file since so much of this is being duplicated from the
original tx/rx code path. I can easily see this becoming confusing as
to which is which when a bug gets found and needs to be fixed.

> +static struct sk_buff *i40e_run_xdp_zc(struct i40e_ring *rx_ring,
> +                                      struct xdp_buff *xdp)
> +{
> +       int err, result = I40E_XDP_PASS;
> +       struct i40e_ring *xdp_ring;
> +       struct bpf_prog *xdp_prog;
> +       u32 act;
> +
> +       rcu_read_lock();
> +       xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
> +       act = bpf_prog_run_xdp(xdp_prog, xdp);
> +       switch (act) {
> +       case XDP_PASS:
> +               break;
> +       case XDP_TX:
> +               xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
> +               result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
> +               break;
> +       case XDP_REDIRECT:
> +               err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
> +               result = !err ? I40E_XDP_TX : I40E_XDP_CONSUMED;
> +               break;
> +       default:
> +               bpf_warn_invalid_xdp_action(act);
> +       case XDP_ABORTED:
> +               trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> +               /* fallthrough -- handle aborts by dropping packet */
> +       case XDP_DROP:
> +               result = I40E_XDP_CONSUMED;
> +               break;
> +       }
> +
> +       rcu_read_unlock();
> +       return ERR_PTR(-result);
> +}
> +
> +static bool i40e_alloc_frame_zc(struct i40e_ring *rx_ring,
> +                               struct i40e_rx_buffer *bi)
> +{
> +       struct xdp_umem *umem = rx_ring->xsk_umem;
> +       void *addr = bi->addr;
> +       u32 *id;
> +
> +       if (addr) {
> +               rx_ring->rx_stats.page_reuse_count++;
> +               return true;
> +       }
> +
> +       id = xsk_umem_peek_id(umem);
> +       if (unlikely(!id)) {
> +               rx_ring->rx_stats.alloc_page_failed++;
> +               return false;
> +       }
> +
> +       bi->dma = umem->frames[*id].dma + umem->frame_headroom +
> +                 XDP_PACKET_HEADROOM;
> +       bi->addr = umem->frames[*id].addr + umem->frame_headroom +
> +                 XDP_PACKET_HEADROOM;
> +       bi->id = *id;
> +
> +       xsk_umem_discard_id(umem);
> +       return true;
> +}
> +
> +bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 cleaned_count)
> +{
> +       u16 ntu = rx_ring->next_to_use;
> +       union i40e_rx_desc *rx_desc;
> +       struct i40e_rx_buffer *bi;
> +
> +       rx_desc = I40E_RX_DESC(rx_ring, ntu);
> +       bi = &rx_ring->rx_bi[ntu];
> +
> +       do {
> +               if (!i40e_alloc_frame_zc(rx_ring, bi))
> +                       goto no_buffers;
> +
> +               /* sync the buffer for use by the device */
> +               dma_sync_single_range_for_device(rx_ring->dev, bi->dma, 0,
> +                                                rx_ring->rx_buf_len,
> +                                                DMA_BIDIRECTIONAL);
> +
> +               /* Refresh the desc even if buffer_addrs didn't change
> +                * because each write-back erases this info.
> +                */
> +               rx_desc->read.pkt_addr = cpu_to_le64(bi->dma);
> +
> +               rx_desc++;
> +               bi++;
> +               ntu++;
> +               if (unlikely(ntu == rx_ring->count)) {
> +                       rx_desc = I40E_RX_DESC(rx_ring, 0);
> +                       bi = rx_ring->rx_bi;
> +                       ntu = 0;
> +               }
> +
> +               /* clear the status bits for the next_to_use descriptor */
> +               rx_desc->wb.qword1.status_error_len = 0;
> +
> +               cleaned_count--;
> +       } while (cleaned_count);
> +
> +       if (rx_ring->next_to_use != ntu)
> +               i40e_release_rx_desc(rx_ring, ntu);
> +
> +       return false;
> +
> +no_buffers:
> +       if (rx_ring->next_to_use != ntu)
> +               i40e_release_rx_desc(rx_ring, ntu);
> +
> +       /* make sure to come back via polling to try again after
> +        * allocation failure
> +        */
> +       return true;
> +}
> +
> +static struct i40e_rx_buffer *i40e_get_rx_buffer_zc(struct i40e_ring *rx_ring,
> +                                                   const unsigned int size)
> +{
> +       struct i40e_rx_buffer *rx_buffer;
> +
> +       rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
> +
> +       /* we are reusing so sync this buffer for CPU use */
> +       dma_sync_single_range_for_cpu(rx_ring->dev,
> +                                     rx_buffer->dma, 0,
> +                                     size,
> +                                     DMA_BIDIRECTIONAL);
> +
> +       return rx_buffer;
> +}
> +
> +static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
> +                                   struct i40e_rx_buffer *old_buff)
> +{
> +       struct i40e_rx_buffer *new_buff;
> +       u16 nta = rx_ring->next_to_alloc;
> +
> +       new_buff = &rx_ring->rx_bi[nta];
> +
> +       /* update, and store next to alloc */
> +       nta++;
> +       rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
> +
> +       /* transfer page from old buffer to new buffer */
> +       new_buff->dma  = old_buff->dma;
> +       new_buff->addr = old_buff->addr;
> +       new_buff->id   = old_buff->id;
> +}
> +
> +/* Called from the XDP return API in NAPI context. */
> +void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
> +{
> +       struct i40e_rx_buffer *new_buff;
> +       struct i40e_ring *rx_ring;
> +       u16 nta;
> +
> +       rx_ring = container_of(alloc, struct i40e_ring, zca);
> +       nta = rx_ring->next_to_alloc;
> +
> +       new_buff = &rx_ring->rx_bi[nta];
> +
> +       /* update, and store next to alloc */
> +       nta++;
> +       rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
> +
> +       new_buff->dma  = rx_ring->xsk_umem->frames[handle].dma;
> +       new_buff->addr = rx_ring->xsk_umem->frames[handle].addr;
> +       new_buff->id   = (u32)handle;
> +}
> +
> +static struct sk_buff *i40e_zc_frame_to_skb(struct i40e_ring *rx_ring,
> +                                           struct i40e_rx_buffer *rx_buffer,
> +                                           struct xdp_buff *xdp)
> +{
> +       // XXX implement alloc skb and copy
> +       i40e_reuse_rx_buffer_zc(rx_ring, rx_buffer);
> +       return NULL;
> +}
> +
> +static void i40e_clean_programming_status_zc(struct i40e_ring *rx_ring,
> +                                            union i40e_rx_desc *rx_desc,
> +                                            u64 qw)
> +{
> +       struct i40e_rx_buffer *rx_buffer;
> +       u32 ntc = rx_ring->next_to_clean;
> +       u8 id;
> +
> +       /* fetch, update, and store next to clean */
> +       rx_buffer = &rx_ring->rx_bi[ntc++];
> +       ntc = (ntc < rx_ring->count) ? ntc : 0;
> +       rx_ring->next_to_clean = ntc;
> +
> +       prefetch(I40E_RX_DESC(rx_ring, ntc));
> +
> +       /* place unused page back on the ring */
> +       i40e_reuse_rx_buffer_zc(rx_ring, rx_buffer);
> +       rx_ring->rx_stats.page_reuse_count++;
> +
> +       /* clear contents of buffer_info */
> +       rx_buffer->addr = NULL;
> +
> +       id = (qw & I40E_RX_PROG_STATUS_DESC_QW1_PROGID_MASK) >>
> +                 I40E_RX_PROG_STATUS_DESC_QW1_PROGID_SHIFT;
> +
> +       if (id == I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS)
> +               i40e_fd_handle_status(rx_ring, rx_desc, id);
> +}
> +
> +int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> +{
> +       unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> +       u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
> +       bool failure = false, xdp_xmit = false;
> +       struct sk_buff *skb;
> +       struct xdp_buff xdp;
> +
> +       xdp.rxq = &rx_ring->xdp_rxq;
> +
> +       while (likely(total_rx_packets < (unsigned int)budget)) {
> +               struct i40e_rx_buffer *rx_buffer;
> +               union i40e_rx_desc *rx_desc;
> +               unsigned int size;
> +               u16 vlan_tag;
> +               u8 rx_ptype;
> +               u64 qword;
> +               u32 ntc;
> +
> +               /* return some buffers to hardware, one at a time is too slow */
> +               if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
> +                       failure = failure ||
> +                                 i40e_alloc_rx_buffers_zc(rx_ring,
> +                                                          cleaned_count);
> +                       cleaned_count = 0;
> +               }
> +
> +               rx_desc = I40E_RX_DESC(rx_ring, rx_ring->next_to_clean);
> +
> +               /* status_error_len will always be zero for unused descriptors
> +                * because it's cleared in cleanup, and overlaps with hdr_addr
> +                * which is always zero because packet split isn't used, if the
> +                * hardware wrote DD then the length will be non-zero
> +                */
> +               qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> +
> +               /* This memory barrier is needed to keep us from reading
> +                * any other fields out of the rx_desc until we have
> +                * verified the descriptor has been written back.
> +                */
> +               dma_rmb();
> +
> +               if (unlikely(i40e_rx_is_programming_status(qword))) {
> +                       i40e_clean_programming_status_zc(rx_ring, rx_desc,
> +                                                        qword);
> +                       cleaned_count++;
> +                       continue;
> +               }
> +               size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
> +                      I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
> +               if (!size)
> +                       break;
> +
> +               rx_buffer = i40e_get_rx_buffer_zc(rx_ring, size);
> +
> +               /* retrieve a buffer from the ring */
> +               xdp.data = rx_buffer->addr;
> +               xdp_set_data_meta_invalid(&xdp);
> +               xdp.data_hard_start = xdp.data - XDP_PACKET_HEADROOM;
> +               xdp.data_end = xdp.data + size;
> +               xdp.handle = rx_buffer->id;
> +
> +               skb = i40e_run_xdp_zc(rx_ring, &xdp);
> +
> +               if (IS_ERR(skb)) {
> +                       if (PTR_ERR(skb) == -I40E_XDP_TX)
> +                               xdp_xmit = true;
> +                       else
> +                               i40e_reuse_rx_buffer_zc(rx_ring, rx_buffer);
> +                       total_rx_bytes += size;
> +                       total_rx_packets++;
> +               } else {
> +                       skb = i40e_zc_frame_to_skb(rx_ring, rx_buffer, &xdp);
> +                       if (!skb) {
> +                               rx_ring->rx_stats.alloc_buff_failed++;
> +                               break;
> +                       }
> +               }
> +
> +               rx_buffer->addr = NULL;
> +               cleaned_count++;
> +
> +               /* don't care about non-EOP frames in XDP mode */
> +               ntc = rx_ring->next_to_clean + 1;
> +               ntc = (ntc < rx_ring->count) ? ntc : 0;
> +               rx_ring->next_to_clean = ntc;
> +               prefetch(I40E_RX_DESC(rx_ring, ntc));
> +
> +               if (i40e_cleanup_headers(rx_ring, skb, rx_desc)) {
> +                       skb = NULL;
> +                       continue;
> +               }
> +
> +               /* probably a little skewed due to removing CRC */
> +               total_rx_bytes += skb->len;
> +
> +               qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> +               rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
> +                          I40E_RXD_QW1_PTYPE_SHIFT;
> +
> +               /* populate checksum, VLAN, and protocol */
> +               i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
> +
> +               vlan_tag = (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) ?
> +                          le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1) : 0;
> +
> +               i40e_receive_skb(rx_ring, skb, vlan_tag);
> +               skb = NULL;
> +
> +               /* update budget accounting */
> +               total_rx_packets++;
> +       }
> +
> +       if (xdp_xmit) {
> +               struct i40e_ring *xdp_ring =
> +                       rx_ring->vsi->xdp_rings[rx_ring->queue_index];
> +
> +               i40e_xdp_ring_update_tail(xdp_ring);
> +               xdp_do_flush_map();
> +       }
> +
> +       u64_stats_update_begin(&rx_ring->syncp);
> +       rx_ring->stats.packets += total_rx_packets;
> +       rx_ring->stats.bytes += total_rx_bytes;
> +       u64_stats_update_end(&rx_ring->syncp);
> +       rx_ring->q_vector->rx.total_packets += total_rx_packets;
> +       rx_ring->q_vector->rx.total_bytes += total_rx_bytes;
> +
> +       /* guarantee a trip back through this routine if there was a failure */
> +       return failure ? budget : (int)total_rx_packets;
> +}
> +
>  static inline u32 i40e_buildreg_itr(const int type, u16 itr)
>  {
>         u32 val;
> @@ -2576,7 +2922,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>         budget_per_ring = max(budget/q_vector->num_ringpairs, 1);
>
>         i40e_for_each_ring(ring, q_vector->rx) {
> -               int cleaned = i40e_clean_rx_irq(ring, budget_per_ring);
> +               int cleaned = ring->clean_rx_irq(ring, budget_per_ring);
>
>                 work_done += cleaned;
>                 /* if we clean as many as budgeted, we must not be done */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index fdd2c55f03a6..9d5d9862e9f1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -296,13 +296,22 @@ struct i40e_tx_buffer {
>
>  struct i40e_rx_buffer {
>         dma_addr_t dma;
> -       struct page *page;
> +       union {
> +               struct {
> +                       struct page *page;
>  #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
> -       __u32 page_offset;
> +                       __u32 page_offset;
>  #else
> -       __u16 page_offset;
> +                       __u16 page_offset;
>  #endif
> -       __u16 pagecnt_bias;
> +                       __u16 pagecnt_bias;
> +               };
> +               struct {
> +                       /* for umem */
> +                       void *addr;
> +                       u32 id;
> +               };
> +       };
>  };
>
>  struct i40e_queue_stats {
> @@ -344,6 +353,8 @@ enum i40e_ring_state_t {
>  #define I40E_RX_SPLIT_TCP_UDP 0x4
>  #define I40E_RX_SPLIT_SCTP    0x8
>
> +void i40e_zc_recycle(struct zero_copy_allocator *alloc, unsigned long handle);
> +
>  /* struct that defines a descriptor ring, associated with a VSI */
>  struct i40e_ring {
>         struct i40e_ring *next;         /* pointer to next ring in q_vector */
> @@ -414,6 +425,12 @@ struct i40e_ring {
>
>         struct i40e_channel *ch;
>         struct xdp_rxq_info xdp_rxq;
> +
> +       int (*clean_rx_irq)(struct i40e_ring *, int);
> +       bool (*alloc_rx_buffers)(struct i40e_ring *, u16);
> +       struct xdp_umem *xsk_umem;
> +
> +       struct zero_copy_allocator zca; /* ZC allocator anchor */
>  } ____cacheline_internodealigned_in_smp;
>
>  static inline bool ring_uses_build_skb(struct i40e_ring *ring)
> @@ -474,6 +491,7 @@ static inline unsigned int i40e_rx_pg_order(struct i40e_ring *ring)
>  #define i40e_rx_pg_size(_ring) (PAGE_SIZE << i40e_rx_pg_order(_ring))
>
>  bool i40e_alloc_rx_buffers(struct i40e_ring *rxr, u16 cleaned_count);
> +bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 cleaned_count);
>  netdev_tx_t i40e_lan_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
>  void i40e_clean_tx_ring(struct i40e_ring *tx_ring);
>  void i40e_clean_rx_ring(struct i40e_ring *rx_ring);
> @@ -489,6 +507,9 @@ int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
>  bool __i40e_chk_linearize(struct sk_buff *skb);
>  int i40e_xdp_xmit(struct net_device *dev, struct xdp_frame *xdpf);
>  void i40e_xdp_flush(struct net_device *dev);
> +int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget);
> +int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget);
> +void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
>
>  /**
>   * i40e_get_head - Retrieve head from head writeback
> @@ -575,4 +596,5 @@ static inline struct netdev_queue *txring_txq(const struct i40e_ring *ring)
>  {
>         return netdev_get_tx_queue(ring->netdev, ring->queue_index);
>  }
> +
>  #endif /* _I40E_TXRX_H_ */
> --
> 2.14.1
>
