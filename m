From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu,  6 Aug 2015 17:57:31 +0900
Subject: [Intel-wired-lan] [PATCH next 4/4] ixgbevf: Enables TSO for stacked
	vlan
In-Reply-To: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <1438851452-13143-4-git-send-email-makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Setting ndo_features_check to passthru_features_check allows the driver
to skip the check for multiple tagged TSO packets and enables stacked
vlan TSO.
Tested with 82599ES.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 88298a3..67c785d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3896,6 +3896,7 @@ static const struct net_device_ops ixgbevf_netdev_ops = {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ixgbevf_netpoll,
 #endif
+	.ndo_features_check	= passthru_features_check,
 };
 
 static void ixgbevf_assign_netdev_ops(struct net_device *dev)
-- 
1.8.1.2


