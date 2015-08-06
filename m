From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu,  6 Aug 2015 17:57:30 +0900
Subject: [Intel-wired-lan] [PATCH next 3/4] ixgbe: Enable TSO for stacked
	vlan
In-Reply-To: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <1438851452-13143-3-git-send-email-makita.toshiaki@lab.ntt.co.jp>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 3e6a931..1f35e6d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8255,6 +8255,7 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_dfwd_del_station	= ixgbe_fwd_del,
 	.ndo_add_vxlan_port	= ixgbe_add_vxlan_port,
 	.ndo_del_vxlan_port	= ixgbe_del_vxlan_port,
+	.ndo_features_check	= passthru_features_check,
 };
 
 /**
-- 
1.8.1.2


