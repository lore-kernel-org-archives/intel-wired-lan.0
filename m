From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  9 Jul 2020 09:16:10 -0700
Subject: [Intel-wired-lan] [PATCH S49 11/15] ice: update reporting of
 autoneg capabilities
In-Reply-To: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
Message-ID: <20200709161614.61098-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Firmware now reports AN28, AN32, and AN73. Add a helper and check these new
values and report PHY autoneg capability.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  3 +++
 drivers/net/ethernet/intel/ice/ice_common.c     | 15 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c    |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c       |  8 ++++++--
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 9a57fabc449f..59f876300e96 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -963,6 +963,9 @@ struct ice_aqc_get_phy_caps_data {
 #define ICE_AQC_PHY_CAPS_MASK				ICE_M(0xff, 0)
 	u8 low_power_ctrl;
 #define ICE_AQC_PHY_EN_D3COLD_LOW_POWER_AUTONEG		BIT(0)
+#define ICE_AQC_PHY_AN_EN_CLAUSE28			BIT(1)
+#define ICE_AQC_PHY_AN_EN_CLAUSE73			BIT(2)
+#define ICE_AQC_PHY_AN_EN_CLAUSE37			BIT(3)
 	__le16 eee_cap;
 #define ICE_AQC_PHY_EEE_EN_100BASE_TX			BIT(0)
 #define ICE_AQC_PHY_EEE_EN_1000BASE_T			BIT(1)
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f5b92a17c5d6..6a64d6e77357 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4237,3 +4237,18 @@ ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 
 	return status;
 }
+
+/**
+ * ice_is_phy_caps_an_enabled - check if PHY capabilities autoneg is enabled
+ * @caps: get PHY capability data
+ */
+bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps)
+{
+	if (caps->caps & ICE_AQC_PHY_AN_MODE ||
+	    caps->low_power_ctrl & (ICE_AQC_PHY_AN_EN_CLAUSE28 |
+				    ICE_AQC_PHY_AN_EN_CLAUSE73 |
+				    ICE_AQC_PHY_AN_EN_CLAUSE37))
+		return true;
+
+	return false;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 1b8b02bb4399..33a681a75439 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -104,6 +104,7 @@ bool ice_fw_supports_link_override(struct ice_hw *hw);
 enum ice_status
 ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 			      struct ice_port_info *pi);
+bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
 
 enum ice_fc_mode ice_caps_to_fc_mode(u8 caps);
 enum ice_fec_mode ice_caps_to_fec_mode(u8 caps, u8 fec_options);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 60abd261b8bf..06b93e97892d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2987,8 +2987,8 @@ ice_get_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 	if (status)
 		goto out;
 
-	pause->autoneg = ((pcaps->caps & ICE_AQC_PHY_AN_MODE) ?
-			AUTONEG_ENABLE : AUTONEG_DISABLE);
+	pause->autoneg = ice_is_phy_caps_an_enabled(pcaps) ? AUTONEG_ENABLE :
+							     AUTONEG_DISABLE;
 
 	if (dcbx_cfg->pfc.pfcena)
 		/* PFC enabled so report LFC as off */
@@ -3056,8 +3056,8 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 		return -EIO;
 	}
 
-	is_an = ((pcaps->caps & ICE_AQC_PHY_AN_MODE) ?
-			AUTONEG_ENABLE : AUTONEG_DISABLE);
+	is_an = ice_is_phy_caps_an_enabled(pcaps) ? AUTONEG_ENABLE :
+						    AUTONEG_DISABLE;
 
 	kfree(pcaps);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a44273769264..7ea99f164d18 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -612,6 +612,7 @@ static void ice_print_topo_conflict(struct ice_vsi *vsi)
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 {
 	struct ice_aqc_get_phy_caps_data *caps;
+	const char *an_advertised;
 	enum ice_status status;
 	const char *fec_req;
 	const char *speed;
@@ -710,6 +711,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	caps = kzalloc(sizeof(*caps), GFP_KERNEL);
 	if (!caps) {
 		fec_req = "Unknown";
+		an_advertised = "Unknown";
 		goto done;
 	}
 
@@ -718,6 +720,8 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	if (status)
 		netdev_info(vsi->netdev, "Get phy capability failed.\n");
 
+	an_advertised = ice_is_phy_caps_an_enabled(caps) ? "On" : "Off";
+
 	if (caps->link_fec_options & ICE_AQC_PHY_FEC_25G_RS_528_REQ ||
 	    caps->link_fec_options & ICE_AQC_PHY_FEC_25G_RS_544_REQ)
 		fec_req = "RS-FEC";
@@ -730,8 +734,8 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	kfree(caps);
 
 done:
-	netdev_info(vsi->netdev, "NIC Link is up %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
-		    speed, fec_req, fec, an, fc);
+	netdev_info(vsi->netdev, "NIC Link is up %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg Advertised: %s, Autoneg Negotiated: %s, Flow Control: %s\n",
+		    speed, fec_req, fec, an_advertised, an, fc);
 	ice_print_topo_conflict(vsi);
 }
 
-- 
2.20.1

