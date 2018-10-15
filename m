From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Oct 2018 12:18:27 -0700
Subject: [Intel-wired-lan] [net-next 1/3] fm10k: fix SM mailbox full
 condition
In-Reply-To: <20181015191829.17115-1-jacob.e.keller@intel.com>
References: <20181015191829.17115-1-jacob.e.keller@intel.com>
Message-ID: <20181015191829.17115-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Current condition will always incorrectly report a full SM mailbox if an
IES API application is not running. Due to this, the
"fm10k_service_task" will be infinitely queued into the driver's
workqueue. This, in turn, will cause a "kworker" thread to report 100%
CPU utilization and might cause "soft lockup" events or system crashes.

To fix this issue, a new condition is added to determine if the SM
mailbox is in the correct state of FM10K_STATE_OPEN before proceeding.
In other words, an instance of the IES API must be running. If there is,
the remainder of the flow stays the same which is to determine if the SM
mailbox capacity has been exceeded or not and take appropriate action.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index e707d717012f..74160c2095ee 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -244,7 +244,8 @@ s32 fm10k_iov_mbx(struct fm10k_intfc *interface)
 		}
 
 		/* guarantee we have free space in the SM mailbox */
-		if (!hw->mbx.ops.tx_ready(&hw->mbx, FM10K_VFMBX_MSG_MTU)) {
+		if (hw->mbx.state == FM10K_STATE_OPEN &&
+		    !hw->mbx.ops.tx_ready(&hw->mbx, FM10K_VFMBX_MSG_MTU)) {
 			/* keep track of how many times this occurs */
 			interface->hw_sm_mbx_full++;
 
-- 
2.18.0.219.gaf81d287a9da

