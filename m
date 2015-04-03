From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:06 -0700
Subject: [Intel-wired-lan] [net-next 16/25] fm10k: don't handle mailbox
	events in iov_event path
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-16-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since we already schedule the service task, we can just wait for this
task to handle the mailbox events from the VF. This reduces some complex
code flow, and makes it so we have a single path for handling the VF
messages. There is a possibility that we have a slight delay in handling
VF messages, but it should be minimal.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 30 ++--------------------------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |  3 +++
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 69cbfde..1071f38 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -47,7 +47,7 @@ s32 fm10k_iov_event(struct fm10k_intfc *interface)
 {
 	struct fm10k_hw *hw = &interface->hw;
 	struct fm10k_iov_data *iov_data;
-	s64 mbicr, vflre;
+	s64 vflre;
 	int i;
 
 	/* if there is no iov_data then there is no mailboxes to process */
@@ -63,7 +63,7 @@ s32 fm10k_iov_event(struct fm10k_intfc *interface)
 		goto read_unlock;
 
 	if (!(fm10k_read_reg(hw, FM10K_EICR) & FM10K_EICR_VFLR))
-		goto process_mbx;
+		goto read_unlock;
 
 	/* read VFLRE to determine if any VFs have been reset */
 	do {
@@ -86,32 +86,6 @@ s32 fm10k_iov_event(struct fm10k_intfc *interface)
 		}
 	} while (i != iov_data->num_vfs);
 
-process_mbx:
-	/* read MBICR to determine which VFs require attention */
-	mbicr = fm10k_read_reg(hw, FM10K_MBICR(1));
-	mbicr <<= 32;
-	mbicr |= fm10k_read_reg(hw, FM10K_MBICR(0));
-
-	i = iov_data->next_vf_mbx ? : iov_data->num_vfs;
-
-	for (mbicr <<= 64 - i; i--; mbicr += mbicr) {
-		struct fm10k_mbx_info *mbx = &iov_data->vf_info[i].mbx;
-
-		if (mbicr >= 0)
-			continue;
-
-		if (!hw->mbx.ops.tx_ready(&hw->mbx, FM10K_VFMBX_MSG_MTU))
-			break;
-
-		mbx->ops.process(hw, mbx);
-	}
-
-	if (i >= 0) {
-		iov_data->next_vf_mbx = i + 1;
-	} else if (iov_data->next_vf_mbx) {
-		iov_data->next_vf_mbx = 0;
-		goto process_mbx;
-	}
 read_unlock:
 	rcu_read_unlock();
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index fcf0d5a..25458ca 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -984,6 +984,7 @@ static irqreturn_t fm10k_msix_mbx_pf(int __always_unused irq, void *data)
 	/* service mailboxes */
 	if (fm10k_mbx_trylock(interface)) {
 		mbx->ops.process(hw, mbx);
+		/* handle VFLRE events */
 		fm10k_iov_event(interface);
 		fm10k_mbx_unlock(interface);
 	}
@@ -1000,6 +1001,8 @@ static irqreturn_t fm10k_msix_mbx_pf(int __always_unused irq, void *data)
 
 	/* we should validate host state after interrupt event */
 	hw->mac.get_host_state = 1;
+
+	/* validate host state, and handle VF mailboxes in the service task */
 	fm10k_service_event_schedule(interface);
 
 	/* re-enable mailbox interrupt and indicate 20us delay */
-- 
1.9.3

