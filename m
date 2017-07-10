From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:04 -0700
Subject: [Intel-wired-lan] [PATCH v3 01/16] fm10k: stop spurious link down
	messages when Tx FIFO is full
Message-ID: <20170710202319.22110-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In fm10k_get_host_state_generic, we check the mailbox tx_read() function
to ensure that the mailbox is still open. This function also checks to
make sure we have space to transmit another message. Unfortunately, if
we just recently sent a bunch of messages (such as enabling hundreds of
VLANs on a VF) this can result in a race where the watchdog task thinks
the link went down just because we haven't had time to process all these
messages yet.

Instead, lets just check whether the mailbox is still open. This ensures
that we don't race with the Tx fifo, and we only link down once the
mailbox is not open.

This is safe, because if the FIFO fills up and we're unable to send
a message for too long, we'll end up triggering the timeout detection
which results in a reset. Additionally, since we still check to ensure
the mailbox state is OPEN, we'll transition to link down whenever the
mailbox closes as well.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
index 62a6ad9b3eed..736a9f087bc9 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -517,8 +517,8 @@ s32 fm10k_get_host_state_generic(struct fm10k_hw *hw, bool *host_ready)
 		goto out;
 	}
 
-	/* verify Mailbox is still valid */
-	if (!mbx->ops.tx_ready(mbx, FM10K_VFMBX_MSG_MTU))
+	/* verify Mailbox is still open */
+	if (mbx->state != FM10K_STATE_OPEN)
 		goto out;
 
 	/* interface cannot receive traffic without logical ports */
-- 
2.13.0.615.gb09ed6e59a40

