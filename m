From: Paul E. McKenney <paulmck@linux.ibm.com>
Date: Sun, 11 Nov 2018 11:43:42 -0800
Subject: [Intel-wired-lan] [PATCH tip/core/rcu 13/41] ethernet/intel/ixgbe:
 Replace synchronize_sched() with synchronize_rcu()
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
Message-ID: <20181111194410.6368-13-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Now that synchronize_rcu() waits for preempt-disable regions of code
as well as RCU read-side critical sections, synchronize_sched() can be
replaced by synchronize_rcu().  This commit therefore makes this change.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <intel-wired-lan@lists.osuosl.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 113b38e0defb..e8095bdf46de 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6077,9 +6077,9 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 	/* Disable Rx */
 	ixgbe_disable_rx(adapter);
 
-	/* synchronize_sched() needed for pending XDP buffers to drain */
+	/* synchronize_rcu() needed for pending XDP buffers to drain */
 	if (adapter->xdp_ring[0])
-		synchronize_sched();
+		synchronize_rcu();
 
 	ixgbe_irq_disable(adapter);
 
@@ -10476,7 +10476,7 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	ixgbe_disable_rxr_hw(adapter, rx_ring);
 
 	if (xdp_ring)
-		synchronize_sched();
+		synchronize_rcu();
 
 	/* Rx/Tx/XDP Tx share the same napi context. */
 	napi_disable(&rx_ring->q_vector->napi);
-- 
2.17.1

