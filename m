From: Ryan Schaefer <ryanschaefer23@gmail.com>
Date: Thu, 8 Dec 2016 08:31:59 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix reporting of 100Mb capability
Message-ID: <CAN1OqpxmGiiMEwm_E+GNQCCJOns8-DEG7cgoBWVs9XGoziXdrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> BaseT adapters that are capable of supporting 100Mb are not reporting this
> capability.  This patch corrects the reporting so that 100Mb is shown as
> supported on those adapters.
>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index fd192bf..8789f21 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -199,7 +199,7 @@ static int ixgbe_get_settings(struct net_device *netdev,
>   if (supported_link & IXGBE_LINK_SPEED_100_FULL)
>   ecmd->supported |= ixgbe_isbackplane(hw->phy.media_type) ?
>     SUPPORTED_1000baseKX_Full :
> -   SUPPORTED_1000baseT_Full;
> +   SUPPORTED_100baseT_Full;
>
>   /* default advertised speed if phy.autoneg_advertised isn't set */
>   ecmd->advertising = ecmd->supported;
> --
> 2.4.0


This patch should also remove the erroneously set
SUPPORTED_1000baseKX_Full bit as well. [PATCH] ixgbe: Switch to
ETHTOOL_xLINKSETTINGS API adds this fix.
