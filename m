From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 19 Jun 2015 16:37:39 -0700
Subject: [Intel-wired-lan] [net-next 10/10] fm10k: fix iov_msg_mac_vlan_pf
	VID checks
In-Reply-To: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434757059-3384-10-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The VF will send a message to request multicast addresses with the
default vid. In the current code, if the PF has statically assigned a
VLAN to a VF, then the VF will not get the multicast addresses. Fix up
all of the various vlan messages to use identical checks (since each
check was different). Also use set as a variable, so that it simplifies
our check for whether vlan matches the pf_vid.

The new logic will allow set of a vlan if it is zero, automatically
converting to the default vid. Otherwise it will allow setting the PF
vid, or any VLAN if PF has not statically assigned a VLAN. This is
consistent behavior, and allows VF to request either 0 or the
default_vid without silently failing.

Note that we need the check for zero since VFs might not get the default
VID message in time to actually request non-zero VLANs.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 37 +++++++++++++++++++----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index d806d87a6192..9bb57531b5db 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1168,9 +1168,10 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 			      struct fm10k_mbx_info *mbx)
 {
 	struct fm10k_vf_info *vf_info = (struct fm10k_vf_info *)mbx;
-	int err = 0;
 	u8 mac[ETH_ALEN];
 	u32 *result;
+	int err = 0;
+	bool set;
 	u16 vlan;
 	u32 vid;
 
@@ -1186,19 +1187,25 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		if (err)
 			return err;
 
+		/* verify upper 16 bits are zero */
+		if (vid >> 16)
+			return FM10K_ERR_PARAM;
+
+		set = !(vid & FM10K_VLAN_CLEAR);
+		vid &= ~FM10K_VLAN_CLEAR;
+
 		/* if VLAN ID is 0, set the default VLAN ID instead of 0 */
-		if (!vid || (vid == FM10K_VLAN_CLEAR)) {
+		if (!vid) {
 			if (vf_info->pf_vid)
 				vid |= vf_info->pf_vid;
 			else
 				vid |= vf_info->sw_vid;
-		} else if (vid != vf_info->pf_vid) {
+		} else if (vf_info->pf_vid && vid != vf_info->pf_vid) {
 			return FM10K_ERR_PARAM;
 		}
 
 		/* update VSI info for VF in regards to VLAN table */
-		err = hw->mac.ops.update_vlan(hw, vid, vf_info->vsi,
-					      !(vid & FM10K_VLAN_CLEAR));
+		err = hw->mac.ops.update_vlan(hw, vid, vf_info->vsi, set);
 	}
 
 	if (!err && !!results[FM10K_MAC_VLAN_MSG_MAC]) {
@@ -1214,19 +1221,22 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		    memcmp(mac, vf_info->mac, ETH_ALEN))
 			return FM10K_ERR_PARAM;
 
+		set = !(vlan & FM10K_VLAN_CLEAR);
+		vlan &= ~FM10K_VLAN_CLEAR;
+
 		/* if VLAN ID is 0, set the default VLAN ID instead of 0 */
-		if (!vlan || (vlan == FM10K_VLAN_CLEAR)) {
+		if (!vlan) {
 			if (vf_info->pf_vid)
 				vlan |= vf_info->pf_vid;
 			else
 				vlan |= vf_info->sw_vid;
-		} else if (vf_info->pf_vid) {
+		} else if (vf_info->pf_vid && vlan != vf_info->pf_vid) {
 			return FM10K_ERR_PARAM;
 		}
 
 		/* notify switch of request for new unicast address */
-		err = hw->mac.ops.update_uc_addr(hw, vf_info->glort, mac, vlan,
-						 !(vlan & FM10K_VLAN_CLEAR), 0);
+		err = hw->mac.ops.update_uc_addr(hw, vf_info->glort,
+						 mac, vlan, set, 0);
 	}
 
 	if (!err && !!results[FM10K_MAC_VLAN_MSG_MULTICAST]) {
@@ -1241,19 +1251,22 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		if (!(vf_info->vf_flags & FM10K_VF_FLAG_MULTI_ENABLED))
 			return FM10K_ERR_PARAM;
 
+		set = !(vlan & FM10K_VLAN_CLEAR);
+		vlan &= ~FM10K_VLAN_CLEAR;
+
 		/* if VLAN ID is 0, set the default VLAN ID instead of 0 */
 		if (!vlan || (vlan == FM10K_VLAN_CLEAR)) {
 			if (vf_info->pf_vid)
 				vlan |= vf_info->pf_vid;
 			else
 				vlan |= vf_info->sw_vid;
-		} else if (vf_info->pf_vid) {
+		} else if (vf_info->pf_vid && vlan != vf_info->pf_vid) {
 			return FM10K_ERR_PARAM;
 		}
 
 		/* notify switch of request for new multicast address */
-		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort, mac, vlan,
-						 !(vlan & FM10K_VLAN_CLEAR));
+		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort,
+						 mac, vlan, set);
 	}
 
 	return err;
-- 
2.4.3

