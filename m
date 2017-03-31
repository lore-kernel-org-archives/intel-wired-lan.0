From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 30 Mar 2017 20:49:02 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix size of queue stats length
Message-ID: <20170331034902.6530.34141.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

IXGBEVF_QUEUE_STATS_LEN is based on ixgebvf_stats, not ixgbe_stats.

This change fixes a bug where ethtool -S displayed some empty fields.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 6bf7409..43b70cd 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -80,7 +80,7 @@ struct ixgbe_stats {
 #define IXGBEVF_QUEUE_STATS_LEN ( \
 	(((struct ixgbevf_adapter *)netdev_priv(netdev))->num_tx_queues + \
 	 ((struct ixgbevf_adapter *)netdev_priv(netdev))->num_rx_queues) * \
-	 (sizeof(struct ixgbe_stats) / sizeof(u64)))
+	 (sizeof(struct ixgbevf_stats) / sizeof(u64)))
 #define IXGBEVF_GLOBAL_STATS_LEN ARRAY_SIZE(ixgbevf_gstrings_stats)
 
 #define IXGBEVF_STATS_LEN (IXGBEVF_GLOBAL_STATS_LEN + IXGBEVF_QUEUE_STATS_LEN)

