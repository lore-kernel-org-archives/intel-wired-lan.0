From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:52 -0800
Subject: [Intel-wired-lan] [PATCH S12 05/14] ice : Ensure only valid bits
 are set in ice_aq_set_phy_cfg
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chinh T Cao <chinh.t.cao@intel.com>

In the ice_aq_set_phy_cfg AQ command, the 16.4 bit is reserved. This
patch will make sure that this bit will never be set to 1.

Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  5 +++--
 drivers/net/ethernet/intel/ice/ice_common.c     | 11 +++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h       |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 242c78469181..8ff438968199 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -953,8 +953,9 @@ struct ice_aqc_set_phy_cfg_data {
 	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
 	__le64 phy_type_high; /* Use values from ICE_PHY_TYPE_HIGH_* */
 	u8 caps;
-#define ICE_AQ_PHY_ENA_TX_PAUSE_ABILITY		BIT(0)
-#define ICE_AQ_PHY_ENA_RX_PAUSE_ABILITY		BIT(1)
+#define ICE_AQ_PHY_ENA_VALID_MASK	ICE_M(0xef, 0)
+#define ICE_AQ_PHY_ENA_TX_PAUSE_ABILITY	BIT(0)
+#define ICE_AQ_PHY_ENA_RX_PAUSE_ABILITY	BIT(1)
 #define ICE_AQ_PHY_ENA_LOW_POWER	BIT(2)
 #define ICE_AQ_PHY_ENA_LINK		BIT(3)
 #define ICE_AQ_PHY_ENA_AUTO_LINK_UPDT	BIT(5)
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 63f003441300..2dc5c3249e12 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1929,6 +1929,15 @@ ice_aq_set_phy_cfg(struct ice_hw *hw, u8 lport,
 	if (!cfg)
 		return ICE_ERR_PARAM;
 
+	/* Ensure that only valid bits of cfg->caps can be turned on. */
+	if (cfg->caps & ~ICE_AQ_PHY_ENA_VALID_MASK) {
+		ice_debug(hw, ICE_DBG_PHY,
+			  "Invalid bit is set in ice_aqc_set_phy_cfg_data->caps : 0x%x\n",
+			  cfg->caps);
+
+		cfg->caps &= ICE_AQ_PHY_ENA_VALID_MASK;
+	}
+
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_phy_cfg);
 	desc.params.set_phy.lport_num = lport;
 	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
@@ -2027,8 +2036,10 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	/* clear the old pause settings */
 	cfg.caps = pcaps->caps & ~(ICE_AQC_PHY_EN_TX_LINK_PAUSE |
 				   ICE_AQC_PHY_EN_RX_LINK_PAUSE);
+
 	/* set the new capabilities */
 	cfg.caps |= pause_mask;
+
 	/* If the capabilities have changed, then set the new config */
 	if (cfg.caps != pcaps->caps) {
 		int retry_count, retry_max = 10;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 17086d5b5c33..560b0d2d46ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -24,6 +24,7 @@ static inline bool ice_is_tc_ena(u8 bitmap, u8 tc)
 /* debug masks - set these bits in hw->debug_mask to control output */
 #define ICE_DBG_INIT		BIT_ULL(1)
 #define ICE_DBG_LINK		BIT_ULL(4)
+#define ICE_DBG_PHY		BIT_ULL(5)
 #define ICE_DBG_QCTX		BIT_ULL(6)
 #define ICE_DBG_NVM		BIT_ULL(7)
 #define ICE_DBG_LAN		BIT_ULL(8)
-- 
2.14.5

