From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Tue, 7 Jul 2015 14:52:32 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbe support for
	ethtool	set_rxfh
In-Reply-To: <1435326018-6097-1-git-send-email-tom.barbette@ulg.ac.be>
References: <1435326018-6097-1-git-send-email-tom.barbette@ulg.ac.be>
Message-ID: <F6FB0E698C9B3143BDF729DF222866469130FE62@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tom Barbette
> Sent: Friday, June 26, 2015 6:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbe support for ethtool
> set_rxfh
> 
> Allows to change the rxfh indirection table and/or key using  ethtool
> interface.
> 
> V2: added checks for maximum number of queues per MAC type.
> 
> Signed-off-by: Tom Barbette <tom.barbette@ulg.ac.be>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 47
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 +-
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index ac3ac2a..4314799 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -967,4 +967,5 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff
> *skb,
>  				  struct ixgbe_adapter *adapter,
>  				  struct ixgbe_ring *tx_ring);
>  u32 ixgbe_rss_indir_tbl_entries(struct ixgbe_adapter *adapter);
> +void ixgbe_store_reta(struct ixgbe_adapter *adapter);
>  #endif /* _IXGBE_H_ */
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index ec7b232..bcd2d03 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -2868,6 +2868,14 @@ static int ixgbe_set_rxnfc(struct net_device *dev,
> struct ethtool_rxnfc *cmd)
>  	return ret;
>  }
> 
> +static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter) {
> +	if (adapter->hw.mac.type < ixgbe_mac_X550)
> +		return 16;
> +	else
> +		return 64;
> +}
> +
>  static u32 ixgbe_get_rxfh_key_size(struct net_device *netdev)  {
>  	struct ixgbe_adapter *adapter = netdev_priv(netdev); @@ -2907,6
> +2915,44 @@ static int ixgbe_get_rxfh(struct net_device *netdev, u32
> *indir, u8 *key,
>  	return 0;
>  }
> 
> +static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
> +			  const u8 *key, const u8 hfunc)
> +{
> +	struct ixgbe_adapter *adapter = netdev_priv(netdev);
> +	int i;
> +	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
> +
> +	if (hfunc)
> +		return -EINVAL;
> +
> +	/* Fill out the redirection table */
> +	if (indir) {
> +		int max_queues = min_t(int, adapter->num_rx_queues,
> +
> ixgbe_rss_indir_tbl_max(adapter));
> +
> +		/*Allow at least 2 queues w/ SR-IOV.*/
> +		if ((adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) &&
> +		    (max_queues < 2))
> +			max_queues = 2;
> +
> +		/* Verify user input. */
> +		for (i = 0; i < reta_entries; i++)
> +			if (indir[i] >= max_queues)
> +				return -EINVAL;
> +
> +		for (i = 0; i < reta_entries; i++)
> +			adapter->rss_indir_tbl[i] = indir[i];
> +	}
> +
> +	/* Fill out the rss hash key */
> +	if (key)
> +		memcpy(adapter->rss_key, key,
> ixgbe_get_rxfh_key_size(netdev));
> +
> +	ixgbe_store_reta(adapter);
> +
> +	return 0;
> +}
> +
>  static int ixgbe_get_ts_info(struct net_device *dev,
>  			     struct ethtool_ts_info *info)
>  {
> @@ -3167,6 +3213,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops =
> {
>  	.get_rxfh_indir_size	= ixgbe_rss_indir_size,
>  	.get_rxfh_key_size	= ixgbe_get_rxfh_key_size,
>  	.get_rxfh		= ixgbe_get_rxfh,
> +	.set_rxfh		= ixgbe_set_rxfh,
>  	.get_channels		= ixgbe_get_channels,
>  	.set_channels		= ixgbe_set_channels,
>  	.get_ts_info		= ixgbe_get_ts_info,
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 9aa6104..0fdeb76 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -3287,7 +3287,7 @@ u32 ixgbe_rss_indir_tbl_entries(struct
> ixgbe_adapter *adapter)
>   *
>   * Write the RSS redirection table stored in adapter.rss_indir_tbl[] to HW.
>   */
> -static void ixgbe_store_reta(struct ixgbe_adapter *adapter)
> +void ixgbe_store_reta(struct ixgbe_adapter *adapter)
>  {
>  	u32 i, reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
>  	struct ixgbe_hw *hw = &adapter->hw;
> --
> 2.1.4
> 

This looks got to me Tom.  After Jeff adds this to his tree we will get our validation to check it out. 

Thanks,
-Don <donald.c.skidmore@intel.com>

