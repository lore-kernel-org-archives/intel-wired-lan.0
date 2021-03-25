From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:13 -0700
Subject: [Intel-wired-lan] [PATCH S57 10/14] ice: Limit forced overrides
 based on FW version
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeb Cramer <jeb.j.cramer@intel.com>

Beyond a specific version of firmware, there is no need to provide
override values to the firmware when setting PHY capabilities.  In this
case, we do not need to indicate whether we're in Strict or Lenient Link
Mode.

In the case of translating capabilities to the configuration structure,
the module compliance enforcement is already correctly set by firmware,
so the extra code block is redundant.

Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8bbd28ddd56c..e93b1e40f627 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3013,17 +3013,6 @@ ice_copy_phy_caps_to_cfg(struct ice_port_info *pi,
 	cfg->link_fec_opt = caps->link_fec_options;
 	cfg->module_compliance_enforcement =
 		caps->module_compliance_enforcement;
-
-	if (ice_fw_supports_link_override(pi->hw)) {
-		struct ice_link_default_override_tlv tlv;
-
-		if (ice_get_link_default_override(&tlv, pi))
-			return;
-
-		if (tlv.options & ICE_LINK_OVERRIDE_STRICT_MODE)
-			cfg->module_compliance_enforcement |=
-				ICE_LINK_OVERRIDE_STRICT_MODE;
-	}
 }
 
 /**
@@ -3091,7 +3080,8 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 		break;
 	}
 
-	if (fec == ICE_FEC_AUTO && ice_fw_supports_link_override(pi->hw)) {
+	if (fec == ICE_FEC_AUTO && ice_fw_supports_link_override(hw) &&
+	    !ice_fw_supports_report_dflt_cfg(hw)) {
 		struct ice_link_default_override_tlv tlv;
 
 		if (ice_get_link_default_override(&tlv, pi))
-- 
2.20.1

