From: Joshua Hay <joshua.a.hay@intel.com>
Date: Mon, 11 Jan 2016 15:18:14 -0800
Subject: [Intel-wired-lan] [next PATCH S27 02/15] i40e: Make the DCB
	firmware checks for X710/XL710 only
In-Reply-To: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
References: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452554307-20937-3-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

Make the DCB firmware version related checks specific to
X710 and XL710 only. These checks are not required for
X722 family of devices.

Introduced an inline routine to help determine if the
MAC type is X710/XL710 or not.

Moved the firmware version related checks in i40e_sw_init()
and defined flags for different cases

Fix the version check to allow using "Set LLDP MIB" AQ
for beyond FVL4 FW releases.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Change-ID: Ib78288343de983aa0354fc28aa36e99b073662c0
---
Testing Hints:
- LLDP should get disabled on FVL with FVLSW1/2 NVM
and no DCB/DCBX functionality should be available
- DCB capability should be enabled for FVL3/4 NVM images
- Once DCB is enabled for FPK builds SW functionally should
be same as FVL DCB

 drivers/net/ethernet/intel/i40e/i40e.h      | 16 ++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c | 27 ++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0ef5635..cffa834 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -137,6 +137,19 @@
 /* default to trying for four seconds */
 #define I40E_TRY_LINK_TIMEOUT (4 * HZ)
 
+/**
+ * i40e_is_mac_710 - Return true if MAC is X710/XL710
+ * @hw: ptr to the hardware info
+ **/
+static inline bool i40e_is_mac_710(struct i40e_hw *hw)
+{
+	if ((hw->mac.type == I40E_MAC_X710) ||
+	    (hw->mac.type == I40E_MAC_XL710))
+		return true;
+
+	return false;
+}
+
 /* driver state flags */
 enum i40e_state_t {
 	__I40E_TESTING,
@@ -341,6 +354,9 @@ struct i40e_pf {
 #define I40E_FLAG_NO_PCI_LINK_CHECK		BIT_ULL(42)
 #define I40E_FLAG_100M_SGMII_CAPABLE		BIT_ULL(43)
 #define I40E_FLAG_RESTART_AUTONEG		BIT_ULL(44)
+#define I40E_FLAG_NO_DCB_SUPPORT		BIT_ULL(45)
+#define I40E_FLAG_USE_SET_LLDP_MIB		BIT_ULL(46)
+#define I40E_FLAG_STOP_FW_LLDP			BIT_ULL(47)
 #define I40E_FLAG_PF_MAC			BIT_ULL(50)
 
 	/* tracks features that get auto disabled by errors */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 94eee68..0d59028 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5017,8 +5017,7 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 	int err = 0;
 
 	/* Do not enable DCB for SW1 and SW2 images even if the FW is capable */
-	if (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
-	    (pf->hw.aq.fw_maj_ver < 4))
+	if (pf->flags & I40E_FLAG_NO_DCB_SUPPORT)
 		goto out;
 
 	/* Get the initial DCB configuration */
@@ -8422,11 +8421,25 @@ static int i40e_sw_init(struct i40e_pf *pf)
 				 pf->hw.func_caps.fd_filters_best_effort;
 	}
 
-	if (((pf->hw.mac.type == I40E_MAC_X710) ||
-	     (pf->hw.mac.type == I40E_MAC_XL710)) &&
+	if (i40e_is_mac_710(&pf->hw) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
-	    (pf->hw.aq.fw_maj_ver < 4)))
+	    (pf->hw.aq.fw_maj_ver < 4))) {
 		pf->flags |= I40E_FLAG_RESTART_AUTONEG;
+		/* No DCB support  for FW < v4.33 */
+		pf->flags |= I40E_FLAG_NO_DCB_SUPPORT;
+	}
+
+	/* Disable FW LLDP if FW < v4.3 */
+	if (i40e_is_mac_710(&pf->hw) &&
+	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 3)) ||
+	    (pf->hw.aq.fw_maj_ver < 4)))
+		pf->flags |= I40E_FLAG_STOP_FW_LLDP;
+
+	/* Use the FW Set LLDP MIB API if FW > v4.40 */
+	if (i40e_is_mac_710(&pf->hw) &&
+	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver >= 40)) ||
+	    (pf->hw.aq.fw_maj_ver >= 5)))
+		pf->flags |= I40E_FLAG_USE_SET_LLDP_MIB;
 
 	if (pf->hw.func_caps.vmdq) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
@@ -8455,6 +8468,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_WB_ON_ITR_CAPABLE |
 			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
 			     I40E_FLAG_100M_SGMII_CAPABLE |
+			     I40E_FLAG_USE_SET_LLDP_MIB |
 			     I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
 	}
 	pf->eeprom_version = 0xDEAD;
@@ -10840,8 +10854,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * Ignore error return codes because if it was already disabled via
 	 * hardware settings this will fail
 	 */
-	if (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 3)) ||
-	    (pf->hw.aq.fw_maj_ver < 4)) {
+	if (pf->flags & I40E_FLAG_STOP_FW_LLDP) {
 		dev_info(&pdev->dev, "Stopping firmware LLDP agent.\n");
 		i40e_aq_stop_lldp(hw, true, NULL);
 	}
-- 
2.1.0

