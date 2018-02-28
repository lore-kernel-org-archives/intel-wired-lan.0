From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Wed, 28 Feb 2018 03:59:09 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add receive length error counter.
Message-ID: <1519819149-10012-1-git-send-email-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ixgbe enabled rlec counter and the rx_error used it.
We can export the counter directly via ethtool -S ethX.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 221f158..eb9aebd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -97,6 +97,7 @@ struct ixgbe_stats {
 	{"tx_heartbeat_errors", IXGBE_NETDEV_STAT(tx_heartbeat_errors)},
 	{"tx_timeout_count", IXGBE_STAT(tx_timeout_count)},
 	{"tx_restart_queue", IXGBE_STAT(restart_queue)},
+	{"rx_length_errors", IXGBE_STAT(stats.rlec)},
 	{"rx_long_length_errors", IXGBE_STAT(stats.roc)},
 	{"rx_short_length_errors", IXGBE_STAT(stats.ruc)},
 	{"tx_flow_control_xon", IXGBE_STAT(stats.lxontxc)},
-- 
1.8.3.1

