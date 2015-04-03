From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:13 -0700
Subject: [Intel-wired-lan] [net-next 23/25] fm10k: reset head instead of
	calling update_max_size
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-23-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we forcefully shutdown the mailbox, we then go about resetting max
size to 0, and clearing all messages in the FIFO. Instead, we should
just reset the head pointer so that the FIFO becomes empty, rather than
changing the max size to 0. This helps prevent increment in tx_dropped
counter during mailbox negotiation, which is confusing to viewers of
Linux ethtool statistics output.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index e9ecfb4..27f8279 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -126,6 +126,18 @@ static u16 fm10k_fifo_head_drop(struct fm10k_mbx_fifo *fifo)
 }
 
 /**
+ *  fm10k_fifo_drop_all - Drop all messages in FIFO
+ *  @fifo: pointer to FIFO
+ *
+ *  This function resets the head pointer to drop all messages in the FIFO,
+ *  and ensure the FIFO is empty.
+ **/
+static void fm10k_fifo_drop_all(struct fm10k_mbx_fifo *fifo)
+{
+	fifo->head = fifo->tail;
+}
+
+/**
  *  fm10k_mbx_index_len - Convert a head/tail index into a length value
  *  @mbx: pointer to mailbox
  *  @head: head index
@@ -1370,9 +1382,11 @@ static void fm10k_mbx_disconnect(struct fm10k_hw *hw,
 		timeout -= FM10K_MBX_POLL_DELAY;
 	} while ((timeout > 0) && (mbx->state != FM10K_STATE_CLOSED));
 
-	/* in case we didn't close just force the mailbox into shutdown */
+	/* in case we didn't close, just force the mailbox into shutdown and
+	 * drop all left over messages in the FIFO.
+	 */
 	fm10k_mbx_connect_reset(mbx);
-	fm10k_mbx_update_max_size(mbx, 0);
+	fm10k_fifo_drop_all(&mbx->tx);
 
 	fm10k_write_reg(hw, mbx->mbmem_reg, 0);
 }
-- 
1.9.3

