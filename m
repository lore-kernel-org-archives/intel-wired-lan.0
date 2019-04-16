From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:34:54 -0700
Subject: [Intel-wired-lan] [PATCH S21 05/14] ice: Cleanup
 ice_update_link_info
In-Reply-To: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173503.29847-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Do not allocate memory for the Get PHY Abilities command data buffer when
it is not necessary, change one local variable to another to reduce the
number of de-references, reduce the scope of some local variables, and
reorder the code and change exit points to get rid of an unnecessary goto
label.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_common.c | 35 +++++++++++----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9a402513613f..89204a289865 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1998,36 +1998,37 @@ ice_aq_set_phy_cfg(struct ice_hw *hw, u8 lport,
  */
 enum ice_status ice_update_link_info(struct ice_port_info *pi)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps;
-	struct ice_phy_info *phy_info;
+	struct ice_link_status *li;
 	enum ice_status status;
-	struct ice_hw *hw;
 
 	if (!pi)
 		return ICE_ERR_PARAM;
 
-	hw = pi->hw;
-
-	pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps), GFP_KERNEL);
-	if (!pcaps)
-		return ICE_ERR_NO_MEMORY;
+	li = &pi->phy.link_info;
 
-	phy_info = &pi->phy;
 	status = ice_aq_get_link_info(pi, true, NULL, NULL);
 	if (status)
-		goto out;
+		return status;
+
+	if (li->link_info & ICE_AQ_MEDIA_AVAILABLE) {
+		struct ice_aqc_get_phy_caps_data *pcaps;
+		struct ice_hw *hw;
+
+		hw = pi->hw;
+		pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps),
+				     GFP_KERNEL);
+		if (!pcaps)
+			return ICE_ERR_NO_MEMORY;
 
-	if (phy_info->link_info.link_info & ICE_AQ_MEDIA_AVAILABLE) {
 		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG,
 					     pcaps, NULL);
-		if (status)
-			goto out;
+		if (!status)
+			memcpy(li->module_type, &pcaps->module_type,
+			       sizeof(li->module_type));
 
-		memcpy(phy_info->link_info.module_type, &pcaps->module_type,
-		       sizeof(phy_info->link_info.module_type));
+		devm_kfree(ice_hw_to_dev(hw), pcaps);
 	}
-out:
-	devm_kfree(ice_hw_to_dev(hw), pcaps);
+
 	return status;
 }
 
-- 
2.20.1

