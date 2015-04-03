From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:14 -0700
Subject: [Intel-wired-lan] [net-next 24/25] fm10k: mbx_update_max_size does
	not drop all oversized messages
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-24-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we call update_max_size it does not drop all oversized messages.
This is due to the difficulty in performing this operation, since it is
a FIFO which makes updating anything other than head or tail very
difficult. To fix this, modify validate_msg_size to ensure that we error
out later when trying to transmit the message that could be oversized.
This will generally be a rare condition, as it requires the FIFO to
include a message larger than the max_size negotiated during mailbox
connect. Note that max_size is always smaller than rx.size so it should
be safe to use here.

Also, update the update_max_size function header comment to clearly
indicate that it does not drop all oversized messages, but only those at
the head of the FIFO.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 27f8279..1b27383 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -327,7 +327,7 @@ static u16 fm10k_mbx_validate_msg_size(struct fm10k_mbx_info *mbx, u16 len)
 	} while (total_len < len);
 
 	/* message extends out of pushed section, but fits in FIFO */
-	if ((len < total_len) && (msg_len <= mbx->rx.size))
+	if ((len < total_len) && (msg_len <= mbx->max_size))
 		return 0;
 
 	/* return length of invalid section */
@@ -1063,8 +1063,11 @@ static void fm10k_mbx_reset_work(struct fm10k_mbx_info *mbx)
  *  @mbx: pointer to mailbox
  *  @size: new value for max_size
  *
- *  This function will update the max_size value and drop any outgoing messages
- *  from the head of the Tx FIFO that are larger than max_size.
+ *  This function updates the max_size value and drops any outgoing messages
+ *  at the head of the Tx FIFO if they are larger than max_size. It does not
+ *  drop all messages, as this is too difficult to parse and remove them from
+ *  the FIFO. Instead, rely on the checking to ensure that messages larger
+ *  than max_size aren't pushed into the memory buffer.
  **/
 static void fm10k_mbx_update_max_size(struct fm10k_mbx_info *mbx, u16 size)
 {
-- 
1.9.3

