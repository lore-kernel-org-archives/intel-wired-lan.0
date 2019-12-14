From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Dec 2019 01:28:19 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix SGMII SFP module discovery
 for 100FX/LX.
In-Reply-To: <ef7b98c8-0ce4-4f84-989d-28b5a29d4831@EXC04-ATKLA.omicron.at>
References: <ef7b98c8-0ce4-4f84-989d-28b5a29d4831@EXC04-ATKLA.omicron.at>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9719B49A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Manfred Rudigier
> Sent: Wednesday, December 4, 2019 2:40 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Manfred Rudigier <manfred.rudigier@omicronenergy.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: Fix SGMII SFP module discovery for
> 100FX/LX.
> 
> Changing the link mode should also be done for 100BaseFX SGMII modules,
> otherwise they just don't work when the default link mode in CTRL_EXT
> coming from the EEPROM is SERDES.
> 
> Additionally 100Base-LX SGMII SFP modules are also supported now, which
> was not the case before.
> 
> Tested with an i210 using Flexoptix S.1303.2M.G 100FX and
> S.1303.10.G 100LX SGMII SFP modules.
> 
> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 8 ++------
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c
> b/drivers/net/ethernet/intel/igb/e1000_82575.c
> index 614130a6ba1f..30e77f5406cf 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_82575.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
> @@ -530,7 +530,7 @@ static s32 igb_set_sfp_media_type_82575(struct
> e1000_hw *hw)
>  		dev_spec->module_plugged = true;
>  		if (eth_flags->e1000_base_lx || eth_flags->e1000_base_sx) {
>  			hw->phy.media_type =
> e1000_media_type_internal_serdes;
> -		} else if (eth_flags->e100_base_fx) {
> +		} else if (eth_flags->e100_base_fx || eth_flags-
> >e100_base_lx) {
>  			dev_spec->sgmii_active = true;
>  			hw->phy.media_type =
> e1000_media_type_internal_serdes;
>  		} else if (eth_flags->e1000_base_t) {
> @@ -657,14 +657,10 @@ static s32 igb_get_invariants_82575(struct
> e1000_hw *hw)
>  			break;
>  		}
> 
> -		/* do not change link mode for 100BaseFX */
> -		if (dev_spec->eth_flags.e100_base_fx)
> -			break;
> -
>  		/* change current link mode setting */
>  		ctrl_ext &= ~E1000_CTRL_EXT_LINK_MODE_MASK;
> 
> -		if (hw->phy.media_type == e1000_media_type_copper)
> +		if (dev_spec->sgmii_active)
>  			ctrl_ext |= E1000_CTRL_EXT_LINK_MODE_SGMII;
>  		else
>  			ctrl_ext |=
> E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES;
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 5acf3b743876..50954e444985 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -181,7 +181,7 @@ static int igb_get_link_ksettings(struct net_device
> *netdev,
>  				advertising &=
> ~ADVERTISED_1000baseKX_Full;
>  			}
>  		}
> -		if (eth_flags->e100_base_fx) {
> +		if (eth_flags->e100_base_fx || eth_flags->e100_base_lx) {
>  			supported |= SUPPORTED_100baseT_Full;
>  			advertising |= ADVERTISED_100baseT_Full;
>  		}
> --
> 2.24.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
