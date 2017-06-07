From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:09 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 09/13] i40e: Add support for
	OEM firmware version
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch adds support for OEM firmware version. If OEM specific
adapter is detected ethtool reports OEM product version in firmware
version string instead of etrack id.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 48 ++++++++++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_main.c | 47 ++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 962ef98..cb102cd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -103,6 +103,12 @@
 	(I40E_AQ_PHY_DEBUG_DISABLE_LINK_FW | \
 	I40E_AQ_PHY_DEBUG_DISABLE_ALL_LINK_FW)
 
+#define I40E_OEM_EETRACK_ID		0xffffffff
+#define I40E_OEM_GEN_SHIFT		24
+#define I40E_OEM_SNAP_MASK		0x00ff0000
+#define I40E_OEM_SNAP_SHIFT		16
+#define I40E_OEM_RELEASE_MASK		0x0000ffff
+
 /* The values in here are decimal coded as hex as is the case in the NVM map*/
 #define I40E_CURRENT_NVM_VERSION_HI	0x2
 #define I40E_CURRENT_NVM_VERSION_LO	0x40
@@ -733,22 +739,36 @@ static inline char *i40e_nvm_version_str(struct i40e_hw *hw)
 {
 	static char buf[32];
 	u32 full_ver;
-	u8 ver, patch;
-	u16 build;
 
 	full_ver = hw->nvm.oem_ver;
-	ver = (u8)(full_ver >> I40E_OEM_VER_SHIFT);
-	build = (u16)((full_ver >> I40E_OEM_VER_BUILD_SHIFT) &
-		 I40E_OEM_VER_BUILD_MASK);
-	patch = (u8)(full_ver & I40E_OEM_VER_PATCH_MASK);
-
-	snprintf(buf, sizeof(buf),
-		 "%x.%02x 0x%x %d.%d.%d",
-		 (hw->nvm.version & I40E_NVM_VERSION_HI_MASK) >>
-			I40E_NVM_VERSION_HI_SHIFT,
-		 (hw->nvm.version & I40E_NVM_VERSION_LO_MASK) >>
-			I40E_NVM_VERSION_LO_SHIFT,
-		 hw->nvm.eetrack, ver, build, patch);
+
+	if (hw->nvm.eetrack == I40E_OEM_EETRACK_ID) {
+		u8 gen, snap;
+		u16 release;
+
+		gen = (u8)(full_ver >> I40E_OEM_GEN_SHIFT);
+		snap = (u8)((full_ver & I40E_OEM_SNAP_MASK) >>
+			I40E_OEM_SNAP_SHIFT);
+		release = (u16)(full_ver & I40E_OEM_RELEASE_MASK);
+
+		snprintf(buf, sizeof(buf), "%x.%x.%x", gen, snap, release);
+	} else {
+		u8 ver, patch;
+		u16 build;
+
+		ver = (u8)(full_ver >> I40E_OEM_VER_SHIFT);
+		build = (u16)((full_ver >> I40E_OEM_VER_BUILD_SHIFT) &
+			 I40E_OEM_VER_BUILD_MASK);
+		patch = (u8)(full_ver & I40E_OEM_VER_PATCH_MASK);
+
+		snprintf(buf, sizeof(buf),
+			 "%x.%02x 0x%x %d.%d.%d",
+			 (hw->nvm.version & I40E_NVM_VERSION_HI_MASK) >>
+				I40E_NVM_VERSION_HI_SHIFT,
+			 (hw->nvm.version & I40E_NVM_VERSION_LO_MASK) >>
+				I40E_NVM_VERSION_LO_SHIFT,
+			 hw->nvm.eetrack, ver, build, patch);
+	}
 
 	return buf;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e4ae673..5fd4d2f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7107,6 +7107,51 @@ static void i40e_send_version(struct i40e_pf *pf)
 }
 
 /**
+ * i40e_get_oem_version - get OEM specific version information
+ * @hw: pointer to the hardware structure
+ **/
+static void i40e_get_oem_version(struct i40e_hw *hw)
+{
+	u16 block_offset = 0xffff;
+	u16 block_length = 0;
+	u16 capabilities = 0;
+	u16 gen_snap = 0;
+	u16 release = 0;
+
+#define I40E_SR_NVM_OEM_VERSION_PTR		0x1B
+#define I40E_NVM_OEM_LENGTH_OFFSET		0x00
+#define I40E_NVM_OEM_CAPABILITIES_OFFSET	0x01
+#define I40E_NVM_OEM_GEN_OFFSET			0x02
+#define I40E_NVM_OEM_RELEASE_OFFSET		0x03
+#define I40E_NVM_OEM_CAPABILITIES_MASK		0x000F
+#define I40E_NVM_OEM_LENGTH			3
+
+	/* Check if pointer to OEM version block is valid. */
+	i40e_read_nvm_word(hw, I40E_SR_NVM_OEM_VERSION_PTR, &block_offset);
+	if (block_offset == 0xffff)
+		return;
+
+	/* Check if OEM version block has correct length. */
+	i40e_read_nvm_word(hw, block_offset + I40E_NVM_OEM_LENGTH_OFFSET,
+			   &block_length);
+	if (block_length < I40E_NVM_OEM_LENGTH)
+		return;
+
+	/* Check if OEM version format is as expected. */
+	i40e_read_nvm_word(hw, block_offset + I40E_NVM_OEM_CAPABILITIES_OFFSET,
+			   &capabilities);
+	if ((capabilities & I40E_NVM_OEM_CAPABILITIES_MASK) != 0)
+		return;
+
+	i40e_read_nvm_word(hw, block_offset + I40E_NVM_OEM_GEN_OFFSET,
+			   &gen_snap);
+	i40e_read_nvm_word(hw, block_offset + I40E_NVM_OEM_RELEASE_OFFSET,
+			   &release);
+	hw->nvm.oem_ver = (gen_snap << I40E_OEM_SNAP_SHIFT) | release;
+	hw->nvm.eetrack = I40E_OEM_EETRACK_ID;
+}
+
+/**
  * i40e_reset - wait for core reset to finish reset, reset pf if corer not seen
  * @pf: board private structure
  **/
@@ -7153,6 +7198,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto clear_recovery;
 	}
+	i40e_get_oem_version(&pf->hw);
 
 	/* re-verify the eeprom if we just had an EMP reset */
 	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state))
@@ -11337,6 +11383,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		goto err_pf_reset;
 	}
+	i40e_get_oem_version(hw);
 
 	/* provide nvm, fw, api versions */
 	dev_info(&pdev->dev, "fw %d.%d.%05d api %d.%d nvm %s\n",
-- 
2.9.3

