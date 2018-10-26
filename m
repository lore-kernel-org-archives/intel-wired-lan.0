From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:55 -0700
Subject: [Intel-wired-lan] [PATCH S8 06/16] ice: Fix flags for port VLAN
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-7-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

According to the spec, whenever insert PVID field is set, the VLAN
driver insertion mode should be set to 01b which isn't done currently.
Fix it.

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 9576b958622b..e71065f9d391 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -348,7 +348,7 @@ static int ice_vsi_set_pvid(struct ice_vsi *vsi, u16 vid)
 	struct ice_vsi_ctx ctxt = { 0 };
 	enum ice_status status;
 
-	ctxt.info.vlan_flags = ICE_AQ_VSI_VLAN_MODE_TAGGED |
+	ctxt.info.vlan_flags = ICE_AQ_VSI_VLAN_MODE_UNTAGGED |
 			       ICE_AQ_VSI_PVLAN_INSERT_PVID |
 			       ICE_AQ_VSI_VLAN_EMOD_STR;
 	ctxt.info.pvid = cpu_to_le16(vid);
-- 
2.14.3

