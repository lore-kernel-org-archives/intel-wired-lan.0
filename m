From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:16 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 01/16] ixgbe: Fix
 interaction between SR-IOV and macvlan offload
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185616.29785.79685.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

When SR-IOV was enabled the macvlan offload was configuring several filters
with the wrong pool value. This would result in the macvlan interfaces not
being able to receive traffic that had to pass over the physical interface.

To fix it wrap the pool argument in the VMDQ_P macro which will add the
necessary offset to get to the actual VMDq pool

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f52ad0d0782f..9c6d4926a136 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5426,10 +5426,11 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 		goto fwd_queue_err;
 
 	if (is_valid_ether_addr(vdev->dev_addr))
-		ixgbe_add_mac_filter(adapter, vdev->dev_addr, accel->pool);
+		ixgbe_add_mac_filter(adapter, vdev->dev_addr,
+				     VMDQ_P(accel->pool));
 
 	ixgbe_fwd_psrtype(accel);
-	ixgbe_macvlan_set_rx_mode(vdev, accel->pool, adapter);
+	ixgbe_macvlan_set_rx_mode(vdev, VMDQ_P(accel->pool), adapter);
 	return err;
 fwd_queue_err:
 	ixgbe_fwd_ring_down(vdev, accel);
@@ -9034,6 +9035,7 @@ static int get_macvlan_queue(struct net_device *upper, void *_data)
 static int handle_redirect_action(struct ixgbe_adapter *adapter, int ifindex,
 				  u8 *queue, u64 *action)
 {
+	struct ixgbe_ring_feature *vmdq = &adapter->ring_feature[RING_F_VMDQ];
 	unsigned int num_vfs = adapter->num_vfs, vf;
 	struct upper_walk_data data;
 	struct net_device *upper;
@@ -9042,11 +9044,7 @@ static int handle_redirect_action(struct ixgbe_adapter *adapter, int ifindex,
 	for (vf = 0; vf < num_vfs; ++vf) {
 		upper = pci_get_drvdata(adapter->vfinfo[vf].vfdev);
 		if (upper->ifindex == ifindex) {
-			if (adapter->num_rx_pools > 1)
-				*queue = vf * 2;
-			else
-				*queue = vf * adapter->num_rx_queues_per_pool;
-
+			*queue = vf * __ALIGN_MASK(1, ~vmdq->mask);
 			*action = vf + 1;
 			*action <<= ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
 			return 0;

