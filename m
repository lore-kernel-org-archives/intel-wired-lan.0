From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 15:56:41 -0700
Subject: [Intel-wired-lan] [PATCH 15/15] fm10k: fix iov_msg_lport_state_pf
	issue
In-Reply-To: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
References: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433372201-12007-15-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When a VF issues an LPORT_STATE request to enable a port that is already
enabled, the PF will first disable the VF LPORT. Then it should
re-enable the VF again with the new requested settings. This ensures
that any switch rules are cleared by deleting the LPORT on the switch.
However, the flow is bugged because we actually check if the VF is
enabled at the end, and thus don't re-enable it. Fix the flow so that we
actually clear the enabled flags as part of our removal of the LPORT.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index ab81c00327b2..54d1cd97866f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1351,6 +1351,14 @@ s32 fm10k_iov_msg_lport_state_pf(struct fm10k_hw *hw, u32 **results,
 			err = fm10k_update_lport_state_pf(hw, vf_info->glort,
 							  1, false);
 
+		/* we need to clear VF_FLAG_ENABLED flags in order to ensure
+		 * that we actually re-enable the LPORT state below. Note that
+		 * this has no impact if the VF is already disabled, as the
+		 * flags are already cleared.
+		 */
+		if (!err)
+			vf_info->vf_flags = FM10K_VF_FLAG_CAPABLE(vf_info);
+
 		/* when enabling the port we should reset the rate limiters */
 		hw->iov.ops.configure_tc(hw, vf_info->vf_idx, vf_info->rate);
 
-- 
2.1.0

