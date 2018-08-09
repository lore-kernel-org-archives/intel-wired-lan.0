From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu,  9 Aug 2018 06:29:03 -0700
Subject: [Intel-wired-lan] [PATCH v4 13/13] ice: Trivial formatting fixes
In-Reply-To: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180809132903.22819-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

1) Add missing "\n" when printing link event error message.

2) Update dev_err statement in probe.

3) Add function description for ice_clear_pf_cfg.

4) Fix coding style for ice_acquire_nvm.

5) netdev->mtu is unsigned so use %u.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 +++
 drivers/net/ethernet/intel/ice/ice_main.c   | 6 +++---
 drivers/net/ethernet/intel/ice/ice_nvm.c    | 5 ++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ebd701ac9428..661beea6af79 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -45,6 +45,9 @@ static enum ice_status ice_set_mac_type(struct ice_hw *hw)
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
+ *
+ * Clears any existing PF configuration (VSIs, VSI lists, switch rules, port
+ * configuration, flow director filters, etc.).
  */
 enum ice_status ice_clear_pf_cfg(struct ice_hw *hw)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e23156515186..f1e80eed2fd6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -901,7 +901,7 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 		case ice_aqc_opc_get_link_status:
 			if (ice_handle_link_event(pf))
 				dev_err(&pf->pdev->dev,
-					"Could not handle link event");
+					"Could not handle link event\n");
 			break;
 		default:
 			dev_dbg(&pf->pdev->dev,
@@ -3284,7 +3284,7 @@ static int ice_probe(struct pci_dev *pdev,
 
 	err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), pci_name(pdev));
 	if (err) {
-		dev_err(&pdev->dev, "I/O map error %d\n", err);
+		dev_err(&pdev->dev, "BAR0 I/O map error %d\n", err);
 		return err;
 	}
 
@@ -5252,7 +5252,7 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	u8 count = 0;
 
 	if (new_mtu == netdev->mtu) {
-		netdev_warn(netdev, "mtu is already %d\n", netdev->mtu);
+		netdev_warn(netdev, "mtu is already %u\n", netdev->mtu);
 		return 0;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 92da0a626ce0..295a8cd87fc1 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -131,9 +131,8 @@ ice_read_sr_word_aq(struct ice_hw *hw, u16 offset, u16 *data)
  *
  * This function will request NVM ownership.
  */
-static enum
-ice_status ice_acquire_nvm(struct ice_hw *hw,
-			   enum ice_aq_res_access_type access)
+static enum ice_status
+ice_acquire_nvm(struct ice_hw *hw, enum ice_aq_res_access_type access)
 {
 	if (hw->nvm.blank_nvm_mode)
 		return 0;
-- 
2.17.1

