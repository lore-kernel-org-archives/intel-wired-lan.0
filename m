From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:16 -0700
Subject: [Intel-wired-lan] [PATCH S44 04/14] ice: Add XDP Tx to VSI ring
 stats
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marta Plantykow <marta.a.plantykow@intel.com>

When XDP Tx program is loaded and packets are sent from
interface, VSI statistics are not updated. This patch adds
packets sent on Tx XDP ring to VSI ring stats.

Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 42 ++++++++++++++++++-----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 61c7d0b57f02..a74b2ce6956a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4281,6 +4281,33 @@ ice_fetch_u64_stats_per_ring(struct ice_ring *ring, u64 *pkts, u64 *bytes)
 	} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 }
 
+/**
+ * ice_update_vsi_tx_ring_stats - Update VSI Tx ring stats counters
+ * @vsi: the VSI to be updated
+ * @rings: rings to work on
+ * @count: number of rings
+ */
+static void
+ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_ring **rings,
+			     u16 count)
+{
+	struct rtnl_link_stats64 *vsi_stats = &vsi->net_stats;
+	u16 i;
+
+	for (i = 0; i < count; i++) {
+		struct ice_ring *ring;
+		u64 pkts, bytes;
+
+		ring = READ_ONCE(rings[i]);
+		ice_fetch_u64_stats_per_ring(ring, &pkts, &bytes);
+		vsi_stats->tx_packets += pkts;
+		vsi_stats->tx_bytes += bytes;
+		vsi->tx_restart += ring->tx_stats.restart_q;
+		vsi->tx_busy += ring->tx_stats.tx_busy;
+		vsi->tx_linearize += ring->tx_stats.tx_linearize;
+	}
+}
+
 /**
  * ice_update_vsi_ring_stats - Update VSI stats counters
  * @vsi: the VSI to be updated
@@ -4308,15 +4335,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	rcu_read_lock();
 
 	/* update Tx rings counters */
-	ice_for_each_txq(vsi, i) {
-		ring = READ_ONCE(vsi->tx_rings[i]);
-		ice_fetch_u64_stats_per_ring(ring, &pkts, &bytes);
-		vsi_stats->tx_packets += pkts;
-		vsi_stats->tx_bytes += bytes;
-		vsi->tx_restart += ring->tx_stats.restart_q;
-		vsi->tx_busy += ring->tx_stats.tx_busy;
-		vsi->tx_linearize += ring->tx_stats.tx_linearize;
-	}
+	ice_update_vsi_tx_ring_stats(vsi, vsi->tx_rings, vsi->num_txq);
 
 	/* update Rx rings counters */
 	ice_for_each_rxq(vsi, i) {
@@ -4328,6 +4347,11 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		vsi->rx_page_failed += ring->rx_stats.alloc_page_failed;
 	}
 
+	/* update XDP Tx rings counters */
+	if (ice_is_xdp_ena_vsi(vsi))
+		ice_update_vsi_tx_ring_stats(vsi, vsi->xdp_rings,
+					     vsi->num_xdp_txq);
+
 	rcu_read_unlock();
 }
 
-- 
2.20.1

