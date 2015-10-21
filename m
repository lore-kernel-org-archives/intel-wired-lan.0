From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:10 -0400
Subject: [Intel-wired-lan] [next PATCH S19 09/15] i40e/i40evf: Add comment
	to #endif
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Helin Zhang <helin.zhang@intel.com>

Add a comment to the #endif to more easily match it with its #if.

Signed-off-by: Helin Zhang <helin.zhang@intel.com>
Change-ID: I47eb0a60a17dc6d2f01a930e45006d2dc82e044f

---
Testing-hints: Verify code change is present, no functional change.
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 6584b6c..61a4979 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -2403,4 +2403,4 @@ struct i40e_aqc_debug_modify_internals {
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
 
-#endif
+#endif /* _I40E_ADMINQ_CMD_H_ */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index fcb9ef3..1c76389 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -2311,4 +2311,4 @@ struct i40e_aqc_debug_modify_internals {
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
 
-#endif
+#endif /* _I40E_ADMINQ_CMD_H_ */
-- 
1.9.3

