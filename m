From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  8 Mar 2018 14:52:09 -0800
Subject: [Intel-wired-lan] [S87 v5 5/7] i40e: factor out re-enable functions
 for ATR and SB
In-Reply-To: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180308225211.12254-5-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A future patch needs to expand on the logic for re-enabling ATR. Doing
so would cause some code to break the 80-character line limit.

To reduce the level of indentation, factor out helper functions for
re-enabling ATR and SB rules.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 48 +++++++++++++++++++----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0b45650b7e31..89bcfd1c3213 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8136,6 +8136,34 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf)
 	return fcnt_prog;
 }
 
+/**
+ * i40e_reenable_fdir_sb - Restore FDir SB capability
+ * @pf: board private structure
+ **/
+static void i40e_reenable_fdir_sb(struct i40e_pf *pf)
+{
+	if (pf->flags & I40E_FLAG_FD_SB_AUTO_DISABLED) {
+		pf->flags &= ~I40E_FLAG_FD_SB_AUTO_DISABLED;
+		if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
+		    (I40E_DEBUG_FD & pf->hw.debug_mask))
+			dev_info(&pf->pdev->dev, "FD Sideband/ntuple is being enabled since we have space in the table now\n");
+	}
+}
+
+/**
+ * i40e_reenable_fdir_atr - Restore FDir ATR capability
+ * @pf: board private structure
+ **/
+static void i40e_reenable_fdir_atr(struct i40e_pf *pf)
+{
+	if (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED) {
+		pf->flags &= ~I40E_FLAG_FD_ATR_AUTO_DISABLED;
+		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+		    (I40E_DEBUG_FD & pf->hw.debug_mask))
+			dev_info(&pf->pdev->dev, "ATR is being enabled since we have space in the table and there are no conflicting ntuple rules\n");
+	}
+}
+
 /**
  * i40e_delete_invalid_filter - Delete an invalid FDIR filter
  * @pf: board private structure
@@ -8199,28 +8227,16 @@ void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 	fcnt_avail = pf->fdir_pf_filter_count;
 	if ((fcnt_prog < (fcnt_avail - I40E_FDIR_BUFFER_HEAD_ROOM)) ||
 	    (pf->fd_add_err == 0) ||
-	    (i40e_get_current_atr_cnt(pf) < pf->fd_atr_cnt)) {
-		if (pf->flags & I40E_FLAG_FD_SB_AUTO_DISABLED) {
-			pf->flags &= ~I40E_FLAG_FD_SB_AUTO_DISABLED;
-			if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
-			    (I40E_DEBUG_FD & pf->hw.debug_mask))
-				dev_info(&pf->pdev->dev, "FD Sideband/ntuple is being enabled since we have space in the table now\n");
-		}
-	}
+	    (i40e_get_current_atr_cnt(pf) < pf->fd_atr_cnt))
+		i40e_reenable_fdir_sb(pf);
 
 	/* We should wait for even more space before re-enabling ATR.
 	 * Additionally, we cannot enable ATR as long as we still have TCP SB
 	 * rules active.
 	 */
 	if ((fcnt_prog < (fcnt_avail - I40E_FDIR_BUFFER_HEAD_ROOM_FOR_ATR)) &&
-	    (pf->fd_tcp4_filter_cnt == 0)) {
-		if (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED) {
-			pf->flags &= ~I40E_FLAG_FD_ATR_AUTO_DISABLED;
-			if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
-			    (I40E_DEBUG_FD & pf->hw.debug_mask))
-				dev_info(&pf->pdev->dev, "ATR is being enabled since we have space in the table and there are no conflicting ntuple rules\n");
-		}
-	}
+	    (pf->fd_tcp4_filter_cnt == 0))
+		i40e_reenable_fdir_atr(pf);
 
 	/* if hw had a problem adding a filter, delete it */
 	if (pf->fd_inv > 0) {
-- 
2.14.3

