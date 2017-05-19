From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 19 May 2017 05:29:38 -0700
Subject: [Intel-wired-lan] [PATCH v5 1/2] i40e: add XDP support for pass
	and drop actions
In-Reply-To: <20170519070856.13900-2-bjorn.topel@gmail.com>
References: <20170519070856.13900-1-bjorn.topel@gmail.com>
 <20170519070856.13900-2-bjorn.topel@gmail.com>
Message-ID: <CAKgT0Ue4E7nDBFNBpQ+NmB9TLksLrxxxMuVs5nqaw9jn3SniBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 19, 2017 at 12:08 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> This commit adds basic XDP support for i40e derived NICs. All XDP
> actions will end up in XDP_DROP.
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

I have called out a few minor cosmetic issues that I would like to see
fixed, but otherwise the patch looks good to me and the issues I saw
didn't impact functionality.

Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   7 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  75 ++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 130 +++++++++++++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   1 +
>  4 files changed, 182 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 395ca94faf80..d3195b29d53c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -645,6 +645,8 @@ struct i40e_vsi {
>         u16 max_frame;
>         u16 rx_buf_len;
>
> +       struct bpf_prog *xdp_prog;
> +
>         /* List of q_vectors allocated to this VSI */
>         struct i40e_q_vector **q_vectors;
>         int num_q_vectors;
> @@ -972,4 +974,9 @@ i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf);
>  i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf);
>  i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf);
>  void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
> +
> +static inline bool i40e_enabled_xdp_vsi(struct i40e_vsi *vsi)
> +{
> +       return !!vsi->xdp_prog;
> +}
>  #endif /* _I40E_H_ */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 8d1d3b859af7..27a29904611a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -27,6 +27,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
> +#include <linux/bpf.h>
>
>  /* Local includes */
>  #include "i40e.h"
> @@ -2408,6 +2409,13 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
>         struct i40e_vsi *vsi = np->vsi;
>         struct i40e_pf *pf = vsi->back;
>
> +       if (i40e_enabled_xdp_vsi(vsi)) {
> +               int frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> +
> +               if (frame_size > vsi->rx_buf_len)
> +                       return -EINVAL;
> +       }
> +
>         netdev_info(netdev, "changing MTU from %d to %d\n",
>                     netdev->mtu, new_mtu);
>         netdev->mtu = new_mtu;
> @@ -9310,6 +9318,72 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
>         return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>  }
>
> +/**
> + * i40e_xdp_setup - add/remove an XDP program
> + * @vsi: VSI to changed
> + * @prog: XDP program
> + **/
> +static int i40e_xdp_setup(struct i40e_vsi *vsi,
> +                         struct bpf_prog *prog)
> +{
> +       struct i40e_pf *pf = vsi->back;
> +       int frame_size = vsi->netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> +       int i;
> +       bool need_reset;
> +       struct bpf_prog *old_prog;
> +
> +       /* Don't allow frames that span over multiple buffers */
> +       if (frame_size > vsi->rx_buf_len)
> +               return -EINVAL;
> +
> +       if (!i40e_enabled_xdp_vsi(vsi) && !prog)
> +               return 0;
> +
> +       /* When turning XDP on->off/off->on we reset and rebuild the rings. */
> +       need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog);
> +
> +       if (need_reset)
> +               i40e_prep_for_reset(pf, true);
> +
> +       old_prog = xchg(&vsi->xdp_prog, prog);
> +
> +       if (need_reset)
> +               i40e_reset_and_rebuild(pf, true, true);
> +
> +       for (i = 0; i < vsi->num_queue_pairs; i++)
> +               WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
> +
> +       if (old_prog)
> +               bpf_prog_put(old_prog);
> +
> +       return 0;
> +}
> +
> +/**
> + * i40e_xdp - implements ndo_xdp for i40e
> + * @dev: netdevice
> + * @xdp: XDP command
> + **/
> +static int i40e_xdp(struct net_device *dev,
> +                   struct netdev_xdp *xdp)
> +{
> +       struct i40e_netdev_priv *np = netdev_priv(dev);
> +       struct i40e_vsi *vsi = np->vsi;
> +
> +       if (vsi->type != I40E_VSI_MAIN)
> +               return -EINVAL;
> +
> +       switch (xdp->command) {
> +       case XDP_SETUP_PROG:
> +               return i40e_xdp_setup(vsi, xdp->prog);
> +       case XDP_QUERY_PROG:
> +               xdp->prog_attached = i40e_enabled_xdp_vsi(vsi);
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static const struct net_device_ops i40e_netdev_ops = {
>         .ndo_open               = i40e_open,
>         .ndo_stop               = i40e_close,
> @@ -9342,6 +9416,7 @@ static const struct net_device_ops i40e_netdev_ops = {
>         .ndo_features_check     = i40e_features_check,
>         .ndo_bridge_getlink     = i40e_ndo_bridge_getlink,
>         .ndo_bridge_setlink     = i40e_ndo_bridge_setlink,
> +       .ndo_xdp                = i40e_xdp,
>  };
>
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index af554f3cda19..0c2f0230faf4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -26,6 +26,7 @@
>
>  #include <linux/prefetch.h>
>  #include <net/busy_poll.h>
> +#include <linux/bpf_trace.h>
>  #include "i40e.h"
>  #include "i40e_trace.h"
>  #include "i40e_prototype.h"
> @@ -1195,6 +1196,7 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>  void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>  {
>         i40e_clean_rx_ring(rx_ring);
> +       rx_ring->xdp_prog = NULL;
>         kfree(rx_ring->rx_bi);
>         rx_ring->rx_bi = NULL;
>
> @@ -1241,6 +1243,8 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
>         rx_ring->next_to_clean = 0;
>         rx_ring->next_to_use = 0;
>
> +       rx_ring->xdp_prog = rx_ring->vsi->xdp_prog;
> +
>         return 0;
>  err:
>         kfree(rx_ring->rx_bi);
> @@ -1592,6 +1596,7 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>  /**
>   * i40e_cleanup_headers - Correct empty headers
>   * @rx_ring: rx descriptor ring packet is being transacted on
> + * @rx_desc: pointer to the EOP Rx descriptor
>   * @skb: pointer to current skb being fixed
>   *
>   * Also address the case where we are pulling data in on pages only
> @@ -1602,8 +1607,25 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>   *
>   * Returns true if an error was encountered and skb was freed.
>   **/
> -static bool i40e_cleanup_headers(struct i40e_ring *rx_ring, struct sk_buff *skb)
> +static bool i40e_cleanup_headers(struct i40e_ring *rx_ring,
> +                                union i40e_rx_desc *rx_desc,
> +                                struct sk_buff *skb)
>  {
> +       /* XDP packets use error pointer so abort at this point */
> +       if (IS_ERR(skb))
> +               return true;
> +
> +       /* ERR_MASK will only have valid bits if EOP set, and
> +        * what we are doing here is actually checking
> +        * I40E_RX_DESC_ERROR_RXE_SHIFT, since it is the zeroth bit in
> +        * the error field
> +        */
> +       if (unlikely(i40e_test_staterr(rx_desc,
> +                                      BIT(I40E_RXD_QW1_ERROR_SHIFT)))) {
> +               dev_kfree_skb_any(skb);
> +               return true;
> +       }
> +
>         /* if eth_skb_pad returns an error the skb was freed */
>         if (eth_skb_pad(skb))
>                 return true;
> @@ -1783,10 +1805,10 @@ static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring *rx_ring,
>   * skb correctly.
>   */
>  static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
> -                                         struct i40e_rx_buffer *rx_buffer,
> -                                         unsigned int size)
> +                                         struct xdp_buff *xdp,
> +                                         struct i40e_rx_buffer *rx_buffer)

One minor request here. Let's leave rx_buffer in place and instead
just replace size with the xdp pointer. It helps to reduce some of the
noise in this and will make maintenance easier for the out-of-tree
driver as we will likely just be replacing xdp with size on older
kernels via our kcompat.

>  {
> -       void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +       unsigned int size = xdp->data_end - xdp->data;
>  #if (PAGE_SIZE < 8192)
>         unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
>  #else
> @@ -1796,9 +1818,9 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
>         struct sk_buff *skb;
>
>         /* prefetch first cache line of first page */
> -       prefetch(va);
> +       prefetch(xdp->data);
>  #if L1_CACHE_BYTES < 128
> -       prefetch(va + L1_CACHE_BYTES);
> +       prefetch(xdp->data + L1_CACHE_BYTES);
>  #endif
>
>         /* allocate a skb to store the frags */
> @@ -1811,10 +1833,11 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
>         /* Determine available headroom for copy */
>         headlen = size;
>         if (headlen > I40E_RX_HDR_SIZE)
> -               headlen = eth_get_headlen(va, I40E_RX_HDR_SIZE);
> +               headlen = eth_get_headlen(xdp->data, I40E_RX_HDR_SIZE);
>
>         /* align pull length to size of long to optimize memcpy performance */
> -       memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
> +       memcpy(__skb_put(skb, headlen), xdp->data,
> +              ALIGN(headlen, sizeof(long)));
>
>         /* update all of the pointers */
>         size -= headlen;
> @@ -1847,10 +1870,10 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
>   * to set up the skb correctly and avoid any memcpy overhead.
>   */
>  static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
> -                                     struct i40e_rx_buffer *rx_buffer,
> -                                     unsigned int size)
> +                                     struct xdp_buff *xdp,
> +                                     struct i40e_rx_buffer *rx_buffer)

Same here. If possible please just replace size with xdp instead of
moving the variables around.

>  {
> -       void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +       unsigned int size = xdp->data_end - xdp->data;
>  #if (PAGE_SIZE < 8192)
>         unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
>  #else
> @@ -1860,12 +1883,12 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>         struct sk_buff *skb;
>
>         /* prefetch first cache line of first page */
> -       prefetch(va);
> +       prefetch(xdp->data);
>  #if L1_CACHE_BYTES < 128
> -       prefetch(va + L1_CACHE_BYTES);
> +       prefetch(xdp->data + L1_CACHE_BYTES);
>  #endif
>         /* build an skb around the page buffer */
> -       skb = build_skb(va - I40E_SKB_PAD, truesize);
> +       skb = build_skb(xdp->data_hard_start, truesize);
>         if (unlikely(!skb))
>                 return NULL;
>
> @@ -1944,6 +1967,46 @@ static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
>         return true;
>  }
>
> +#define I40E_XDP_PASS 0
> +#define I40E_XDP_CONSUMED 1
> +
> +/**
> + * i40e_run_xdp - run an XDP program
> + * @rx_ring: Rx ring being processed
> + * @xdp: XDP buffer containing the frame
> + **/
> +static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
> +                                   struct xdp_buff *xdp)
> +{
> +       int result = I40E_XDP_PASS;
> +       struct bpf_prog *xdp_prog;
> +       u32 act;
> +
> +       rcu_read_lock();
> +       xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
> +       if (!xdp_prog)
> +               goto xdp_out;
> +
> +       act = bpf_prog_run_xdp(xdp_prog, xdp);
> +       switch (act) {
> +       case XDP_PASS:
> +               break;
> +       default:
> +               bpf_warn_invalid_xdp_action(act);
> +       case XDP_TX:
> +       case XDP_ABORTED:
> +               trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> +               /* fallthrough -- handle aborts by dropping packet */
> +       case XDP_DROP:
> +               result = I40E_XDP_CONSUMED;
> +               break;
> +       }
> +xdp_out:
> +       rcu_read_unlock();
> +       return ERR_PTR(-result);
> +}
> +
>  /**
>   * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>   * @rx_ring: rx descriptor ring to transact packets on
> @@ -1970,6 +2033,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                 u16 vlan_tag;
>                 u8 rx_ptype;
>                 u64 qword;
> +               struct xdp_buff xdp;

Dave usually prefers what we call a reverse Christmas tree layout for
variables. Basically you should try to place the longest variable
declaration at the top and the shortest at the bottom. So you could
probably place it above vlan tag or size depending on the length of
the line.

>
>                 /* return some buffers to hardware, one at a time is too slow */
>                 if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
> @@ -2006,12 +2070,27 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                 rx_buffer = i40e_get_rx_buffer(rx_ring, size);
>
>                 /* retrieve a buffer from the ring */
> -               if (skb)
> +               if (!skb) {
> +                       xdp.data = page_address(rx_buffer->page) +
> +                                  rx_buffer->page_offset;
> +                       xdp.data_hard_start = xdp.data -
> +                                             i40e_rx_offset(rx_ring);
> +                       xdp.data_end = xdp.data + size;
> +
> +                       skb = i40e_run_xdp(rx_ring, &xdp);
> +               }
> +
> +               if (IS_ERR(skb)) {
> +                       total_rx_bytes += size;
> +                       total_rx_packets++;
> +                       rx_buffer->pagecnt_bias++;
> +               } else if (skb) {
>                         i40e_add_rx_frag(rx_ring, rx_buffer, skb, size);
> -               else if (ring_uses_build_skb(rx_ring))
> -                       skb = i40e_build_skb(rx_ring, rx_buffer, size);
> -               else
> -                       skb = i40e_construct_skb(rx_ring, rx_buffer, size);
> +               } else if (ring_uses_build_skb(rx_ring)) {
> +                       skb = i40e_build_skb(rx_ring, &xdp, rx_buffer);
> +               } else {
> +                       skb = i40e_construct_skb(rx_ring, &xdp, rx_buffer);
> +               }
>
>                 /* exit if we failed to retrieve a buffer */
>                 if (!skb) {
> @@ -2026,18 +2105,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                 if (i40e_is_non_eop(rx_ring, rx_desc, skb))
>                         continue;
>
> -               /* ERR_MASK will only have valid bits if EOP set, and
> -                * what we are doing here is actually checking
> -                * I40E_RX_DESC_ERROR_RXE_SHIFT, since it is the zeroth bit in
> -                * the error field
> -                */
> -               if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT)))) {
> -                       dev_kfree_skb_any(skb);
> -                       skb = NULL;
> -                       continue;
> -               }
> -
> -               if (i40e_cleanup_headers(rx_ring, skb)) {
> +               if (i40e_cleanup_headers(rx_ring, rx_desc, skb)) {
>                         skb = NULL;
>                         continue;
>                 }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index f5de51124cae..31f0b162996f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -360,6 +360,7 @@ struct i40e_ring {
>         void *desc;                     /* Descriptor ring memory */
>         struct device *dev;             /* Used for DMA mapping */
>         struct net_device *netdev;      /* netdev ring maps to */
> +       struct bpf_prog *xdp_prog;
>         union {
>                 struct i40e_tx_buffer *tx_bi;
>                 struct i40e_rx_buffer *rx_bi;
> --
> 2.11.0
>
