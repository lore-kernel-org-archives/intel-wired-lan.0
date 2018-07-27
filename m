From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri, 27 Jul 2018 16:07:38 +0800
Subject: [Intel-wired-lan] [PATCH] net: intel: igb: Replace mdelay() with
 msleep() in igb_integrated_phy_loopback()
Message-ID: <20180727080738.3301-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igb_integrated_phy_loopback() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e77ba0d5866d..4e64c9a6f1b6 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1670,7 +1670,7 @@ static int igb_integrated_phy_loopback(struct igb_adapter *adapter)
 	if (hw->phy.type == e1000_phy_m88)
 		igb_phy_disable_receiver(adapter);
 
-	mdelay(500);
+	msleep(500);
 	return 0;
 }
 
-- 
2.17.0

