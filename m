From: Alice Michael <alice.michael@intel.com>
Date: Mon,  7 Aug 2017 10:28:34 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V6 07/12] i40e: ensure reset
	occurs when disabling VF
In-Reply-To: <20170807142839.60975-1-alice.michael@intel.com>
References: <20170807142839.60975-1-alice.michael@intel.com>
Message-ID: <20170807142839.60975-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

It is possible although rare that we may not reset when
i40e_vc_disable_vf() is called. This can lead to some weird
circumstances with some values not being properly set. Modify
i40e_reset_vf() to return a code indicating whether it reset or not.

Now, i40e_vc_disable_vf() can wait until a reset actually occurs. If it
fails to free up within a reasonable timeframe we'll display a warning
message.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 42 +++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  4 +--
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 81b405f..7d5362d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -156,12 +156,28 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
  * i40e_vc_disable_vf
  * @vf: pointer to the VF info
  *
- * Disable the VF through a SW reset
+ * Disable the VF through a SW reset.
  **/
 static inline void i40e_vc_disable_vf(struct i40e_vf *vf)
 {
+	int i;
+
 	i40e_vc_notify_vf_reset(vf);
-	i40e_reset_vf(vf, false);
+
+	/* We want to ensure that an actual reset occurs initiated after this
+	 * function was called. However, we do not want to wait forever, so
+	 * we'll give a reasonable time and print a message if we failed to
+	 * ensure a reset.
+	 */
+	for (i = 0; i < 20; i++) {
+		if (i40e_reset_vf(vf, false))
+			return;
+		usleep_range(10000, 20000);
+	}
+
+	dev_warn(&vf->pf->pdev->dev,
+		 "Failed to initiate reset for VF %d after 200 milliseconds\n",
+		 vf->vf_id);
 }
 
 /**
@@ -1048,9 +1064,9 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * reset the VF
+ * Returns true if the VF is reset, false otherwise.
  **/
-void i40e_reset_vf(struct i40e_vf *vf, bool flr)
+bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
@@ -1058,9 +1074,11 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 	u32 reg;
 	int i;
 
-	/* If VFs have been disabled, there is no need to reset */
+	/* If the VFs have been disabled, this means something else is
+	 * resetting the VF, so we shouldn't continue.
+	 */
 	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state))
-		return;
+		return false;
 
 	i40e_trigger_vf_reset(vf, flr);
 
@@ -1097,6 +1115,8 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 
 	i40e_flush(hw);
 	clear_bit(__I40E_VF_DISABLE, pf->state);
+
+	return true;
 }
 
 /**
@@ -1108,8 +1128,10 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
  * VF, then do all the waiting in one chunk, and finally finish restoring each
  * VF after the wait. This is useful during PF routines which need to reset
  * all VFs, as otherwise it must perform these resets in a serialized fashion.
+ *
+ * Returns true if any VFs were reset, and false otherwise.
  **/
-void i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
+bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 {
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vf *vf;
@@ -1118,11 +1140,11 @@ void i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 
 	/* If we don't have any VFs, then there is nothing to reset */
 	if (!pf->num_alloc_vfs)
-		return;
+		return false;
 
 	/* If VFs have been disabled, there is no need to reset */
 	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state))
-		return;
+		return false;
 
 	/* Begin reset on all VFs at once */
 	for (v = 0; v < pf->num_alloc_vfs; v++)
@@ -1197,6 +1219,8 @@ void i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 
 	i40e_flush(hw);
 	clear_bit(__I40E_VF_DISABLE, pf->state);
+
+	return true;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 5111d05..5ea42ad 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -122,8 +122,8 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs);
 int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 			   u32 v_retval, u8 *msg, u16 msglen);
 int i40e_vc_process_vflr_event(struct i40e_pf *pf);
-void i40e_reset_vf(struct i40e_vf *vf, bool flr);
-void i40e_reset_all_vfs(struct i40e_pf *pf, bool flr);
+bool i40e_reset_vf(struct i40e_vf *vf, bool flr);
+bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr);
 void i40e_vc_notify_vf_reset(struct i40e_vf *vf);
 
 /* VF configuration related iplink handlers */
-- 
2.9.4

