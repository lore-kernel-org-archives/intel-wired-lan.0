From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 31 Dec 2021 12:58:06 +0100
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove non-inclusive language
 from Intel code.
In-Reply-To: <20211231114208.9897-1-piotrx.skajewski@intel.com>
References: <20211231114208.9897-1-piotrx.skajewski@intel.com>
Message-ID: <01d882ac-42be-f4c3-b037-5ccc165462fd@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Piotr,


Am 31.12.21 um 12:42 schrieb Piotr Skajewski:
> Remove non-inclusive language from Intel code.

Thank you. Three minor things:

1.  Please remove the trailing dot/period from the git commit message 
summary. (git?s default messages do not have one either.)
2.  So, basically, ?master? is changed to ?primary??
3.  Please mention the fix ?from from? to ?from?, or make it a separate 
commit.


Kind regards,

Paul


> Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> ---
>   .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 36 +++++++++----------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 10 +++---
>   3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index e90b5047e695..4c26c4b92f07 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -30,7 +30,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
>   					     u16 words, u16 *data);
>   static s32 ixgbe_detect_eeprom_page_size_generic(struct ixgbe_hw *hw,
>   						 u16 offset);
> -static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw);
> +static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw);
>   
>   /* Base table for registers values that change by MAC */
>   const u32 ixgbe_mvals_8259X[IXGBE_MVALS_IDX_LIMIT] = {
> @@ -746,10 +746,10 @@ s32 ixgbe_stop_adapter_generic(struct ixgbe_hw *hw)
>   	usleep_range(1000, 2000);
>   
>   	/*
> -	 * Prevent the PCI-E bus from from hanging by disabling PCI-E master
> +	 * Prevent the PCI-E bus from hanging by disabling PCI-E primary
>   	 * access and verify no pending requests
>   	 */
> -	return ixgbe_disable_pcie_master(hw);
> +	return ixgbe_disable_pcie_primary(hw);
>   }
>   
>   /**
> @@ -2506,15 +2506,15 @@ static u32 ixgbe_pcie_timeout_poll(struct ixgbe_hw *hw)
>   }
>   
>   /**
> - *  ixgbe_disable_pcie_master - Disable PCI-express master access
> + *  ixgbe_disable_pcie_primary - Disable PCI-express primary access
>    *  @hw: pointer to hardware structure
>    *
> - *  Disables PCI-Express master access and verifies there are no pending
> - *  requests. IXGBE_ERR_MASTER_REQUESTS_PENDING is returned if master disable
> - *  bit hasn't caused the master requests to be disabled, else 0
> - *  is returned signifying master requests disabled.
> + *  Disables PCI-Express primary access and verifies there are no pending
> + *  requests. IXGBE_ERR_PRIMARY_REQUESTS_PENDING is returned if primary disable
> + *  bit hasn't caused the primary requests to be disabled, else 0
> + *  is returned signifying primary requests disabled.
>    **/
> -static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
> +static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw)
>   {
>   	u32 i, poll;
>   	u16 value;
> @@ -2523,23 +2523,23 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
>   	IXGBE_WRITE_REG(hw, IXGBE_CTRL, IXGBE_CTRL_GIO_DIS);
>   
>   	/* Poll for bit to read as set */
> -	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
> +	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
>   		if (IXGBE_READ_REG(hw, IXGBE_CTRL) & IXGBE_CTRL_GIO_DIS)
>   			break;
>   		usleep_range(100, 120);
>   	}
> -	if (i >= IXGBE_PCI_MASTER_DISABLE_TIMEOUT) {
> +	if (i >= IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT) {
>   		hw_dbg(hw, "GIO disable did not set - requesting resets\n");
>   		goto gio_disable_fail;
>   	}
>   
> -	/* Exit if master requests are blocked */
> +	/* Exit if primary requests are blocked */
>   	if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO) ||
>   	    ixgbe_removed(hw->hw_addr))
>   		return 0;
>   
> -	/* Poll for master request bit to clear */
> -	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
> +	/* Poll for primary request bit to clear */
> +	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
>   		udelay(100);
>   		if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO))
>   			return 0;
> @@ -2547,13 +2547,13 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
>   
>   	/*
>   	 * Two consecutive resets are required via CTRL.RST per datasheet
> -	 * 5.2.5.3.2 Master Disable.  We set a flag to inform the reset routine
> -	 * of this need.  The first reset prevents new master requests from
> +	 * 5.2.5.3.2 Primary Disable.  We set a flag to inform the reset routine
> +	 * of this need.  The first reset prevents new primary requests from
>   	 * being issued by our device.  We then must wait 1usec or more for any
>   	 * remaining completions from the PCIe bus to trickle in, and then reset
>   	 * again to clear out any effects they may have had on our device.
>   	 */
> -	hw_dbg(hw, "GIO Master Disable bit didn't clear - requesting resets\n");
> +	hw_dbg(hw, "GIO Primary Disable bit didn't clear - requesting resets\n");
>   gio_disable_fail:
>   	hw->mac.flags |= IXGBE_FLAGS_DOUBLE_RESET_REQUIRED;
>   
> @@ -2575,7 +2575,7 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
>   	}
>   
>   	hw_dbg(hw, "PCIe transaction pending bit also did not clear.\n");
> -	return IXGBE_ERR_MASTER_REQUESTS_PENDING;
> +	return IXGBE_ERR_PRIMARY_REQUESTS_PENDING;
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 796b9895bc91..1cff14fc6c20 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -5948,8 +5948,8 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
>   	case IXGBE_ERR_SFP_NOT_PRESENT:
>   	case IXGBE_ERR_SFP_NOT_SUPPORTED:
>   		break;
> -	case IXGBE_ERR_MASTER_REQUESTS_PENDING:
> -		e_dev_err("master disable timed out\n");
> +	case IXGBE_ERR_PRIMARY_REQUESTS_PENDING:
> +		e_dev_err("primary disable timed out\n");
>   		break;
>   	case IXGBE_ERR_EEPROM_VERSION:
>   		/* We are running on a pre-production device, log a warning */
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index 2647937f7f4d..6da9880d766a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -1247,7 +1247,7 @@ struct ixgbe_nvm_version {
>   #define IXGBE_PSRTYPE_RQPL_SHIFT    29
>   
>   /* CTRL Bit Masks */
> -#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Master Disable bit */
> +#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Primary Disable bit */
>   #define IXGBE_CTRL_LNK_RST      0x00000008 /* Link Reset. Resets everything. */
>   #define IXGBE_CTRL_RST          0x04000000 /* Reset (SW) */
>   #define IXGBE_CTRL_RST_MASK     (IXGBE_CTRL_LNK_RST | IXGBE_CTRL_RST)
> @@ -1811,7 +1811,7 @@ enum {
>   /* STATUS Bit Masks */
>   #define IXGBE_STATUS_LAN_ID         0x0000000C /* LAN ID */
>   #define IXGBE_STATUS_LAN_ID_SHIFT   2          /* LAN ID Shift*/
> -#define IXGBE_STATUS_GIO            0x00080000 /* GIO Master Enable Status */
> +#define IXGBE_STATUS_GIO            0x00080000 /* GIO Primary Enable Status */
>   
>   #define IXGBE_STATUS_LAN_ID_0   0x00000000 /* LAN ID 0 */
>   #define IXGBE_STATUS_LAN_ID_1   0x00000004 /* LAN ID 1 */
> @@ -2193,8 +2193,8 @@ enum {
>   #define IXGBE_PCIDEVCTRL2_4_8s		0xd
>   #define IXGBE_PCIDEVCTRL2_17_34s	0xe
>   
> -/* Number of 100 microseconds we wait for PCI Express master disable */
> -#define IXGBE_PCI_MASTER_DISABLE_TIMEOUT	800
> +/* Number of 100 microseconds we wait for PCI Express primary disable */
> +#define IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT	800
>   
>   /* RAH */
>   #define IXGBE_RAH_VIND_MASK     0x003C0000
> @@ -3671,7 +3671,7 @@ struct ixgbe_info {
>   #define IXGBE_ERR_ADAPTER_STOPPED               -9
>   #define IXGBE_ERR_INVALID_MAC_ADDR              -10
>   #define IXGBE_ERR_DEVICE_NOT_SUPPORTED          -11
> -#define IXGBE_ERR_MASTER_REQUESTS_PENDING       -12
> +#define IXGBE_ERR_PRIMARY_REQUESTS_PENDING      -12
>   #define IXGBE_ERR_INVALID_LINK_SETTINGS         -13
>   #define IXGBE_ERR_AUTONEG_NOT_COMPLETE          -14
>   #define IXGBE_ERR_RESET_FAILED                  -15
