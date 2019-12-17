From: Yunfeng Ye <yeyunfeng@huawei.com>
Date: Tue, 17 Dec 2019 20:26:34 +0800
Subject: [Intel-wired-lan] [PATCH] e100: remove unused varibale err in
 e100_diag_test()
Message-ID: <b0cf9969-bb56-2ccb-cf16-025eb700a24e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fix following warning:
drivers/net/ethernet/intel/e100.c: In function ?e100_diag_test?:
drivers/net/ethernet/intel/e100.c:2600:9: warning: variable ?err? set
but not used [-Wunused-but-set-variable]
  int i, err;
         ^~~

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/net/ethernet/intel/e100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index a65d5a9ba7db..f1cb493a811f 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2597,7 +2597,7 @@ static void e100_diag_test(struct net_device *netdev,
 {
 	struct ethtool_cmd cmd;
 	struct nic *nic = netdev_priv(netdev);
-	int i, err;
+	int i;

 	memset(data, 0, E100_TEST_LEN * sizeof(u64));
 	data[0] = !mii_link_ok(&nic->mii);
@@ -2605,7 +2605,7 @@ static void e100_diag_test(struct net_device *netdev,
 	if (test->flags & ETH_TEST_FL_OFFLINE) {

 		/* save speed, duplex & autoneg settings */
-		err = mii_ethtool_gset(&nic->mii, &cmd);
+		mii_ethtool_gset(&nic->mii, &cmd);

 		if (netif_running(netdev))
 			e100_down(nic);
@@ -2614,7 +2614,7 @@ static void e100_diag_test(struct net_device *netdev,
 		data[4] = e100_loopback_test(nic, lb_phy);

 		/* restore speed, duplex & autoneg settings */
-		err = mii_ethtool_sset(&nic->mii, &cmd);
+		mii_ethtool_sset(&nic->mii, &cmd);

 		if (netif_running(netdev))
 			e100_up(nic);
-- 
2.7.4

