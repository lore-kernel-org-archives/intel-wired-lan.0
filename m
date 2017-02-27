From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 27 Feb 2017 08:22:47 -0800
Subject: [Intel-wired-lan] [net-next PATCH 1/3] ixgbe: add XDP support
	for pass and drop actions
In-Reply-To: <20170225173229.32741.12321.stgit@john-Precision-Tower-5810>
References: <20170225172422.32741.67877.stgit@john-Precision-Tower-5810>
 <20170225173229.32741.12321.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0UcYvKdbvnSmgrT8_pkt9XL=Wqe87vU3eEx5sPUGCuntsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Feb 25, 2017 at 9:32 AM, John Fastabend
<john.fastabend@gmail.com> wrote:
> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
> programs instead of rcu primitives as suggested by Daniel Borkmann and
> Alex Duyck.
>
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  108 +++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index b812913..2d12c24 100644
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
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index e3da397..ec2c38f 100644
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
> @@ -2051,7 +2054,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>                 /* hand second half of page back to the ring */
>                 ixgbe_reuse_rx_page(rx_ring, rx_buffer);
>         } else {
> -               if (IXGBE_CB(skb)->dma == rx_buffer->dma) {
> +               if (skb && IXGBE_CB(skb)->dma == rx_buffer->dma) {
>                         /* the page has been released from the ring */
>                         IXGBE_CB(skb)->page_released = true;
>                 } else {

So just an idea here.  What if we were to use the PTR_ERR code for the
skb return value instead just NULL or an skb pointer.  More on that
idea to follow in the review.

> @@ -2157,6 +2160,42 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>         return skb;
>  }
>
> +static int ixgbe_run_xdp(struct ixgbe_ring  *rx_ring,
> +                        struct ixgbe_rx_buffer *rx_buffer,
> +                        unsigned int size)

Maybe we should pass size via a reference pointer instead of as a
value.  Then we can modify it without having to use it as a return
value.  More on that below.

> +{
> +       struct bpf_prog *xdp_prog;
> +       struct xdp_buff xdp;
> +       void *addr;
> +       u32 act;
> +
> +       xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
> +       if (!xdp_prog)
> +               return 0;
> +
> +       addr = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +       xdp.data_hard_start = addr;

So this math is only partly correct.  The data_hard_start should be
adjusted if the BUILD_SKB flag is set by subtracting NET_SKB_PAD +
NET_IP_ALIGN.

> +       xdp.data = addr;
> +       xdp.data_end = addr + size;
> +
> +       act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +       switch (act) {
> +       case XDP_PASS:
> +               return 0;
> +       default:
> +               bpf_warn_invalid_xdp_action(act);
> +       case XDP_TX:
> +       case XDP_ABORTED:
> +               trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> +               /* fallthrough -- handle aborts by dropping packet */
> +       case XDP_DROP:
> +               rx_buffer->pagecnt_bias++; /* give page back */
> +               break;
> +       }
> +       return size;
> +}
> +

I realized if we allow for head adjustment we should probably have
rx_buffer->page_offset get updated based off of xdp.data if we allow
it to be passed through.  We also may want to pass size as a pointer
instead of returning it.  That way we can return an skb as a PTR_ERR
type if we need to either Tx, drop, or abort.

If we allow XDP_PASS to adjust the page_offset we will need to make
sure in the 4K page case that we are sanitizing the page_offset later.
Probably need to add an and/or combination to make certain we are
always resetting the padding to the correct amount.

>  /**
>   * ixgbe_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>   * @q_vector: structure containing interrupt and ring information
> @@ -2187,6 +2226,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                 struct ixgbe_rx_buffer *rx_buffer;
>                 struct sk_buff *skb;
>                 unsigned int size;
> +               int consumed;
>
>                 /* return some buffers to hardware, one at a time is too slow */
>                 if (cleaned_count >= IXGBE_RX_BUFFER_WRITE) {

If my idea is right we won't need to mess with adding another variable at all.

> @@ -2207,6 +2247,19 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>
>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>
> +               rcu_read_lock();
> +               consumed = ixgbe_run_xdp(rx_ring, rx_buffer, size);
> +               rcu_read_unlock();
> +
> +               if (consumed) {
> +                       ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
> +                       cleaned_count++;
> +                       ixgbe_is_non_eop(rx_ring, rx_desc, skb);
> +                       total_rx_packets++;
> +                       total_rx_bytes += size;
> +                       continue;
> +               }
> +
>                 /* retrieve a buffer from the ring */
>                 if (skb)
>                         ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);


I'm not really sure if we still need the rcu_read_lock/unlock after
changing to the READ_ONCE semantics.  For now I am just dropping it in
my suggestions down below.  It might make sense to move the RCU
locking into ixgbe_run_xdp if it is truly needed.

I'm not really a huge fan of having to break up the receive path like
this.  It seems like a ton of duplication of effort.  I think this
might work much better laid out like:
/* retrieve a buffer from the ring */
if (likely(!skb))
    skb = ixgbe_run_xdp(rx_ring, rx_buffer, &size);

if (IS_ERR(skb)) {
    total_rx_packets++;
    total_rx_bytes += size;
} else if (skb) {
    ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);

Then all that is left is to make a change to ixgbe_cleanup_headers so
that it will identify that the skb is an error and push us back
through via the continue.

From what I can tell the only thing really preventing us from being
able to handle jumbo frames this way is the fact that they want to
track the first DMA mapping in the skb.  So with a change like the one
you already made, and us enforcing that RSC has to be disabled to
support XDP then we should be good.

> @@ -6106,6 +6159,12 @@ int ixgbe_setup_rx_resources(struct ixgbe_ring *rx_ring)
>         return -ENOMEM;
>  }
>
> +static void ixgbe_setup_xdp_resource(struct ixgbe_adapter *adapter,
> +                                    struct ixgbe_ring *ring)
> +{
> +       xchg(&ring->xdp_prog, adapter->xdp_prog);
> +}
> +
>  /**
>   * ixgbe_setup_all_rx_resources - allocate all queues Rx resources
>   * @adapter: board private structure
> @@ -6122,8 +6181,10 @@ static int ixgbe_setup_all_rx_resources(struct ixgbe_adapter *adapter)
>
>         for (i = 0; i < adapter->num_rx_queues; i++) {
>                 err = ixgbe_setup_rx_resources(adapter->rx_ring[i]);
> -               if (!err)
> +               if (!err) {
> +                       ixgbe_setup_xdp_resource(adapter, adapter->rx_ring[i]);
>                         continue;
> +               }
>
>                 e_err(probe, "Allocation for Rx Queue %u failed\n", i);
>                 goto err_setup_rx;

I'd say just this into ixgbe_setup_rx_resources instead of making it
its own thing.  It is just a one liner and we already have all the
same arguments in that function anyway.

We probably also need to update the code that will free_rx_resources
so that it will reset xdp_prog back to NULL.  That way we can
guarantee it is released if we just down the interface without
bringing it back up.

> @@ -9455,6 +9516,48 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
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
> +               ixgbe_setup_xdp_resource(adapter, adapter->rx_ring[i]);
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
> @@ -9500,6 +9603,7 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
>         .ndo_udp_tunnel_add     = ixgbe_add_udp_tunnel_port,
>         .ndo_udp_tunnel_del     = ixgbe_del_udp_tunnel_port,
>         .ndo_features_check     = ixgbe_features_check,
> +       .ndo_xdp                = ixgbe_xdp,
>  };
>
>  /**
>
