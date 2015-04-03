From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:07 -0700
Subject: [Intel-wired-lan] [net-next 17/25] fm10k: comment next_vf_mbx flow
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-17-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a header comment explaining why we have the somewhat crazy mailbox
flow. This flow is necessary as it prevents the PF<->SM mailbox from
being flooded by the VF messages, which normally trigger a message to
the PF. This helps prevent the case where we see a PF mailbox timeout.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 1071f38..ce361cf 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -113,6 +113,13 @@ s32 fm10k_iov_mbx(struct fm10k_intfc *interface)
 	/* lock the mailbox for transmit and receive */
 	fm10k_mbx_lock(interface);
 
+	/* Most VF messages sent to the PF cause the PF to respond by
+	 * requesting from the SM mailbox. This means that too many VF
+	 * messages processed at once could cause a mailbox timeout on the PF.
+	 * To prevent this, store a pointer to the next VF mbx to process. Use
+	 * that as the start of the loop so that we don't starve whichever VF
+	 * got ignored on the previous run.
+	 */
 process_mbx:
 	for (i = iov_data->next_vf_mbx ? : iov_data->num_vfs; i--;) {
 		struct fm10k_vf_info *vf_info = &iov_data->vf_info[i];
@@ -141,6 +148,10 @@ process_mbx:
 		mbx->ops.process(hw, mbx);
 	}
 
+	/* if we stopped processing mailboxes early, update next_vf_mbx.
+	 * Otherwise, reset next_vf_mbx, and restart loop so that we process
+	 * the remaining mailboxes we skipped at the start.
+	 */
 	if (i >= 0) {
 		iov_data->next_vf_mbx = i + 1;
 	} else if (iov_data->next_vf_mbx) {
-- 
1.9.3

