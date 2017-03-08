From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  8 Mar 2017 15:55:43 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: reschedule service event if we
	stall the PF<->SM mailbox
In-Reply-To: <20170308235543.16537-1-jacob.e.keller@intel.com>
References: <20170308235543.16537-1-jacob.e.keller@intel.com>
Message-ID: <20170308235543.16537-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we are handling PF<->VF mailbox messages, it is possible that the
VF will send us so many messages that the PF<->SM FIFO will fill up. In
this case, we stop the loop and wait until the service event is
rescheduled.

Normally this should happen due to an interrupt. But it is possible that
we don't get another interrupt for a while and it isn't until the
service timer actually reschedules us. Instead, simply reschedule
immediately which will cause the service event to be run again as soon
as we exit.

This ensures that we promptly handle all of the PF<->VF messages with
minimal delay, while still giving time for the SM mailbox to drain.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 2ec49116fe91..d8356c494f06 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -143,6 +143,10 @@ s32 fm10k_iov_mbx(struct fm10k_intfc *interface)
 		if (!hw->mbx.ops.tx_ready(&hw->mbx, FM10K_VFMBX_MSG_MTU)) {
 			/* keep track of how many times this occurs */
 			interface->hw_sm_mbx_full++;
+
+			/* make sure we try again momentarily */
+			fm10k_service_event_schedule(interface);
+
 			break;
 		}
 
-- 
2.12.0.rc1.272.g5157a0d593b8

