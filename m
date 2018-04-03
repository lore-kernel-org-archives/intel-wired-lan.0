From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:40 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 09/10] ixgbe: Drop
 real_adapter from l2 fwd acceleration structure
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211640.7880.19722.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch drops the real_adapter member from the fwd_adapter structure.
The general idea behind the change is that the real_adapter is carrying
unnecessary data since we could always just grab the adapter structure
from netdev_priv(macvlan->lowerdev) if we really needed to get at it.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   28 ++++++++++++++-----------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 4f08c71..238137c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -306,7 +306,6 @@ enum ixgbe_ring_state_t {
 struct ixgbe_fwd_adapter {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	struct net_device *netdev;
-	struct ixgbe_adapter *real_adapter;
 	unsigned int tx_base_queue;
 	unsigned int rx_base_queue;
 	int pool;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7c0f310..56772d6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5330,10 +5330,10 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring *rx_ring)
 	rx_ring->next_to_use = 0;
 }
 
-static int ixgbe_fwd_ring_up(struct net_device *vdev,
+static int ixgbe_fwd_ring_up(struct ixgbe_adapter *adapter,
 			     struct ixgbe_fwd_adapter *accel)
 {
-	struct ixgbe_adapter *adapter = accel->real_adapter;
+	struct net_device *vdev = accel->netdev;
 	int i, baseq, err;
 
 	if (!test_bit(accel->pool, adapter->fwd_bitmask))
@@ -5370,14 +5370,19 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 	return err;
 }
 
-static int ixgbe_upper_dev_walk(struct net_device *upper, void *data)
+static int ixgbe_macvlan_up(struct net_device *vdev, void *data)
 {
-	if (netif_is_macvlan(upper)) {
-		struct ixgbe_fwd_adapter *vadapter = macvlan_accel_priv(upper);
+	struct ixgbe_adapter *adapter = data;
+	struct ixgbe_fwd_adapter *accel;
 
-		if (vadapter)
-			ixgbe_fwd_ring_up(upper, vadapter);
-	}
+	if (!netif_is_macvlan(vdev))
+		return 0;
+
+	accel = macvlan_accel_priv(vdev);
+	if (!accel)
+		return 0;
+
+	ixgbe_fwd_ring_up(adapter, accel);
 
 	return 0;
 }
@@ -5385,7 +5390,7 @@ static int ixgbe_upper_dev_walk(struct net_device *upper, void *data)
 static void ixgbe_configure_dfwd(struct ixgbe_adapter *adapter)
 {
 	netdev_walk_all_upper_dev_rcu(adapter->netdev,
-				      ixgbe_upper_dev_walk, NULL);
+				      ixgbe_macvlan_up, adapter);
 }
 
 static void ixgbe_configure(struct ixgbe_adapter *adapter)
@@ -9776,13 +9781,12 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	adapter->ring_feature[RING_F_VMDQ].limit = limit + 1;
 
 	fwd_adapter->pool = pool;
-	fwd_adapter->real_adapter = adapter;
 
 	/* Force reinit of ring allocation with VMDQ enabled */
 	err = ixgbe_setup_tc(pdev, adapter->hw_tcs);
 
 	if (!err && netif_running(pdev))
-		err = ixgbe_fwd_ring_up(vdev, fwd_adapter);
+		err = ixgbe_fwd_ring_up(adapter, fwd_adapter);
 
 	if (!err)
 		return fwd_adapter;
@@ -9798,7 +9802,7 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 {
 	struct ixgbe_fwd_adapter *accel = priv;
-	struct ixgbe_adapter *adapter = accel->real_adapter;
+	struct ixgbe_adapter *adapter = netdev_priv(pdev);
 	unsigned int rxbase = accel->rx_base_queue;
 	unsigned int limit, i;
 

