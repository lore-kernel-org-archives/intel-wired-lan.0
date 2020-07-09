From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  9 Jul 2020 09:16:05 -0700
Subject: [Intel-wired-lan] [PATCH S49 06/15] ice: move auto FEC checks into
 ice_cfg_phy_fec()
In-Reply-To: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
Message-ID: <20200709161614.61098-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

The call to ice_cfg_phy_fec() requires the caller to perform certain
actions before calling it. Instead of imposing these preconditions move
the operations into the function and perform them ourselves.

Also, fix some style issues in nearby touched code.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 43 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_common.h  |  5 ++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 31 ++------------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 556fa1c9aee2..c41b598782cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2657,25 +2657,41 @@ ice_copy_phy_caps_to_cfg(struct ice_aqc_get_phy_caps_data *caps,
 
 /**
  * ice_cfg_phy_fec - Configure PHY FEC data based on FEC mode
+ * @pi: port information structure
  * @cfg: PHY configuration data to set FEC mode
  * @fec: FEC mode to configure
- *
- * Caller should copy ice_aqc_get_phy_caps_data.caps ICE_AQC_PHY_EN_AUTO_FEC
- * (bit 7) and ice_aqc_get_phy_caps_data.link_fec_options to cfg.caps
- * ICE_AQ_PHY_ENA_AUTO_FEC (bit 7) and cfg.link_fec_options before calling.
  */
-void
-ice_cfg_phy_fec(struct ice_aqc_set_phy_cfg_data *cfg, enum ice_fec_mode fec)
+enum ice_status
+ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
+		enum ice_fec_mode fec)
 {
+	struct ice_aqc_get_phy_caps_data *pcaps;
+	enum ice_status status;
+
+	if (!pi || !cfg)
+		return ICE_ERR_BAD_PTR;
+
+	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
+	if (!pcaps)
+		return ICE_ERR_NO_MEMORY;
+
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP, pcaps,
+				     NULL);
+	if (status)
+		goto out;
+
+	cfg->caps |= pcaps->caps & ICE_AQC_PHY_EN_AUTO_FEC;
+	cfg->link_fec_opt = pcaps->link_fec_options;
+
 	switch (fec) {
 	case ICE_FEC_BASER:
 		/* Clear RS bits, and AND BASE-R ability
 		 * bits and OR request bits.
 		 */
 		cfg->link_fec_opt &= ICE_AQC_PHY_FEC_10G_KR_40G_KR4_EN |
-				     ICE_AQC_PHY_FEC_25G_KR_CLAUSE74_EN;
+			ICE_AQC_PHY_FEC_25G_KR_CLAUSE74_EN;
 		cfg->link_fec_opt |= ICE_AQC_PHY_FEC_10G_KR_40G_KR4_REQ |
-				     ICE_AQC_PHY_FEC_25G_KR_REQ;
+			ICE_AQC_PHY_FEC_25G_KR_REQ;
 		break;
 	case ICE_FEC_RS:
 		/* Clear BASE-R bits, and AND RS ability
@@ -2683,7 +2699,7 @@ ice_cfg_phy_fec(struct ice_aqc_set_phy_cfg_data *cfg, enum ice_fec_mode fec)
 		 */
 		cfg->link_fec_opt &= ICE_AQC_PHY_FEC_25G_RS_CLAUSE91_EN;
 		cfg->link_fec_opt |= ICE_AQC_PHY_FEC_25G_RS_528_REQ |
-				     ICE_AQC_PHY_FEC_25G_RS_544_REQ;
+			ICE_AQC_PHY_FEC_25G_RS_544_REQ;
 		break;
 	case ICE_FEC_NONE:
 		/* Clear all FEC option bits. */
@@ -2692,8 +2708,17 @@ ice_cfg_phy_fec(struct ice_aqc_set_phy_cfg_data *cfg, enum ice_fec_mode fec)
 	case ICE_FEC_AUTO:
 		/* AND auto FEC bit, and all caps bits. */
 		cfg->caps &= ICE_AQC_PHY_CAPS_MASK;
+		cfg->link_fec_opt |= pcaps->link_fec_options;
+		break;
+	default:
+		status = ICE_ERR_PARAM;
 		break;
 	}
+
+out:
+	kfree(pcaps);
+
+	return status;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index d1238f43e872..2f912c671e6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -103,8 +103,9 @@ ice_aq_set_phy_cfg(struct ice_hw *hw, u8 lport,
 enum ice_status
 ice_set_fc(struct ice_port_info *pi, u8 *aq_failures,
 	   bool ena_auto_link_update);
-void
-ice_cfg_phy_fec(struct ice_aqc_set_phy_cfg_data *cfg, enum ice_fec_mode fec);
+enum ice_status
+ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
+		enum ice_fec_mode fec);
 void
 ice_copy_phy_caps_to_cfg(struct ice_aqc_get_phy_caps_data *caps,
 			 struct ice_aqc_set_phy_cfg_data *cfg);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c2291cf4dc6e..4567b0175712 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -968,7 +968,6 @@ static int ice_set_fec_cfg(struct net_device *netdev, enum ice_fec_mode req_fec)
 	struct ice_aqc_set_phy_cfg_data config = { 0 };
 	struct ice_aqc_get_phy_caps_data *caps;
 	struct ice_vsi *vsi = np->vsi;
-	u8 sw_cfg_caps, sw_cfg_fec;
 	struct ice_port_info *pi;
 	enum ice_status status;
 	int err = 0;
@@ -997,36 +996,12 @@ static int ice_set_fec_cfg(struct net_device *netdev, enum ice_fec_mode req_fec)
 
 	/* Copy SW configuration returned from PHY caps to PHY config */
 	ice_copy_phy_caps_to_cfg(caps, &config);
-	sw_cfg_caps = caps->caps;
-	sw_cfg_fec = caps->link_fec_options;
 
-	/* Get toloplogy caps, then copy PHY FEC topoloy caps to PHY config */
-	memset(caps, 0, sizeof(*caps));
+	ice_cfg_phy_fec(pi, &config, req_fec);
+	config.caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
 
-	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP,
-				     caps, NULL);
-	if (status) {
+	if (ice_aq_set_phy_cfg(pi->hw, pi->lport, &config, NULL))
 		err = -EAGAIN;
-		goto done;
-	}
-
-	config.caps |= (caps->caps & ICE_AQC_PHY_EN_AUTO_FEC);
-	config.link_fec_opt = caps->link_fec_options;
-
-	ice_cfg_phy_fec(&config, req_fec);
-
-	/* If FEC mode has changed, then set PHY configuration and enable AN. */
-	if ((config.caps & ICE_AQ_PHY_ENA_AUTO_FEC) !=
-	    (sw_cfg_caps & ICE_AQC_PHY_EN_AUTO_FEC) ||
-	    config.link_fec_opt != sw_cfg_fec) {
-		if (caps->caps & ICE_AQC_PHY_AN_MODE)
-			config.caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
-
-		status = ice_aq_set_phy_cfg(pi->hw, pi->lport, &config, NULL);
-
-		if (status)
-			err = -EAGAIN;
-	}
 
 done:
 	kfree(caps);
-- 
2.20.1

