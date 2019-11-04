From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon,  4 Nov 2019 01:30:58 -0800
Subject: [Intel-wired-lan] [PATCH S32 v2 05/15] ice: Fix to change Rx/Tx
 ring descriptor size via ethtool with DCBx
In-Reply-To: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
References: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
Message-ID: <20191104093108.21542-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Usha Ketineni <usha.k.ketineni@intel.com>

This patch fixes the call trace caused by the kernel when the Rx/Tx
descriptor size change request is initiated via ethtool when DCB is
configured. ice_set_ringparam() should use vsi->num_txq instead of
vsi->alloc_txq as it represents the queues that are enabled in the
driver when DCB is enabled/disabled. Otherwise, queue index being
used can go out of range.

For example, when vsi->alloc_txq has 104 queues and with 3 TCS enabled
via DCB, each TC gets 34 queues, vsi->num_txq will be 102 and only 102
queues will be enabled.

Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 67d884e27ea4..3b9d33ad23d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2743,14 +2743,14 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 	netdev_info(netdev, "Changing Tx descriptor count from %d to %d\n",
 		    vsi->tx_rings[0]->count, new_tx_cnt);
 
-	tx_rings = devm_kcalloc(&pf->pdev->dev, vsi->alloc_txq,
+	tx_rings = devm_kcalloc(&pf->pdev->dev, vsi->num_txq,
 				sizeof(*tx_rings), GFP_KERNEL);
 	if (!tx_rings) {
 		err = -ENOMEM;
 		goto done;
 	}
 
-	for (i = 0; i < vsi->alloc_txq; i++) {
+	ice_for_each_txq(vsi, i) {
 		/* clone ring and setup updated count */
 		tx_rings[i] = *vsi->tx_rings[i];
 		tx_rings[i].count = new_tx_cnt;
@@ -2803,14 +2803,14 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 	netdev_info(netdev, "Changing Rx descriptor count from %d to %d\n",
 		    vsi->rx_rings[0]->count, new_rx_cnt);
 
-	rx_rings = devm_kcalloc(&pf->pdev->dev, vsi->alloc_rxq,
+	rx_rings = devm_kcalloc(&pf->pdev->dev, vsi->num_rxq,
 				sizeof(*rx_rings), GFP_KERNEL);
 	if (!rx_rings) {
 		err = -ENOMEM;
 		goto done;
 	}
 
-	for (i = 0; i < vsi->alloc_rxq; i++) {
+	ice_for_each_rxq(vsi, i) {
 		/* clone ring and setup updated count */
 		rx_rings[i] = *vsi->rx_rings[i];
 		rx_rings[i].count = new_rx_cnt;
@@ -2848,7 +2848,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 		ice_down(vsi);
 
 		if (tx_rings) {
-			for (i = 0; i < vsi->alloc_txq; i++) {
+			ice_for_each_txq(vsi, i) {
 				ice_free_tx_ring(vsi->tx_rings[i]);
 				*vsi->tx_rings[i] = tx_rings[i];
 			}
@@ -2856,7 +2856,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 		}
 
 		if (rx_rings) {
-			for (i = 0; i < vsi->alloc_rxq; i++) {
+			ice_for_each_rxq(vsi, i) {
 				ice_free_rx_ring(vsi->rx_rings[i]);
 				/* copy the real tail offset */
 				rx_rings[i].tail = vsi->rx_rings[i]->tail;
@@ -2890,7 +2890,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 free_tx:
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
-		for (i = 0; i < vsi->alloc_txq; i++)
+		ice_for_each_txq(vsi, i)
 			ice_free_tx_ring(&tx_rings[i]);
 		devm_kfree(&pf->pdev->dev, tx_rings);
 	}
-- 
2.20.1

