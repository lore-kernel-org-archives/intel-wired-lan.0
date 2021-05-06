From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:40:01 -0700
Subject: [Intel-wired-lan] [PATCH S59 06/13] ice: Detect and report
 unsupported module power levels
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Determine whether an unsupported power configuration is preventing link
establishment by storing and checking the link_cfg_err_byte. Print error
messages when module power levels are unsupported. Also add a new flag
bit to prevent spamming said error messages.

Co-developed-by: Jeb Cramer <jeb.j.cramer@intel.com>
Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  6 ++-
 drivers/net/ethernet/intel/ice/ice_common.c   |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 40 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f78466fa7150..a36e42a4348b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -382,6 +382,7 @@ enum ice_pf_flags {
 	ICE_FLAG_TOTAL_PORT_SHUTDOWN_ENA,
 	ICE_FLAG_NO_MEDIA,
 	ICE_FLAG_FW_LLDP_AGENT,
+	ICE_FLAG_MOD_POWER_UNSUPPORTED,
 	ICE_FLAG_ETHTOOL_CTXT,		/* set when ethtool holds RTNL lock */
 	ICE_FLAG_LEGACY_RX,
 	ICE_FLAG_VF_TRUE_PROMISC_ENA,
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 5cdfe406af84..e760f48ed07b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1122,7 +1122,9 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_TOPO_UNDRUTIL_PRT	BIT(5)
 #define ICE_AQ_LINK_TOPO_UNDRUTIL_MEDIA	BIT(6)
 #define ICE_AQ_LINK_TOPO_UNSUPP_MEDIA	BIT(7)
-	u8 reserved1;
+	u8 link_cfg_err;
+#define ICE_AQ_LINK_MODULE_POWER_UNSUPPORTED	BIT(5)
+#define ICE_AQ_LINK_INVAL_MAX_POWER_LIMIT	BIT(7)
 	u8 link_info;
 #define ICE_AQ_LINK_UP			BIT(0)	/* Link Status */
 #define ICE_AQ_LINK_FAULT		BIT(1)
@@ -1165,7 +1167,7 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_CFG_PACING_TYPE_FIXED	ICE_AQ_CFG_PACING_TYPE_M
 	/* External Device Power Ability */
 	u8 power_desc;
-#define ICE_AQ_PWR_CLASS_M		0x3
+#define ICE_AQ_PWR_CLASS_M		0x3F
 #define ICE_AQ_LINK_PWR_BASET_LOW_HIGH	0
 #define ICE_AQ_LINK_PWR_BASET_HIGH	1
 #define ICE_AQ_LINK_PWR_QSFP_CLASS_1	0
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e93b1e40f627..a327371e78b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -424,6 +424,7 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 	li->phy_type_high = le64_to_cpu(link_data.phy_type_high);
 	*hw_media_type = ice_get_media_type(pi);
 	li->link_info = link_data.link_info;
+	li->link_cfg_err = link_data.link_cfg_err;
 	li->an_info = link_data.an_info;
 	li->ext_info = link_data.ext_info;
 	li->max_frame_size = le16_to_cpu(link_data.max_frame_size);
@@ -454,6 +455,7 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 		  (unsigned long long)li->phy_type_high);
 	ice_debug(hw, ICE_DBG_LINK, "	media_type = 0x%x\n", *hw_media_type);
 	ice_debug(hw, ICE_DBG_LINK, "	link_info = 0x%x\n", li->link_info);
+	ice_debug(hw, ICE_DBG_LINK, "	link_cfg_err = 0x%x\n", li->link_cfg_err);
 	ice_debug(hw, ICE_DBG_LINK, "	an_info = 0x%x\n", li->an_info);
 	ice_debug(hw, ICE_DBG_LINK, "	ext_info = 0x%x\n", li->ext_info);
 	ice_debug(hw, ICE_DBG_LINK, "	fec_info = 0x%x\n", li->fec_info);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a7c359335cb0..0bf3b9bd9ef8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -875,6 +875,38 @@ static void ice_set_dflt_mib(struct ice_pf *pf)
 	kfree(lldpmib);
 }
 
+/**
+ * ice_check_module_power
+ * @pf: pointer to PF struct
+ * @link_cfg_err: bitmap from the link info structure
+ *
+ * check module power level returned by a previous call to aq_get_link_info
+ * and print error messages if module power level is not supported
+ */
+static void ice_check_module_power(struct ice_pf *pf, u8 link_cfg_err)
+{
+	/* if module power level is supported, clear the flag */
+	if (!(link_cfg_err & (ICE_AQ_LINK_INVAL_MAX_POWER_LIMIT |
+			      ICE_AQ_LINK_MODULE_POWER_UNSUPPORTED))) {
+		clear_bit(ICE_FLAG_MOD_POWER_UNSUPPORTED, pf->flags);
+		return;
+	}
+
+	/* if ICE_FLAG_MOD_POWER_UNSUPPORTED was previously set and the
+	 * above block didn't clear this bit, there's nothing to do
+	 */
+	if (test_bit(ICE_FLAG_MOD_POWER_UNSUPPORTED, pf->flags))
+		return;
+
+	if (link_cfg_err & ICE_AQ_LINK_INVAL_MAX_POWER_LIMIT) {
+		dev_err(ice_pf_to_dev(pf), "The installed module is incompatible with the device's NVM image. Cannot start link\n");
+		set_bit(ICE_FLAG_MOD_POWER_UNSUPPORTED, pf->flags);
+	} else if (link_cfg_err & ICE_AQ_LINK_MODULE_POWER_UNSUPPORTED) {
+		dev_err(ice_pf_to_dev(pf), "The module's power requirements exceed the device's power supply. Cannot start link\n");
+		set_bit(ICE_FLAG_MOD_POWER_UNSUPPORTED, pf->flags);
+	}
+}
+
 /**
  * ice_link_event - process the link event
  * @pf: PF that the link event is associated with
@@ -910,6 +942,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 			pi->lport, ice_stat_str(status),
 			ice_aq_str(pi->hw->adminq.sq_last_status));
 
+	ice_check_module_power(pf, pi->phy.link_info.link_cfg_err);
+
 	/* Check if the link state is up after updating link info, and treat
 	 * this event as an UP event since the link is actually UP now.
 	 */
@@ -2024,6 +2058,8 @@ static void ice_check_media_subtask(struct ice_pf *pf)
 	if (err)
 		return;
 
+	ice_check_module_power(pf, pi->phy.link_info.link_cfg_err);
+
 	if (pi->phy.link_info.link_info & ICE_AQ_MEDIA_AVAILABLE) {
 		if (!test_bit(ICE_PHY_INIT_COMPLETE, pf->state))
 			ice_init_phy_user_cfg(pi);
@@ -4225,6 +4261,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	ice_init_link_dflt_override(pf->hw.port_info);
 
+	ice_check_module_power(pf, pf->hw.port_info->phy.link_info.link_cfg_err);
+
 	/* if media available, initialize PHY settings */
 	if (pf->hw.port_info->phy.link_info.link_info &
 	    ICE_AQ_MEDIA_AVAILABLE) {
@@ -6847,6 +6885,8 @@ int ice_open_internal(struct net_device *netdev)
 		return -EIO;
 	}
 
+	ice_check_module_power(pf, pi->phy.link_info.link_cfg_err);
+
 	/* Set PHY if there is media, otherwise, turn off PHY */
 	if (pi->phy.link_info.link_info & ICE_AQ_MEDIA_AVAILABLE) {
 		clear_bit(ICE_FLAG_NO_MEDIA, pf->flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index a925273c2cca..f322c8415a2c 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -146,6 +146,7 @@ struct ice_link_status {
 	u16 max_frame_size;
 	u16 link_speed;
 	u16 req_speeds;
+	u8 link_cfg_err;
 	u8 lse_ena;	/* Link Status Event notification */
 	u8 link_info;
 	u8 an_info;
-- 
2.20.1

