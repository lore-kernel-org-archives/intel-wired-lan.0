From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sun, 31 Dec 2017 13:33:08 +0100
Subject: [Intel-wired-lan] [bpf-next V3 PATCH 03/14] i40e: setup
 xdp_rxq_info
In-Reply-To: <151471806938.30703.6297729195211114521.stgit@firesoul>
References: <151471801977.30703.3258796879718706203.stgit@firesoul>
 <151471806938.30703.6297729195211114521.stgit@firesoul>
Message-ID: <c66b35f5-c476-1fd0-aad9-f44743c8ffb8@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jesper,


Just some nits. In the description, the verb *set up* is written with a 
space.

Am 31.12.2017 um 12:01 schrieb Jesper Dangaard Brouer:
> The i40e driver have a special "FDIR" RX-ring (I40E_VSI_FDIR) which is

s/have/has/

> a sideband channel for configuring/updating the flow director tables.
> This (i40e_vsi_)type does not invoke XDP-ebpf code. Thus, mark this
> type as a XDP RX-queue type RXQ_TYPE_SINK.
> 
> Driver hook points for xdp_rxq_info:
>   * reg  : i40e_setup_rx_descriptors (via i40e_vsi_setup_rx_resources)
>   * unreg: i40e_free_rx_resources    (via i40e_vsi_free_rx_resources)
> 
> Tested on actual hardware with samples/bpf program.
> 
> V2: Fixed bug in i40e_set_ringparam

I assume that the added `memset` below in `i40e_ethtool.c`?

> Cc: intel-wired-lan at lists.osuosl.org
> Cc: Bj?rn T?pel <bjorn.topel@intel.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    2 ++
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c    |   18 ++++++++++++++++--
>   drivers/net/ethernet/intel/i40e/i40e_txrx.h    |    3 +++
>   3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 5f6cf7212d4f..cfd788b4fd7a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1585,6 +1585,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
>   			 */
>   			rx_rings[i].desc = NULL;
>   			rx_rings[i].rx_bi = NULL;
> +			/* Clear cloned XDP RX-queue info before setup call */
> +			memset(&rx_rings[i].xdp_rxq, 0, sizeof(rx_rings[i].xdp_rxq));
>   			/* this is to allow wr32 to have something to write to
>   			 * during early allocation of Rx buffers
>   			 */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 4566d66ffc7c..2a8a85e3ae8f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -27,6 +27,7 @@
>   #include <linux/prefetch.h>
>   #include <net/busy_poll.h>
>   #include <linux/bpf_trace.h>
> +#include <net/xdp.h>
>   #include "i40e.h"
>   #include "i40e_trace.h"
>   #include "i40e_prototype.h"
> @@ -1236,6 +1237,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>   void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>   {
>   	i40e_clean_rx_ring(rx_ring);
> +	if (rx_ring->vsi->type == I40E_VSI_MAIN)
> +		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>   	rx_ring->xdp_prog = NULL;
>   	kfree(rx_ring->rx_bi);
>   	rx_ring->rx_bi = NULL;
> @@ -1256,6 +1259,7 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>   int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
>   {
>   	struct device *dev = rx_ring->dev;
> +	int err = -ENOMEM;
>   	int bi_size;
>   
>   	/* warn if we are about to overwrite the pointer */
> @@ -1283,13 +1287,21 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
>   	rx_ring->next_to_clean = 0;
>   	rx_ring->next_to_use = 0;
>   
> +	/* XDP RX-queue info only needed for RX rings exposed to XDP */
> +	if (rx_ring->vsi->type == I40E_VSI_MAIN) {
> +		err = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> +				       rx_ring->queue_index);
> +		if (err < 0)
> +			goto err;
> +	}
> +
>   	rx_ring->xdp_prog = rx_ring->vsi->xdp_prog;
>   
>   	return 0;
>   err:
>   	kfree(rx_ring->rx_bi);
>   	rx_ring->rx_bi = NULL;
> -	return -ENOMEM;
> +	return err;
>   }
>   
>   /**
> @@ -2068,11 +2080,13 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>   	struct sk_buff *skb = rx_ring->skb;
>   	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
>   	bool failure = false, xdp_xmit = false;
> +	struct xdp_buff xdp;
> +
> +	xdp.rxq = &rx_ring->xdp_rxq;
>   
>   	while (likely(total_rx_packets < (unsigned int)budget)) {
>   		struct i40e_rx_buffer *rx_buffer;
>   		union i40e_rx_desc *rx_desc;
> -		struct xdp_buff xdp;
>   		unsigned int size;
>   		u16 vlan_tag;
>   		u8 rx_ptype;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index fbae1182e2ea..2d08760fc4ce 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -27,6 +27,8 @@
>   #ifndef _I40E_TXRX_H_
>   #define _I40E_TXRX_H_
>   
> +#include <net/xdp.h>
> +
>   /* Interrupt Throttling and Rate Limiting Goodies */
>   
>   #define I40E_MAX_ITR               0x0FF0  /* reg uses 2 usec resolution */
> @@ -428,6 +430,7 @@ struct i40e_ring {
>   					 */
>   
>   	struct i40e_channel *ch;
> +	struct xdp_rxq_info xdp_rxq;
>   } ____cacheline_internodealigned_in_smp;
>   
>   static inline bool ring_uses_build_skb(struct i40e_ring *ring)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
