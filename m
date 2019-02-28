From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:51 -0800
Subject: [Intel-wired-lan] [PATCH S17 05/17] ice: Reduce scope of variable
 in ice_vsi_cfg_rxqs
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Reduce scope of the variable 'err' to inside the for loop instead
of using it as a second looping conditional. Also while here,
improve the debug message if we fail to configure a Rx queue.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index fa8ebd8a10ce..61bb9e92f6ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1641,7 +1641,6 @@ int ice_vsi_kill_vlan(struct ice_vsi *vsi, u16 vid)
  */
 int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
 {
-	int err = 0;
 	u16 i;
 
 	if (vsi->type == ICE_VSI_VF)
@@ -1656,14 +1655,19 @@ int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
 	vsi->rx_buf_len = ICE_RXBUF_2048;
 setup_rings:
 	/* set up individual rings */
-	for (i = 0; i < vsi->num_rxq && !err; i++)
-		err = ice_setup_rx_ctx(vsi->rx_rings[i]);
+	for (i = 0; i < vsi->num_rxq; i++) {
+		int err;
 
-	if (err) {
-		dev_err(&vsi->back->pdev->dev, "ice_setup_rx_ctx failed\n");
-		return -EIO;
+		err = ice_setup_rx_ctx(vsi->rx_rings[i]);
+		if (err) {
+			dev_err(&vsi->back->pdev->dev,
+				"ice_setup_rx_ctx failed for RxQ %d, err %d\n",
+				i, err);
+			return err;
+		}
 	}
-	return err;
+
+	return 0;
 }
 
 /**
-- 
2.14.5

