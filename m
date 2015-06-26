From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 26 Jun 2015 08:54:07 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: TRIVIAL remove unnecessary
	comma
In-Reply-To: <1435334047-6404-1-git-send-email-jacob.e.keller@intel.com>
References: <1435334047-6404-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1435334047-6404-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 5403d8602fce..af09a1b272e6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -129,8 +129,8 @@ static u16 fm10k_fifo_head_drop(struct fm10k_mbx_fifo *fifo)
  *  fm10k_fifo_drop_all - Drop all messages in FIFO
  *  @fifo: pointer to FIFO
  *
- *  This function resets the head pointer to drop all messages in the FIFO,
- *  and ensure the FIFO is empty.
+ *  This function resets the head pointer to drop all messages in the FIFO and
+ *  ensure the FIFO is empty.
  **/
 static void fm10k_fifo_drop_all(struct fm10k_mbx_fifo *fifo)
 {
-- 
2.4.3

