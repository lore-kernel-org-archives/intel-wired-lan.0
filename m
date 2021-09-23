From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 23 Sep 2021 09:44:40 +0200
Subject: [Intel-wired-lan] [PATCH net v1] iavf-linux: Fix reporting when
 setting descriptor count
In-Reply-To: <20210923071452.21975-1-michal.maloszewski@intel.com>
References: <20210923071452.21975-1-michal.maloszewski@intel.com>
Message-ID: <5437f421-e935-6484-4f8b-ed6751e9bae1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Michal,


Am 23.09.21 um 09:14 schrieb Michal Maloszewski:
> iavf_set_ringparams doesn't communicate to the user that
> 
> 1. The user requested descriptor count is out of range. Instead it
>     just quietly sets descriptors to the "clamped" value and calls it
>     done. This makes it look an invalid value was successfully set as
>     the descriptor count when this isn't actually true.
> 
> 2. The user provided descriptor count needs to be inflated for alignment
>     reasons.
> 
> This behavior is confusing. The ice driver has already addressed this

Please reference the commit.

> by rejecting invalid values for and messaging for alignment adjustments.

Values for what?

> Do the same thing here.

? by adding the error and info messages.

> Title: iavf-linux: Fix reporting when setting descriptor count

This tag is not needed, is it?

> Fixes: 129cf89e5856 ("iavf: rename functions and structs to new name")
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>   .../net/ethernet/intel/iavf/iavf_ethtool.c    | 43 ++++++++++++++-----
>   1 file changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 7cbe59bee..cbfc8d07a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -612,23 +612,44 @@ static int iavf_set_ringparam(struct net_device *netdev,
>   	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>   		return -EINVAL;
>   
> -	new_tx_count = clamp_t(u32, ring->tx_pending,
> -			       IAVF_MIN_TXD,
> -			       IAVF_MAX_TXD);
> -	new_tx_count = ALIGN(new_tx_count, IAVF_REQ_DESCRIPTOR_MULTIPLE);
> +	if (ring->tx_pending > IAVF_MAX_TXD ||
> +	    ring->tx_pending < IAVF_MIN_TXD ||
> +	    ring->rx_pending > IAVF_MAX_RXD ||
> +	    ring->rx_pending < IAVF_MIN_RXD) {
> +		  netdev_err(netdev, "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d] (increment %d)\n",
> +			     ring->tx_pending, ring->rx_pending, IAVF_MIN_TXD,
> +			     IAVF_MAX_RXD, IAVF_REQ_DESCRIPTOR_MULTIPLE);
> +		  return -EINVAL;
> +	}
> +
> +	new_tx_count = ALIGN(ring->tx_pending, IAVF_REQ_DESCRIPTOR_MULTIPLE);
> +	if (new_tx_count != ring->tx_pending)
> +		netdev_info(netdev, "Requested Tx descriptor count rounded up to %d\n",
> +			    new_tx_count);
>   
> -	new_rx_count = clamp_t(u32, ring->rx_pending,
> -			       IAVF_MIN_RXD,
> -			       IAVF_MAX_RXD);
> -	new_rx_count = ALIGN(new_rx_count, IAVF_REQ_DESCRIPTOR_MULTIPLE);
> +	new_rx_count = ALIGN(ring->rx_pending, IAVF_REQ_DESCRIPTOR_MULTIPLE);
> +	if (new_rx_count != ring->rx_pending)
> +		netdev_info(netdev, "Requested Rx descriptor count rounded up to %d\n",
> +			    new_rx_count);
>   
>   	/* if nothing to do return success */
>   	if ((new_tx_count == adapter->tx_desc_count) &&
> -	    (new_rx_count == adapter->rx_desc_count))
> +	    (new_rx_count == adapter->rx_desc_count)) {
> +		netdev_dbg(netdev, "Nothing to change, descriptor count is same as requested\n");
>   		return 0;
> +	}
>   
> -	adapter->tx_desc_count = new_tx_count;
> -	adapter->rx_desc_count = new_rx_count;
> +	if (new_tx_count != adapter->tx_desc_count) {
> +		netdev_info(netdev, "Changing Tx descriptor count from %d to %d\n",
> +			    adapter->tx_desc_count, new_tx_count);
> +		adapter->tx_desc_count = new_tx_count;
> +	}
> +
> +	if (new_rx_count != adapter->rx_desc_count) {
> +		netdev_info(netdev, "Changing Rx descriptor count from %d to %d\n",
> +			    adapter->rx_desc_count, new_rx_count);
> +		adapter->rx_desc_count = new_rx_count;
> +	}
>   
>   	if (netif_running(netdev)) {
>   		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
> 
