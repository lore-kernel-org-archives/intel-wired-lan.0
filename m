From: Corinna Vinschen <vinschen@redhat.com>
Date: Tue, 26 Jan 2021 11:30:37 +0100
Subject: [Intel-wired-lan] igc: fix link speed advertising
In-Reply-To: <20201117195040.178651-1-vinschen@redhat.com>
References: <20201117195040.178651-1-vinschen@redhat.com>
Message-ID: <20210126103037.GH4393@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ping?

It looks like this patch got lost somehow.  Without this patch,
setting link speed advertising is broken.


Thanks,
Corinna


On Nov 17 20:50, Corinna Vinschen wrote:
> Link speed advertising in igc has two problems:
> 
> - When setting the advertisement via ethtool, the link speed is converted
>   to the legacy 32 bit representation for the intel PHY code.
>   This inadvertently drops ETHTOOL_LINK_MODE_2500baseT_Full_BIT (being
>   beyond bit 31).  As a result, any call to `ethtool -s ...' drops the
>   2500Mbit/s link speed from the PHY settings.  Only reloading the driver
>   alleviates that problem.
> 
>   Fix this by converting the ETHTOOL_LINK_MODE_2500baseT_Full_BIT to the
>   Intel PHY ADVERTISE_2500_FULL bit explicitely.
> 
> - Rather than checking the actual PHY setting, the .get_link_ksettings
>   function always fills link_modes.advertising with all link speeds
>   the device is capable of.
> 
>   Fix this by checking the PHY autoneg_advertised settings and report
>   only the actually advertised speeds up to ethtool.
> 
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 24 +++++++++++++++-----
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 61d331ce38cd..75cb4ca36bac 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1675,12 +1675,18 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>  	cmd->base.phy_address = hw->phy.addr;
>  
>  	/* advertising link modes */
> -	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Half);
> -	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Full);
> -	ethtool_link_ksettings_add_link_mode(cmd, advertising, 100baseT_Half);
> -	ethtool_link_ksettings_add_link_mode(cmd, advertising, 100baseT_Full);
> -	ethtool_link_ksettings_add_link_mode(cmd, advertising, 1000baseT_Full);
> -	ethtool_link_ksettings_add_link_mode(cmd, advertising, 2500baseT_Full);
> +	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
> +		ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Half);
> +	if (hw->phy.autoneg_advertised & ADVERTISE_10_FULL)
> +		ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Full);
> +	if (hw->phy.autoneg_advertised & ADVERTISE_100_HALF)
> +		ethtool_link_ksettings_add_link_mode(cmd, advertising, 100baseT_Half);
> +	if (hw->phy.autoneg_advertised & ADVERTISE_100_FULL)
> +		ethtool_link_ksettings_add_link_mode(cmd, advertising, 100baseT_Full);
> +	if (hw->phy.autoneg_advertised & ADVERTISE_1000_FULL)
> +		ethtool_link_ksettings_add_link_mode(cmd, advertising, 1000baseT_Full);
> +	if (hw->phy.autoneg_advertised & ADVERTISE_2500_FULL)
> +		ethtool_link_ksettings_add_link_mode(cmd, advertising, 2500baseT_Full);
>  
>  	/* set autoneg settings */
>  	if (hw->mac.autoneg == 1) {
> @@ -1792,6 +1798,12 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>  
>  	ethtool_convert_link_mode_to_legacy_u32(&advertising,
>  						cmd->link_modes.advertising);
> +	/* Converting to legacy u32 drops ETHTOOL_LINK_MODE_2500baseT_Full_BIT.
> +	 * We have to check this and convert it to ADVERTISE_2500_FULL
> +	 * (aka ETHTOOL_LINK_MODE_2500baseX_Full_BIT) explicitely.
> +	 */
> +	if (ethtool_link_ksettings_test_link_mode(cmd, advertising, 2500baseT_Full))
> +		advertising |= ADVERTISE_2500_FULL;
>  
>  	if (cmd->base.autoneg == AUTONEG_ENABLE) {
>  		hw->mac.autoneg = 1;
> -- 
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

