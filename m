From: Brett Creeley <brett.creeley@intel.com>
Date: Tue, 27 Jul 2021 16:15:48 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Add support to print error on PHY FW
 load failure
Message-ID: <20210727231548.50360-1-brett.creeley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some devices have support for loading the PHY FW and in some cases this
can fail. When this fails, the FW will set the corresponding bit in the
link info structure. Also, the FW will send a link event if the correct
link event mask bit is set. Add support for printing an error message
when the PHY FW load fails during any link configuration flow and the
link event flow.

Since ice_check_module_power() is already doing something very similar
add a new function ice_check_link_cfg_err() so any failures reported in
the link info's link_cfg_err member can be printed in this one function.

Also, add the new ICE_FLAG_PHY_FW_LOAD_FAILED bit to the PF's flags so
we don't constantly print this error message during link polling if the
value never changed.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 49 +++++++++++++++++--
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index be5ce0dfc9e1..5517e13bcba1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -403,6 +403,7 @@ enum ice_pf_flags {
 	ICE_FLAG_NO_MEDIA,
 	ICE_FLAG_FW_LLDP_AGENT,
 	ICE_FLAG_MOD_POWER_UNSUPPORTED,
+	ICE_FLAG_PHY_FW_LOAD_FAILED,
 	ICE_FLAG_ETHTOOL_CTXT,		/* set when ethtool holds RTNL lock */
 	ICE_FLAG_LEGACY_RX,
 	ICE_FLAG_VF_TRUE_PROMISC_ENA,
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 012af71dcbff..f05d78319d11 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1222,6 +1222,7 @@ struct ice_aqc_set_event_mask {
 #define ICE_AQ_LINK_EVENT_AN_COMPLETED		BIT(7)
 #define ICE_AQ_LINK_EVENT_MODULE_QUAL_FAIL	BIT(8)
 #define ICE_AQ_LINK_EVENT_PORT_TX_SUSPENDED	BIT(9)
+#define ICE_AQ_LINK_EVENT_PHY_FW_LOAD_FAIL      BIT(12)
 	u8	reserved1[6];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4f5ce08b2624..fbb84709962e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -893,6 +893,29 @@ static void ice_set_dflt_mib(struct ice_pf *pf)
 	kfree(lldpmib);
 }
 
+/**
+ * ice_check_phy_fw_load - check if PHY FW load failed
+ * @pf: pointer to PF struct
+ * @link_cfg_err: bitmap from the link info structure
+ *
+ * check if external PHY FW load failed and print an error message if it did
+ */
+static void ice_check_phy_fw_load(struct ice_pf *pf, u8 link_cfg_err)
+{
+	if (!(link_cfg_err & ICE_AQ_LINK_EVENT_PHY_FW_LOAD_FAIL)) {
+		clear_bit(ICE_FLAG_PHY_FW_LOAD_FAILED, pf->flags);
+		return;
+	}
+
+	if (test_bit(ICE_FLAG_PHY_FW_LOAD_FAILED, pf->flags))
+		return;
+
+	if (link_cfg_err & ICE_AQ_LINK_EVENT_PHY_FW_LOAD_FAIL) {
+		dev_err(ice_pf_to_dev(pf), "Device failed to load the FW for the external PHY. Please download and install the latest NVM for your device and try again\n");
+		set_bit(ICE_FLAG_PHY_FW_LOAD_FAILED, pf->flags);
+	}
+}
+
 /**
  * ice_check_module_power
  * @pf: pointer to PF struct
@@ -925,6 +948,20 @@ static void ice_check_module_power(struct ice_pf *pf, u8 link_cfg_err)
 	}
 }
 
+/**
+ * ice_check_link_cfg_err - check if link configuration failed
+ * @pf: pointer to the PF struct
+ * @link_cfg_err: bitmap from the link info structure
+ *
+ * print if any link configuration failure happens due to the value in the
+ * link_cfg_err parameter in the link info structure
+ */
+static void ice_check_link_cfg_err(struct ice_pf *pf, u8 link_cfg_err)
+{
+	ice_check_module_power(pf, link_cfg_err);
+	ice_check_phy_fw_load(pf, link_cfg_err);
+}
+
 /**
  * ice_link_event - process the link event
  * @pf: PF that the link event is associated with
@@ -960,7 +997,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 			pi->lport, ice_stat_str(status),
 			ice_aq_str(pi->hw->adminq.sq_last_status));
 
-	ice_check_module_power(pf, pi->phy.link_info.link_cfg_err);
+	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
 
 	/* Check if the link state is up after updating link info, and treat
 	 * this event as an UP event since the link is actually UP now.
@@ -1041,7 +1078,8 @@ static int ice_init_link_events(struct ice_port_info *pi)
 	u16 mask;
 
 	mask = ~((u16)(ICE_AQ_LINK_EVENT_UPDOWN | ICE_AQ_LINK_EVENT_MEDIA_NA |
-		       ICE_AQ_LINK_EVENT_MODULE_QUAL_FAIL));
+		       ICE_AQ_LINK_EVENT_MODULE_QUAL_FAIL |
+		       ICE_AQ_LINK_EVENT_PHY_FW_LOAD_FAIL));
 
 	if (ice_aq_set_event_mask(pi->hw, pi->lport, mask, NULL)) {
 		dev_dbg(ice_hw_to_dev(pi->hw), "Failed to set link event mask for port %d\n",
@@ -2112,7 +2150,7 @@ static void ice_check_media_subtask(struct ice_pf *pf)
 	if (err)
 		return;
 
-	ice_check_module_power(pf, pi->phy.link_info.link_cfg_err);
+	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
 
 	if (pi->phy.link_info.link_info & ICE_AQ_MEDIA_AVAILABLE) {
 		if (!test_bit(ICE_PHY_INIT_COMPLETE, pf->state))
@@ -4467,7 +4505,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	ice_init_link_dflt_override(pf->hw.port_info);
 
-	ice_check_module_power(pf, pf->hw.port_info->phy.link_info.link_cfg_err);
+	ice_check_link_cfg_err(pf,
+			       pf->hw.port_info->phy.link_info.link_cfg_err);
 
 	/* if media available, initialize PHY settings */
 	if (pf->hw.port_info->phy.link_info.link_info &
@@ -7181,7 +7220,7 @@ int ice_open_internal(struct net_device *netdev)
 		return -EIO;
 	}
 
-	ice_check_module_power(pf, pi->phy.link_info.link_cfg_err);
+	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
 
 	/* Set PHY if there is media, otherwise, turn off PHY */
 	if (pi->phy.link_info.link_info & ICE_AQ_MEDIA_AVAILABLE) {
-- 
2.26.3

