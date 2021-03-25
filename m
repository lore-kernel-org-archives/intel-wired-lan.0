From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:06 -0700
Subject: [Intel-wired-lan] [PATCH S57 03/14] ice: Align macro names to the
 specification
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

For get PHY abilities AQ, the specification defines "report modes"
as "with media", "without media" and "active configuration". For
clarity, rename macros to align with the specification.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_common.c     | 13 +++++++------
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 12 ++++++------
 drivers/net/ethernet/intel/ice/ice_main.c       | 12 ++++++------
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 0a5f4c230076..f65e509f582c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -882,11 +882,11 @@ struct ice_aqc_get_phy_caps {
 	 * 01b - Report topology capabilities
 	 * 10b - Report SW configured
 	 */
-#define ICE_AQC_REPORT_MODE_S		1
-#define ICE_AQC_REPORT_MODE_M		(3 << ICE_AQC_REPORT_MODE_S)
-#define ICE_AQC_REPORT_NVM_CAP		0
-#define ICE_AQC_REPORT_TOPO_CAP		BIT(1)
-#define ICE_AQC_REPORT_SW_CFG		BIT(2)
+#define ICE_AQC_REPORT_MODE_S			1
+#define ICE_AQC_REPORT_MODE_M			(3 << ICE_AQC_REPORT_MODE_S)
+#define ICE_AQC_REPORT_TOPO_CAP_NO_MEDIA	0
+#define ICE_AQC_REPORT_TOPO_CAP_MEDIA		BIT(1)
+#define ICE_AQC_REPORT_ACTIVE_CFG		BIT(2)
 	__le32 reserved1;
 	__le32 addr_high;
 	__le32 addr_low;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f1573d653321..1d744d2456d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -191,7 +191,7 @@ ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 	ice_debug(hw, ICE_DBG_LINK, "   module_type[2] = 0x%x\n",
 		  pcaps->module_type[2]);
 
-	if (!status && report_mode == ICE_AQC_REPORT_TOPO_CAP) {
+	if (!status && report_mode == ICE_AQC_REPORT_TOPO_CAP_MEDIA) {
 		pi->phy.phy_type_low = le64_to_cpu(pcaps->phy_type_low);
 		pi->phy.phy_type_high = le64_to_cpu(pcaps->phy_type_high);
 		memcpy(pi->phy.link_info.module_type, &pcaps->module_type,
@@ -922,7 +922,8 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 
 	/* Initialize port_info struct with PHY capabilities */
 	status = ice_aq_get_phy_caps(hw->port_info, false,
-				     ICE_AQC_REPORT_TOPO_CAP, pcaps, NULL);
+				     ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps,
+				     NULL);
 	devm_kfree(ice_hw_to_dev(hw), pcaps);
 	if (status)
 		dev_warn(ice_hw_to_dev(hw), "Get PHY capabilities failed status = %d, continuing anyway\n",
@@ -2734,7 +2735,7 @@ enum ice_status ice_update_link_info(struct ice_port_info *pi)
 		if (!pcaps)
 			return ICE_ERR_NO_MEMORY;
 
-		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP,
+		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
 					     pcaps, NULL);
 
 		devm_kfree(ice_hw_to_dev(hw), pcaps);
@@ -2894,8 +2895,8 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 		return ICE_ERR_NO_MEMORY;
 
 	/* Get the current PHY config */
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG, pcaps,
-				     NULL);
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_ACTIVE_CFG,
+				     pcaps, NULL);
 	if (status) {
 		*aq_failures = ICE_SET_FC_AQ_FAIL_GET;
 		goto out;
@@ -3041,7 +3042,7 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 	if (!pcaps)
 		return ICE_ERR_NO_MEMORY;
 
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP, pcaps,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps,
 				     NULL);
 	if (status)
 		goto out;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d3459bdf5134..49baf73a3c2c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1060,7 +1060,7 @@ ice_get_fecparam(struct net_device *netdev, struct ethtool_fecparam *fecparam)
 	if (!caps)
 		return -ENOMEM;
 
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
 				     caps, NULL);
 	if (status) {
 		err = -EAGAIN;
@@ -2000,7 +2000,7 @@ ice_get_link_ksettings(struct net_device *netdev,
 		return -ENOMEM;
 
 	status = ice_aq_get_phy_caps(vsi->port_info, false,
-				     ICE_AQC_REPORT_SW_CFG, caps, NULL);
+				     ICE_AQC_REPORT_ACTIVE_CFG, caps, NULL);
 	if (status) {
 		err = -EIO;
 		goto done;
@@ -2037,7 +2037,7 @@ ice_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
 
 	status = ice_aq_get_phy_caps(vsi->port_info, false,
-				     ICE_AQC_REPORT_TOPO_CAP, caps, NULL);
+				     ICE_AQC_REPORT_TOPO_CAP_MEDIA, caps, NULL);
 	if (status) {
 		err = -EIO;
 		goto done;
@@ -2243,7 +2243,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 		return -ENOMEM;
 
 	/* Get the PHY capabilities based on media */
-	status = ice_aq_get_phy_caps(p, false, ICE_AQC_REPORT_TOPO_CAP,
+	status = ice_aq_get_phy_caps(p, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
 				     abilities, NULL);
 	if (status) {
 		err = -EAGAIN;
@@ -2972,7 +2972,7 @@ ice_get_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 		return;
 
 	/* Get current PHY config */
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG, pcaps,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_ACTIVE_CFG, pcaps,
 				     NULL);
 	if (status)
 		goto out;
@@ -3039,7 +3039,7 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 		return -ENOMEM;
 
 	/* Get current PHY config */
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG, pcaps,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_ACTIVE_CFG, pcaps,
 				     NULL);
 	if (status) {
 		kfree(pcaps);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ecadc517e9eb..4c4ce4379eb4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -734,7 +734,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	}
 
 	status = ice_aq_get_phy_caps(vsi->port_info, false,
-				     ICE_AQC_REPORT_SW_CFG, caps, NULL);
+				     ICE_AQC_REPORT_ACTIVE_CFG, caps, NULL);
 	if (status)
 		netdev_info(vsi->netdev, "Get phy capability failed.\n");
 
@@ -1650,7 +1650,7 @@ static int ice_force_phys_link_state(struct ice_vsi *vsi, bool link_up)
 	if (!pcaps)
 		return -ENOMEM;
 
-	retcode = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG, pcaps,
+	retcode = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_ACTIVE_CFG, pcaps,
 				      NULL);
 	if (retcode) {
 		dev_err(dev, "Failed to get phy capabilities, VSI %d error %d\n",
@@ -1710,7 +1710,7 @@ static int ice_init_nvm_phy_type(struct ice_port_info *pi)
 	if (!pcaps)
 		return -ENOMEM;
 
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_NVM_CAP, pcaps,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_NO_MEDIA, pcaps,
 				     NULL);
 
 	if (status) {
@@ -1826,7 +1826,7 @@ static int ice_init_phy_user_cfg(struct ice_port_info *pi)
 	if (!pcaps)
 		return -ENOMEM;
 
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP, pcaps,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps,
 				     NULL);
 	if (status) {
 		dev_err(ice_pf_to_dev(pf), "Get PHY capability failed.\n");
@@ -1905,7 +1905,7 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 		return -ENOMEM;
 
 	/* Get current PHY config */
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG, pcaps,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_ACTIVE_CFG, pcaps,
 				     NULL);
 	if (status) {
 		dev_err(dev, "Failed to get PHY configuration, VSI %d error %s\n",
@@ -1923,7 +1923,7 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 
 	/* Use PHY topology as baseline for configuration */
 	memset(pcaps, 0, sizeof(*pcaps));
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP, pcaps,
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps,
 				     NULL);
 	if (status) {
 		dev_err(dev, "Failed to get PHY topology, VSI %d error %s\n",
-- 
2.20.1

