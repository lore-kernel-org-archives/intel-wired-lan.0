From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 16:38:45 -0700
Subject: [Intel-wired-lan] [PATCH 1/6] igb: mark expected switch fall-through
Message-ID: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warning:

drivers/net/ethernet/intel/igb/igb_main.c: In function ?__igb_notify_dca?:
drivers/net/ethernet/intel/igb/igb_main.c:6694:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (dca_add_requester(dev) == 0) {
      ^
drivers/net/ethernet/intel/igb/igb_main.c:6701:2: note: here
  case DCA_PROVIDER_REMOVE:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 834e879e1d57..e8042b0254bc 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6701,7 +6701,7 @@ static int __igb_notify_dca(struct device *dev, void *data)
 			igb_setup_dca(adapter);
 			break;
 		}
-		/* Fall Through since DCA is disabled. */
+		/* Fall Through - since DCA is disabled. */
 	case DCA_PROVIDER_REMOVE:
 		if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
 			/* without this a class_device is left
-- 
2.20.1

