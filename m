From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Jun 2015 15:00:54 -0700
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: reset Tx FIFO head and tail
	pointers as part of reset_work
In-Reply-To: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434405656-10465-4-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a corner case issue with the PF/VF mailbox code.
Currently, fm10k_mbx_reset_work clears various state about the
mailbox. However, it did not clear the Tx FIFO head/tail pointers. Thus,
when the PF finally re-connects (say due to VF reset), it in-advertently
might send some previous data in the Tx FIFO again. This was discovered
by attempting to perform a static VF MAC address assignment on the PF
device. The VF would receive the message and then initiate a reset.
During this process it disconnects and reconnects to the mailbox. If the
PF doesn't respond fast enough, it may not see the disconnect message,
and only sees a new connect message. In this flow, it does not properly
clear the Tx FIFO pointers. Thus, it will re-transmit the last message
in the Tx FIFO. However, it does not increment the mailbox Tx messages
because it has already reset mbx->pulled and thus does not think it is
actually sending any data. The fix is to simply reset the Tx FIFO
pointers whenever we call fm10k_mbx_reset_work.

As a consequence, we no longer need both fm10k_mbx_fifo_drop_all and calls
to fm10k_mbx_update_max_size with a size of 0.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 1a4b52637de9..f9016bf8b5b1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -126,18 +126,6 @@ static u16 fm10k_fifo_head_drop(struct fm10k_mbx_fifo *fifo)
 }
 
 /**
- *  fm10k_fifo_drop_all - Drop all messages in FIFO
- *  @fifo: pointer to FIFO
- *
- *  This function resets the head pointer to drop all messages in the FIFO,
- *  and ensure the FIFO is empty.
- **/
-static void fm10k_fifo_drop_all(struct fm10k_mbx_fifo *fifo)
-{
-	fifo->head = fifo->tail;
-}
-
-/**
  *  fm10k_mbx_index_len - Convert a head/tail index into a length value
  *  @mbx: pointer to mailbox
  *  @head: head index
@@ -1054,6 +1042,8 @@ static void fm10k_mbx_reset_work(struct fm10k_mbx_info *mbx)
 	mbx->pulled = 0;
 	mbx->tail_len = 0;
 	mbx->head_len = 0;
+	mbx->tx.tail = 0;
+	mbx->tx.head = 0;
 	mbx->rx.tail = 0;
 	mbx->rx.head = 0;
 }
@@ -1384,7 +1374,6 @@ static void fm10k_mbx_disconnect(struct fm10k_hw *hw,
 	 * drop all left over messages in the FIFO.
 	 */
 	fm10k_mbx_connect_reset(mbx);
-	fm10k_fifo_drop_all(&mbx->tx);
 
 	fm10k_write_reg(hw, mbx->mbmem_reg, 0);
 }
@@ -1725,7 +1714,6 @@ static void fm10k_sm_mbx_disconnect(struct fm10k_hw *hw,
 	mbx->state = FM10K_STATE_CLOSED;
 	mbx->remote = 0;
 	fm10k_mbx_reset_work(mbx);
-	fm10k_mbx_update_max_size(mbx, 0);
 
 	fm10k_write_reg(hw, mbx->mbmem_reg, 0);
 }
-- 
2.4.2

