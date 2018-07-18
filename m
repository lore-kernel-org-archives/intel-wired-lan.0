From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 18 Jul 2018 11:18:06 +0300
Subject: [Intel-wired-lan] [PATCH v4 08/11] igc: Add NVM support
Message-ID: <20180718081806.15824-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add code for NVM support and get MAC address, complete probe
method.

Sasha Neftin (v2):
minor cosmetic changes

Alexander Duyck (v3):
NVM access code optimization

Sasha Neftin (v4):
fix xmas tree layout
remove no need spaces
rework igc_read_nvm_srrd/srwr and igc_validate_nvm_checksum_i225
methods as suggested by Shannon Nelson's approach
remove obsolete comments
replace e1000_ prefix with igc_ prefix
remove unused NVM control definitions
remove unused NVM Word offsets
remove unused SW FW SYNC definition
fix duplication of mask definition

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/igc/Makefile      |   2 +-
 drivers/net/ethernet/intel/igc/igc.h         |   6 +
 drivers/net/ethernet/intel/igc/igc_base.c    | 118 ++++++++-
 drivers/net/ethernet/intel/igc/igc_defines.h |  54 ++++-
 drivers/net/ethernet/intel/igc/igc_hw.h      |   3 +
 drivers/net/ethernet/intel/igc/igc_i225.c    | 350 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_i225.h    |   3 +
 drivers/net/ethernet/intel/igc/igc_mac.c     | 173 +++++++++++++
 drivers/net/ethernet/intel/igc/igc_mac.h     |   5 +
 drivers/net/ethernet/intel/igc/igc_main.c    |  20 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c     | 215 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_nvm.h     |  14 ++
 drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
 13 files changed, 958 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_nvm.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_nvm.h

diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
index 8b8022ea590a..2b5378d96c7b 100644
--- a/drivers/net/ethernet/intel/igc/Makefile
+++ b/drivers/net/ethernet/intel/igc/Makefile
@@ -7,4 +7,4 @@
 
 obj-$(CONFIG_IGC) += igc.o
 
-igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o
+igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index f7ad668bc80b..9ef6f290209c 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -131,6 +131,10 @@ enum igc_tx_flags {
 	IGC_TX_FLAGS_CSUM       = 0x20,
 };
 
+enum igc_boards {
+	board_base,
+};
+
 /**
  *  The largest size we can write to the descriptor is 65535.  In order to
  *  maintain a power of two alignment we have to limit ourselves to 32K.
@@ -348,6 +352,8 @@ struct igc_adapter {
 	spinlock_t nfc_lock;
 
 	struct igc_mac_addr *mac_table;
+
+	struct igc_info ei;
 };
 
 /* igc_desc_unused - calculate if we have unused descriptors */
diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 3dae4f8b89f7..0c7cacb75643 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -11,9 +11,49 @@
 
 /* forward declaration */
 static s32 igc_get_invariants_base(struct igc_hw *);
+static s32 igc_check_for_link_base(struct igc_hw *);
 static s32 igc_init_hw_base(struct igc_hw *);
 static s32 igc_reset_hw_base(struct igc_hw *);
 static s32 igc_set_pcie_completion_timeout(struct igc_hw *hw);
+static s32 igc_read_mac_addr_base(struct igc_hw *hw);
+
+/**
+ *  igc_init_nvm_params_base - Init NVM func ptrs.
+ *  @hw: pointer to the HW structure
+ **/
+static s32 igc_init_nvm_params_base(struct igc_hw *hw)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+	u32 eecd = rd32(IGC_EECD);
+	u16 size;
+
+	size = (u16)((eecd & IGC_EECD_SIZE_EX_MASK) >>
+		     IGC_EECD_SIZE_EX_SHIFT);
+
+	/* Added to a constant, "size" becomes the left-shift value
+	 * for setting word_size.
+	 */
+	size += NVM_WORD_SIZE_BASE_SHIFT;
+
+	/* Just in case size is out of range, cap it to the largest
+	 * EEPROM size supported
+	 */
+	if (size > 15)
+		size = 15;
+
+	nvm->word_size = BIT(size);
+	nvm->opcode_bits = 8;
+	nvm->delay_usec = 1;
+
+	nvm->page_size = eecd & IGC_EECD_ADDR_BITS ? 32 : 8;
+	nvm->address_bits = eecd & IGC_EECD_ADDR_BITS ?
+			    16 : 8;
+
+	if (nvm->word_size == BIT(15))
+		nvm->page_size = 128;
+
+	return 0;
+}
 
 /**
  *  igc_init_mac_params_base - Init MAC func ptrs.
@@ -21,6 +61,7 @@ static s32 igc_set_pcie_completion_timeout(struct igc_hw *hw);
  **/
 static s32 igc_init_mac_params_base(struct igc_hw *hw)
 {
+	struct igc_dev_spec_base *dev_spec = &hw->dev_spec._base;
 	struct igc_mac_info *mac = &hw->mac;
 
 	/* Set mta register count */
@@ -33,6 +74,10 @@ static s32 igc_init_mac_params_base(struct igc_hw *hw)
 	mac->ops.acquire_swfw_sync = igc_acquire_swfw_sync_i225;
 	mac->ops.release_swfw_sync = igc_release_swfw_sync_i225;
 
+	/* Allow a single clear of the SW semaphore on I225 */
+	if (mac->type == igc_i225)
+		dev_spec->clear_semaphore_once = true;
+
 	return 0;
 }
 
@@ -50,11 +95,60 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 	if (ret_val)
 		goto out;
 
+	/* NVM initialization */
+	ret_val = igc_init_nvm_params_base(hw);
+	switch (hw->mac.type) {
+	case igc_i225:
+		ret_val = igc_init_nvm_params_i225(hw);
+		break;
+	default:
+		break;
+	}
+
+	if (ret_val)
+		goto out;
+
 out:
 	return ret_val;
 }
 
 /**
+ *  igc_get_link_up_info_base - Get link speed/duplex info
+ *  @hw: pointer to the HW structure
+ *  @speed: stores the current speed
+ *  @duplex: stores the current duplex
+ *
+ *  This is a wrapper function, if using the serial gigabit media independent
+ *  interface, use PCS to retrieve the link speed and duplex information.
+ *  Otherwise, use the generic function to get the link speed and duplex info.
+ **/
+static s32 igc_get_link_up_info_base(struct igc_hw *hw, u16 *speed,
+				     u16 *duplex)
+{
+	s32 ret_val;
+
+	ret_val = igc_get_speed_and_duplex_copper(hw, speed, duplex);
+
+	return ret_val;
+}
+
+/**
+ *  igc_check_for_link_base - Check for link
+ *  @hw: pointer to the HW structure
+ *
+ *  If sgmii is enabled, then use the pcs register to determine link, otherwise
+ *  use the generic interface for determining link.
+ **/
+static s32 igc_check_for_link_base(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+
+	ret_val = igc_check_for_copper_link(hw);
+
+	return ret_val;
+}
+
+/**
  *  igc_init_hw_base - Initialize hardware
  *  @hw: pointer to the HW structure
  *
@@ -93,6 +187,19 @@ static s32 igc_init_hw_base(struct igc_hw *hw)
 }
 
 /**
+ *  igc_read_mac_addr_base - Read device MAC address
+ *  @hw: pointer to the HW structure
+ **/
+static s32 igc_read_mac_addr_base(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+
+	ret_val = igc_read_mac_addr(hw);
+
+	return ret_val;
+}
+
+/**
  *  igc_rx_fifo_flush_base - Clean rx fifo after Rx enable
  *  @hw: pointer to the HW structure
  *
@@ -169,12 +276,17 @@ void igc_rx_fifo_flush_base(struct igc_hw *hw)
 }
 
 static struct igc_mac_operations igc_mac_ops_base = {
-	.init_hw	= igc_init_hw_base,
+	.init_hw		= igc_init_hw_base,
+	.check_for_link		= igc_check_for_link_base,
+	.rar_set		= igc_rar_set,
+	.read_mac_addr		= igc_read_mac_addr_base,
+	.get_speed_and_duplex	= igc_get_link_up_info_base,
 };
 
 const struct igc_info igc_base_info = {
-	.get_invariants = igc_get_invariants_base,
-	.mac_ops = &igc_mac_ops_base,
+	.get_invariants		= igc_get_invariants_base,
+	.mac_ops		= &igc_mac_ops_base,
+	/* TODO phy_ops */
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index a54c12b96390..a94970289a74 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -42,6 +42,8 @@
  */
 #define IGC_RAH_AV		0x80000000 /* Receive descriptor valid */
 #define IGC_RAH_POOL_1		0x00040000
+#define IGC_RAL_MAC_ADDR_LEN	4
+#define IGC_RAH_MAC_ADDR_LEN	2
 
 /* Error Codes */
 #define IGC_SUCCESS			0
@@ -64,12 +66,52 @@
 #define IGC_SWSM_SMBI		0x00000001 /* Driver Semaphore bit */
 #define IGC_SWSM_SWESMBI	0x00000002 /* FW Semaphore bit */
 
+/* SWFW_SYNC Definitions */
+#define IGC_SWFW_EEP_SM		0x1
+#define IGC_SWFW_PHY0_SM	0x2
+
 /* NVM Control */
-#define IGC_EECD_PRES		0x00000100 /* NVM Present */
+#define IGC_EECD_REQ		0x00000040 /* NVM Access Request */
+#define IGC_EECD_GNT		0x00000080 /* NVM Access Grant */
+/* NVM Addressing bits based on type 0=small, 1=large */
+#define IGC_EECD_ADDR_BITS		0x00000400
+#define IGC_NVM_GRANT_ATTEMPTS		1000 /* NVM # attempts to gain grant */
+#define IGC_EECD_AUTO_RD		0x00000200  /* NVM Auto Read done */
+#define IGC_EECD_SIZE_EX_MASK		0x00007800  /* NVM Size */
+#define IGC_EECD_SIZE_EX_SHIFT		11
+#define IGC_EECD_FLUPD_I225		0x00800000 /* Update FLASH */
+#define IGC_EECD_FLUDONE_I225		0x04000000 /* Update FLASH done*/
+#define IGC_EECD_FLASH_DETECTED_I225	0x00080000 /* FLASH detected */
+#define IGC_FLUDONE_ATTEMPTS		20000
+#define IGC_EERD_EEWR_MAX_COUNT		512 /* buffered EEPROM words rw */
 
 /* Number of milliseconds for NVM auto read done after MAC reset. */
 #define AUTO_READ_DONE_TIMEOUT		10
-#define IGC_EECD_AUTO_RD	0x00000200  /* NVM Auto Read done */
+
+/* Offset to data in NVM read/write registers */
+#define IGC_NVM_RW_REG_DATA	16
+#define IGC_NVM_RW_REG_DONE	2    /* Offset to READ/WRITE done bit */
+#define IGC_NVM_RW_REG_START	1    /* Start operation */
+#define IGC_NVM_RW_ADDR_SHIFT	2    /* Shift to the address bits */
+#define IGC_NVM_POLL_READ	0    /* Flag for polling for read complete */
+
+/* NVM Word Offsets */
+#define NVM_CHECKSUM_REG		0x003F
+
+/* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
+#define NVM_SUM				0xBABA
+
+#define NVM_PBA_OFFSET_0		8
+#define NVM_PBA_OFFSET_1		9
+#define NVM_RESERVED_WORD		0xFFFF
+#define NVM_PBA_PTR_GUARD		0xFAFA
+#define NVM_WORD_SIZE_BASE_SHIFT	6
+
+/* Collision related configuration parameters */
+#define IGC_COLLISION_THRESHOLD		15
+#define IGC_CT_SHIFT			4
+#define IGC_COLLISION_DISTANCE		63
+#define IGC_COLD_SHIFT			12
 
 /* Device Status */
 #define IGC_STATUS_FD		0x00000001      /* Full duplex.0=half,1=full */
@@ -80,6 +122,14 @@
 #define IGC_STATUS_TXOFF	0x00000010      /* transmission paused */
 #define IGC_STATUS_SPEED_100	0x00000040      /* Speed 100Mb/s */
 #define IGC_STATUS_SPEED_1000	0x00000080      /* Speed 1000Mb/s */
+#define IGC_STATUS_SPEED_2500	0x00400000	/* Speed 2.5Gb/s */
+
+#define SPEED_10		10
+#define SPEED_100		100
+#define SPEED_1000		1000
+#define SPEED_2500		2500
+#define HALF_DUPLEX		1
+#define FULL_DUPLEX		2
 
 /* Interrupt Cause Read */
 #define IGC_ICR_TXDW		BIT(0)	/* Transmit desc written back */
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 154aefeee4d1..bf4fcbe396e6 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -11,6 +11,7 @@
 #include "igc_regs.h"
 #include "igc_defines.h"
 #include "igc_mac.h"
+#include "igc_nvm.h"
 #include "igc_i225.h"
 #include "igc_base.h"
 
@@ -81,6 +82,8 @@ struct igc_info {
 	struct igc_nvm_operations *nvm_ops;
 };
 
+extern const struct igc_info igc_base_info;
+
 struct igc_mac_info {
 	struct igc_mac_operations ops;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 68cd59df7e5e..c6b58c3a8e45 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -6,6 +6,32 @@
 #include "igc_hw.h"
 
 /**
+ *  igc_acquire_nvm_i225 - Request for access to EEPROM
+ *  @hw: pointer to the HW structure
+ *
+ *  Acquire the necessary semaphores for exclusive access to the EEPROM.
+ *  Set the EEPROM access request bit and wait for EEPROM access grant bit.
+ *  Return successful if access grant bit set, else clear the request for
+ *  EEPROM access and return -IGC_ERR_NVM (-1).
+ **/
+static s32 igc_acquire_nvm_i225(struct igc_hw *hw)
+{
+	return igc_acquire_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
+}
+
+/**
+ *  igc_release_nvm_i225 - Release exclusive access to EEPROM
+ *  @hw: pointer to the HW structure
+ *
+ *  Stop any current commands to the EEPROM and clear the EEPROM request bit,
+ *  then release the semaphores acquired.
+ **/
+static void igc_release_nvm_i225(struct igc_hw *hw)
+{
+	igc_release_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
+}
+
+/**
  *  igc_get_hw_semaphore_i225 - Acquire hardware semaphore
  *  @hw: pointer to the HW structure
  *
@@ -139,3 +165,327 @@ void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask)
 
 	igc_put_hw_semaphore(hw);
 }
+
+/**
+ *  igc_read_nvm_srrd_i225 - Reads Shadow Ram using EERD register
+ *  @hw: pointer to the HW structure
+ *  @offset: offset of word in the Shadow Ram to read
+ *  @words: number of words to read
+ *  @data: word read from the Shadow Ram
+ *
+ *  Reads a 16 bit word from the Shadow Ram using the EERD register.
+ *  Uses necessary synchronization semaphores.
+ **/
+static s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset, u16 words,
+				  u16 *data)
+{
+	s32 status = 0;
+	u16 i, count;
+
+	/* We cannot hold synchronization semaphores for too long,
+	 * because of forceful takeover procedure. However it is more efficient
+	 * to read in bursts than synchronizing access for each word.
+	 */
+	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
+			IGC_EERD_EEWR_MAX_COUNT : (words - i);
+
+		status = hw->nvm.ops.acquire(hw);
+		if (status)
+			break;
+
+		status = igc_read_nvm_eerd(hw, offset, count, data + i);
+		hw->nvm.ops.release(hw);
+		if (status)
+			break;
+	}
+
+	return status;
+}
+
+/**
+ *  igc_write_nvm_srwr - Write to Shadow Ram using EEWR
+ *  @hw: pointer to the HW structure
+ *  @offset: offset within the Shadow Ram to be written to
+ *  @words: number of words to write
+ *  @data: 16 bit word(s) to be written to the Shadow Ram
+ *
+ *  Writes data to Shadow Ram at offset using EEWR register.
+ *
+ *  If igc_update_nvm_checksum is not called after this function , the
+ *  Shadow Ram will most likely contain an invalid checksum.
+ **/
+static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
+			      u16 *data)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+	u32 attempts = 100000;
+	u32 i, k, eewr = 0;
+	s32 ret_val = 0;
+
+	/* A check for invalid values:  offset too large, too many words,
+	 * too many words for the offset, and not enough words.
+	 */
+	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
+	    words == 0) {
+		hw_dbg("nvm parameter(s) out of bounds\n");
+		ret_val = -IGC_ERR_NVM;
+		goto out;
+	}
+
+	for (i = 0; i < words; i++) {
+		eewr = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) |
+			(data[i] << IGC_NVM_RW_REG_DATA) |
+			IGC_NVM_RW_REG_START;
+
+		wr32(IGC_SRWR, eewr);
+
+		for (k = 0; k < attempts; k++) {
+			if (IGC_NVM_RW_REG_DONE &
+			    rd32(IGC_SRWR)) {
+				ret_val = 0;
+				break;
+			}
+			udelay(5);
+		}
+
+		if (ret_val) {
+			hw_dbg("Shadow RAM write EEWR timed out\n");
+			break;
+		}
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_write_nvm_srwr_i225 - Write to Shadow RAM using EEWR
+ *  @hw: pointer to the HW structure
+ *  @offset: offset within the Shadow RAM to be written to
+ *  @words: number of words to write
+ *  @data: 16 bit word(s) to be written to the Shadow RAM
+ *
+ *  Writes data to Shadow RAM@offset using EEWR register.
+ *
+ *  If igc_update_nvm_checksum is not called after this function , the
+ *  data will not be committed to FLASH and also Shadow RAM will most likely
+ *  contain an invalid checksum.
+ *
+ *  If error code is returned, data and Shadow RAM may be inconsistent - buffer
+ *  partially written.
+ **/
+static s32 igc_write_nvm_srwr_i225(struct igc_hw *hw, u16 offset, u16 words,
+				   u16 *data)
+{
+	s32 status = 0;
+	u16 i, count;
+
+	/* We cannot hold synchronization semaphores for too long,
+	 * because of forceful takeover procedure. However it is more efficient
+	 * to write in bursts than synchronizing access for each word.
+	 */
+	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
+			IGC_EERD_EEWR_MAX_COUNT : (words - i);
+
+		status = hw->nvm.ops.acquire(hw);
+		if (status)
+			break;
+
+		status = igc_write_nvm_srwr(hw, offset, count, data + i);
+		hw->nvm.ops.release(hw);
+		if (status)
+			break;
+	}
+
+	return status;
+}
+
+/**
+ *  igc_validate_nvm_checksum_i225 - Validate EEPROM checksum
+ *  @hw: pointer to the HW structure
+ *
+ *  Calculates the EEPROM checksum by reading/adding each word of the EEPROM
+ *  and then verifies that the sum of the EEPROM is equal to 0xBABA.
+ **/
+static s32 igc_validate_nvm_checksum_i225(struct igc_hw *hw)
+{
+	s32 (*read_op_ptr)(struct igc_hw *hw, u16 offset, u16 count,
+			   u16 *data);
+	s32 status = 0;
+
+	status = hw->nvm.ops.acquire(hw);
+	if (status)
+		goto out;
+
+	/* Replace the read function with semaphore grabbing with
+	 * the one that skips this for a while.
+	 * We have semaphore taken already here.
+	 */
+	read_op_ptr = hw->nvm.ops.read;
+	hw->nvm.ops.read = igc_read_nvm_eerd;
+
+	status = igc_validate_nvm_checksum(hw);
+
+	/* Revert original read operation. */
+	hw->nvm.ops.read = read_op_ptr;
+
+	hw->nvm.ops.release(hw);
+
+out:
+	return status;
+}
+
+/**
+ *  igc_pool_flash_update_done_i225 - Pool FLUDONE status
+ *  @hw: pointer to the HW structure
+ **/
+static s32 igc_pool_flash_update_done_i225(struct igc_hw *hw)
+{
+	s32 ret_val = -IGC_ERR_NVM;
+	u32 i, reg;
+
+	for (i = 0; i < IGC_FLUDONE_ATTEMPTS; i++) {
+		reg = rd32(IGC_EECD);
+		if (reg & IGC_EECD_FLUDONE_I225) {
+			ret_val = 0;
+			break;
+		}
+		udelay(5);
+	}
+
+	return ret_val;
+}
+
+/**
+ *  igc_update_flash_i225 - Commit EEPROM to the flash
+ *  @hw: pointer to the HW structure
+ **/
+static s32 igc_update_flash_i225(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+	u32 flup;
+
+	ret_val = igc_pool_flash_update_done_i225(hw);
+	if (ret_val == -IGC_ERR_NVM) {
+		hw_dbg("Flash update time out\n");
+		goto out;
+	}
+
+	flup = rd32(IGC_EECD) | IGC_EECD_FLUPD_I225;
+	wr32(IGC_EECD, flup);
+
+	ret_val = igc_pool_flash_update_done_i225(hw);
+	if (ret_val)
+		hw_dbg("Flash update time out\n");
+	else
+		hw_dbg("Flash update complete\n");
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_update_nvm_checksum_i225 - Update EEPROM checksum
+ *  @hw: pointer to the HW structure
+ *
+ *  Updates the EEPROM checksum by reading/adding each word of the EEPROM
+ *  up to the checksum.  Then calculates the EEPROM checksum and writes the
+ *  value to the EEPROM. Next commit EEPROM data onto the Flash.
+ **/
+static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
+{
+	u16 checksum = 0;
+	s32 ret_val = 0;
+	u16 i, nvm_data;
+
+	/* Read the first word from the EEPROM. If this times out or fails, do
+	 * not continue or we could be in for a very long wait while every
+	 * EEPROM read fails
+	 */
+	ret_val = igc_read_nvm_eerd(hw, 0, 1, &nvm_data);
+	if (ret_val) {
+		hw_dbg("EEPROM read failed\n");
+		goto out;
+	}
+
+	ret_val = hw->nvm.ops.acquire(hw);
+	if (ret_val)
+		goto out;
+
+	/* Do not use hw->nvm.ops.write, hw->nvm.ops.read
+	 * because we do not want to take the synchronization
+	 * semaphores twice here.
+	 */
+
+	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
+		ret_val = igc_read_nvm_eerd(hw, i, 1, &nvm_data);
+		if (ret_val) {
+			hw->nvm.ops.release(hw);
+			hw_dbg("NVM Read Error while updating checksum.\n");
+			goto out;
+		}
+		checksum += nvm_data;
+	}
+	checksum = (u16)NVM_SUM - checksum;
+	ret_val = igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
+				     &checksum);
+	if (ret_val) {
+		hw->nvm.ops.release(hw);
+		hw_dbg("NVM Write Error while updating checksum.\n");
+		goto out;
+	}
+
+	hw->nvm.ops.release(hw);
+
+	ret_val = igc_update_flash_i225(hw);
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_get_flash_presence_i225 - Check if flash device is detected
+ *  @hw: pointer to the HW structure
+ **/
+bool igc_get_flash_presence_i225(struct igc_hw *hw)
+{
+	bool ret_val = false;
+	u32 eec = 0;
+
+	eec = rd32(IGC_EECD);
+	if (eec & IGC_EECD_FLASH_DETECTED_I225)
+		ret_val = true;
+
+	return ret_val;
+}
+
+/**
+ *  igc_init_nvm_params_i225 - Init NVM func ptrs.
+ *  @hw: pointer to the HW structure
+ **/
+s32 igc_init_nvm_params_i225(struct igc_hw *hw)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+	s32 ret_val = 0;
+
+	nvm->ops.acquire = igc_acquire_nvm_i225;
+	nvm->ops.release = igc_release_nvm_i225;
+
+	/* NVM Function Pointers */
+	if (igc_get_flash_presence_i225(hw)) {
+		hw->nvm.type = igc_nvm_flash_hw;
+		nvm->ops.read = igc_read_nvm_srrd_i225;
+		nvm->ops.write = igc_write_nvm_srwr_i225;
+		nvm->ops.validate = igc_validate_nvm_checksum_i225;
+		nvm->ops.update = igc_update_nvm_checksum_i225;
+	} else {
+		hw->nvm.type = igc_nvm_invm;
+		nvm->ops.read = igc_read_nvm_eerd;
+		nvm->ops.write = NULL;
+		nvm->ops.validate = NULL;
+		nvm->ops.update = NULL;
+	}
+	return ret_val;
+}
diff --git a/drivers/net/ethernet/intel/igc/igc_i225.h b/drivers/net/ethernet/intel/igc/igc_i225.h
index 461cd8c7e352..7b66e1f9c0e6 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.h
+++ b/drivers/net/ethernet/intel/igc/igc_i225.h
@@ -7,4 +7,7 @@
 s32 igc_acquire_swfw_sync_i225(struct igc_hw *hw, u16 mask);
 void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask);
 
+s32 igc_init_nvm_params_i225(struct igc_hw *hw);
+bool igc_get_flash_presence_i225(struct igc_hw *hw);
+
 #endif
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 9495e75bf07a..d08d2c6a6647 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -326,6 +326,132 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 }
 
 /**
+ *  igc_rar_set - Set receive address register
+ *  @hw: pointer to the HW structure
+ *  @addr: pointer to the receive address
+ *  @index: receive address array register
+ *
+ *  Sets the receive address array register at index to the address passed
+ *  in by addr.
+ **/
+void igc_rar_set(struct igc_hw *hw, u8 *addr, u32 index)
+{
+	u32 rar_low, rar_high;
+
+	/* HW expects these in little endian so we reverse the byte order
+	 * from network order (big endian) to little endian
+	 */
+	rar_low = ((u32)addr[0] |
+		   ((u32)addr[1] << 8) |
+		   ((u32)addr[2] << 16) | ((u32)addr[3] << 24));
+
+	rar_high = ((u32)addr[4] | ((u32)addr[5] << 8));
+
+	/* If MAC address zero, no need to set the AV bit */
+	if (rar_low || rar_high)
+		rar_high |= IGC_RAH_AV;
+
+	/* Some bridges will combine consecutive 32-bit writes into
+	 * a single burst write, which will malfunction on some parts.
+	 * The flushes avoid this.
+	 */
+	wr32(IGC_RAL(index), rar_low);
+	wrfl();
+	wr32(IGC_RAH(index), rar_high);
+	wrfl();
+}
+
+/**
+ *  igc_check_for_copper_link - Check for link (Copper)
+ *  @hw: pointer to the HW structure
+ *
+ *  Checks to see of the link status of the hardware has changed.  If a
+ *  change in link status has been detected, then we read the PHY registers
+ *  to get the current speed/duplex if link exists.
+ **/
+s32 igc_check_for_copper_link(struct igc_hw *hw)
+{
+	struct igc_mac_info *mac = &hw->mac;
+	s32 ret_val;
+	bool link;
+
+	/* We only want to go out to the PHY registers to see if Auto-Neg
+	 * has completed and/or if our link status has changed.  The
+	 * get_link_status flag is set upon receiving a Link Status
+	 * Change or Rx Sequence Error interrupt.
+	 */
+	if (!mac->get_link_status) {
+		ret_val = 0;
+		goto out;
+	}
+
+	/* First we want to see if the MII Status Register reports
+	 * link.  If so, then we want to get the current speed/duplex
+	 * of the PHY.
+	 */
+	/* TODO ret_val = igc_phy_has_link(hw, 1, 0, &link); */
+	if (ret_val)
+		goto out;
+
+	if (!link)
+		goto out; /* No link detected */
+
+	mac->get_link_status = false;
+
+	/* Check if there was DownShift, must be checked
+	 * immediately after link-up
+	 */
+	/* TODO igc_check_downshift(hw); */
+
+	/* If we are forcing speed/duplex, then we simply return since
+	 * we have already determined whether we have link or not.
+	 */
+	if (!mac->autoneg) {
+		ret_val = -IGC_ERR_CONFIG;
+		goto out;
+	}
+
+	/* Auto-Neg is enabled.  Auto Speed Detection takes care
+	 * of MAC speed/duplex configuration.  So we only need to
+	 * configure Collision Distance in the MAC.
+	 */
+	igc_config_collision_dist(hw);
+
+	/* Configure Flow Control now that Auto-Neg has completed.
+	 * First, we need to restore the desired flow control
+	 * settings because we may have had to re-autoneg with a
+	 * different link partner.
+	 */
+	/* TODO ret_val = igc_config_fc_after_link_up(hw); */
+	if (ret_val)
+		hw_dbg("Error configuring flow control\n");
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_config_collision_dist - Configure collision distance
+ *  @hw: pointer to the HW structure
+ *
+ *  Configures the collision distance to the default value and is used
+ *  during link setup. Currently no func pointer exists and all
+ *  implementations are handled in the generic version of this function.
+ **/
+void igc_config_collision_dist(struct igc_hw *hw)
+{
+	u32 tctl;
+
+	tctl = rd32(IGC_TCTL);
+
+	tctl &= ~IGC_TCTL_COLD;
+	tctl |= IGC_COLLISION_DISTANCE << IGC_COLD_SHIFT;
+
+	wr32(IGC_TCTL, tctl);
+	wrfl();
+}
+
+/**
  *  igc_get_auto_rd_done - Check for auto read completion
  *  @hw: pointer to the HW structure
  *
@@ -354,6 +480,53 @@ s32 igc_get_auto_rd_done(struct igc_hw *hw)
 }
 
 /**
+ *  igc_get_speed_and_duplex_copper - Retrieve current speed/duplex
+ *  @hw: pointer to the HW structure
+ *  @speed: stores the current speed
+ *  @duplex: stores the current duplex
+ *
+ *  Read the status register for the current speed/duplex and store the current
+ *  speed and duplex for copper connections.
+ **/
+s32 igc_get_speed_and_duplex_copper(struct igc_hw *hw, u16 *speed,
+				    u16 *duplex)
+{
+	u32 status;
+
+	status = rd32(IGC_STATUS);
+	if (status & IGC_STATUS_SPEED_1000) {
+		/* For I225, STATUS will indicate 1G speed in both 1 Gbps
+		 * and 2.5 Gbps link modes. An additional bit is used
+		 * to differentiate between 1 Gbps and 2.5 Gbps.
+		 */
+		if (hw->mac.type == igc_i225 &&
+		    (status & IGC_STATUS_SPEED_2500)) {
+			*speed = SPEED_2500;
+			hw_dbg("2500 Mbs, ");
+		} else {
+			*speed = SPEED_1000;
+			hw_dbg("1000 Mbs, ");
+		}
+	} else if (status & IGC_STATUS_SPEED_100) {
+		*speed = SPEED_100;
+		hw_dbg("100 Mbs, ");
+	} else {
+		*speed = SPEED_10;
+		hw_dbg("10 Mbs, ");
+	}
+
+	if (status & IGC_STATUS_FD) {
+		*duplex = FULL_DUPLEX;
+		hw_dbg("Full Duplex\n");
+	} else {
+		*duplex = HALF_DUPLEX;
+		hw_dbg("Half Duplex\n");
+	}
+
+	return 0;
+}
+
+/**
  *  igc_put_hw_semaphore - Release hardware semaphore
  *  @hw: pointer to the HW structure
  *
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.h b/drivers/net/ethernet/intel/igc/igc_mac.h
index 1337168dc93a..7d935d581fc7 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.h
+++ b/drivers/net/ethernet/intel/igc/igc_mac.h
@@ -12,13 +12,18 @@
 #endif /* IGC_REMOVED */
 
 /* forward declaration */
+s32 igc_check_for_copper_link(struct igc_hw *hw);
 s32  igc_disable_pcie_master(struct igc_hw *hw);
 void igc_init_rx_addrs(struct igc_hw *hw, u16 rar_count);
 s32  igc_setup_link(struct igc_hw *hw);
 void igc_clear_hw_cntrs_base(struct igc_hw *hw);
 s32 igc_get_auto_rd_done(struct igc_hw *hw);
 void igc_put_hw_semaphore(struct igc_hw *hw);
+void igc_rar_set(struct igc_hw *hw, u8 *addr, u32 index);
+void igc_config_collision_dist(struct igc_hw *hw);
 
 s32 igc_get_bus_info_pcie(struct igc_hw *hw);
+s32 igc_get_speed_and_duplex_copper(struct igc_hw *hw, u16 *speed,
+				    u16 *duplex);
 
 #endif
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 727f852936a8..2514bb5e5651 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -19,9 +19,13 @@ static const char igc_driver_string[] = DRV_SUMMARY;
 static const char igc_copyright[] =
 	"Copyright(c) 2018 Intel Corporation.";
 
+static const struct igc_info *igc_info_tbl[] = {
+	[board_base] = &igc_base_info,
+};
+
 static const struct pci_device_id igc_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LM) },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_V) },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LM), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_V), board_base },
 	/* required last entry */
 	{0, }
 };
@@ -3311,6 +3315,7 @@ static int igc_probe(struct pci_dev *pdev,
 	struct igc_adapter *adapter;
 	struct net_device *netdev;
 	struct igc_hw *hw;
+	const struct igc_info *ei = igc_info_tbl[ent->driver_data];
 	int err, pci_using_dac;
 
 	err = pci_enable_device_mem(pdev);
@@ -3394,6 +3399,14 @@ static int igc_probe(struct pci_dev *pdev,
 	hw->subsystem_vendor_id = pdev->subsystem_vendor;
 	hw->subsystem_device_id = pdev->subsystem_device;
 
+	/* Copy the default MAC and PHY function pointers */
+	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
+
+	/* Initialize skew-specific constants */
+	err = ei->get_invariants(hw);
+	if (err)
+		goto err_sw_init;
+
 	/* setup the private structure */
 	err = igc_sw_init(adapter);
 	if (err)
@@ -3429,6 +3442,9 @@ static int igc_probe(struct pci_dev *pdev,
 	 /* carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
+	/* Check if Media Autosense is enabled */
+	adapter->ei = *ei;
+
 	/* print pcie link status and MAC address */
 	pcie_print_link_status(pdev);
 	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
new file mode 100644
index 000000000000..54d8f75b4fed
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include "igc_mac.h"
+#include "igc_nvm.h"
+
+/**
+ *  igc_poll_eerd_eewr_done - Poll for EEPROM read/write completion
+ *  @hw: pointer to the HW structure
+ *  @ee_reg: EEPROM flag for polling
+ *
+ *  Polls the EEPROM status bit for either read or write completion based
+ *  upon the value of 'ee_reg'.
+ **/
+static s32 igc_poll_eerd_eewr_done(struct igc_hw *hw, int ee_reg)
+{
+	s32 ret_val = -IGC_ERR_NVM;
+	u32 attempts = 100000;
+	u32 i, reg = 0;
+
+	for (i = 0; i < attempts; i++) {
+		if (ee_reg == IGC_NVM_POLL_READ)
+			reg = rd32(IGC_EERD);
+		else
+			reg = rd32(IGC_EEWR);
+
+		if (reg & IGC_NVM_RW_REG_DONE) {
+			ret_val = 0;
+			break;
+		}
+
+		udelay(5);
+	}
+
+	return ret_val;
+}
+
+/**
+ *  igc_acquire_nvm - Generic request for access to EEPROM
+ *  @hw: pointer to the HW structure
+ *
+ *  Set the EEPROM access request bit and wait for EEPROM access grant bit.
+ *  Return successful if access grant bit set, else clear the request for
+ *  EEPROM access and return -IGC_ERR_NVM (-1).
+ **/
+s32 igc_acquire_nvm(struct igc_hw *hw)
+{
+	s32 timeout = IGC_NVM_GRANT_ATTEMPTS;
+	u32 eecd = rd32(IGC_EECD);
+	s32 ret_val = 0;
+
+	wr32(IGC_EECD, eecd | IGC_EECD_REQ);
+	eecd = rd32(IGC_EECD);
+
+	while (timeout) {
+		if (eecd & IGC_EECD_GNT)
+			break;
+		udelay(5);
+		eecd = rd32(IGC_EECD);
+		timeout--;
+	}
+
+	if (!timeout) {
+		eecd &= ~IGC_EECD_REQ;
+		wr32(IGC_EECD, eecd);
+		hw_dbg("Could not acquire NVM grant\n");
+		ret_val = -IGC_ERR_NVM;
+	}
+
+	return ret_val;
+}
+
+/**
+ *  igc_release_nvm - Release exclusive access to EEPROM
+ *  @hw: pointer to the HW structure
+ *
+ *  Stop any current commands to the EEPROM and clear the EEPROM request bit.
+ **/
+void igc_release_nvm(struct igc_hw *hw)
+{
+	u32 eecd;
+
+	eecd = rd32(IGC_EECD);
+	eecd &= ~IGC_EECD_REQ;
+	wr32(IGC_EECD, eecd);
+}
+
+/**
+ *  igc_read_nvm_eerd - Reads EEPROM using EERD register
+ *  @hw: pointer to the HW structure
+ *  @offset: offset of word in the EEPROM to read
+ *  @words: number of words to read
+ *  @data: word read from the EEPROM
+ *
+ *  Reads a 16 bit word from the EEPROM using the EERD register.
+ **/
+s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+	u32 i, eerd = 0;
+	s32 ret_val = 0;
+
+	/* A check for invalid values:  offset too large, too many words,
+	 * and not enough words.
+	 */
+	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
+	    words == 0) {
+		hw_dbg("nvm parameter(s) out of bounds\n");
+		ret_val = -IGC_ERR_NVM;
+		goto out;
+	}
+
+	for (i = 0; i < words; i++) {
+		eerd = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) +
+			IGC_NVM_RW_REG_START;
+
+		wr32(IGC_EERD, eerd);
+		ret_val = igc_poll_eerd_eewr_done(hw, IGC_NVM_POLL_READ);
+		if (ret_val)
+			break;
+
+		data[i] = (rd32(IGC_EERD) >> IGC_NVM_RW_REG_DATA);
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_read_mac_addr - Read device MAC address
+ *  @hw: pointer to the HW structure
+ **/
+s32 igc_read_mac_addr(struct igc_hw *hw)
+{
+	u32 rar_high;
+	u32 rar_low;
+	u16 i;
+
+	rar_high = rd32(IGC_RAH(0));
+	rar_low = rd32(IGC_RAL(0));
+
+	for (i = 0; i < IGC_RAL_MAC_ADDR_LEN; i++)
+		hw->mac.perm_addr[i] = (u8)(rar_low >> (i * 8));
+
+	for (i = 0; i < IGC_RAH_MAC_ADDR_LEN; i++)
+		hw->mac.perm_addr[i + 4] = (u8)(rar_high >> (i * 8));
+
+	for (i = 0; i < ETH_ALEN; i++)
+		hw->mac.addr[i] = hw->mac.perm_addr[i];
+
+	return 0;
+}
+
+/**
+ *  igc_validate_nvm_checksum - Validate EEPROM checksum
+ *  @hw: pointer to the HW structure
+ *
+ *  Calculates the EEPROM checksum by reading/adding each word of the EEPROM
+ *  and then verifies that the sum of the EEPROM is equal to 0xBABA.
+ **/
+s32 igc_validate_nvm_checksum(struct igc_hw *hw)
+{
+	u16 checksum = 0;
+	u16 i, nvm_data;
+	s32 ret_val = 0;
+
+	for (i = 0; i < (NVM_CHECKSUM_REG + 1); i++) {
+		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
+		if (ret_val) {
+			hw_dbg("NVM Read Error\n");
+			goto out;
+		}
+		checksum += nvm_data;
+	}
+
+	if (checksum != (u16)NVM_SUM) {
+		hw_dbg("NVM Checksum Invalid\n");
+		ret_val = -IGC_ERR_NVM;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_update_nvm_checksum - Update EEPROM checksum
+ *  @hw: pointer to the HW structure
+ *
+ *  Updates the EEPROM checksum by reading/adding each word of the EEPROM
+ *  up to the checksum.  Then calculates the EEPROM checksum and writes the
+ *  value to the EEPROM.
+ **/
+s32 igc_update_nvm_checksum(struct igc_hw *hw)
+{
+	u16 checksum = 0;
+	u16 i, nvm_data;
+	s32  ret_val;
+
+	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
+		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
+		if (ret_val) {
+			hw_dbg("NVM Read Error while updating checksum.\n");
+			goto out;
+		}
+		checksum += nvm_data;
+	}
+	checksum = (u16)NVM_SUM - checksum;
+	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
+	if (ret_val)
+		hw_dbg("NVM Write Error while updating checksum.\n");
+
+out:
+	return ret_val;
+}
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.h b/drivers/net/ethernet/intel/igc/igc_nvm.h
new file mode 100644
index 000000000000..dcca6c699531
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_NVM_H_
+#define _IGC_NVM_H_
+
+s32 igc_acquire_nvm(struct igc_hw *hw);
+void igc_release_nvm(struct igc_hw *hw);
+s32 igc_read_mac_addr(struct igc_hw *hw);
+s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
+s32  igc_validate_nvm_checksum(struct igc_hw *hw);
+s32  igc_update_nvm_checksum(struct igc_hw *hw);
+
+#endif
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index fc7cce5d9b7a..aaeaf61b730a 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -191,6 +191,9 @@
 /* Management registers */
 #define IGC_MANC	0x05820  /* Management Control - RW */
 
+/* Shadow Ram Write Register - RW */
+#define IGC_SRWR	0x12018
+
 /* forward declaration */
 struct igc_hw;
 u32 igc_rd32(struct igc_hw *hw, u32 reg);
-- 
2.11.0

