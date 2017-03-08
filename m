From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  8 Mar 2017 15:55:42 -0800
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: ensure we process SM mbx when
	processing VF mbx
Message-ID: <20170308235543.16537-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we process VF mailboxes, the driver is likely going to also queue
up messages to the switch manager. This process merely queues up the
FIFO, but doesn't actually begin the transmission process. Because we
hold the mailbox lock during this VF processing, the PF<->SM mailbox is
not getting processed at this time. Ensure that we actually process the
PF<->SM mailbox in between each PF<->VF mailbox.

This should ensure prompt transmission of the messages queued up after
each VF message is received and handled.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 5f4dac0d36ef..2ec49116fe91 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -126,6 +126,9 @@ s32 fm10k_iov_mbx(struct fm10k_intfc *interface)
 		struct fm10k_mbx_info *mbx = &vf_info->mbx;
 		u16 glort = vf_info->glort;
 
+		/* process the SM mailbox first to drain outgoing messages */
+		hw->mbx.ops.process(hw, &hw->mbx);
+
 		/* verify port mapping is valid, if not reset port */
 		if (vf_info->vf_flags && !fm10k_glort_valid_pf(hw, glort))
 			hw->iov.ops.reset_lport(hw, vf_info);
-- 
2.12.0.rc1.272.g5157a0d593b8

