From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 22 May 2015 11:09:02 -0700
Subject: [Intel-wired-lan] [PATCH] igb: report unsupported ethtool
 settings in set_coalesce
In-Reply-To: <20150522174950.16145.78447.stgit@htfujina-fc.jf.intel.com>
References: <20150522174950.16145.78447.stgit@htfujina-fc.jf.intel.com>
Message-ID: <555F70BE.6090904@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 05/22/2015 10:49 AM, Todd Fujinaka wrote:
> There are many settings possible using ethtool -C/--coalesce, but not
> all of them are supported. Report failure when an unsupported option is
> set.
>
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_ethtool.c |   21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 109cad9..13560fe 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -2159,6 +2159,27 @@ static int igb_set_coalesce(struct net_device *netdev,
>   	struct igb_adapter *adapter = netdev_priv(netdev);
>   	int i;
>
> +	if ((ec->rx_max_coalesced_frames != -1) ||
> +	    (ec->rx_coalesce_usecs_irq != -1) ||
> +	    (ec->rx_max_coalesced_frames_irq != -1) ||
> +	    (ec->tx_max_coalesced_frames != -1) ||
> +	    (ec->tx_coalesce_usecs_irq != -1) ||
> +	    (ec->stats_block_coalesce_usecs != -1) ||
> +	    (ec->use_adaptive_rx_coalesce != -1) ||
> +	    (ec->use_adaptive_tx_coalesce != -1) ||
> +	    (ec->pkt_rate_low != -1) ||
> +	    (ec->rx_coalesce_usecs_low != -1) ||
> +	    (ec->rx_max_coalesced_frames_low != -1) ||
> +	    (ec->tx_coalesce_usecs_low != -1) ||
> +	    (ec->tx_max_coalesced_frames_low != -1) ||
> +	    (ec->pkt_rate_high != -1) ||
> +	    (ec->rx_coalesce_usecs_high != -1) ||
> +	    (ec->rx_max_coalesced_frames_high != -1) ||
> +	    (ec->tx_coalesce_usecs_high != -1) ||
> +	    (ec->tx_max_coalesced_frames_high != -1) ||
> +	    (ec->rate_sample_interval != -1))
> +		return -ENOTSUPP;
> +
>   	if ((ec->rx_coalesce_usecs > IGB_MAX_ITR_USECS) ||
>   	    ((ec->rx_coalesce_usecs > 3) &&
>   	     (ec->rx_coalesce_usecs < IGB_MIN_ITR_USECS)) ||
>

Shouldn't these tests all give you a signed/unsigned mismatch since you 
are comparing an unsigned 32 bit value versus a signed value?

- Alex
