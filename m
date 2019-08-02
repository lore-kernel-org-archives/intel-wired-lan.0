From: Chuhong Yuan <hslester96@gmail.com>
Date: Fri,  2 Aug 2019 18:55:07 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use refcount_t for refcount
Message-ID: <20190802105507.16650-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

refcount_t is better for reference counters since its
implementation can prevent overflows.
So convert atomic_t ref counters to refcount_t.

Also convert refcount from 0-based to 1-based.

This patch depends on PATCH 1/2.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 6 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 00710f43cfd2..d313d00065cd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -773,7 +773,7 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
 
 	fcoe->extra_ddp_buffer = buffer;
 	fcoe->extra_ddp_buffer_dma = dma;
-	atomic_set(&fcoe->refcnt, 0);
+	refcount_set(&fcoe->refcnt, 1);
 
 	/* allocate pci pool for each cpu */
 	for_each_possible_cpu(cpu) {
@@ -837,7 +837,7 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_fcoe *fcoe = &adapter->fcoe;
 
-	atomic_inc(&fcoe->refcnt);
+	refcount_inc(&fcoe->refcnt);
 
 	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
 		return -EINVAL;
@@ -883,7 +883,7 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 
-	if (!atomic_dec_and_test(&adapter->fcoe.refcnt))
+	if (!refcount_dec_and_test(&adapter->fcoe.refcnt))
 		return -EINVAL;
 
 	if (!(adapter->flags & IXGBE_FLAG_FCOE_ENABLED))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
index 724f5382329f..7ace5fee6ede 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
@@ -51,7 +51,7 @@ struct ixgbe_fcoe_ddp_pool {
 
 struct ixgbe_fcoe {
 	struct ixgbe_fcoe_ddp_pool __percpu *ddp_pool;
-	atomic_t refcnt;
+	refcount_t refcnt;
 	spinlock_t lock;
 	struct ixgbe_fcoe_ddp ddp[IXGBE_FCOE_DDP_MAX_X550];
 	void *extra_ddp_buffer;
-- 
2.20.1

