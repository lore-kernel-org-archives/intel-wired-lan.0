From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:51:00 -0800
Subject: [Intel-wired-lan] [PATCH S12 13/14] ice: Enable MAC anti-spoof by
 default
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch enables MAC anti-spoof by default, with creation of VF VSIs or
when the VF VSIs are being re-initialized.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 864007bc945e..d528640fc5b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -952,6 +952,7 @@ static int ice_vsi_init(struct ice_vsi *vsi, bool init_vsi)
 	if (!ctxt)
 		return -ENOMEM;
 
+	ctxt->info = vsi->info;
 	switch (vsi->type) {
 	case ICE_VSI_PF:
 		ctxt->flags = ICE_AQ_VSI_TYPE_PF;
@@ -978,6 +979,14 @@ static int ice_vsi_init(struct ice_vsi *vsi, bool init_vsi)
 	ctxt->info.sw_id = vsi->port_info->sw_id;
 	ice_vsi_setup_q_map(vsi, ctxt);
 
+	/* Enable MAC Antispoof with new VSI being initialized or updated */
+	if (vsi->type == ICE_VSI_VF && pf->vf[vsi->vf_id].spoofchk) {
+		ctxt->info.valid_sections |=
+			cpu_to_le16(ICE_AQ_VSI_PROP_SECURITY_VALID);
+		ctxt->info.sec_flags |=
+			ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF;
+	}
+
 	if (init_vsi) {
 		ret = ice_add_vsi(hw, vsi->idx, ctxt, NULL);
 		if (ret) {
-- 
2.14.5

