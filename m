From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Wed, 6 Oct 2021 13:09:08 -0500
Subject: [Intel-wired-lan] [PATCH][next] ice: use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <20211006180908.GA913430@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 16de603b280c..38960bcc384c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -706,7 +706,7 @@ ice_create_init_fdir_rule(struct ice_pf *pf, enum ice_fltr_ptype flow)
 	if (!seg)
 		return -ENOMEM;
 
-	tun_seg = devm_kzalloc(dev, sizeof(*seg) * ICE_FD_HW_SEG_MAX,
+	tun_seg = devm_kcalloc(dev, sizeof(*seg), ICE_FD_HW_SEG_MAX,
 			       GFP_KERNEL);
 	if (!tun_seg) {
 		devm_kfree(dev, seg);
@@ -1068,7 +1068,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 	if (!seg)
 		return -ENOMEM;
 
-	tun_seg = devm_kzalloc(dev, sizeof(*seg) * ICE_FD_HW_SEG_MAX,
+	tun_seg = devm_kcalloc(dev, sizeof(*seg), ICE_FD_HW_SEG_MAX,
 			       GFP_KERNEL);
 	if (!tun_seg) {
 		devm_kfree(dev, seg);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 13b2bdc25b0d..fd10f8548feb 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -340,7 +340,7 @@ int ice_setup_tx_ring(struct ice_ring *tx_ring)
 	/* warn if we are about to overwrite the pointer */
 	WARN_ON(tx_ring->tx_buf);
 	tx_ring->tx_buf =
-		devm_kzalloc(dev, sizeof(*tx_ring->tx_buf) * tx_ring->count,
+		devm_kcalloc(dev, sizeof(*tx_ring->tx_buf), tx_ring->count,
 			     GFP_KERNEL);
 	if (!tx_ring->tx_buf)
 		return -ENOMEM;
@@ -464,7 +464,7 @@ int ice_setup_rx_ring(struct ice_ring *rx_ring)
 	/* warn if we are about to overwrite the pointer */
 	WARN_ON(rx_ring->rx_buf);
 	rx_ring->rx_buf =
-		devm_kzalloc(dev, sizeof(*rx_ring->rx_buf) * rx_ring->count,
+		devm_kcalloc(dev, sizeof(*rx_ring->rx_buf), rx_ring->count,
 			     GFP_KERNEL);
 	if (!rx_ring->rx_buf)
 		return -ENOMEM;
-- 
2.27.0

