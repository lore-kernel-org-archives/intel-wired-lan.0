From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 15 Aug 2017 08:59:54 -0700
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: restore normal RSS after
	last macvlan offload is removed
Message-ID: <1502812794-452204-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Just like when the last VF is removed, we need to restore normal
operations after the last macvlan offload is removed, else we
get stuck in single queue operations.

To test:
ethtool -l eth1   # note the number of queues in use, ~= cpus

ethtool -K eth1 l2-fwd-offload on
ip link add mv1 link eth1 type macvlan mode bridge
ip link set dev mv1 up
ip link del mv1

ethtool -l eth1   # are we back to the same # of queues, or stuck on 1?

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0f867dc..cedaf1c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9728,6 +9728,17 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	limit = find_last_bit(&adapter->fwd_bitmask, 32);
 	adapter->ring_feature[RING_F_VMDQ].limit = limit + 1;
 	ixgbe_fwd_ring_down(fwd_adapter->netdev, fwd_adapter);
+
+	/* go back to full RSS if we're done with our VMQs */
+	if (adapter->ring_feature[RING_F_VMDQ].limit == 1) {
+		int rss = min_t(int, ixgbe_max_rss_indices(adapter),
+				num_online_cpus());
+
+		adapter->flags &= ~IXGBE_FLAG_VMDQ_ENABLED;
+		adapter->flags &= ~IXGBE_FLAG_SRIOV_ENABLED;
+		adapter->ring_feature[RING_F_RSS].limit = rss;
+	}
+
 	ixgbe_setup_tc(pdev, netdev_get_num_tc(pdev));
 	netdev_dbg(pdev, "pool %i:%i queues %i:%i VSI bitmask %lx\n",
 		   fwd_adapter->pool, adapter->num_rx_pools,
-- 
1.7.1

