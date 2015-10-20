From: Raanan Avargil <raanan.avargil@intel.com>
Date: Tue, 20 Oct 2015 17:13:02 +0300
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: cosmetic changes
In-Reply-To: <1445350382-6739-1-git-send-email-raanan.avargil@intel.com>
References: <1445350382-6739-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <1445350382-6739-2-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Few cosmetics changes to improve code readability.
Replaced tab with spaces, deleted few lines, and
indented lines. Script checkpatch passed.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 ++++++++------------
 drivers/net/ethernet/intel/e1000e/netdev.c  |  3 +--
 drivers/net/ethernet/intel/e1000e/nvm.c     |  2 --
 drivers/net/ethernet/intel/e1000e/phy.c     |  3 ---
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index a049e30..9a43096 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1043,8 +1043,7 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 		 */
 		rxa *= 512;
 		value = (rxa > hw->adapter->max_frame_size) ?
-			(rxa - hw->adapter->max_frame_size) * (16000 / speed) :
-			0;
+		    (rxa - hw->adapter->max_frame_size) * (16000 / speed) : 0;
 
 		while (value > PCI_LTR_VALUE_MASK) {
 			scale++;
@@ -1415,7 +1414,6 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 			tipg_reg |= 0xC;
 			emi_val = 1;
 		} else {
-
 			/* Roll back the default values */
 			tipg_reg |= 0x08;
 			emi_val = 1;
@@ -1721,7 +1719,7 @@ static s32 e1000_acquire_swflag_ich8lan(struct e1000_hw *hw)
 
 	if (!timeout) {
 		e_dbg("Failed to acquire the semaphore, FW or HW has it: FWSM=0x%8.8x EXTCNF_CTRL=0x%8.8x)\n",
-		      er32(FWSM), extcnf_ctrl);
+		     er32(FWSM), extcnf_ctrl);
 		extcnf_ctrl &= ~E1000_EXTCNF_CTRL_SWFLAG;
 		ew32(EXTCNF_CTRL, extcnf_ctrl);
 		ret_val = -E1000_ERR_CONFIG;
@@ -1772,8 +1770,8 @@ static bool e1000_check_mng_mode_ich8lan(struct e1000_hw *hw)
 
 	fwsm = er32(FWSM);
 	return (fwsm & E1000_ICH_FWSM_FW_VALID) &&
-		((fwsm & E1000_FWSM_MODE_MASK) ==
-		 (E1000_ICH_MNG_IAMT_MODE << E1000_FWSM_MODE_SHIFT));
+	    ((fwsm & E1000_FWSM_MODE_MASK) ==
+	     (E1000_ICH_MNG_IAMT_MODE << E1000_FWSM_MODE_SHIFT));
 }
 
 /**
@@ -2721,7 +2719,6 @@ static s32 e1000_k1_workaround_lv(struct e1000_hw *hw)
 				return ret_val;
 		} else {
 			u32 mac_reg;
-
 			mac_reg = er32(FEXTNVM4);
 			mac_reg &= ~E1000_FEXTNVM4_BEACON_DURATION_MASK;
 			mac_reg |= E1000_FEXTNVM4_BEACON_DURATION_16USEC;
@@ -3480,7 +3477,6 @@ static s32 e1000_read_flash_word_ich8lan(struct e1000_hw *hw, u32 offset,
 {
 	/* Must convert offset into bytes. */
 	offset <<= 1;
-
 	return e1000_read_flash_data_ich8lan(hw, offset, 2, data);
 }
 
@@ -3535,7 +3531,6 @@ static s32 e1000_read_flash_data_ich8lan(struct e1000_hw *hw, u32 offset,
 
 	if (size < 1 || size > 2 || offset > ICH_FLASH_LINEAR_ADDR_MASK)
 		return -E1000_ERR_NVM;
-
 	flash_linear_addr = ((ICH_FLASH_LINEAR_ADDR_MASK & offset) +
 			     hw->nvm.flash_base_addr);
 
@@ -3545,13 +3540,12 @@ static s32 e1000_read_flash_data_ich8lan(struct e1000_hw *hw, u32 offset,
 		ret_val = e1000_flash_cycle_init_ich8lan(hw);
 		if (ret_val)
 			break;
-
 		hsflctl.regval = er16flash(ICH_FLASH_HSFCTL);
+
 		/* 0b/1b corresponds to 1 or 2 byte size, respectively. */
 		hsflctl.hsf_ctrl.fldbcount = size - 1;
 		hsflctl.hsf_ctrl.flcycle = ICH_CYCLE_READ;
 		ew16flash(ICH_FLASH_HSFCTL, hsflctl.regval);
-
 		ew32flash(ICH_FLASH_FADDR, flash_linear_addr);
 
 		ret_val =
@@ -3929,7 +3923,6 @@ static s32 e1000_update_nvm_checksum_ich8lan(struct e1000_hw *hw)
 			if (ret_val)
 				break;
 		}
-
 		/* If the word is 0x13, then make sure the signature bits
 		 * (15:14) are 11b until the commit has completed.
 		 * This will allow us to write 10b which indicates the
@@ -3944,6 +3937,7 @@ static s32 e1000_update_nvm_checksum_ich8lan(struct e1000_hw *hw)
 		act_offset = (i + new_bank_offset) << 1;
 
 		usleep_range(100, 200);
+
 		/* Write the bytes to the new bank. */
 		ret_val = e1000_retry_write_flash_byte_ich8lan(hw,
 							       act_offset,
@@ -3991,7 +3985,9 @@ static s32 e1000_update_nvm_checksum_ich8lan(struct e1000_hw *hw)
 	 * to 1's. We can write 1's to 0's without an erase
 	 */
 	act_offset = (old_bank_offset + E1000_ICH_NVM_SIG_WORD) * 2 + 1;
+
 	ret_val = e1000_retry_write_flash_byte_ich8lan(hw, act_offset, 0);
+
 	if (ret_val)
 		goto release;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 2fd8b9d..e8e50c0 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1960,7 +1960,7 @@ static irqreturn_t e1000_intr_msix_rx(int __always_unused irq, void *data)
 	 */
 	if (rx_ring->set_itr) {
 		u32 itr = rx_ring->itr_val ?
-			1000000000 / (rx_ring->itr_val * 256) : 0;
+		    1000000000 / (rx_ring->itr_val * 256) : 0;
 
 		writel(itr, rx_ring->itr_register);
 		rx_ring->set_itr = 0;
@@ -6336,7 +6336,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	if ((hw->phy.type >= e1000_phy_i217) &&
 	    adapter->eee_advert && hw->dev_spec.ich8lan.eee_lp_ability) {
 		u16 lpi_ctrl = 0;
-
 		retval = hw->phy.ops.acquire(hw);
 		if (!retval) {
 			retval = e1e_rphy_locked(hw, I82579_LPI_CTRL,
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index 49f205c..7ecf2b2 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -172,7 +172,6 @@ s32 e1000e_acquire_nvm(struct e1000_hw *hw)
 
 	ew32(EECD, eecd | E1000_EECD_REQ);
 	eecd = er32(EECD);
-
 	while (timeout) {
 		if (eecd & E1000_EECD_GNT)
 			break;
@@ -400,7 +399,6 @@ s32 e1000e_write_nvm_spi(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
 		/* Loop to allow for up to whole page write of eeprom */
 		while (widx < words) {
 			u16 word_out = data[widx];
-
 			word_out = (word_out >> 8) | (word_out << 8);
 			e1000_shift_out_eec_bits(hw, word_out, 16);
 			widx++;
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index de13aea..5819b29 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -2763,7 +2763,6 @@ static s32 __e1000_read_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 *data,
 		if (ret_val)
 			return ret_val;
 	}
-
 	/* Page 800 works differently than the rest so it has its own func */
 	if (page == BM_WUC_PAGE) {
 		ret_val = e1000_access_phy_wakeup_reg_bm(hw, offset, data,
@@ -2870,7 +2869,6 @@ static s32 __e1000_write_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 data,
 		if (ret_val)
 			return ret_val;
 	}
-
 	/* Page 800 works differently than the rest so it has its own func */
 	if (page == BM_WUC_PAGE) {
 		ret_val = e1000_access_phy_wakeup_reg_bm(hw, offset, &data,
@@ -2896,7 +2894,6 @@ static s32 __e1000_write_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 data,
 		    (hw->phy.addr == 2) &&
 		    !(MAX_PHY_REG_ADDRESS & reg) && (data & (1 << 11))) {
 			u16 data2 = 0x7EFF;
-
 			ret_val = e1000_access_phy_debug_regs_hv(hw,
 								 (1 << 6) | 0x3,
 								 &data2, false);
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

