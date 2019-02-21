From: Joel Fernandes (Google) <joel@joelfernandes.org>
Date: Thu, 21 Feb 2019 00:49:39 -0500
Subject: [Intel-wired-lan] [PATCH RFC 2/5] ixgbe: Fix incorrect RCU API usage
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
Message-ID: <20190221054942.132388-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Recently, I added an RCU annotation check in rcu_assign_pointer. This
caused a sparse error to be reported by the ixgbe driver.

Further looking, it seems the adapter->xdp_prog pointer is not annotated
with __rcu. Annonating it fixed the error, but caused a bunch of other
warnings.

This patch tries to fix all warnings by using RCU API properly. This
makes sense to do because not using RCU properly can result in various
hard to find bugs. This is a best effort fix and is only build tested.
The sparse errors and warnings go away with the change. I request
maintainers / developers in this area to test it properly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 08d85e336bd4..3b14daf27516 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -311,7 +311,7 @@ struct ixgbe_ring {
 	struct ixgbe_ring *next;	/* pointer to next ring in q_vector */
 	struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
 	struct net_device *netdev;	/* netdev ring belongs to */
-	struct bpf_prog *xdp_prog;
+	struct bpf_prog __rcu *xdp_prog;
 	struct device *dev;		/* device for DMA mapping */
 	void *desc;			/* descriptor ring memory */
 	union {
@@ -560,7 +560,7 @@ struct ixgbe_adapter {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	/* OS defined structs */
 	struct net_device *netdev;
-	struct bpf_prog *xdp_prog;
+	struct bpf_prog __rcu *xdp_prog;
 	struct pci_dev *pdev;
 	struct mii_bus *mii_bus;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index daff8183534b..6aa59bb13a14 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2199,7 +2199,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 	u32 act;
 
 	rcu_read_lock();
-	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
+	xdp_prog = rcu_dereference(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
 		goto xdp_out;
@@ -6547,7 +6547,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 			     rx_ring->queue_index) < 0)
 		goto err;
 
-	rx_ring->xdp_prog = adapter->xdp_prog;
+	rcu_assign_pointer(rx_ring->xdp_prog, adapter->xdp_prog);
 
 	return 0;
 err:
@@ -10246,7 +10246,10 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	if (nr_cpu_ids > MAX_XDP_QUEUES)
 		return -ENOMEM;
 
-	old_prog = xchg(&adapter->xdp_prog, prog);
+	rcu_read_lock();
+	old_prog = rcu_dereference(adapter->xdp_prog);
+	rcu_assign_pointer(adapter->xdp_prog, prog);
+	rcu_read_unlock();
 
 	/* If transitioning XDP modes reconfigure rings */
 	if (!!prog != !!old_prog) {
@@ -10271,13 +10274,17 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 static int ixgbe_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct bpf_prog *prog;
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return ixgbe_xdp_setup(dev, xdp->prog);
 	case XDP_QUERY_PROG:
-		xdp->prog_id = adapter->xdp_prog ?
-			adapter->xdp_prog->aux->id : 0;
+		rcu_read_lock();
+		prog = rcu_dereference(adapter->xdp_prog);
+		xdp->prog_id = prog ? prog->aux->id : 0;
+		rcu_read_unlock();
+
 		return 0;
 	case XDP_QUERY_XSK_UMEM:
 		return ixgbe_xsk_umem_query(adapter, &xdp->xsk.umem,
-- 
2.21.0.rc0.258.g878e2cd30e-goog

