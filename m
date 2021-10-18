From: luo penghao <cgel.zte@gmail.com>
Date: Mon, 18 Oct 2021 08:51:54 +0000
Subject: [Intel-wired-lan] [PATCH linux-next] e1000e: Remove redundant
 statement
Message-ID: <20211018085154.853744-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This assignment statement is meaningless, because the statement
will execute to the tag "set_itr_now".

The clang_analyzer complains as follows:

drivers/net/ethernet/intel/e1000e/netdev.c:2552:3 warning:

Value stored to 'current_itr' is never read.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ff8672a..21ec716 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2549,7 +2549,6 @@ static void e1000_set_itr(struct e1000_adapter *adapter)
 
 	/* for non-gigabit speeds, just fix the interrupt rate at 4000 */
 	if (adapter->link_speed != SPEED_1000) {
-		current_itr = 0;
 		new_itr = 4000;
 		goto set_itr_now;
 	}
-- 
2.15.2


