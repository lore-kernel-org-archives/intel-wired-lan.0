From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Mar 2022 19:36:27 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 1/3] ice: synchronize_rcu() when
 terminating rings
In-Reply-To: <20220317183629.340350-1-maciej.fijalkowski@intel.com>
References: <20220317183629.340350-1-maciej.fijalkowski@intel.com>
Message-ID: <20220317183629.340350-2-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Unfortunately, the ice driver doesn't respect the RCU critical section that
XSK wakeup is surrounded with. To fix this, add synchronize_rcu() calls to
paths that destroy resources that might be in use.

This was addressed in other AF_XDP ZC enabled drivers, for reference see
for example commit b3873a5be757 ("net/i40e: Fix concurrency issues
between config flow and XSK")

Fixes: efc2214b6047 ("ice: Add support for XDP")
Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c | 4 +++-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index bea1d1e39fa2..211d91be53a0 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -672,7 +672,7 @@ static inline struct ice_pf *ice_netdev_to_pf(struct net_device *netdev)
 
 static inline bool ice_is_xdp_ena_vsi(struct ice_vsi *vsi)
 {
-	return !!vsi->xdp_prog;
+	return !!READ_ONCE(vsi->xdp_prog);
 }
 
 static inline void ice_set_ring_xdp(struct ice_tx_ring *ring)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b7e8744b0c0a..c3c73a61bfd0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2729,8 +2729,10 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 
 	ice_for_each_xdp_txq(vsi, i)
 		if (vsi->xdp_rings[i]) {
-			if (vsi->xdp_rings[i]->desc)
+			if (vsi->xdp_rings[i]->desc) {
+				synchronize_rcu();
 				ice_free_tx_ring(vsi->xdp_rings[i]);
+			}
 			kfree_rcu(vsi->xdp_rings[i], rcu);
 			vsi->xdp_rings[i] = NULL;
 		}
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 2388837d6d6c..24a8f54c32df 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -41,8 +41,10 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (ice_is_xdp_ena_vsi(vsi)) {
+		synchronize_rcu();
 		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
+	}
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
 }
 
-- 
2.27.0

