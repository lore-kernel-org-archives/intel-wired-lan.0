From: Michael Marley <michael@michaelmarley.com>
Date: Thu, 12 Sep 2019 13:50:43 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix secpath usage for IPsec TX
 offload.
In-Reply-To: <20190912110144.GS2879@gauss3.secunet.de>
References: <20190912110144.GS2879@gauss3.secunet.de>
Message-ID: <10aeb092a51c85563b37622417de51e3@michaelmarley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-09-12 07:01, Steffen Klassert wrote:
> The ixgbe driver currently does IPsec TX offloading
> based on an existing secpath. However, the secpath
> can also come from the RX side, in this case it is
> misinterpreted for TX offload and the packets are
> dropped with a "bad sa_idx" error. Fix this by using
> the xfrm_offload() function to test for TX offload.
> 
> Fixes: 592594704761 ("ixgbe: process the Tx ipsec offload")
> Reported-by: Michael Marley <michael@michaelmarley.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Tested-by: Michael Marley <michael@michaelmarley.com>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 9bcae44e9883..ae31bd57127c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -36,6 +36,7 @@
>  #include <net/vxlan.h>
>  #include <net/mpls.h>
>  #include <net/xdp_sock.h>
> +#include <net/xfrm.h>
> 
>  #include "ixgbe.h"
>  #include "ixgbe_common.h"
> @@ -8696,7 +8697,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff 
> *skb,
>  #endif /* IXGBE_FCOE */
> 
>  #ifdef CONFIG_IXGBE_IPSEC
> -	if (secpath_exists(skb) &&
> +	if (xfrm_offload(skb) &&
>  	    !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
>  		goto out_drop;
>  #endif
