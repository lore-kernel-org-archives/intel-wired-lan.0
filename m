From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:15 -0700
Subject: [Intel-wired-lan] [PATCH S18 02/15] ice: Preserve VLAN Rx stripping
 settings
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>

When Tx insertion is set, we are not accounting for the state of Rx
stripping.  This causes Rx stripping to be enabled any time Tx
insertion is changed, even when it's supposed to be disabled.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index bda6ade755c3..947730d74612 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1932,6 +1932,10 @@ int ice_vsi_manage_vlan_insertion(struct ice_vsi *vsi)
 	 */
 	ctxt->info.vlan_flags = ICE_AQ_VSI_VLAN_MODE_ALL;
 
+	/* Preserve existing VLAN strip setting */
+	ctxt->info.vlan_flags |= (vsi->info.vlan_flags &
+				  ICE_AQ_VSI_VLAN_EMOD_M);
+
 	ctxt->info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID);
 
 	status = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
-- 
2.20.1

