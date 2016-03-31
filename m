From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 31 Mar 2016 09:52:30 -0700
Subject: [Intel-wired-lan] [PATCH net] fm10k: fix multi-bit VLAN update
	requests from VF
Message-ID: <1459443150-3461-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The VF uses a multi-bit update request to clear unused VLANs whenever it
resets. However, an accident in a previous refector broke multi-bit
updates for VFs, due to misreading a comment in fm10k_vf.c and
attempting to reduce code duplication. The problem occurs because
a multi-bit request has a non-zero length, and the PF would simply drop
any request with the upper 16 bits set.

We can't simply remove the check of the upper 16 bits and the call to
fm10k_iov_select vid, because this would remove the checks for default
VID and for ensuring no other VLANs can be enabled except pf_vid when it
has been set. To resolve that issue, this revision uses the
iov_select_vid when we have a single-bit update, and denies any
multi-bit update when the VLAN was administratively set by the PF. This
should be ok since the PF properly updates VLAN_TABLE when it assigns
the PF vid. This ensures that requests to add or remove the PF vid work
as expected, but a rogue VF could not use the multi-bit update as
a loophole to attempt receiving traffic on other VLANs.

Reported-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Notes:
    Testing-hints:
      This patch fixes HSD 7661917
    
    This should probably be backported onto the net tree as it is a possible
    security issue.

 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 30 +++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index ecc99f9d2cce..d37e94df8828 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1223,18 +1223,32 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		if (err)
 			return err;
 
-		/* verify upper 16 bits are zero */
-		if (vid >> 16)
-			return FM10K_ERR_PARAM;
-
 		set = !(vid & FM10K_VLAN_CLEAR);
 		vid &= ~FM10K_VLAN_CLEAR;
 
-		err = fm10k_iov_select_vid(vf_info, (u16)vid);
-		if (err < 0)
-			return err;
+		/* if the length field has been set, this is a multi-bit
+		 * update request. For multi-bit requests, simply disallow
+		 * them when the pf_vid has been set. In this case, the PF
+		 * should have already cleared the VLAN_TABLE, and if we
+		 * allowed them, it could allow a rogue VF to receive traffic
+		 * on a VLAN it was not assigned. In the single-bit case, we
+		 * need to modify requests for VLAN 0 to use the default PF or
+		 * SW vid when assigned.
+		 */
 
-		vid = err;
+		if (vid >> 16) {
+			/* prevent multi-bit requests when PF has
+			 * administratively set the VLAN for this VF
+			 */
+			if (vf_info->pf_vid)
+				return FM10K_ERR_PARAM;
+		} else {
+			err = fm10k_iov_select_vid(vf_info, (u16)vid);
+			if (err < 0)
+				return err;
+
+			vid = err;
+		}
 
 		/* update VSI info for VF in regards to VLAN table */
 		err = hw->mac.ops.update_vlan(hw, vid, vf_info->vsi, set);
-- 
2.8.0.rc1.177.g5628860

