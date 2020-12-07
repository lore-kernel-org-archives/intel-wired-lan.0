From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Sun, 6 Dec 2020 17:55:47 -0800
Subject: [Intel-wired-lan] [PATCH 1/1] ice: fix array overflow on
 receiving too many fragments for a packet
In-Reply-To: <20201207011415.463-1-ruc_zhangxiaohui@163.com>
References: <20201207011415.463-1-ruc_zhangxiaohui@163.com>
Message-ID: <20201206175547.00005aa9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Xiaohui Zhang wrote:

> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> 
> If the hardware receives an oversized packet with too many rx fragments,
> skb_shinfo(skb)->frags can overflow and corrupt memory of adjacent pages.
> This becomes especially visible if it corrupts the freelist pointer of
> a slab page.

As I replied to the ionic patch, please justify this with how you found
it and how you reproduced a problem. Resend the patches as a series so
we can discuss them as one change.

> 
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index eae75260f..f0f034fa5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -823,8 +823,12 @@ ice_add_rx_frag(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
>  
>  	if (!size)
>  		return;
> -	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
> +	struct skb_shared_info *shinfo = skb_shinfo(skb);
> +
> +	if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags)) {
> +		skb_add_rx_frag(skb, shinfo, rx_buf->page,
>  			rx_buf->page_offset, size, truesize);
> +	}

The driver is using 2kB receive buffers, and can chain them together up
to a max receive size of 9126 bytes (or so), so how can we receive more
than 18 fragments? Please explain your logic

>  
>  	/* page is being used so we must update the page offset */
>  	ice_rx_buf_adjust_pg_offset(rx_buf, truesize);

Your patch doesn't compile. You must compile test and explain your
patches better.

  CC [M]  drivers/net/ethernet/intel/ice//ice_main.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_controlq.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_common.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_nvm.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_switch.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_sched.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_base.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_lib.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_txrx_lib.o
  CC [M]  drivers/net/ethernet/intel/ice//ice_txrx.o
drivers/net/ethernet/intel/ice//ice_txrx.c: In function ?ice_add_rx_frag?:
drivers/net/ethernet/intel/ice//ice_txrx.c:829:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
  829 |  struct skb_shared_info *shinfo = skb_shinfo(skb);
      |  ^~~~~~
drivers/net/ethernet/intel/ice//ice_txrx.c:832:24: warning: passing argument 2 of ?skb_add_rx_frag? makes integer from pointer without a cast [-Wint-conversion]
  832 |   skb_add_rx_frag(skb, shinfo, rx_buf->page,
      |                        ^~~~~~
      |                        |
      |                        struct skb_shared_info *
In file included from ./include/linux/if_ether.h:19,
                 from ./include/uapi/linux/ethtool.h:19,
                 from ./include/linux/ethtool.h:18,
                 from ./include/linux/netdevice.h:37,
                 from ./include/trace/events/xdp.h:8,
                 from ./include/linux/bpf_trace.h:5,
                 from drivers/net/ethernet/intel/ice//ice_txrx.c:8:
./include/linux/skbuff.h:2182:47: note: expected ?int? but argument is of type ?struct skb_shared_info *?
 2182 | void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
      |                                           ~~~~^
