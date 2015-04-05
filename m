From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sun,  5 Apr 2015 16:32:04 -0600
Subject: [Intel-wired-lan] [net-next] e100: don't initialize int object to
	zero
Message-ID: <1428273124-14321-1-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

'err' will be overwritten so no need to initialize it to zero.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 05f88394f9a5..75a11ea7a9d6 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -874,7 +874,7 @@ static int e100_exec_cb(struct nic *nic, struct sk_buff *skb,
 {
 	struct cb *cb;
 	unsigned long flags;
-	int err = 0;
+	int err;
 
 	spin_lock_irqsave(&nic->cb_lock, flags);
 
