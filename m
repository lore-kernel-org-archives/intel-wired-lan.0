From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 2 Nov 2020 18:56:17 +0100
Subject: [Intel-wired-lan] [PATCH v3 1/9] igc: Fix igc_ptp_rx_pktstamp()
In-Reply-To: <20201030210351.46482-2-andre.guedes@intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-2-andre.guedes@intel.com>
Message-ID: <20201102175617.GI6427@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 30, 2020 at 02:03:43PM -0700, Andre Guedes wrote:
> The comment describing the timestamps layout in the packet buffer is
> wrong and the code is actually retrieving the timestamp in Timer 1
> reference instead of Timer 0. This hasn't been a big issue so far
> because hardware is configured to report both timestamps using Timer 0
> (see IGC_SRRCTL register configuration in igc_ptp_enable_rx_timestamp()
> helper). This patch fixes the comment and the code so we retrieve the
> timestamp in Timer 0 reference as expected.
> 
> This patch also takes the opportunity to get rid of the hw.mac.type check
> since it is not required.
> 
> Fixes: 81b055205e8ba ("igc: Add support for RX timestamping")
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h     |  2 +-
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 72 +++++++++++++-----------
>  2 files changed, 41 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 83d59b08e883..b66dda992d32 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -552,7 +552,7 @@ void igc_ptp_init(struct igc_adapter *adapter);
>  void igc_ptp_reset(struct igc_adapter *adapter);
>  void igc_ptp_suspend(struct igc_adapter *adapter);
>  void igc_ptp_stop(struct igc_adapter *adapter);
> -void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, void *va,
> +void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, u32 *va,
>  			 struct sk_buff *skb);
>  int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
>  int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index d73c4aaac610..79873f6df335 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -154,46 +154,54 @@ static void igc_ptp_systim_to_hwtstamp(struct igc_adapter *adapter,
>  }
>  
>  /**
> - * igc_ptp_rx_pktstamp - retrieve Rx per packet timestamp
> + * igc_ptp_rx_pktstamp - Retrieve timestamp from rx packet buffer
>   * @q_vector: Pointer to interrupt specific structure
>   * @va: Pointer to address containing Rx buffer
>   * @skb: Buffer containing timestamp and packet
>   *
> - * This function is meant to retrieve the first timestamp from the
> - * first buffer of an incoming frame. The value is stored in little
> - * endian format starting on byte 0. There's a second timestamp
> - * starting on byte 8.
> - **/
> -void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, void *va,
> + * This function retrieves the timestamp saved in the beginning of packet
> + * buffer. While two timestamps are available, one in timer0 reference and the
> + * other in timer1 reference, this function considers only the timestamp in
> + * timer0 reference.
> + */
> +void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, u32 *va,
>  			 struct sk_buff *skb)
>  {
>  	struct igc_adapter *adapter = q_vector->adapter;
> -	__le64 *regval = (__le64 *)va;
> -	int adjust = 0;
> -
> -	/* The timestamp is recorded in little endian format.
> -	 * DWORD: | 0          | 1           | 2          | 3
> -	 * Field: | Timer0 Low | Timer0 High | Timer1 Low | Timer1 High
> +	u64 regval;
> +	int adjust;
> +
> +	/* Timestamps are saved in little endian at the beginning of the packet
> +	 * buffer following the layout:
> +	 *
> +	 * | 0              | 1              | 2              | 3              |

Minor nit, I find DWORD comment helpful from previous version of this
description.

> +	 * | Timer1 SYSTIML | Timer1 SYSTIMH | Timer0 SYSTIML | Timer0 SYSTIMH |

A dumb question from ptp/igc noob: why two timers?

> +	 *
> +	 * SYSTIML holds the nanoseconds part while SYSTIMH holds the seconds
> +	 * part of the timestamp.
>  	 */
> -	igc_ptp_systim_to_hwtstamp(adapter, skb_hwtstamps(skb),
> -				   le64_to_cpu(regval[0]));
> -
> -	/* adjust timestamp for the RX latency based on link speed */
> -	if (adapter->hw.mac.type == igc_i225) {

if this check is not required here, then is it within
igc_ptp_systim_to_hwtstamp?

> -		switch (adapter->link_speed) {
> -		case SPEED_10:
> -			adjust = IGC_I225_RX_LATENCY_10;
> -			break;
> -		case SPEED_100:
> -			adjust = IGC_I225_RX_LATENCY_100;
> -			break;
> -		case SPEED_1000:
> -			adjust = IGC_I225_RX_LATENCY_1000;
> -			break;
> -		case SPEED_2500:
> -			adjust = IGC_I225_RX_LATENCY_2500;
> -			break;
> -		}
> +	regval = le32_to_cpu(va[2]);
> +	regval |= (u64)le32_to_cpu(va[3]) << 32;
> +	igc_ptp_systim_to_hwtstamp(adapter, skb_hwtstamps(skb), regval);
> +
> +	/* Adjust timestamp for the RX latency based on link speed */
> +	switch (adapter->link_speed) {
> +	case SPEED_10:
> +		adjust = IGC_I225_RX_LATENCY_10;
> +		break;
> +	case SPEED_100:
> +		adjust = IGC_I225_RX_LATENCY_100;
> +		break;
> +	case SPEED_1000:
> +		adjust = IGC_I225_RX_LATENCY_1000;
> +		break;
> +	case SPEED_2500:
> +		adjust = IGC_I225_RX_LATENCY_2500;
> +		break;
> +	default:
> +		adjust = 0;
> +		netdev_warn_once(adapter->netdev, "Imprecise timestamp\n");

How is timestamp related to link speed? I mean, this warning is telling me
that there is something wrong with the timestamp that hw put onto frame,
not that link speed is cranky.

> +		break;
>  	}
>  	skb_hwtstamps(skb)->hwtstamp =
>  		ktime_sub_ns(skb_hwtstamps(skb)->hwtstamp, adjust);
> -- 
> 2.28.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
