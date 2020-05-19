From: Murali Karicheri <m-karicheri2@ti.com>
Date: Tue, 19 May 2020 12:36:52 -0400
Subject: [Intel-wired-lan] [next-queue RFC 3/4] igc: Add support for
 configuring frame preemption
In-Reply-To: <20200516012948.3173993-4-vinicius.gomes@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516012948.3173993-4-vinicius.gomes@intel.com>
Message-ID: <e9e21a52-9f7f-bd5e-4656-45ca748f845b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

On 5/15/20 9:29 PM, Vinicius Costa Gomes wrote:
> WIP
> 
- cut -
>   
>   /* forward declaration */
>   struct igc_stats {
> @@ -1549,6 +1550,71 @@ static int igc_ethtool_set_priv_flags(struct net_device *netdev, u32 priv_flags)
>   	return 0;
>   }
>   
> +static int igc_ethtool_get_preempt(struct net_device *netdev,
> +				   struct ethtool_fp *fpcmd)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	int i;
> +
> +	fpcmd->fp_supported = 1;
> +	fpcmd->fp_enabled = adapter->frame_preemption_active;
> +	fpcmd->min_frag_size = adapter->min_frag_size;
> +
> +	for (i = 0; i < adapter->num_tx_queues; i++) {
> +		struct igc_ring *ring = adapter->tx_ring[i];
> +
> +		fpcmd->supported_queues_mask |= BIT(i);
> +
> +		if (ring->preemptible)
> +			fpcmd->preemptible_queues_mask |= BIT(i);
> +	}
> +
> +	return 0;
> +}
> +
Is this something that can be provided by the driver when netdevice
is registered so that a common function at net core layer be
implemented instead of duplicating this in individual device drivers?

> +static int igc_ethtool_set_preempt(struct net_device *netdev,
> +				   struct ethtool_fp *fpcmd)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	int i;
> +
> +	/* The formula is (Section 8.12.4 of the datasheet):
> +	 *   MIN_FRAG_SIZE = 4 + (1 + MIN_FRAG)*64
> +	 * MIN_FRAG is represented by two bits, so we can only have
> +	 * min_frag_size between 68 and 260.
> +	 */
> +	if (fpcmd->min_frag_size < 68 || fpcmd->min_frag_size > 260)
> +		return -EINVAL;

- cut-

-- 
Murali Karicheri
Texas Instruments
