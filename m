From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 28 Jun 2018 16:35:35 -0700
Subject: [Intel-wired-lan] [PATCH v3 08/11] igc: Add NVM support
In-Reply-To: <20180624084518.10286-1-sasha.neftin@intel.com>
References: <20180624084518.10286-1-sasha.neftin@intel.com>
Message-ID: <f20934e8-d2e6-e0c1-c89a-9c2e621d5761@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2018 1:45 AM, Sasha Neftin wrote:
> Add code for NVM support and get MAC address, complete probe
> method.
> 
> Sasha Neftin (v2):
> minor cosmetic changes
> 
> Alexander Duyck (v3):
> NVM access code optimization
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/Makefile        |   2 +-
>   drivers/net/ethernet/intel/igc/e1000_base.c    | 118 ++++++++-
>   drivers/net/ethernet/intel/igc/e1000_defines.h |  81 ++++++
>   drivers/net/ethernet/intel/igc/e1000_hw.h      |   5 +-
>   drivers/net/ethernet/intel/igc/e1000_i225.c    | 351 +++++++++++++++++++++++++
>   drivers/net/ethernet/intel/igc/e1000_i225.h    |   3 +
>   drivers/net/ethernet/intel/igc/e1000_mac.c     | 173 ++++++++++++
>   drivers/net/ethernet/intel/igc/e1000_mac.h     |  13 +-
>   drivers/net/ethernet/intel/igc/e1000_nvm.c     | 219 +++++++++++++++
>   drivers/net/ethernet/intel/igc/e1000_nvm.h     |  16 ++
>   drivers/net/ethernet/intel/igc/e1000_regs.h    |   3 +
>   drivers/net/ethernet/intel/igc/igc.h           |   6 +
>   drivers/net/ethernet/intel/igc/igc_main.c      |  20 +-
>   13 files changed, 1000 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/igc/e1000_nvm.c
>   create mode 100644 drivers/net/ethernet/intel/igc/e1000_nvm.h
> 
> diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
> index cb260bedfa37..5147bca1a900 100644
> --- a/drivers/net/ethernet/intel/igc/Makefile
> +++ b/drivers/net/ethernet/intel/igc/Makefile
> @@ -7,4 +7,4 @@
>   
>   obj-$(CONFIG_IGC) += igc.o
>   
> -igc-objs := igc_main.o e1000_mac.o e1000_i225.o e1000_base.o
> +igc-objs := igc_main.o e1000_mac.o e1000_i225.o e1000_base.o e1000_nvm.o
> diff --git a/drivers/net/ethernet/intel/igc/e1000_base.c b/drivers/net/ethernet/intel/igc/e1000_base.c
> index 395d7ce70bb4..6db31349daa4 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_base.c
> +++ b/drivers/net/ethernet/intel/igc/e1000_base.c
> @@ -11,9 +11,49 @@
>   
>   /* forward declaration */
>   static s32 igc_get_invariants_base(struct e1000_hw *);
> +static s32 igc_check_for_link_base(struct e1000_hw *);
>   static s32 igc_init_hw_base(struct e1000_hw *);
>   static s32 igc_reset_hw_base(struct e1000_hw *);
>   static s32 igc_set_pcie_completion_timeout(struct e1000_hw *hw);
> +static s32 igc_read_mac_addr_base(struct e1000_hw *hw);
> +
> +/**
> + *  igc_init_nvm_params_base - Init NVM func ptrs.
> + *  @hw: pointer to the HW structure
> + **/
> +static s32 igc_init_nvm_params_base(struct e1000_hw *hw)
> +{
> +	struct e1000_nvm_info *nvm = &hw->nvm;
> +	u32 eecd = rd32(E1000_EECD);
> +	u16 size;
> +
> +	size = (u16)((eecd & E1000_EECD_SIZE_EX_MASK) >>
> +		     E1000_EECD_SIZE_EX_SHIFT);
> +
> +	/* Added to a constant, "size" becomes the left-shift value
> +	 * for setting word_size.
> +	 */
> +	size += NVM_WORD_SIZE_BASE_SHIFT;
> +
> +	/* Just in case size is out of range, cap it to the largest
> +	 * EEPROM size supported
> +	 */
> +	if (size > 15)
> +		size = 15;
> +
> +	nvm->word_size = BIT(size);
> +	nvm->opcode_bits = 8;
> +	nvm->delay_usec = 1;
> +
> +	nvm->page_size = eecd & E1000_EECD_ADDR_BITS ? 32 : 8;
> +	nvm->address_bits = eecd & E1000_EECD_ADDR_BITS ?
> +			    16 : 8;
> +
> +	if (nvm->word_size == BIT(15))
> +		nvm->page_size = 128;
> +
> +	return 0;
> +}
>   
>   /**
>    *  igc_init_mac_params_base - Init MAC func ptrs.
> @@ -22,6 +62,7 @@ static s32 igc_set_pcie_completion_timeout(struct e1000_hw *hw);
>   static s32 igc_init_mac_params_base(struct e1000_hw *hw)
>   {
>   	struct e1000_mac_info *mac = &hw->mac;
> +	struct e1000_dev_spec_base *dev_spec = &hw->dev_spec._base;

reverse xmas tree

>   
>   	/* Set mta register count */
>   	mac->mta_reg_count = 128;
> @@ -33,6 +74,10 @@ static s32 igc_init_mac_params_base(struct e1000_hw *hw)
>   	mac->ops.acquire_swfw_sync = igc_acquire_swfw_sync_i225;
>   	mac->ops.release_swfw_sync = igc_release_swfw_sync_i225;
>   
> +	/* Allow a single clear of the SW semaphore on I225 */
> +	if (mac->type == e1000_i225)
> +		dev_spec->clear_semaphore_once = true;
> +
>   	return 0;
>   }
>   
> @@ -50,11 +95,60 @@ static s32 igc_get_invariants_base(struct e1000_hw *hw)
>   	if (ret_val)
>   		goto out;
>   
> +	/* NVM initialization */
> +	ret_val = igc_init_nvm_params_base(hw);
> +	switch (hw->mac.type) {
> +	case e1000_i225:
> +		ret_val = igc_init_nvm_params_i225(hw);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (ret_val)
> +		goto out;
> +
>   out:
>   	return ret_val;
>   }
>   
>   /**
> + *  igc_get_link_up_info_base - Get link speed/duplex info
> + *  @hw: pointer to the HW structure
> + *  @speed: stores the current speed
> + *  @duplex: stores the current duplex
> + *
> + *  This is a wrapper function, if using the serial gigabit media independent
> + *  interface, use PCS to retrieve the link speed and duplex information.
> + *  Otherwise, use the generic function to get the link speed and duplex info.
> + **/
> +static s32 igc_get_link_up_info_base(struct e1000_hw *hw, u16 *speed,
> +				     u16 *duplex)
> +{
> +	s32 ret_val;
> +
> +	ret_val = igc_get_speed_and_duplex_copper(hw, speed, duplex);
> +
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_check_for_link_base - Check for link
> + *  @hw: pointer to the HW structure
> + *
> + *  If sgmii is enabled, then use the pcs register to determine link, otherwise
> + *  use the generic interface for determining link.
> + **/
> +static s32 igc_check_for_link_base(struct e1000_hw *hw)
> +{
> +	s32 ret_val = 0;
> +
> +	ret_val = igc_check_for_copper_link(hw);
> +
> +	return ret_val;
> +}
> +
> +/**
>    *  igc_init_hw_base - Initialize hardware
>    *  @hw: pointer to the HW structure
>    *
> @@ -93,6 +187,19 @@ static s32 igc_init_hw_base(struct e1000_hw *hw)
>   }
>   
>   /**
> + *  igc_read_mac_addr_base - Read device MAC address
> + *  @hw: pointer to the HW structure
> + **/
> +static s32 igc_read_mac_addr_base(struct e1000_hw *hw)
> +{
> +	s32 ret_val = 0;
> +
> +	ret_val = igc_read_mac_addr(hw);
> +
> +	return ret_val;
> +}
> +
> +/**
>    *  igc_rx_fifo_flush_base - Clean rx fifo after Rx enable
>    *  @hw: pointer to the HW structure
>    *
> @@ -169,12 +276,17 @@ void igc_rx_fifo_flush_base(struct e1000_hw *hw)
>   }
>   
>   static struct e1000_mac_operations e1000_mac_ops_base = {
> -	.init_hw	= igc_init_hw_base,
> +	.init_hw		= igc_init_hw_base,
> +	.check_for_link		= igc_check_for_link_base,
> +	.rar_set		= igc_rar_set,
> +	.read_mac_addr		=  igc_read_mac_addr_base,

Extra space after the '='

> +	.get_speed_and_duplex	= igc_get_link_up_info_base,
>   };
>   
>   const struct e1000_info e1000_base_info = {
> -	.get_invariants = igc_get_invariants_base,
> -	.mac_ops = &e1000_mac_ops_base,
> +	.get_invariants	= igc_get_invariants_base,
> +	.mac_ops	= &e1000_mac_ops_base,
> +	/* TODO phy_ops */
>   };
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/igc/e1000_defines.h b/drivers/net/ethernet/intel/igc/e1000_defines.h
> index 5613806742b1..31bc85cfa149 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_defines.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_defines.h
> @@ -55,6 +55,8 @@
>    */
>   #define E1000_RAH_AV		0x80000000 /* Receive descriptor valid */
>   #define E1000_RAH_POOL_1	0x00040000
> +#define E1000_RAL_MAC_ADDR_LEN	4
> +#define E1000_RAH_MAC_ADDR_LEN	2
>   
>   /* Error Codes */
>   #define E1000_SUCCESS				0
> @@ -77,13 +79,84 @@
>   #define E1000_SWSM_SMBI		0x00000001 /* Driver Semaphore bit */
>   #define E1000_SWSM_SWESMBI	0x00000002 /* FW Semaphore bit */
>   
> +/* SWFW_SYNC Definitions */
> +#define E1000_SWFW_EEP_SM	0x1
> +#define E1000_SWFW_PHY0_SM	0x2
> +#define E1000_SWFW_PHY1_SM	0x4
> +#define E1000_SWFW_PHY2_SM	0x20
> +#define E1000_SWFW_PHY3_SM	0x40
> +
>   /* NVM Control */
> +#define E1000_EECD_SK		0x00000001 /* NVM Clock */
> +#define E1000_EECD_CS		0x00000002 /* NVM Chip Select */
> +#define E1000_EECD_DI		0x00000004 /* NVM Data In */
> +#define E1000_EECD_DO		0x00000008 /* NVM Data Out */
> +#define E1000_EECD_REQ		0x00000040 /* NVM Access Request */
> +#define E1000_EECD_GNT		0x00000080 /* NVM Access Grant */
>   #define E1000_EECD_PRES		0x00000100 /* NVM Present */
> +/* NVM Addressing bits based on type 0=small, 1=large */
> +#define E1000_EECD_ADDR_BITS		0x00000400
> +#define E1000_NVM_GRANT_ATTEMPTS	1000 /* NVM # attempts to gain grant */
> +#define E1000_EECD_AUTO_RD		0x00000200  /* NVM Auto Read done */
> +#define E1000_EECD_SIZE_EX_MASK		0x00007800  /* NVM Size */
> +#define E1000_EECD_SIZE_EX_SHIFT	11
> +#define E1000_EECD_FLUPD_I225		0x00800000 /* Update FLASH */
> +#define E1000_EECD_FLUDONE_I225		0x04000000 /* Update FLASH done*/
> +#define E1000_EECD_FLASH_DETECTED_I225	0x00080000 /* FLASH detected */
> +#define E1000_FLUDONE_ATTEMPTS		20000
> +#define E1000_EERD_EEWR_MAX_COUNT	512 /* buffered EEPROM words rw */
>   
>   /* Number of milliseconds for NVM auto read done after MAC reset. */
>   #define AUTO_READ_DONE_TIMEOUT		10
>   #define E1000_EECD_AUTO_RD	0x00000200  /* NVM Auto Read done */
>   
> +/* Offset to data in NVM read/write registers */
> +#define E1000_NVM_RW_REG_DATA	16
> +#define E1000_NVM_RW_REG_DONE	2    /* Offset to READ/WRITE done bit */
> +#define E1000_NVM_RW_REG_START	1    /* Start operation */
> +#define E1000_NVM_RW_ADDR_SHIFT	2    /* Shift to the address bits */
> +#define E1000_NVM_POLL_READ	0    /* Flag for polling for read complete */
> +
> +/* NVM Word Offsets */
> +#define NVM_COMPAT			0x0003
> +#define NVM_ID_LED_SETTINGS		0x0004 /* SERDES output amplitude */
> +#define NVM_VERSION			0x0005
> +#define NVM_INIT_CONTROL2_REG		0x000F
> +#define NVM_INIT_CONTROL3_PORT_B	0x0014
> +#define NVM_INIT_CONTROL3_PORT_A	0x0024
> +#define NVM_ALT_MAC_ADDR_PTR		0x0037
> +#define NVM_CHECKSUM_REG		0x003F
> +#define NVM_COMPATIBILITY_REG_3		0x0003
> +#define NVM_COMPATIBILITY_BIT_MASK	0x8000
> +#define NVM_MAC_ADDR			0x0000
> +#define NVM_SUB_DEV_ID			0x000B
> +#define NVM_SUB_VEN_ID			0x000C
> +#define NVM_DEV_ID			0x000D
> +#define NVM_VEN_ID			0x000E
> +#define NVM_INIT_CTRL_2			0x000F
> +#define NVM_INIT_CTRL_4			0x0013
> +#define NVM_LED_1_CFG			0x001C
> +#define NVM_LED_0_2_CFG			0x001F
> +#define NVM_ETRACK_WORD			0x0042
> +#define NVM_ETRACK_HIWORD		0x0043
> +#define NVM_COMB_VER_OFF		0x0083
> +#define NVM_COMB_VER_PTR		0x003d
> +
> +/* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
> +#define NVM_SUM				0xBABA
> +
> +#define NVM_PBA_OFFSET_0		8
> +#define NVM_PBA_OFFSET_1		9
> +#define NVM_RESERVED_WORD		0xFFFF
> +#define NVM_PBA_PTR_GUARD		0xFAFA
> +#define NVM_WORD_SIZE_BASE_SHIFT	6
> +
> +/* Collision related configuration parameters */
> +#define E1000_COLLISION_THRESHOLD	15
> +#define E1000_CT_SHIFT			4
> +#define E1000_COLLISION_DISTANCE	63
> +#define E1000_COLD_SHIFT		12
> +
>   /* Device Status */
>   #define E1000_STATUS_FD		0x00000001      /* Full duplex.0=half,1=full */
>   #define E1000_STATUS_LU		0x00000002      /* Link up.0=no,1=link */
> @@ -93,6 +166,14 @@
>   #define E1000_STATUS_TXOFF	0x00000010      /* transmission paused */
>   #define E1000_STATUS_SPEED_100	0x00000040      /* Speed 100Mb/s */
>   #define E1000_STATUS_SPEED_1000	0x00000080      /* Speed 1000Mb/s */
> +#define E1000_STATUS_SPEED_2500	0x00400000	/* Speed 2.5Gb/s */
> +
> +#define SPEED_10		10
> +#define SPEED_100		100
> +#define SPEED_1000		1000
> +#define SPEED_2500		2500
> +#define HALF_DUPLEX		1
> +#define FULL_DUPLEX		2
>   
>   /* Interrupt Cause Read */
>   #define E1000_ICR_TXDW		0x00000001 /* Transmit desc written back */
> diff --git a/drivers/net/ethernet/intel/igc/e1000_hw.h b/drivers/net/ethernet/intel/igc/e1000_hw.h
> index debeadd61b45..ab630e5b3d97 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_hw.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_hw.h
> @@ -11,6 +11,7 @@
>   #include "e1000_regs.h"
>   #include "e1000_defines.h"
>   #include "e1000_mac.h"
> +#include "e1000_nvm.h"
>   #include "e1000_i225.h"
>   #include "e1000_base.h"
>   
> @@ -81,6 +82,8 @@ struct e1000_info {
>   	struct e1000_nvm_operations *nvm_ops;
>   };
>   
> +extern const struct e1000_info e1000_base_info;
> +
>   struct e1000_mac_info {
>   	struct e1000_mac_operations ops;
>   
> @@ -118,7 +121,7 @@ struct e1000_mac_info {
>   
>   struct e1000_nvm_operations {
>   	s32 (*acquire)(struct e1000_hw *hw);
> -	s32 (*read)(struct e1000_hw *hw, u16 offset, u16 i, u16 *data);
> +	s32 (*read)(struct e1000_hw *hw, u16 offset, u16 words, u16 *data);
>   	void (*release)(struct e1000_hw *hw);
>   	s32 (*write)(struct e1000_hw *hw, u16 offset, u16 i, u16 *data);
>   	s32 (*update)(struct e1000_hw *hw);
> diff --git a/drivers/net/ethernet/intel/igc/e1000_i225.c b/drivers/net/ethernet/intel/igc/e1000_i225.c
> index 11d797c77619..d1fa45f600dc 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_i225.c
> +++ b/drivers/net/ethernet/intel/igc/e1000_i225.c
> @@ -6,6 +6,32 @@
>   #include "e1000_hw.h"
>   
>   /**
> + *  igc_acquire_nvm_i225 - Request for access to EEPROM
> + *  @hw: pointer to the HW structure
> + *
> + *  Acquire the necessary semaphores for exclusive access to the EEPROM.
> + *  Set the EEPROM access request bit and wait for EEPROM access grant bit.
> + *  Return successful if access grant bit set, else clear the request for
> + *  EEPROM access and return -E1000_ERR_NVM (-1).
> + **/
> +static s32 igc_acquire_nvm_i225(struct e1000_hw *hw)
> +{
> +	return igc_acquire_swfw_sync_i225(hw, E1000_SWFW_EEP_SM);
> +}
> +
> +/**
> + *  igc_release_nvm_i225 - Release exclusive access to EEPROM
> + *  @hw: pointer to the HW structure
> + *
> + *  Stop any current commands to the EEPROM and clear the EEPROM request bit,
> + *  then release the semaphores acquired.
> + **/
> +static void igc_release_nvm_i225(struct e1000_hw *hw)
> +{
> +	igc_release_swfw_sync_i225(hw, E1000_SWFW_EEP_SM);
> +}
> +
> +/**
>    *  igc_get_hw_semaphore_i225 - Acquire hardware semaphore
>    *  @hw: pointer to the HW structure
>    *
> @@ -139,3 +165,328 @@ void igc_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
>   
>   	igc_put_hw_semaphore(hw);
>   }
> +
> +/**
> + *  igc_read_nvm_srrd_i225 - Reads Shadow Ram using EERD register
> + *  @hw: pointer to the HW structure
> + *  @offset: offset of word in the Shadow Ram to read
> + *  @words: number of words to read
> + *  @data: word read from the Shadow Ram
> + *
> + *  Reads a 16 bit word from the Shadow Ram using the EERD register.
> + *  Uses necessary synchronization semaphores.
> + **/
> +static s32 igc_read_nvm_srrd_i225(struct e1000_hw *hw, u16 offset, u16 words,
> +				  u16 *data)
> +{
> +	s32 status = 0;
> +	u16 i, count;
> +
> +	/* We cannot hold synchronization semaphores for too long,
> +	 * because of forceful takeover procedure. However it is more efficient
> +	 * to read in bursts than synchronizing access for each word.
> +	 */
> +	for (i = 0; i < words; i += E1000_EERD_EEWR_MAX_COUNT) {
> +		count = (words - i) / E1000_EERD_EEWR_MAX_COUNT > 0 ?
> +			E1000_EERD_EEWR_MAX_COUNT : (words - i);
> +		if (!(hw->nvm.ops.acquire(hw))) {
> +			status = igc_read_nvm_eerd(hw, offset, count,
> +						   data + i);
> +			hw->nvm.ops.release(hw);
> +		} else {
> +			status = E1000_ERR_SWFW_SYNC;

Is this missing the '-' on purpose?

> +		}
> +
> +		if (status)
> +			break;

This code seem rather awkward and harder to read than necessary ... 
maybe something more like this?

		status = hw->nvm.ops.acquire(hw);
		if (status)
			break;

		status = igc_read_nvm_eerd(hw, offset, count, data + i);
		hw->nvm.ops.release(hw);

		if (status)
			break;

> +	}
> +
> +	return status;
> +}
> +
> +/**
> + *  igc_write_nvm_srwr - Write to Shadow Ram using EEWR
> + *  @hw: pointer to the HW structure
> + *  @offset: offset within the Shadow Ram to be written to
> + *  @words: number of words to write
> + *  @data: 16 bit word(s) to be written to the Shadow Ram
> + *
> + *  Writes data to Shadow Ram at offset using EEWR register.
> + *
> + *  If igc_update_nvm_checksum is not called after this function , the
> + *  Shadow Ram will most likely contain an invalid checksum.
> + **/
> +static s32 igc_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
> +			      u16 *data)
> +{
> +	struct e1000_nvm_info *nvm = &hw->nvm;
> +	u32 i, k, eewr = 0;
> +	u32 attempts = 100000;
> +	s32 ret_val = 0;
> +
> +	/* A check for invalid values:  offset too large, too many words,
> +	 * too many words for the offset, and not enough words.
> +	 */
> +	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
> +	    words == 0) {
> +		hw_dbg("nvm parameter(s) out of bounds\n");
> +		ret_val = -E1000_ERR_NVM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < words; i++) {
> +		eewr = ((offset + i) << E1000_NVM_RW_ADDR_SHIFT) |
> +			(data[i] << E1000_NVM_RW_REG_DATA) |
> +			E1000_NVM_RW_REG_START;
> +
> +		wr32(E1000_SRWR, eewr);
> +
> +		for (k = 0; k < attempts; k++) {
> +			if (E1000_NVM_RW_REG_DONE &
> +			    rd32(E1000_SRWR)) {
> +				ret_val = 0;
> +				break;
> +			}
> +			udelay(5);
> +		}
> +
> +		if (ret_val) {
> +			hw_dbg("Shadow RAM write EEWR timed out\n");
> +			break;
> +		}
> +	}
> +
> +out:
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_write_nvm_srwr_i225 - Write to Shadow RAM using EEWR
> + *  @hw: pointer to the HW structure
> + *  @offset: offset within the Shadow RAM to be written to
> + *  @words: number of words to write
> + *  @data: 16 bit word(s) to be written to the Shadow RAM
> + *
> + *  Writes data to Shadow RAM at offset using EEWR register.
> + *
> + *  If e1000_update_nvm_checksum is not called after this function , the
> + *  data will not be committed to FLASH and also Shadow RAM will most likely
> + *  contain an invalid checksum.
> + *
> + *  If error code is returned, data and Shadow RAM may be inconsistent - buffer
> + *  partially written.
> + **/
> +static s32 igc_write_nvm_srwr_i225(struct e1000_hw *hw, u16 offset, u16 words,
> +				   u16 *data)
> +{
> +	s32 status = 0;
> +	u16 i, count;
> +
> +	/* We cannot hold synchronization semaphores for too long,
> +	 * because of forceful takeover procedure. However it is more efficient
> +	 * to write in bursts than synchronizing access for each word.
> +	 */
> +	for (i = 0; i < words; i += E1000_EERD_EEWR_MAX_COUNT) {
> +		count = (words - i) / E1000_EERD_EEWR_MAX_COUNT > 0 ?
> +			E1000_EERD_EEWR_MAX_COUNT : (words - i);
> +		if (!(hw->nvm.ops.acquire(hw))) {
> +			status = igc_write_nvm_srwr(hw, offset, count,
> +						    data + i);
> +			hw->nvm.ops.release(hw);
> +		} else {
> +			status = E1000_ERR_SWFW_SYNC;

Is this missing the '-' on purpose?

> +		}
> +
> +		if (status)
> +			break;

Same as earlier comment - this code can be made clearer

> +	}
> +
> +	return status;
> +}
> +
> +/**
> + *  igc_validate_nvm_checksum_i225 - Validate EEPROM checksum
> + *  @hw: pointer to the HW structure
> + *
> + *  Calculates the EEPROM checksum by reading/adding each word of the EEPROM
> + *  and then verifies that the sum of the EEPROM is equal to 0xBABA.
> + **/
> +static s32 igc_validate_nvm_checksum_i225(struct e1000_hw *hw)
> +{
> +	s32 status = 0;
> +	s32 (*read_op_ptr)(struct e1000_hw *hw, u16 offset, u16 count,
> +			   u16 *data);
> +
> +	if (!(hw->nvm.ops.acquire(hw))) {

Again, this can be simpler

	status = hw->nvm.ops.acquire(hw);
	if (status)
		return status;

and now the next chunk doesn't need to be indented

> +		/* Replace the read function with semaphore grabbing with
> +		 * the one that skips this for a while.
> +		 * We have semaphore taken already here.
> +		 */
> +		read_op_ptr = hw->nvm.ops.read;
> +		hw->nvm.ops.read = igc_read_nvm_eerd;
> +
> +		status = igc_validate_nvm_checksum(hw);
> +
> +		/* Revert original read operation. */
> +		hw->nvm.ops.read = read_op_ptr;
> +
> +		hw->nvm.ops.release(hw);
> +	} else {
> +		status = E1000_ERR_SWFW_SYNC;

Should this have a minus sign?  Or, this line is not needed if the code 
is simplified as suggested above.

> +	}
> +
> +	return status;
> +}
> +
> +/**
> + *  igc_pool_flash_update_done_i225 - Pool FLUDONE status
> + *  @hw: pointer to the HW structure
> + **/
> +static s32 igc_pool_flash_update_done_i225(struct e1000_hw *hw)
> +{
> +	s32 ret_val = -E1000_ERR_NVM;
> +	u32 i, reg;
> +
> +	for (i = 0; i < E1000_FLUDONE_ATTEMPTS; i++) {
> +		reg = rd32(E1000_EECD);
> +		if (reg & E1000_EECD_FLUDONE_I225) {
> +			ret_val = 0;
> +			break;
> +		}
> +		udelay(5);
> +	}
> +
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_update_flash_i225 - Commit EEPROM to the flash
> + *  @hw: pointer to the HW structure
> + **/
> +static s32 igc_update_flash_i225(struct e1000_hw *hw)
> +{
> +	s32 ret_val = 0;
> +	u32 flup;
> +
> +	ret_val = igc_pool_flash_update_done_i225(hw);
> +	if (ret_val == -E1000_ERR_NVM) {
> +		hw_dbg("Flash update time out\n");
> +		goto out;
> +	}
> +
> +	flup = rd32(E1000_EECD) | E1000_EECD_FLUPD_I225;
> +	wr32(E1000_EECD, flup);
> +
> +	ret_val = igc_pool_flash_update_done_i225(hw);
> +	if (ret_val)
> +		hw_dbg("Flash update time out\n");
> +	else
> +		hw_dbg("Flash update complete\n");
> +
> +out:
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_update_nvm_checksum_i225 - Update EEPROM checksum
> + *  @hw: pointer to the HW structure
> + *
> + *  Updates the EEPROM checksum by reading/adding each word of the EEPROM
> + *  up to the checksum.  Then calculates the EEPROM checksum and writes the
> + *  value to the EEPROM. Next commit EEPROM data onto the Flash.
> + **/
> +static s32 igc_update_nvm_checksum_i225(struct e1000_hw *hw)
> +{
> +	s32 ret_val = 0;
> +	u16 checksum = 0;
> +	u16 i, nvm_data;
> +
> +	/* Read the first word from the EEPROM. If this times out or fails, do
> +	 * not continue or we could be in for a very long wait while every
> +	 * EEPROM read fails
> +	 */
> +	ret_val = igc_read_nvm_eerd(hw, 0, 1, &nvm_data);
> +	if (ret_val) {
> +		hw_dbg("EEPROM read failed\n");
> +		goto out;

May as well do a return here rather than goto a return

> +	}
> +
> +	if (!(hw->nvm.ops.acquire(hw))) {

See earlier comments

> +		/* Do not use hw->nvm.ops.write, hw->nvm.ops.read
> +		 * because we do not want to take the synchronization
> +		 * semaphores twice here.
> +		 */
> +
> +		for (i = 0; i < NVM_CHECKSUM_REG; i++) {
> +			ret_val = igc_read_nvm_eerd(hw, i, 1, &nvm_data);
> +			if (ret_val) {
> +				hw->nvm.ops.release(hw);
> +				hw_dbg("NVM Read Error while updating checksum.\n");
> +				goto out;
> +			}
> +			checksum += nvm_data;
> +		}
> +		checksum = (u16)NVM_SUM - checksum;
> +		ret_val = igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
> +					     &checksum);
> +		if (ret_val) {
> +			hw->nvm.ops.release(hw);
> +			hw_dbg("NVM Write Error while updating checksum.\n");
> +			goto out;
> +		}
> +
> +		hw->nvm.ops.release(hw);
> +
> +		ret_val = igc_update_flash_i225(hw);
> +	} else {
> +		ret_val = -E1000_ERR_SWFW_SYNC;
> +	}
> +
> +out:
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_get_flash_presence_i225 - Check if flash device is detected
> + *  @hw: pointer to the HW structure
> + **/
> +bool igc_get_flash_presence_i225(struct e1000_hw *hw)
> +{
> +	u32 eec = 0;
> +	bool ret_val = false;
> +
> +	eec = rd32(E1000_EECD);
> +	if (eec & E1000_EECD_FLASH_DETECTED_I225)
> +		ret_val = true;
> +
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_init_nvm_params_i225 - Init NVM func ptrs.
> + *  @hw: pointer to the HW structure
> + **/
> +s32 igc_init_nvm_params_i225(struct e1000_hw *hw)
> +{
> +	s32 ret_val = 0;
> +	struct e1000_nvm_info *nvm = &hw->nvm;
> +
> +	nvm->ops.acquire = igc_acquire_nvm_i225;
> +	nvm->ops.release = igc_release_nvm_i225;
> +
> +	/* NVM Function Pointers */
> +	if (igc_get_flash_presence_i225(hw)) {
> +		hw->nvm.type = e1000_nvm_flash_hw;
> +		nvm->ops.read = igc_read_nvm_srrd_i225;
> +		nvm->ops.write = igc_write_nvm_srwr_i225;
> +		nvm->ops.validate = igc_validate_nvm_checksum_i225;
> +		nvm->ops.update = igc_update_nvm_checksum_i225;
> +	} else {
> +		hw->nvm.type = e1000_nvm_invm;
> +		nvm->ops.read = igc_read_nvm_eerd;
> +		nvm->ops.write = NULL;
> +		nvm->ops.validate = NULL;
> +		nvm->ops.update = NULL;
> +	}
> +	return ret_val;
> +}
> diff --git a/drivers/net/ethernet/intel/igc/e1000_i225.h b/drivers/net/ethernet/intel/igc/e1000_i225.h
> index 749a50c34534..c8c0398d9ff0 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_i225.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_i225.h
> @@ -7,4 +7,7 @@
>   s32 igc_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
>   void igc_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
>   
> +s32 igc_init_nvm_params_i225(struct e1000_hw *hw);
> +bool igc_get_flash_presence_i225(struct e1000_hw *hw);
> +
>   #endif
> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.c b/drivers/net/ethernet/intel/igc/e1000_mac.c
> index 27e478a9854c..5681c0e3f0c8 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_mac.c
> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.c
> @@ -326,6 +326,132 @@ void igc_clear_hw_cntrs_base(struct e1000_hw *hw)
>   }
>   
>   /**
> + *  igc_rar_set - Set receive address register
> + *  @hw: pointer to the HW structure
> + *  @addr: pointer to the receive address
> + *  @index: receive address array register
> + *
> + *  Sets the receive address array register at index to the address passed
> + *  in by addr.
> + **/
> +void igc_rar_set(struct e1000_hw *hw, u8 *addr, u32 index)
> +{
> +	u32 rar_low, rar_high;
> +
> +	/* HW expects these in little endian so we reverse the byte order
> +	 * from network order (big endian) to little endian
> +	 */
> +	rar_low = ((u32)addr[0] |
> +		   ((u32)addr[1] << 8) |
> +		   ((u32)addr[2] << 16) | ((u32)addr[3] << 24));
> +
> +	rar_high = ((u32)addr[4] | ((u32)addr[5] << 8));
> +
> +	/* If MAC address zero, no need to set the AV bit */
> +	if (rar_low || rar_high)
> +		rar_high |= E1000_RAH_AV;

if the mac address is zero, there's no need to do the swap

> +
> +	/* Some bridges will combine consecutive 32-bit writes into
> +	 * a single burst write, which will malfunction on some parts.

Is this malfunction in the new devices?  Is this comment still needed?

> +	 * The flushes avoid this.
> +	 */
> +	wr32(E1000_RAL(index), rar_low);
> +	wrfl();
> +	wr32(E1000_RAH(index), rar_high);
> +	wrfl();
> +}
> +
> +/**
> + *  igc_check_for_copper_link - Check for link (Copper)
> + *  @hw: pointer to the HW structure
> + *
> + *  Checks to see of the link status of the hardware has changed.  If a
> + *  change in link status has been detected, then we read the PHY registers
> + *  to get the current speed/duplex if link exists.
> + **/
> +s32 igc_check_for_copper_link(struct e1000_hw *hw)
> +{
> +	struct e1000_mac_info *mac = &hw->mac;
> +	s32 ret_val;
> +	bool link;
> +
> +	/* We only want to go out to the PHY registers to see if Auto-Neg
> +	 * has completed and/or if our link status has changed.  The
> +	 * get_link_status flag is set upon receiving a Link Status
> +	 * Change or Rx Sequence Error interrupt.
> +	 */
> +	if (!mac->get_link_status) {
> +		ret_val = 0;
> +		goto out;
> +	}
> +
> +	/* First we want to see if the MII Status Register reports
> +	 * link.  If so, then we want to get the current speed/duplex
> +	 * of the PHY.
> +	 */
> +	/* TODO ret_val = igc_phy_has_link(hw, 1, 0, &link); */
> +	if (ret_val)
> +		goto out;
> +
> +	if (!link)
> +		goto out; /* No link detected */
> +
> +	mac->get_link_status = false;
> +
> +	/* Check if there was DownShift, must be checked
> +	 * immediately after link-up
> +	 */
> +	/* TODO igc_check_downshift(hw); */
> +
> +	/* If we are forcing speed/duplex, then we simply return since
> +	 * we have already determined whether we have link or not.
> +	 */
> +	if (!mac->autoneg) {
> +		ret_val = -E1000_ERR_CONFIG;
> +		goto out;
> +	}
> +
> +	/* Auto-Neg is enabled.  Auto Speed Detection takes care
> +	 * of MAC speed/duplex configuration.  So we only need to
> +	 * configure Collision Distance in the MAC.
> +	 */
> +	igc_config_collision_dist(hw);
> +
> +	/* Configure Flow Control now that Auto-Neg has completed.
> +	 * First, we need to restore the desired flow control
> +	 * settings because we may have had to re-autoneg with a
> +	 * different link partner.
> +	 */
> +	/* TODO ret_val = igc_config_fc_after_link_up(hw); */
> +	if (ret_val)
> +		hw_dbg("Error configuring flow control\n");
> +
> +out:
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_config_collision_dist - Configure collision distance
> + *  @hw: pointer to the HW structure
> + *
> + *  Configures the collision distance to the default value and is used
> + *  during link setup. Currently no func pointer exists and all
> + *  implementations are handled in the generic version of this function.
> + **/
> +void igc_config_collision_dist(struct e1000_hw *hw)
> +{
> +	u32 tctl;
> +
> +	tctl = rd32(E1000_TCTL);
> +
> +	tctl &= ~E1000_TCTL_COLD;
> +	tctl |= E1000_COLLISION_DISTANCE << E1000_COLD_SHIFT;
> +
> +	wr32(E1000_TCTL, tctl);
> +	wrfl();
> +}
> +
> +/**
>    *  igc_get_auto_rd_done - Check for auto read completion
>    *  @hw: pointer to the HW structure
>    *
> @@ -354,6 +480,53 @@ s32 igc_get_auto_rd_done(struct e1000_hw *hw)
>   }
>   
>   /**
> + *  igc_get_speed_and_duplex_copper - Retrieve current speed/duplex
> + *  @hw: pointer to the HW structure
> + *  @speed: stores the current speed
> + *  @duplex: stores the current duplex
> + *
> + *  Read the status register for the current speed/duplex and store the current
> + *  speed and duplex for copper connections.
> + **/
> +s32 igc_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
> +				    u16 *duplex)
> +{
> +	u32 status;
> +
> +	status = rd32(E1000_STATUS);
> +	if (status & E1000_STATUS_SPEED_1000) {
> +		/* For I225, STATUS will indicate 1G speed in both 1 Gbps
> +		 * and 2.5 Gbps link modes. An additional bit is used
> +		 * to differentiate between 1 Gbps and 2.5 Gbps.
> +		 */
> +		if (hw->mac.type == e1000_i225 &&
> +		    (status & E1000_STATUS_SPEED_2500)) {
> +			*speed = SPEED_2500;
> +			hw_dbg("2500 Mbs, ");
> +		} else {
> +			*speed = SPEED_1000;
> +			hw_dbg("1000 Mbs, ");
> +		}
> +	} else if (status & E1000_STATUS_SPEED_100) {
> +		*speed = SPEED_100;
> +		hw_dbg("100 Mbs, ");
> +	} else {
> +		*speed = SPEED_10;
> +		hw_dbg("10 Mbs, ");
> +	}
> +
> +	if (status & E1000_STATUS_FD) {
> +		*duplex = FULL_DUPLEX;
> +		hw_dbg("Full Duplex\n");
> +	} else {
> +		*duplex = HALF_DUPLEX;
> +		hw_dbg("Half Duplex\n");
> +	}
> +
> +	return 0;
> +}
> +
> +/**
>    *  igc_put_hw_semaphore - Release hardware semaphore
>    *  @hw: pointer to the HW structure
>    *
> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.h b/drivers/net/ethernet/intel/igc/e1000_mac.h
> index 2f8dbf17800a..f18f5221199f 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_mac.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.h
> @@ -12,13 +12,20 @@
>   #endif /* E1000_REMOVED */
>   
>   /* forward declaration */
> -s32  igc_disable_pcie_master(struct e1000_hw *hw);
> +s32 igc_check_for_copper_link(struct e1000_hw *hw);
> +
> +s32 igc_disable_pcie_master(struct e1000_hw *hw);
>   void igc_init_rx_addrs(struct e1000_hw *hw, u16 rar_count);
> -s32  igc_setup_link(struct e1000_hw *hw);
> +s32 igc_setup_link(struct e1000_hw *hw);
>   void igc_clear_hw_cntrs_base(struct e1000_hw *hw);
>   s32 igc_get_auto_rd_done(struct e1000_hw *hw);
>   void igc_put_hw_semaphore(struct e1000_hw *hw);
> +void igc_rar_set(struct e1000_hw *hw, u8 *addr, u32 index);
> +
> +void igc_config_collision_dist(struct e1000_hw *hw);
>   
> -s32  igc_get_bus_info_pcie(struct e1000_hw *hw);
> +s32 igc_get_bus_info_pcie(struct e1000_hw *hw);
> +s32 igc_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
> +				    u16 *duplex);
>   
>   #endif
> diff --git a/drivers/net/ethernet/intel/igc/e1000_nvm.c b/drivers/net/ethernet/intel/igc/e1000_nvm.c
> new file mode 100644
> index 000000000000..62a4ae7f224b
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/e1000_nvm.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c)  2018 Intel Corporation */
> +
> +#include "e1000_mac.h"
> +#include "e1000_nvm.h"
> +
> +/**
> + *  igc_poll_eerd_eewr_done - Poll for EEPROM read/write completion
> + *  @hw: pointer to the HW structure
> + *  @ee_reg: EEPROM flag for polling
> + *
> + *  Polls the EEPROM status bit for either read or write completion based
> + *  upon the value of 'ee_reg'.
> + **/
> +static s32 igc_poll_eerd_eewr_done(struct e1000_hw *hw, int ee_reg)
> +{
> +	u32 attempts = 100000;
> +	u32 i, reg = 0;
> +	s32 ret_val = -E1000_ERR_NVM;
> +
> +	for (i = 0; i < attempts; i++) {
> +		if (ee_reg == E1000_NVM_POLL_READ)
> +			reg = rd32(E1000_EERD);
> +		else
> +			reg = rd32(E1000_EEWR);
> +
> +		if (reg & E1000_NVM_RW_REG_DONE) {
> +			ret_val = 0;
> +			break;
> +		}
> +
> +		udelay(5);
> +	}
> +
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_acquire_nvm - Generic request for access to EEPROM
> + *  @hw: pointer to the HW structure
> + *
> + *  Set the EEPROM access request bit and wait for EEPROM access grant bit.
> + *  Return successful if access grant bit set, else clear the request for
> + *  EEPROM access and return -E1000_ERR_NVM (-1).
> + **/
> +s32 igc_acquire_nvm(struct e1000_hw *hw)
> +{
> +	u32 eecd = rd32(E1000_EECD);
> +	s32 timeout = E1000_NVM_GRANT_ATTEMPTS;
> +	s32 ret_val = 0;
> +
> +	wr32(E1000_EECD, eecd | E1000_EECD_REQ);
> +	eecd = rd32(E1000_EECD);
> +
> +	while (timeout) {
> +		if (eecd & E1000_EECD_GNT)
> +			break;
> +		udelay(5);
> +		eecd = rd32(E1000_EECD);
> +		timeout--;
> +	}
> +
> +	if (!timeout) {
> +		eecd &= ~E1000_EECD_REQ;
> +		wr32(E1000_EECD, eecd);
> +		hw_dbg("Could not acquire NVM grant\n");
> +		ret_val = -E1000_ERR_NVM;
> +	}
> +
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_release_nvm - Release exclusive access to EEPROM
> + *  @hw: pointer to the HW structure
> + *
> + *  Stop any current commands to the EEPROM and clear the EEPROM request bit.
> + **/
> +void igc_release_nvm(struct e1000_hw *hw)
> +{
> +	u32 eecd;
> +
> +	eecd = rd32(E1000_EECD);
> +	eecd &= ~E1000_EECD_REQ;
> +	wr32(E1000_EECD, eecd);
> +}
> +
> +/**
> + *  igc_read_nvm_eerd - Reads EEPROM using EERD register
> + *  @hw: pointer to the HW structure
> + *  @offset: offset of word in the EEPROM to read
> + *  @words: number of words to read
> + *  @data: word read from the EEPROM
> + *
> + *  Reads a 16 bit word from the EEPROM using the EERD register.
> + **/
> +s32 igc_read_nvm_eerd(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
> +{
> +	struct e1000_nvm_info *nvm = &hw->nvm;
> +	u32 i, eerd = 0;
> +	s32 ret_val = 0;
> +
> +	/* A check for invalid values:  offset too large, too many words,
> +	 * and not enough words.
> +	 */
> +	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
> +	    words == 0) {
> +		hw_dbg("nvm parameter(s) out of bounds\n");
> +		ret_val = -E1000_ERR_NVM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < words; i++) {
> +		eerd = ((offset + i) << E1000_NVM_RW_ADDR_SHIFT) +
> +			E1000_NVM_RW_REG_START;
> +
> +		wr32(E1000_EERD, eerd);
> +		ret_val = igc_poll_eerd_eewr_done(hw, E1000_NVM_POLL_READ);
> +		if (ret_val)
> +			break;
> +
> +		data[i] = (rd32(E1000_EERD) >> E1000_NVM_RW_REG_DATA);
> +	}
> +
> +out:
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_read_mac_addr - Read device MAC address
> + *  @hw: pointer to the HW structure
> + *
> + *  Reads the device MAC address from the EEPROM and stores the value.
> + *  Since devices with two ports use the same EEPROM, we increment the
> + *  last bit in the MAC address for the second port.
> + **/
> +s32 igc_read_mac_addr(struct e1000_hw *hw)
> +{
> +	u32 rar_high;
> +	u32 rar_low;
> +	u16 i;
> +
> +	rar_high = rd32(E1000_RAH(0));
> +	rar_low = rd32(E1000_RAL(0));
> +
> +	for (i = 0; i < E1000_RAL_MAC_ADDR_LEN; i++)
> +		hw->mac.perm_addr[i] = (u8)(rar_low >> (i * 8));
> +
> +	for (i = 0; i < E1000_RAH_MAC_ADDR_LEN; i++)
> +		hw->mac.perm_addr[i + 4] = (u8)(rar_high >> (i * 8));
> +
> +	for (i = 0; i < ETH_ALEN; i++)
> +		hw->mac.addr[i] = hw->mac.perm_addr[i];

Is there supposed to be an increment here for the second port as 
mentioned in the function comments?

> +
> +	return 0;

Can this be a void function?

> +}
> +
> +/**
> + *  igc_validate_nvm_checksum - Validate EEPROM checksum
> + *  @hw: pointer to the HW structure
> + *
> + *  Calculates the EEPROM checksum by reading/adding each word of the EEPROM
> + *  and then verifies that the sum of the EEPROM is equal to 0xBABA.
> + **/
> +s32 igc_validate_nvm_checksum(struct e1000_hw *hw)
> +{
> +	s32 ret_val = 0;
> +	u16 checksum = 0;
> +	u16 i, nvm_data;
> +
> +	for (i = 0; i < (NVM_CHECKSUM_REG + 1); i++) {
> +		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
> +		if (ret_val) {
> +			hw_dbg("NVM Read Error\n");
> +			goto out;
> +		}
> +		checksum += nvm_data;
> +	}

This looks slow, reading one word at a time.  Can you read a buffer at a 
time to speed things up a bit?

> +
> +	if (checksum != (u16)NVM_SUM) {
> +		hw_dbg("NVM Checksum Invalid\n");
> +		ret_val = -E1000_ERR_NVM;
> +		goto out;
> +	}
> +
> +out:
> +	return ret_val;
> +}
> +
> +/**
> + *  igc_update_nvm_checksum - Update EEPROM checksum
> + *  @hw: pointer to the HW structure
> + *
> + *  Updates the EEPROM checksum by reading/adding each word of the EEPROM
> + *  up to the checksum.  Then calculates the EEPROM checksum and writes the
> + *  value to the EEPROM.
> + **/
> +s32 igc_update_nvm_checksum(struct e1000_hw *hw)
> +{
> +	s32  ret_val;
> +	u16 checksum = 0;
> +	u16 i, nvm_data;
> +
> +	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
> +		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
> +		if (ret_val) {
> +			hw_dbg("NVM Read Error while updating checksum.\n");
> +			goto out;
> +		}
> +		checksum += nvm_data;

Again, maybe do buffer reads rather than one word at a time?

> +	}
> +	checksum = (u16)NVM_SUM - checksum;
> +	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
> +	if (ret_val)
> +		hw_dbg("NVM Write Error while updating checksum.\n");
> +
> +out:
> +	return ret_val;
> +}
> diff --git a/drivers/net/ethernet/intel/igc/e1000_nvm.h b/drivers/net/ethernet/intel/igc/e1000_nvm.h
> new file mode 100644
> index 000000000000..b6237bd515e9
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/e1000_nvm.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c)  2018 Intel Corporation */
> +
> +#ifndef _E1000_NVM_H_
> +#define _E1000_NVM_H_
> +
> +s32 igc_acquire_nvm(struct e1000_hw *hw);
> +void igc_release_nvm(struct e1000_hw *hw);
> +s32 igc_read_mac_addr(struct e1000_hw *hw);
> +
> +s32 igc_read_nvm_eerd(struct e1000_hw *hw, u16 offset, u16 words, u16 *data);
> +
> +s32  igc_validate_nvm_checksum(struct e1000_hw *hw);
> +s32  igc_update_nvm_checksum(struct e1000_hw *hw);
> +
> +#endif
> diff --git a/drivers/net/ethernet/intel/igc/e1000_regs.h b/drivers/net/ethernet/intel/igc/e1000_regs.h
> index 66d5c757dae8..698ce0cac757 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_regs.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_regs.h
> @@ -259,6 +259,9 @@
>   /* Management registers */
>   #define E1000_MANC	0x05820  /* Management Control - RW */
>   
> +/* Shadow Ram Write Register - RW */
> +#define E1000_SRWR	0x12018
> +
>   /* forward declaration */
>   struct e1000_hw;
>   u32 igc_rd32(struct e1000_hw *hw, u32 reg);
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index c61212ccb60e..735a5e3d0717 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -133,6 +133,10 @@ enum igc_tx_flags {
>   	IGC_TX_FLAGS_CSUM       = 0x20,
>   };
>   
> +enum igc_boards {
> +	board_base,
> +};
> +
>   /** The largest size we can write to the descriptor is 65535.  In order to
>    * maintain a power of two alignment we have to limit ourselves to 32K.
>    **/
> @@ -348,6 +352,8 @@ struct igc_adapter {
>   	spinlock_t nfc_lock;
>   
>   	struct igc_mac_addr *mac_table;
> +
> +	struct e1000_info ei;
>   };
>   
>   /* igc_desc_unused - calculate if we have unused descriptors */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 9a99c7d68796..dcc7e700074f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -19,9 +19,13 @@ static const char igc_driver_string[] = DRV_SUMMARY;
>   static const char igc_copyright[] =
>   	"Copyright(c) 2018 Intel Corporation.";
>   
> +static const struct e1000_info *igc_info_tbl[] = {
> +	[board_base] = &e1000_base_info,
> +};
> +
>   static const struct pci_device_id igc_pci_tbl[] = {
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I225_LM) },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I225_V) },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I225_LM), board_base },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I225_V), board_base },
>   	/* required last entry */
>   	{0, }
>   };
> @@ -3334,6 +3338,7 @@ static int igc_probe(struct pci_dev *pdev,
>   	struct net_device *netdev;
>   	struct igc_adapter *adapter;
>   	struct e1000_hw *hw;
> +	const struct e1000_info *ei = igc_info_tbl[ent->driver_data];
>   	int err, pci_using_dac;
>   
>   	err = pci_enable_device_mem(pdev);
> @@ -3417,6 +3422,14 @@ static int igc_probe(struct pci_dev *pdev,
>   	hw->subsystem_vendor_id = pdev->subsystem_vendor;
>   	hw->subsystem_device_id = pdev->subsystem_device;
>   
> +	/* Copy the default MAC and PHY function pointers */
> +	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
> +
> +	/* Initialize skew-specific constants */
> +	err = ei->get_invariants(hw);
> +	if (err)
> +		goto err_sw_init;
> +
>   	/* setup the private structure */
>   	err = igc_sw_init(adapter);
>   	if (err)
> @@ -3452,6 +3465,9 @@ static int igc_probe(struct pci_dev *pdev,
>   	 /* carrier off reporting is important to ethtool even BEFORE open */
>   	netif_carrier_off(netdev);
>   
> +	/* Check if Media Autosense is enabled */
> +	adapter->ei = *ei;
> +
>   	dev_info(&pdev->dev, "@SUMMARY@");
>   	/* print bus type/speed/width info */
>   	dev_info(&pdev->dev, "%s: (PCIe:%s:%s) ",
> 
