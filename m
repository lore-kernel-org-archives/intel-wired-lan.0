From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 12 Nov 2020 11:03:24 +0200
Subject: [Intel-wired-lan] [PATCH v4 9/9] igc: Add support for
 XDP_REDIRECT action
In-Reply-To: <20201104031210.27772-10-andre.guedes@intel.com>
References: <20201104031210.27772-1-andre.guedes@intel.com>
 <20201104031210.27772-10-andre.guedes@intel.com>
Message-ID: <df3339ba-f2d1-6e85-044d-9db96807fd97@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/4/2020 05:12, Andre Guedes wrote:
> This patch adds support for the XDP_REDIRECT action which enables XDP
> programs to redirect packets arriving at I225 NIC. It also implements
> the ndo_xdp_xmit ops, enabling the igc driver to transmit packets
> forwarded to it by xdp programs running on other interfaces.
> 
> The patch tweaks the driver's page counting scheme (as described in
> '8ce29c679a6e i40e: tweak page counting for XDP_REDIRECT' and
> implemented by other Intel drivers) in order to properly support
> XDP_REDIRECT action.
> 
> This patch has been tested with the sample apps "xdp_redirect_cpu" and
> "xdp_redirect_map" located in samples/bpf/.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 59 +++++++++++++++++++++--
>   1 file changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index ee8e4615aba5..f406364e8797 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -27,6 +27,7 @@
>   #define IGC_XDP_PASS		0
>   #define IGC_XDP_CONSUMED	BIT(0)
>   #define IGC_XDP_TX		BIT(1)
> +#define IGC_XDP_REDIRECT	BIT(2)
Hello Andre, I would suggest move the _XDP_REDIRECT mask to the 
igc_defines.h file.
Same suggestion for mask above (in previous patches)
>   
>   static int debug = -1;
>   
> @@ -1720,8 +1721,8 @@ static bool igc_can_reuse_rx_page(struct igc_rx_buffer *rx_buffer)
>   	 * the pagecnt_bias and page count so that we fully restock the
>   	 * number of references the driver holds.
>   	 */
> -	if (unlikely(!pagecnt_bias)) {
> -		page_ref_add(page, USHRT_MAX);
> +	if (unlikely(pagecnt_bias == 1)) {
> +		page_ref_add(page, USHRT_MAX - 1);
>   		rx_buffer->pagecnt_bias = USHRT_MAX;
>   	}
>   
> @@ -1862,7 +1863,8 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
>   	bi->dma = dma;
>   	bi->page = page;
>   	bi->page_offset = igc_rx_offset(rx_ring);
> -	bi->pagecnt_bias = 1;
> +	page_ref_add(page, USHRT_MAX - 1);
> +	bi->pagecnt_bias = USHRT_MAX;
>   
>   	return true;
>   }
> @@ -2058,6 +2060,12 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
>   		else
>   			res = IGC_XDP_TX;
>   		break;
> +	case XDP_REDIRECT:
> +		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
> +			res = IGC_XDP_CONSUMED;
> +		else
> +			res = IGC_XDP_REDIRECT;
> +		break;
>   	default:
>   		bpf_warn_invalid_xdp_action(act);
>   		fallthrough;
> @@ -2099,6 +2107,9 @@ static void igc_finalize_xdp(struct igc_adapter *adapter, int status)
>   		igc_flush_tx_descriptors(ring);
>   		__netif_tx_unlock(nq);
>   	}
> +
> +	if (status & IGC_XDP_REDIRECT)
> +		xdp_do_flush();
>   }
>   
>   static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> @@ -2167,6 +2178,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>   				rx_buffer->pagecnt_bias++;
>   				break;
>   			case IGC_XDP_TX:
> +			case IGC_XDP_REDIRECT:
>   				igc_rx_buffer_flip(rx_buffer, truesize);
>   				xdp_status |= xdp_res;
>   				break;
> @@ -5132,6 +5144,46 @@ static int igc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>   	}
>   }
>   
> +static int igc_xdp_xmit(struct net_device *dev, int num_frames,
> +			struct xdp_frame **frames, u32 flags)
> +{
> +	struct igc_adapter *adapter = netdev_priv(dev);
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +	struct igc_ring *ring;
> +	int i, drops;
> +
> +	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
> +		return -ENETDOWN;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	ring = igc_xdp_get_tx_ring(adapter, cpu);
> +	nq = txring_txq(ring);
> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	drops = 0;
> +	for (i = 0; i < num_frames; i++) {
> +		int err;
> +		struct xdp_frame *xdpf = frames[i];
> +
> +		err = igc_xdp_init_tx_descriptor(ring, xdpf);
> +		if (err) {
> +			xdp_return_frame_rx_napi(xdpf);
> +			drops++;
> +		}
> +	}
> +
> +	if (flags & XDP_XMIT_FLUSH)
> +		igc_flush_tx_descriptors(ring);
> +
> +	__netif_tx_unlock(nq);
> +
> +	return num_frames - drops;
> +}
> +
>   static const struct net_device_ops igc_netdev_ops = {
>   	.ndo_open		= igc_open,
>   	.ndo_stop		= igc_close,
> @@ -5146,6 +5198,7 @@ static const struct net_device_ops igc_netdev_ops = {
>   	.ndo_do_ioctl		= igc_ioctl,
>   	.ndo_setup_tc		= igc_setup_tc,
>   	.ndo_bpf		= igc_bpf,
> +	.ndo_xdp_xmit		= igc_xdp_xmit,
>   };
>   
>   /* PCIe configuration access */
> 
Thanks,
Sasha
