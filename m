From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Mon, 14 Mar 2022 17:41:37 +0100
Subject: [Intel-wired-lan] [PATCH net-next] gtp: Fix inconsistent indenting
Message-ID: <20220314164137.15101-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wojciech Drewek <wojciech.drewek@intel.com>

Commit d33bd757d362("gtp: Implement GTP echo request") introduced
this issue.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
There is no "Fixes" tag because patch that caused the
issue is not present in net yet.
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 756714d4ad92..a208e2b1a9af 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1793,7 +1793,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 	if (IS_ERR(rt)) {
 		netdev_dbg(gtp->dev, "no route for echo request to %pI4\n",
 			   &dst_ip);
-			   kfree_skb(skb_to_send);
+		kfree_skb(skb_to_send);
 		return -ENODEV;
 	}
 
-- 
2.35.1

