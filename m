From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Tue, 17 Dec 2019 16:20:47 +0000
Subject: [Intel-wired-lan] [PATCH bpf v2 4/4] net/ixgbe: Fix concurrency
 issues between config flow and XSK
In-Reply-To: <20191217162023.16011-1-maximmi@mellanox.com>
References: <20191217162023.16011-1-maximmi@mellanox.com>
Message-ID: <20191217162023.16011-5-maximmi@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use synchronize_rcu to wait until the XSK wakeup function finishes
before destroying the resources it uses:

1. ixgbe_down already calls synchronize_rcu after setting __IXGBE_DOWN.

2. After switching the XDP program, call synchronize_rcu to let
ixgbe_xsk_wakeup exit before the XDP program is freed.

3. Changing the number of channels brings the interface down.

4. Disabling UMEM sets __IXGBE_TX_DISABLED before closing hardware
resources and resetting xsk_umem. Check that bit in ixgbe_xsk_wakeup to
avoid using the XDP ring when it's already destroyed. synchronize_rcu is
called from ixgbe_txrx_ring_disable.

Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 ++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 25c097cd8100..82a30b597cf9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10261,7 +10261,12 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 
 	/* If transitioning XDP modes reconfigure rings */
 	if (need_reset) {
-		int err = ixgbe_setup_tc(dev, adapter->hw_tcs);
+		int err;
+
+		if (!prog)
+			/* Wait until ndo_xsk_wakeup completes. */
+			synchronize_rcu();
+		err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
 		if (err) {
 			rcu_assign_pointer(adapter->xdp_prog, old_prog);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index d6feaacfbf89..b43be9f14105 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -709,10 +709,14 @@ int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 	if (qid >= adapter->num_xdp_queues)
 		return -ENXIO;
 
-	if (!adapter->xdp_ring[qid]->xsk_umem)
+	ring = adapter->xdp_ring[qid];
+
+	if (test_bit(__IXGBE_TX_DISABLED, &ring->state))
+		return -ENETDOWN;
+
+	if (!ring->xsk_umem)
 		return -ENXIO;
 
-	ring = adapter->xdp_ring[qid];
 	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
 		u64 eics = BIT_ULL(ring->q_vector->v_idx);
 
-- 
2.20.1

