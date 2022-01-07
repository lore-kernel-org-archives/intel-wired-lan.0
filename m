From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 7 Jan 2022 11:02:06 +0300
Subject: [Intel-wired-lan] [PATCH net] ice: fix an error code in
 ice_cfg_phy_fec()
Message-ID: <20220107080206.GI22086@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Propagate the error code from ice_get_link_default_override() instead
of returning success.

Fixes: ea78ce4dab05 ("ice: add link lenient and default override support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Not tested!

 drivers/net/ethernet/intel/ice/ice_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2a1ee60e85f4..67343a1a43d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3321,7 +3321,8 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 	    !ice_fw_supports_report_dflt_cfg(hw)) {
 		struct ice_link_default_override_tlv tlv;
 
-		if (ice_get_link_default_override(&tlv, pi))
+		status = ice_get_link_default_override(&tlv, pi);
+		if (status)
 			goto out;
 
 		if (!(tlv.options & ICE_LINK_OVERRIDE_STRICT_MODE) &&
-- 
2.20.1

