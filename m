From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:30 -0400
Subject: [Intel-wired-lan] [next PATCH S16 01/15] i40e: generate fewer
	startup messages
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Cut down on the number of startup log entries by putting a couple behind
debug flags and combining a couple others into a single line.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I708089f086308f84d43f8b6f0e8a634a02d058fb
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 20 ++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c     |  4 ++--
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0ed6506..cb8002f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -584,10 +584,10 @@ struct i40e_device {
 };
 
 /**
- * i40e_fw_version_str - format the FW and NVM version strings
+ * i40e_nvm_version_str - format the NVM version strings
  * @hw: ptr to the hardware info
  **/
-static inline char *i40e_fw_version_str(struct i40e_hw *hw)
+static inline char *i40e_nvm_version_str(struct i40e_hw *hw)
 {
 	static char buf[32];
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d6b0788..0d5aecf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1122,7 +1122,7 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 	strlcpy(drvinfo->driver, i40e_driver_name, sizeof(drvinfo->driver));
 	strlcpy(drvinfo->version, i40e_driver_version_str,
 		sizeof(drvinfo->version));
-	strlcpy(drvinfo->fw_version, i40e_fw_version_str(&pf->hw),
+	strlcpy(drvinfo->fw_version, i40e_nvm_version_str(&pf->hw),
 		sizeof(drvinfo->fw_version));
 	strlcpy(drvinfo->bus_info, pci_name(pf->pdev),
 		sizeof(drvinfo->bus_info));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f8401d0..5503763 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6402,8 +6402,9 @@ static void i40e_config_bridge_mode(struct i40e_veb *veb)
 {
 	struct i40e_pf *pf = veb->pf;
 
-	dev_info(&pf->pdev->dev, "enabling bridge mode: %s\n",
-		 veb->bridge_mode == BRIDGE_MODE_VEPA ? "VEPA" : "VEB");
+	if (pf->hw.debug_mask & I40E_DEBUG_LAN)
+		dev_info(&pf->pdev->dev, "enabling bridge mode: %s\n",
+			 veb->bridge_mode == BRIDGE_MODE_VEPA ? "VEPA" : "VEB");
 	if (veb->bridge_mode & BRIDGE_MODE_VEPA)
 		i40e_disable_pf_switch_lb(pf);
 	else
@@ -10133,6 +10134,10 @@ static void i40e_print_features(struct i40e_pf *pf)
 	if (pf->flags & I40E_FLAG_FCOE_ENABLED)
 		buf += sprintf(buf, "FCOE ");
 #endif
+	if (pf->flags & I40E_FLAG_VEB_MODE_ENABLED)
+		buf += sprintf(buf, "VEB ");
+	else
+		buf += sprintf(buf, "VEPA ");
 
 	BUG_ON(buf > (string + INFO_STRING_LEN));
 	dev_info(&pf->pdev->dev, "%s\n", string);
@@ -10272,13 +10277,12 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pf->hw.fc.requested_mode = I40E_FC_NONE;
 
 	err = i40e_init_adminq(hw);
-	dev_info(&pdev->dev, "%s\n", i40e_fw_version_str(hw));
 
-	/* provide additional fw info, like api and ver */
-	dev_info(&pdev->dev, "fw_version:%d.%d.%05d\n",
-		 hw->aq.fw_maj_ver, hw->aq.fw_min_ver, hw->aq.fw_build);
-	dev_info(&pdev->dev, "fw api version:%d.%d\n",
-		 hw->aq.api_maj_ver, hw->aq.api_min_ver);
+	/* provide nvm, fw, api versions */
+	dev_info(&pdev->dev, "fw %d.%d.%05d api %d.%d nvm %s\n",
+		 hw->aq.fw_maj_ver, hw->aq.fw_min_ver, hw->aq.fw_build,
+		 hw->aq.api_maj_ver, hw->aq.api_min_ver,
+		 i40e_nvm_version_str(hw));
 
 	if (err) {
 		dev_info(&pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 552c84e..565ca7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -674,8 +674,8 @@ void i40e_ptp_init(struct i40e_pf *pf)
 		struct timespec64 ts;
 		u32 regval;
 
-		dev_info(&pf->pdev->dev, "%s: added PHC on %s\n", __func__,
-			 netdev->name);
+		if (pf->hw.debug_mask & I40E_DEBUG_LAN)
+			dev_info(&pf->pdev->dev, "PHC enabled\n");
 		pf->flags |= I40E_FLAG_PTP;
 
 		/* Ensure the clocks are running. */
-- 
1.9.3

