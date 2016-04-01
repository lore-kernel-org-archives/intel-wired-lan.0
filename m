From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Apr 2016 16:17:39 -0700
Subject: [Intel-wired-lan] [PATCH v1 9/9] fm10k: Reset multicast mode when
	deleting lport
In-Reply-To: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1459552659-22959-10-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Deleting lport when multicast mode is configured to
FM10K_XCAST_MODE_ALLMULTI or FM10K_XCAST_MODE_PROMISC will result in
generating orphaned multicast-group entries in the switch manager.
Before deleting the lport, reset multicast mode to FM10K_XCAST_MODE_NONE
to flush out these multicast-group entries.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 88d5acf484d0..2105cb8d31cc 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -488,6 +488,10 @@ static s32 fm10k_update_lport_state_pf(struct fm10k_hw *hw, u16 glort,
 	if (!fm10k_glort_valid_pf(hw, glort))
 		return FM10K_ERR_PARAM;
 
+	/* reset multicast mode if deleting lport */
+	if (!enable)
+		fm10k_update_xcast_mode_pf(hw, glort, FM10K_XCAST_MODE_NONE);
+
 	/* construct the lport message from the 2 pieces of data we have */
 	lport_msg = ((u32)count << 16) | glort;
 
-- 
2.8.0.rc1.177.g5628860

