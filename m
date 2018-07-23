From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 23 Jul 2018 10:37:51 -0700
Subject: [Intel-wired-lan] [PATCH 12/13] ice: Fix potential return of
 uninitialized value
In-Reply-To: <20180723173752.19676-1-anirudh.venkataramanan@intel.com>
References: <20180723173752.19676-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180723173752.19676-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

In ice_vsi_setup_[tx|rx]_rings, err is uninitialized which can result in
a garbage value return to the caller. Fix that.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e5b8eb0c4581..3782569b450a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4887,7 +4887,7 @@ int ice_down(struct ice_vsi *vsi)
  */
 static int ice_vsi_setup_tx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (!vsi->num_txq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Tx queues\n",
@@ -4912,7 +4912,7 @@ static int ice_vsi_setup_tx_rings(struct ice_vsi *vsi)
  */
 static int ice_vsi_setup_rx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (!vsi->num_rxq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Rx queues\n",
-- 
2.14.3

