From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 10 Apr 2015 17:20:17 -0700
Subject: [Intel-wired-lan] [net-next v2 16/25] fm10k: don't handle mailbox
 events in iov_event path and always process mailbox
Message-ID: <20150411001618.24651.38935.stgit@gmw-smvitp108.amr.corp.intel.com>
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

The result of tx_complete and !rx_ready is insufficient to determine
whether we need to process the mailbox. There is a possible race
condition whereby the VF fills up the mbmem for us, but we have already
recently processed the mailboxes in the interrupt. During this time,
the interrupt is disabled. Thus, our Rx FIFO is empty, but the mbmem now
has data in it. Since we continually check whether Rx FIFO is empty, we
then never call process. This results in the possibility to prevent PF
from handling the VF mailbox messages.

Instead, just call process every time, despite the fact that we may or
may not have anything to process for the VF. There should be minimal
overhead for doing this, and it resolves an issue where the VF never
comes up due to never getting response for its SET_LPORT_STATE message.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
v2: on review, found that additional change was needed in the patch to
    resolve a possible race condition.
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c |   34 ++------------------------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    3 ++
 2 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 69cbfde..0b37e19 100644
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
 
@@ -155,10 +129,6 @@ process_mbx:
 			mbx->ops.connect(hw, mbx);
 		}
 
-		/* no work pending, then just continue */
-		if (mbx->ops.tx_complete(mbx) && !mbx->ops.rx_ready(mbx))
-			continue;
-
 		/* guarantee we have free space in the SM mailbox */
 		if (!hw->mbx.ops.tx_ready(&hw->mbx, FM10K_VFMBX_MSG_MTU))
 			break;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 64255cd..94c602f 100644
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

