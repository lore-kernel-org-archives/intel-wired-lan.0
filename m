From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:08 -0700
Subject: [Intel-wired-lan] [net-next 18/25] fm10k: fix function header
	comment
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-18-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The header comment included a miscopy of a C-code line, and also
mis-used Rx FIFO when it clearly meant Tx FIFO

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 59faf32..e9ecfb4 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -326,8 +326,7 @@ static u16 fm10k_mbx_validate_msg_size(struct fm10k_mbx_info *mbx, u16 len)
  *  fm10k_mbx_write_copy - pulls data off of Tx FIFO and places it in mbmem
  *  @mbx: pointer to mailbox
  *
- *  This function will take a section of the Rx FIFO and copy it into the
-		mbx->tail--;
+ *  This function will take a section of the Tx FIFO and copy it into the
  *  mailbox memory.  The offset in mbmem is based on the lower bits of the
  *  tail and len determines the length to copy.
  **/
-- 
1.9.3

