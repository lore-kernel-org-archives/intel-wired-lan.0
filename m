From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 3 Mar 2017 12:55:07 -0800
Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] ixgbe: add XDP
	support for pass and drop actions
In-Reply-To: <20170303175703.25015.13873.stgit@john-Precision-Tower-5810>
References: <20170303175526.25015.12183.stgit@john-Precision-Tower-5810>
 <20170303175703.25015.13873.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0Uce50xKSYvVdnZxFeKyPoNtUF=kzguMOascwvev5ue5Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 3, 2017 at 9:57 AM, John Fastabend <john.fastabend@gmail.com> wrote:
> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
> programs instead of rcu primitives as suggested by Daniel Borkmann and
> Alex Duyck.
>
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  123 +++++++++++++++++++++-
>  3 files changed, 120 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index b812913..6eaf506 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -273,6 +273,7 @@ struct ixgbe_ring {
>         struct ixgbe_ring *next;        /* pointer to next ring in q_vector */
>         struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
>         struct net_device *netdev;      /* netdev ring belongs to */
> +       struct bpf_prog *xdp_prog;
>         struct device *dev;             /* device for DMA mapping */
>         struct ixgbe_fwd_adapter *l2_accel_priv;
>         void *desc;                     /* descriptor ring memory */
> @@ -510,6 +511,7 @@ struct ixgbe_adapter {
>         unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
>         /* OS defined structs */
>         struct net_device *netdev;
> +       struct bpf_prog *xdp_prog;
>         struct pci_dev *pdev;
>
>         unsigned long state;
> @@ -790,7 +792,7 @@ enum ixgbe_boards {
>  void ixgbe_reinit_locked(struct ixgbe_adapter *adapter);
>  void ixgbe_reset(struct ixgbe_adapter *adapter);
>  void ixgbe_set_ethtool_ops(struct net_device *netdev);
> -int ixgbe_setup_rx_resources(struct ixgbe_ring *);
> +int ixgbe_setup_rx_resources(struct ixgbe_adapter *, struct ixgbe_ring *);
>  int ixgbe_setup_tx_resources(struct ixgbe_ring *);
>  void ixgbe_free_rx_resources(struct ixgbe_ring *);
>  void ixgbe_free_tx_resources(struct ixgbe_ring *);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index d3e02ac..cf955e69 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1114,7 +1114,7 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
>                                sizeof(struct ixgbe_ring));
>
>                         temp_ring[i].count = new_rx_count;
> -                       err = ixgbe_setup_rx_resources(&temp_ring[i]);
> +                       err = ixgbe_setup_rx_resources(adapter, &temp_ring[i]);
>                         if (err) {
>                                 while (i) {
>                                         i--;
> @@ -1747,7 +1747,7 @@ static int ixgbe_setup_desc_rings(struct ixgbe_adapter *adapter)
>         rx_ring->netdev = adapter->netdev;
>         rx_ring->reg_idx = adapter->rx_ring[0]->reg_idx;
>
> -       err = ixgbe_setup_rx_resources(rx_ring);
> +       err = ixgbe_setup_rx_resources(adapter, rx_ring);
>         if (err) {
>                 ret_val = 4;
>                 goto err_nomem;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index e3da397..0a569e6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -49,6 +49,9 @@
>  #include <linux/if_macvlan.h>
>  #include <linux/if_bridge.h>
>  #include <linux/prefetch.h>
> +#include <linux/bpf.h>
> +#include <linux/bpf_trace.h>
> +#include <linux/atomic.h>
>  #include <scsi/fc/fc_fcoe.h>
>  #include <net/udp_tunnel.h>
>  #include <net/pkt_cls.h>
> @@ -1858,6 +1861,10 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
>   * @rx_desc: pointer to the EOP Rx descriptor
>   * @skb: pointer to current skb being fixed
>   *
> + * Check if the skb is valid in the XDP case it will be an error pointer.
> + * Return true in this case to abort processing and advance to next
> + * descriptor.
> + *
>   * Check for corrupted packet headers caused by senders on the local L2
>   * embedded NIC switch not setting up their Tx Descriptors right.  These
>   * should be very rare.
> @@ -1876,6 +1883,10 @@ static bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
>  {
>         struct net_device *netdev = rx_ring->netdev;
>
> +       /* XDP packets use error pointer so abort at this point */
> +       if (IS_ERR(skb))
> +               return true;
> +
>         /* verify that the packet does not have any known errors */
>         if (unlikely(ixgbe_test_staterr(rx_desc,
>                                         IXGBE_RXDADV_ERR_FRAME_ERR_MASK) &&
> @@ -2051,7 +2062,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>                 /* hand second half of page back to the ring */
>                 ixgbe_reuse_rx_page(rx_ring, rx_buffer);
>         } else {
> -               if (IXGBE_CB(skb)->dma == rx_buffer->dma) {
> +               if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
>                         /* the page has been released from the ring */
>                         IXGBE_CB(skb)->page_released = true;
>                 } else {
> @@ -2157,6 +2168,50 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>         return skb;
>  }
>
> +#define IXGBE_XDP_PASS 0
> +#define IXGBE_XDP_CONSUMED 1
> +
> +static struct sk_buff *ixgbe_run_xdp(struct ixgbe_ring  *rx_ring,
> +                                    struct ixgbe_rx_buffer *rx_buffer,
> +                                    unsigned int size)
> +{
> +       int result = IXGBE_XDP_PASS;
> +       struct bpf_prog *xdp_prog;
> +       struct xdp_buff xdp;
> +       void *addr;
> +       u32 act;
> +
> +       rcu_read_lock();
> +       xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
> +       if (!xdp_prog)
> +               goto xdp_out;
> +
> +       addr = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +       xdp.data_hard_start = addr;
> +       xdp.data = addr;
> +       xdp.data_end = addr + size;
> +
> +       act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +       switch (act) {
> +       case XDP_PASS:
> +               goto xdp_out;
> +       default:
> +               bpf_warn_invalid_xdp_action(act);
> +       case XDP_TX:
> +       case XDP_ABORTED:
> +               trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> +               /* fallthrough -- handle aborts by dropping packet */
> +       case XDP_DROP:
> +               rx_buffer->pagecnt_bias++; /* give page back */

Minor nit.  You should put the comment on the line above the
pagecnt_bias update.

> +               result = IXGBE_XDP_CONSUMED;
> +               break;
> +       }
> +xdp_out:
> +       rcu_read_unlock();
> +       return ERR_PTR(-result);
> +}
> +
>  /**
>   * ixgbe_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>   * @q_vector: structure containing interrupt and ring information
> @@ -2207,15 +2262,19 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>
>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>
> -               /* retrieve a buffer from the ring */
> -               if (skb)
> +               skb = ixgbe_run_xdp(rx_ring, rx_buffer, size);
> +               if (IS_ERR(skb)) { /* XDP consumed buffer */

For the XDP comment it should be moved down inside of the statement.

> +                       total_rx_packets++;
> +                       total_rx_bytes += size;
> +               } else if (skb) {
>                         ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
> -               else if (ring_uses_build_skb(rx_ring))
> +               } else if (ring_uses_build_skb(rx_ring)) {
>                         skb = ixgbe_build_skb(rx_ring, rx_buffer,
>                                               rx_desc, size);
> -               else
> +               } else {
>                         skb = ixgbe_construct_skb(rx_ring, rx_buffer,
>                                                   rx_desc, size);
> +               }
>
>                 /* exit if we failed to retrieve a buffer */
>                 if (!skb) {
> @@ -6061,7 +6120,8 @@ static int ixgbe_setup_all_tx_resources(struct ixgbe_adapter *adapter)
>   *
>   * Returns 0 on success, negative on failure
>   **/
> -int ixgbe_setup_rx_resources(struct ixgbe_ring *rx_ring)
> +int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
> +                            struct ixgbe_ring *rx_ring)
>  {
>         struct device *dev = rx_ring->dev;
>         int orig_node = dev_to_node(dev);
> @@ -6098,6 +6158,8 @@ int ixgbe_setup_rx_resources(struct ixgbe_ring *rx_ring)
>         rx_ring->next_to_clean = 0;
>         rx_ring->next_to_use = 0;
>
> +       xchg(&rx_ring->xdp_prog, adapter->xdp_prog);
> +
>         return 0;
>  err:
>         vfree(rx_ring->rx_buffer_info);

It occurs to me that I am not sure we even need the xchg here.  This
should be protected by an the rtnl lock anyway.  So I don't think we
need the xchg unless XDP can update things outside the rtnl lock which
if it can we have other issues since adapter->xdp_prog could then be
updated while this is going on.

> @@ -6121,10 +6183,11 @@ static int ixgbe_setup_all_rx_resources(struct ixgbe_adapter *adapter)
>         int i, err = 0;
>
>         for (i = 0; i < adapter->num_rx_queues; i++) {
> -               err = ixgbe_setup_rx_resources(adapter->rx_ring[i]);
> +               struct ixgbe_ring *rx_ring = adapter->rx_ring[i];
> +
> +               err = ixgbe_setup_rx_resources(adapter, rx_ring);
>                 if (!err)
>                         continue;
> -

There is a bunch of noise here.  Don't bother modifying white space,
just add the adapter reference to the function call.   It will still
be below 80 characters anyway.

>                 e_err(probe, "Allocation for Rx Queue %u failed\n", i);
>                 goto err_setup_rx;
>         }
> @@ -6189,6 +6252,7 @@ void ixgbe_free_rx_resources(struct ixgbe_ring *rx_ring)
>  {
>         ixgbe_clean_rx_ring(rx_ring);
>
> +       xchg(&rx_ring->xdp_prog, NULL);
>         vfree(rx_ring->rx_buffer_info);
>         rx_ring->rx_buffer_info = NULL;
>

Same question that I had for the other xchg.  Do we even need it?  The
NAPI polling routine should already be unregistered since we are
freeing rings at this point.  Odds are we can probably just assign
NULL as a value and skip the xchg assuming all callers of this
function are holding the rtnl.

> @@ -9455,6 +9519,48 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
>         return features;
>  }
>
> +static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
> +{
> +       int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> +       struct ixgbe_adapter *adapter = netdev_priv(dev);
> +       struct bpf_prog *old_adapter_prog;
> +
> +       /* verify ixgbe ring attributes are sufficient for XDP */
> +       for (i = 0; i < adapter->num_rx_queues; i++) {
> +               struct ixgbe_ring *ring = adapter->rx_ring[i];
> +
> +               if (ring_is_rsc_enabled(ring))
> +                       return -EINVAL;
> +
> +               if (frame_size > ixgbe_rx_bufsz(ring))
> +                       return -EINVAL;
> +       }
> +
> +       old_adapter_prog = xchg(&adapter->xdp_prog, prog);
> +       for (i = 0; i < adapter->num_rx_queues; i++)
> +               xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
> +
> +       if (old_adapter_prog)
> +               bpf_prog_put(old_adapter_prog);
> +
> +       return 0;
> +}
> +
> +static int ixgbe_xdp(struct net_device *dev, struct netdev_xdp *xdp)
> +{
> +       struct ixgbe_adapter *adapter = netdev_priv(dev);
> +
> +       switch (xdp->command) {
> +       case XDP_SETUP_PROG:
> +               return ixgbe_xdp_setup(dev, xdp->prog);
> +       case XDP_QUERY_PROG:
> +               xdp->prog_attached = !!(adapter->rx_ring[0]->xdp_prog);
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static const struct net_device_ops ixgbe_netdev_ops = {
>         .ndo_open               = ixgbe_open,
>         .ndo_stop               = ixgbe_close,
> @@ -9500,6 +9606,7 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
>         .ndo_udp_tunnel_add     = ixgbe_add_udp_tunnel_port,
>         .ndo_udp_tunnel_del     = ixgbe_del_udp_tunnel_port,
>         .ndo_features_check     = ixgbe_features_check,
> +       .ndo_xdp                = ixgbe_xdp,
>  };
>
>  /**
>
