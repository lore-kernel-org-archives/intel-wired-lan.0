From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu,  6 Aug 2015 17:57:29 +0900
Subject: [Intel-wired-lan] [PATCH next 2/4] e1000e: Enable TSO for stacked
	vlan
In-Reply-To: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <1438851452-13143-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Setting ndo_features_check to passthru_features_check allows the driver
to skip the check for multiple tagged TSO packets and enables stacked
vlan TSO.
Tested with I217-LM.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 546b5da..bcabbba 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6952,6 +6952,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #endif
 	.ndo_set_features = e1000_set_features,
 	.ndo_fix_features = e1000_fix_features,
+	.ndo_features_check	= passthru_features_check,
 };
 
 /**
-- 
1.8.1.2


