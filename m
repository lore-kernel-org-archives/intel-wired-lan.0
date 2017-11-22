From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:34 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 04/16] ixgbe: There is
 no need to update num_rx_pools in L2 fwd offload
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185634.29785.72563.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The num_rx_pools value is overwritten when we reinitialize the queue
configuration. In reality we shouldn't need to be updating the value since
it is redone every time we call into ixgbe_setup_tc so for now just drop
the spots where we were incrementing or decrementing the value.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 8e2a957aca18..56622adc76dc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -701,7 +701,7 @@ static void ixgbe_set_num_queues(struct ixgbe_adapter *adapter)
 	adapter->num_rx_queues = 1;
 	adapter->num_tx_queues = 1;
 	adapter->num_xdp_queues = 0;
-	adapter->num_rx_pools = adapter->num_rx_queues;
+	adapter->num_rx_pools = 1;
 	adapter->num_rx_queues_per_pool = 1;
 
 #ifdef CONFIG_IXGBE_DCB
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 060474747ecc..c1df873faf68 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9833,7 +9833,6 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 		return ERR_PTR(-ENOMEM);
 
 	pool = find_first_zero_bit(&adapter->fwd_bitmask, 32);
-	adapter->num_rx_pools++;
 	set_bit(pool, &adapter->fwd_bitmask);
 	limit = find_last_bit(&adapter->fwd_bitmask, 32);
 
@@ -9862,7 +9861,6 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	netdev_info(pdev,
 		    "%s: dfwd hardware acceleration failed\n", vdev->name);
 	clear_bit(pool, &adapter->fwd_bitmask);
-	adapter->num_rx_pools--;
 	kfree(fwd_adapter);
 	return ERR_PTR(err);
 }
@@ -9874,7 +9872,6 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	unsigned int limit;
 
 	clear_bit(fwd_adapter->pool, &adapter->fwd_bitmask);
-	adapter->num_rx_pools--;
 
 	limit = find_last_bit(&adapter->fwd_bitmask, 32);
 	adapter->ring_feature[RING_F_VMDQ].limit = limit + 1;

