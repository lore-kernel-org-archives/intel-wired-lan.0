From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sat, 19 Sep 2015 05:08:43 -0600
Subject: [Intel-wired-lan] [next-queue v2 4/8] i40e: fix kernel-doc argument
	name
In-Reply-To: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
References: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442660927-30431-4-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

The second argument name in the kernel-doc argument list for
i40e_features_check() was slightly off. Fix it for the kernel doc.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2: No changes.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8707a2e5696e..2d8c0cc23fcf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8498,7 +8498,7 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 /**
  * i40e_features_check - Validate encapsulated packet conforms to limits
  * @skb: skb buff
- * @netdev: This physical port's netdev
+ * @dev: This physical port's netdev
  * @features: Offload features that the stack believes apply
  **/
 static netdev_features_t i40e_features_check(struct sk_buff *skb,
