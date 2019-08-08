From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:27 -0700
Subject: [Intel-wired-lan] [PATCH S27 04/15] ice: Rebuild VSI while changing
 queues
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

Currently, while the queues are being changed, the driver rebuilds
the VSI only when the netdev is running. However, the driver needs
to rebuild the VSI irrespective of the state of netdev. In this way,
alloc_txq / alloc_rxq fields of the VSI would be updated correctly.

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ca5175774f41..e0aa34064283 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4002,28 +4002,21 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx)
 		usleep_range(1000, 2000);
 	}
 
+	if (new_tx)
+		vsi->req_txq = new_tx;
+	if (new_rx)
+		vsi->req_rxq = new_rx;
+
 	/* set for the next time the netdev is started */
 	if (!netif_running(vsi->netdev)) {
-		if (new_tx)
-			vsi->req_txq = new_tx;
-		if (new_rx)
-			vsi->req_rxq = new_rx;
-
+		ice_vsi_rebuild(vsi, false);
 		dev_dbg(&pf->pdev->dev, "Link is down, queue count change happens when link is brought up\n");
 		goto done;
 	}
 
 	ice_vsi_close(vsi);
-
-	if (new_tx)
-		vsi->req_txq = new_tx;
-
-	if (new_rx)
-		vsi->req_rxq = new_rx;
-
 	ice_vsi_rebuild(vsi, false);
 	ice_pf_dcb_recfg(pf);
-
 	ice_vsi_open(vsi);
 done:
 	clear_bit(__ICE_CFG_BUSY, pf->state);
-- 
2.20.1

