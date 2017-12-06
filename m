From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed,  6 Dec 2017 09:25:10 -0800
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: cleanup unnecessary
 parenthesis in fm10k_iov.c
Message-ID: <20171206172515.37577-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This fixes a few warnings found by checkpatch.pl --strict

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index ea3ab24265ee..760cfa52d02c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -353,7 +353,7 @@ int fm10k_iov_resume(struct pci_dev *pdev)
 		struct fm10k_vf_info *vf_info = &iov_data->vf_info[i];
 
 		/* allocate all but the last GLORT to the VFs */
-		if (i == ((~hw->mac.dglort_map) >> FM10K_DGLORTMAP_MASK_SHIFT))
+		if (i == (~hw->mac.dglort_map >> FM10K_DGLORTMAP_MASK_SHIFT))
 			break;
 
 		/* assign GLORT to VF, and restrict it to multicast */
@@ -511,7 +511,7 @@ int fm10k_iov_configure(struct pci_dev *pdev, int num_vfs)
 		return err;
 
 	/* allocate VFs if not already allocated */
-	if (num_vfs && (num_vfs != current_vfs)) {
+	if (num_vfs && num_vfs != current_vfs) {
 		/* Disable completer abort error reporting as
 		 * the VFs can trigger this any time they read a queue
 		 * that they don't own.
-- 
2.15.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

