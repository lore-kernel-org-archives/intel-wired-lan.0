From: Ronciak, John <john.ronciak@intel.com>
Date: Mon, 21 Mar 2016 19:53:12 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for single-port
 X550	device
In-Reply-To: <20160321182131.33845.74687.stgit@mdrustad-wks.jf.intel.com>
References: <20160321182131.33845.74687.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <D38E8E86660E514AB505863C19C9287C8CBD0654@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hold on.  Was the DCR for this approved?  There was some question about this earlier this morning.  If the DCR isn't approved then we can't do this yet.

Cheers,
John


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, March 21, 2016 11:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for single-port X550
> device
> 
> Add support for a single-port X550 device.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index 833567cacda4..737443a015d5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -97,6 +97,7 @@ bool ixgbe_device_supports_autoneg_fc(struct
> ixgbe_hw *hw)
>  		case IXGBE_DEV_ID_X540T:
>  		case IXGBE_DEV_ID_X540T1:
>  		case IXGBE_DEV_ID_X550T:
> +		case IXGBE_DEV_ID_X550T1:
>  		case IXGBE_DEV_ID_X550EM_X_10G_T:
>  			supported = true;
>  			break;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index cef1fd98909c..320c7d4f16b8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -126,6 +126,7 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
>  	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_SF_QP),
> board_82599 },
>  	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540T1), board_X540 },
>  	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550T), board_X550},
> +	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550T1), board_X550},
>  	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KX4),
> board_X550EM_x},
>  	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KR),
> board_X550EM_x},
>  	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T),
> board_X550EM_x}, @@ -9020,6 +9021,7 @@ int ixgbe_wol_supported(struct
> ixgbe_adapter *adapter, u16 device_id,
>  	case IXGBE_DEV_ID_X540T:
>  	case IXGBE_DEV_ID_X540T1:
>  	case IXGBE_DEV_ID_X550T:
> +	case IXGBE_DEV_ID_X550T1:
>  	case IXGBE_DEV_ID_X550EM_X_KX4:
>  	case IXGBE_DEV_ID_X550EM_X_KR:
>  	case IXGBE_DEV_ID_X550EM_X_10G_T:
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index 937abe23db6b..a1986a664306 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -75,6 +75,7 @@
>  #define IXGBE_DEV_ID_X540T1              0x1560
> 
>  #define IXGBE_DEV_ID_X550T		0x1563
> +#define IXGBE_DEV_ID_X550T1		0x15D1
>  #define IXGBE_DEV_ID_X550EM_X_KX4	0x15AA
>  #define IXGBE_DEV_ID_X550EM_X_KR	0x15AB
>  #define IXGBE_DEV_ID_X550EM_X_SFP	0x15AC
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
