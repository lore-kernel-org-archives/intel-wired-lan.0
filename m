From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 22 Sep 2021 09:03:59 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/2] e1000e: Separate TGP board
 type from SPT
In-Reply-To: <20210922065449.3780338-1-sasha.neftin@intel.com>
References: <20210922065449.3780338-1-sasha.neftin@intel.com>
Message-ID: <a07296fa-f920-a31d-dc35-be629954eb17@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Am 22.09.21 um 08:54 schrieb Sasha Neftin:
> We have a same LAN controller on different PCH.

the same

Nit: Please add a blank line between paragraphs, or do not wrap lines 
between sentences.

> Separate TGP board type from SPT will alllow apply specific fixes

allow

> for TGP platforms.
> 
> Suggested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +-
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 +++++++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 45 +++++++++++----------
>   3 files changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
> index f3424255bd2b..c3def0ee7788 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -114,7 +114,8 @@ enum e1000_boards {
>   	board_pch2lan,
>   	board_pch_lpt,
>   	board_pch_spt,
> -	board_pch_cnp
> +	board_pch_cnp,
> +	board_pch_tgp
>   };
>   
>   struct e1000_ps_page {
> @@ -500,6 +501,7 @@ extern const struct e1000_info e1000_pch2_info;
>   extern const struct e1000_info e1000_pch_lpt_info;
>   extern const struct e1000_info e1000_pch_spt_info;
>   extern const struct e1000_info e1000_pch_cnp_info;
> +extern const struct e1000_info e1000_pch_tgp_info;
>   extern const struct e1000_info e1000_es2_info;
>   
>   void e1000e_ptp_init(struct e1000_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 60c582a16821..66d7196310e2 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -5992,3 +5992,23 @@ const struct e1000_info e1000_pch_cnp_info = {
>   	.phy_ops		= &ich8_phy_ops,
>   	.nvm_ops		= &spt_nvm_ops,
>   };
> +
> +const struct e1000_info e1000_pch_tgp_info = {
> +	.mac			= e1000_pch_tgp,
> +	.flags			= FLAG_IS_ICH
> +				  | FLAG_HAS_WOL
> +				  | FLAG_HAS_HW_TIMESTAMP
> +				  | FLAG_HAS_CTRLEXT_ON_LOAD
> +				  | FLAG_HAS_AMT
> +				  | FLAG_HAS_FLASH
> +				  | FLAG_HAS_JUMBO_FRAMES
> +				  | FLAG_APME_IN_WUC,
> +	.flags2			= FLAG2_HAS_PHY_STATS
> +				  | FLAG2_HAS_EEE,
> +	.pba			= 26,
> +	.max_hw_frame_size	= 9022,
> +	.get_variants		= e1000_get_variants_ich8lan,
> +	.mac_ops		= &ich8_mac_ops,
> +	.phy_ops		= &ich8_phy_ops,
> +	.nvm_ops		= &spt_nvm_ops,
> +};
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 900b3ab998bd..ebcb2a30add0 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -51,6 +51,7 @@ static const struct e1000_info *e1000_info_tbl[] = {
>   	[board_pch_lpt]		= &e1000_pch_lpt_info,
>   	[board_pch_spt]		= &e1000_pch_spt_info,
>   	[board_pch_cnp]		= &e1000_pch_cnp_info,
> +	[board_pch_tgp]		= &e1000_pch_tgp_info,
>   };
>   
>   struct e1000_reg_info {
> @@ -7896,28 +7897,28 @@ static const struct pci_device_id e1000_pci_tbl[] = {
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V11), board_pch_cnp },
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM12), board_pch_spt },
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V12), board_pch_spt },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM13), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V13), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM14), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM23), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V23), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM16), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V16), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM17), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V17), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM22), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V22), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM18), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V18), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM19), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V19), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM20), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V20), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM21), board_pch_cnp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V21), board_pch_cnp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM13), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V13), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM14), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM23), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V23), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM16), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V16), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM17), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V17), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM22), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V22), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM18), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V18), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM19), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V19), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM20), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V20), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM21), board_pch_tgp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V21), board_pch_tgp },
>   
>   	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
>   };
> 

The diff looks fine.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
