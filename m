From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:42 -0800
Subject: [Intel-wired-lan] [PATCH S11 15/16] ice: Fix for FC get rx/tx pause
 params
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-16-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Ethtool reported pause params based on the currently negotiated
link settings instead of current PHY config. User was not able
to turn off pause params because ethtool was incorrectly reporting
parameters as off when link was down even though PHY was configured
to support pause frames. Now pause params are taken from PHY config
instead of link status.

Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 37 +++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a93daf660171..295571b1c4e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1818,21 +1818,36 @@ static void
 ice_get_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_port_info *pi;
+	struct ice_port_info *pi = np->vsi->port_info;
+	struct ice_aqc_get_phy_caps_data *pcaps;
+	struct ice_vsi *vsi = np->vsi;
+	enum ice_status status;
 
-	pi = np->vsi->port_info;
-	pause->autoneg =
-		((pi->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) ?
-		 AUTONEG_ENABLE : AUTONEG_DISABLE);
+	/* Initialize pause params */
+	pause->rx_pause = 0;
+	pause->tx_pause = 0;
 
-	if (pi->fc.current_mode == ICE_FC_RX_PAUSE) {
-		pause->rx_pause = 1;
-	} else if (pi->fc.current_mode == ICE_FC_TX_PAUSE) {
+	pcaps = devm_kzalloc(&vsi->back->pdev->dev, sizeof(*pcaps),
+			     GFP_KERNEL);
+	if (!pcaps)
+		return;
+
+	/* Get current phy config */
+	status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG, pcaps,
+				     NULL);
+	if (status)
+		goto out;
+
+	pause->autoneg = ((pcaps->caps & ICE_AQC_PHY_AN_MODE) ?
+			AUTONEG_ENABLE : AUTONEG_DISABLE);
+
+	if (pcaps->caps & ICE_AQC_PHY_EN_TX_LINK_PAUSE)
 		pause->tx_pause = 1;
-	} else if (pi->fc.current_mode == ICE_FC_FULL) {
+	if (pcaps->caps & ICE_AQC_PHY_EN_RX_LINK_PAUSE)
 		pause->rx_pause = 1;
-		pause->tx_pause = 1;
-	}
+
+out:
+	devm_kfree(&vsi->back->pdev->dev, pcaps);
 }
 
 /**
-- 
2.14.5

