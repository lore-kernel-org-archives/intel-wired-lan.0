From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu,  6 Aug 2015 17:57:28 +0900
Subject: [Intel-wired-lan] [PATCH next 1/4] igbvf: Enable TSO for stacked
	vlan
Message-ID: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Setting ndo_features_check to passthru_features_check allows the driver
to skip the check for multiple tagged TSO packets and enables stacked
vlan TSO.
Tested with I350.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 95af14e..45679e4 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2614,6 +2614,7 @@ static const struct net_device_ops igbvf_netdev_ops = {
 	.ndo_poll_controller	= igbvf_netpoll,
 #endif
 	.ndo_set_features	= igbvf_set_features,
+	.ndo_features_check	= passthru_features_check,
 };
 
 /**
-- 
1.8.1.2


