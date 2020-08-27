From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Date: Thu, 27 Aug 2020 10:34:10 +0800
Subject: [Intel-wired-lan] [PATCH] ice: Fix memleak in ice_set_ringparam
Message-ID: <20200827023410.3677-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When kcalloc() on rx_rings fails, we should free tx_rings
and xdp_rings to prevent memleak. Similarly, when
ice_alloc_rx_bufs() fails, we should free xdp_rings.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 9e8e9531cd87..caf64eb5e96d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2863,7 +2863,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 	rx_rings = kcalloc(vsi->num_rxq, sizeof(*rx_rings), GFP_KERNEL);
 	if (!rx_rings) {
 		err = -ENOMEM;
-		goto done;
+		goto free_xdp;
 	}
 
 	ice_for_each_rxq(vsi, i) {
@@ -2892,7 +2892,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 			}
 			kfree(rx_rings);
 			err = -ENOMEM;
-			goto free_tx;
+			goto free_xdp;
 		}
 	}
 
@@ -2943,6 +2943,15 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 	}
 	goto done;
 
+free_xdp:
+	if (xdp_rings) {
+		for (i = 0; i < vsi->num_xdp_txq; i++) {
+			ice_free_tx_ring(vsi->xdp_rings[i]);
+			*vsi->xdp_rings[i] = xdp_rings[i];
+		}
+		kfree(xdp_rings);
+	}
+
 free_tx:
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
-- 
2.17.1

