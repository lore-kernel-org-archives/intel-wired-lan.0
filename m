From: Jason Yan <yanaijie@huawei.com>
Date: Mon, 20 Apr 2020 20:35:06 +0800
Subject: [Intel-wired-lan] [PATCH] e1000: remove unneeded conversion to bool
Message-ID: <20200420123506.7716-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The '==' expression itself is bool, no need to convert it to bool again.
This fixes the following coccicheck warning:

drivers/net/ethernet/intel/e1000/e1000_main.c:1479:44-49: WARNING:
conversion to bool not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index ac5146d53c4c..05bc6e216bca 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1476,7 +1476,7 @@ static bool e1000_check_64k_bound(struct e1000_adapter *adapter, void *start,
 	if (hw->mac_type == e1000_82545 ||
 	    hw->mac_type == e1000_ce4100 ||
 	    hw->mac_type == e1000_82546) {
-		return ((begin ^ (end - 1)) >> 16) != 0 ? false : true;
+		return ((begin ^ (end - 1)) >> 16) == 0;
 	}
 
 	return true;
-- 
2.21.1

