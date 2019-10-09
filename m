From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Oct 2019 07:09:47 -0700
Subject: [Intel-wired-lan] [PATCH S31 09/15] ice: Check for null pointer
 dereference when setting rings
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20191009140953.14087-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Without this check rebuild vsi can lead to kernel panic.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 57dcd6142a41..2493be3289ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4563,8 +4563,13 @@ int ice_vsi_setup_tx_rings(struct ice_vsi *vsi)
 	}
 
 	ice_for_each_txq(vsi, i) {
-		vsi->tx_rings[i]->netdev = vsi->netdev;
-		err = ice_setup_tx_ring(vsi->tx_rings[i]);
+		struct ice_ring *ring = vsi->tx_rings[i];
+
+		if (!ring)
+			return -EINVAL;
+
+		ring->netdev = vsi->netdev;
+		err = ice_setup_tx_ring(ring);
 		if (err)
 			break;
 	}
@@ -4589,8 +4594,13 @@ int ice_vsi_setup_rx_rings(struct ice_vsi *vsi)
 	}
 
 	ice_for_each_rxq(vsi, i) {
-		vsi->rx_rings[i]->netdev = vsi->netdev;
-		err = ice_setup_rx_ring(vsi->rx_rings[i]);
+		struct ice_ring *ring = vsi->rx_rings[i];
+
+		if (!ring)
+			return -EINVAL;
+
+		ring->netdev = vsi->netdev;
+		err = ice_setup_rx_ring(ring);
 		if (err)
 			break;
 	}
-- 
2.20.1

