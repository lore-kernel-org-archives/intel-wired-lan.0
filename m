From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 18 Aug 2021 18:20:28 -0400
Subject: [Intel-wired-lan] [PATCH net-next] ice: handle MAC delete command
 on PR
Message-ID: <20210818222028.14820-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Order of VIRTCHNL_OP_ADD_ETH_ADDR and VIRTCHNL_OP_DEL_ETH_ADDR cannot be
guarantee. Because of that mac delete command on PR should be handled
in the case of communication with legacy VF driver. If there is cached
MAC address driver should update dev_lan and hw_lan with value from
legacy_last_added_umac.

Not handling this case leads to situation when VF MAC is changed but VF
MAC showing on PF not.

This happen only in switchdev mode, because in switchdev mode VF default
ops are changed.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
This commit should be squashed with "ice: allow process vf opcodes in
different ways"
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 0ed7f1ec6172..ed99f3a348bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -3831,6 +3831,26 @@ static bool ice_is_legacy_umac_expired(struct ice_time_mac *last_added_umac)
 				      ICE_LEGACY_VF_MAC_CHANGE_EXPIRE_TIME);
 }
 
+/**
+ * ice_update_legacy_cached_mac - update cached hardware MAC for legacy VF
+ * @vf: VF to update
+ * @vc_ether_addr: structure from VIRTCHNL with MAC to check
+ *
+ * only update cached hardware MAC for legacy VF drivers on delete
+ * because we cannot guarantee order/type of MAC from the VF driver
+ */
+static void
+ice_update_legacy_cached_mac(struct ice_vf *vf,
+			     struct virtchnl_ether_addr *vc_ether_addr)
+{
+	if (!ice_is_vc_addr_legacy(vc_ether_addr) ||
+	    ice_is_legacy_umac_expired(&vf->legacy_last_added_umac))
+		return;
+
+	ether_addr_copy(vf->dev_lan_addr.addr, vf->legacy_last_added_umac.addr);
+	ether_addr_copy(vf->hw_lan_addr.addr, vf->legacy_last_added_umac.addr);
+}
+
 /**
  * ice_vfhw_mac_del - update the VF's cached hardware MAC if allowed
  * @vf: VF to update
@@ -3852,16 +3872,7 @@ ice_vfhw_mac_del(struct ice_vf *vf, struct virtchnl_ether_addr *vc_ether_addr)
 	 */
 	eth_zero_addr(vf->dev_lan_addr.addr);
 
-	/* only update cached hardware MAC for legacy VF drivers on delete
-	 * because we cannot guarantee order/type of MAC from the VF driver
-	 */
-	if (ice_is_vc_addr_legacy(vc_ether_addr) &&
-	    !ice_is_legacy_umac_expired(&vf->legacy_last_added_umac)) {
-		ether_addr_copy(vf->dev_lan_addr.addr,
-				vf->legacy_last_added_umac.addr);
-		ether_addr_copy(vf->hw_lan_addr.addr,
-				vf->legacy_last_added_umac.addr);
-	}
+	ice_update_legacy_cached_mac(vf, vc_ether_addr);
 }
 
 /**
@@ -4527,10 +4538,16 @@ static int ice_vc_repr_add_mac(struct ice_vf *vf, u8 *msg)
  * @msg: virtchannel message
  *
  * Respond with success to not break normal VF flow.
+ * For legacy VF driver try to update cached MAC address.
  */
 static int
 ice_vc_repr_del_mac(struct ice_vf __always_unused *vf, u8 __always_unused *msg)
 {
+	struct virtchnl_ether_addr_list *al =
+		(struct virtchnl_ether_addr_list *)msg;
+
+	ice_update_legacy_cached_mac(vf, &al->list[0]);
+
 	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DEL_ETH_ADDR,
 				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
 }
-- 
2.31.1

