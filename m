From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:56 -0800
Subject: [Intel-wired-lan] [PATCH S17 10/17] ice: Remove unnecessary wait
 when disabling/enabling Rx queues
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

In ice_vsi_ctrl_rx_rings() we are unnecessarily waiting for
QRX_CTRL_QENA_REQ and QRX_CTRL_QENA_STAT to be the same value prior to
disabling each Rx queue. There is no reason to do this so remove
this wait loop as we already have a wait loop after disabling/enabling
the Rx queue through the QRX_CTRL register to make sure it gets
successfully disabled/enabled.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4c6ecc25aaa0..8e0a23e6b563 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -197,19 +197,13 @@ static int ice_vsi_ctrl_rx_rings(struct ice_vsi *vsi, bool ena)
 {
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
-	int i, j, ret = 0;
+	int i, ret = 0;
 
 	for (i = 0; i < vsi->num_rxq; i++) {
 		int pf_q = vsi->rxq_map[i];
 		u32 rx_reg;
 
-		for (j = 0; j < ICE_Q_WAIT_MAX_RETRY; j++) {
-			rx_reg = rd32(hw, QRX_CTRL(pf_q));
-			if (((rx_reg >> QRX_CTRL_QENA_REQ_S) & 1) ==
-			    ((rx_reg >> QRX_CTRL_QENA_STAT_S) & 1))
-				break;
-			usleep_range(1000, 2000);
-		}
+		rx_reg = rd32(hw, QRX_CTRL(pf_q));
 
 		/* Skip if the queue is already in the requested state */
 		if (ena == !!(rx_reg & QRX_CTRL_QENA_STAT_M))
-- 
2.14.5

