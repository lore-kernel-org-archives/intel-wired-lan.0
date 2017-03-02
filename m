From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 2 Mar 2017 08:22:42 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 1/3] ixgbe: add XDP
	support for pass and drop actions
In-Reply-To: <20170302005417.30505.14047.stgit@john-Precision-Tower-5810>
References: <20170302005417.30505.14047.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0UdoHK-5=pXHGcgbSp5zFSzHuSwiqY=5B2czjkLbN4KuQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 1, 2017 at 4:54 PM, John Fastabend <john.fastabend@gmail.com> wrote:
> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
> programs instead of rcu primitives as suggested by Daniel Borkmann and
> Alex Duyck.
>
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>

So it still looks like this is doing a bunch of hacking in the Rx
path.  I suggested a few items below to streamline this.

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  114 ++++++++++++++++++++++++-
>  2 files changed, 113 insertions(+), 3 deletions(-)
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
> index e3da397..0b802b5 100644
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

So you can probably change this to "if (!IS_ERR(skb) &&
IXGBE_CB(skb)->dma == rx_buffer->dma) {" more on why below.

> @@ -2157,6 +2160,50 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>         return skb;
>  }
>
> +#define IXGBE_XDP_PASS 0
> +#define IXGBE_XDP_CONSUMED 1
> +
> +static int ixgbe_run_xdp(struct ixgbe_ring  *rx_ring,
> +                        struct ixgbe_rx_buffer *rx_buffer,
> +                        unsigned int size)
> +{

Change the return type here to an sk_buff pointer.

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
> +               result = IXGBE_XDP_CONSUMED;
> +               break;
> +       }
> +xdp_out:
> +       rcu_read_unlock();
> +       return result;
> +}
> +

Instead of returning result directly I would suggest returning
"ERR_PTR(-result)", or you can cast IXGBE_XDP_CONSUMED as - 1 and just
return "ERR_PTR(result)".

>  /**
>   * ixgbe_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>   * @q_vector: structure containing interrupt and ring information
> @@ -2187,6 +2234,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                 struct ixgbe_rx_buffer *rx_buffer;
>                 struct sk_buff *skb;
>                 unsigned int size;
> +               int consumed;
>
>                 /* return some buffers to hardware, one at a time is too slow */
>                 if (cleaned_count >= IXGBE_RX_BUFFER_WRITE) {

With the changes above this bit becomes unnecessary.

> @@ -2207,6 +2255,18 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>
>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>
> +               consumed = ixgbe_run_xdp(rx_ring, rx_buffer, size);
> +               rcu_read_unlock();
> +

Did you leave an rcu_read_unlock here?  I'm assuming you meant to drop this.

> +               if (consumed) {
> +                       ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
> +                       cleaned_count++;
> +                       ixgbe_is_non_eop(rx_ring, rx_desc, skb);
> +                       total_rx_packets++;
> +                       total_rx_bytes += size;
> +                       continue;
> +               }
> +

Looks like this wasn't adding one back to the pagecnt_bias.  That
would trigger a memory leak.

This bit will need to change a bit.  Basically it should become:
    /* retrieve a buffer from the ring */
    if (!skb)
        skb = ixgbe_run_xdp(rx_ring, rx_buffer, size);

    if (IS_ERR(skb)) {
        total_rx_packets++;
        total_rx_bytes += size;
        rx_buffer->pagecnt_bias++;
    } else if (skb)

Then the only other change that should be needed is a minor tweak to
ixgbe_cleanup_headers() by adding the following to the start of the
function:
    if (IS_ERR(skb))
        return true;

>                 /* retrieve a buffer from the ring */
>                 if (skb)
>                         ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
> @@ -6121,9 +6181,13 @@ static int ixgbe_setup_all_rx_resources(struct ixgbe_adapter *adapter)
>         int i, err = 0;
>
>         for (i = 0; i < adapter->num_rx_queues; i++) {
> -               err = ixgbe_setup_rx_resources(adapter->rx_ring[i]);
> -               if (!err)
> +               struct ixgbe_ring *rx_ring = adapter->rx_ring[i];
> +
> +               err = ixgbe_setup_rx_resources(rx_ring);
> +               if (!err) {
> +                       xchg(&rx_ring->xdp_prog, adapter->xdp_prog);
>                         continue;
> +               }
>
>                 e_err(probe, "Allocation for Rx Queue %u failed\n", i);
>                 goto err_setup_rx;

I still think it makes more sense to just place this in
ixgbe_setup_rx_resources.  No point in putting here as it just adds
more complication.

If I am not mistaken all you would have to add is the xchg line and
that would be it.

> @@ -6191,6 +6255,7 @@ void ixgbe_free_rx_resources(struct ixgbe_ring *rx_ring)
>
>         vfree(rx_ring->rx_buffer_info);
>         rx_ring->rx_buffer_info = NULL;
> +       xchg(&rx_ring->xdp_prog, NULL);
>
>         /* if not set, then don't free */
>         if (!rx_ring->desc)

Just for the sake of symmetry I would suggest placing the xchg in
front of the vfree.  Also this code being here makes a stronger
argument for us setting up xdp in setup_rx_resources.

> @@ -9455,6 +9520,48 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
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
> @@ -9500,6 +9607,7 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
>         .ndo_udp_tunnel_add     = ixgbe_add_udp_tunnel_port,
>         .ndo_udp_tunnel_del     = ixgbe_del_udp_tunnel_port,
>         .ndo_features_check     = ixgbe_features_check,
> +       .ndo_xdp                = ixgbe_xdp,
>  };
>
>  /**
>
