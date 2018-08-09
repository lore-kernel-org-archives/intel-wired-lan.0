From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu,  9 Aug 2018 06:29:01 -0700
Subject: [Intel-wired-lan] [PATCH v4 11/13] ice: Fix potential return of
 uninitialized value
In-Reply-To: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180809132903.22819-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

In ice_vsi_setup_[tx|rx]_rings, err is uninitialized which can result in
a garbage value return to the caller. Fix that.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d5d83c8848f8..e23156515186 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4885,7 +4885,7 @@ int ice_down(struct ice_vsi *vsi)
  */
 static int ice_vsi_setup_tx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (!vsi->num_txq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Tx queues\n",
@@ -4910,7 +4910,7 @@ static int ice_vsi_setup_tx_rings(struct ice_vsi *vsi)
  */
 static int ice_vsi_setup_rx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (!vsi->num_rxq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Rx queues\n",
-- 
2.17.1

