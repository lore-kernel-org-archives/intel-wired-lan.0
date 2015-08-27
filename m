From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:38 -0400
Subject: [Intel-wired-lan] [next PATCH S12 10/15] i40e: Fix for extra Flow
	Director filter in table after error
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes a problem where the pf's fdir filter table would have an
entry that the hw was unable to add. This notification happens in the hot
path, so instead of trying to fix it then, we note the location in the
failure case and delete it during regular fdir subtask callback. Without
this patch, a case can occur where an invalid entry gets replayed and a
valid one is not.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I67831c183b5d0309876de807cc434809b74c9cb7
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index edda619..877fab3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -412,6 +412,7 @@ struct i40e_pf {
 	u32 npar_min_bw;
 
 	u32 ioremap_len;
+	u32 fd_inv;
 };
 
 struct i40e_mac_filter {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 34c6796..6cc0fa0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5404,7 +5404,9 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf)
  **/
 void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 {
+	struct i40e_fdir_filter *filter;
 	u32 fcnt_prog, fcnt_avail;
+	struct hlist_node *node;
 
 	if (test_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state))
 		return;
@@ -5433,6 +5435,18 @@ void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 				dev_info(&pf->pdev->dev, "ATR is being enabled since we have space in the table now\n");
 		}
 	}
+
+	/* if hw had a problem adding a filter, delete it */
+	if (pf->fd_inv > 0) {
+		hlist_for_each_entry_safe(filter, node,
+					  &pf->fdir_filter_list, fdir_node) {
+			if (filter->fd_id == pf->fd_inv) {
+				hlist_del(&filter->fdir_node);
+				kfree(filter);
+				pf->fdir_pf_active_filters--;
+			}
+		}
+	}
 }
 
 #define I40E_MIN_FD_FLUSH_INTERVAL 10
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 79c8f71..4232217 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -465,10 +465,11 @@ static void i40e_fd_handle_status(struct i40e_ring *rx_ring,
 		I40E_RX_PROG_STATUS_DESC_QW1_ERROR_SHIFT;
 
 	if (error == BIT(I40E_RX_PROG_STATUS_DESC_FD_TBL_FULL_SHIFT)) {
+		pf->fd_inv = le32_to_cpu(rx_desc->wb.qword0.hi_dword.fd_id);
 		if ((rx_desc->wb.qword0.hi_dword.fd_id != 0) ||
 		    (I40E_DEBUG_FD & pf->hw.debug_mask))
 			dev_warn(&pdev->dev, "ntuple filter loc = %d, could not be added\n",
-				 rx_desc->wb.qword0.hi_dword.fd_id);
+				 pf->fd_inv);
 
 		/* Check if the programming error is for ATR.
 		 * If so, auto disable ATR and set a state for
-- 
1.9.3

