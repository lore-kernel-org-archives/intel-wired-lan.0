From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:51:11 -0800
Subject: [Intel-wired-lan] [PATCH S13 15/16] ice: use irq_num var in
 ice_vsi_req_irq_msix
In-Reply-To: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
References: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205112.12180-16-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Someone went through the effort of making this a variable so let's use
it instead of recalculating it again.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fa7351638815..fbeb7e023520 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1248,10 +1248,9 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 			/* skip this unused q_vector */
 			continue;
 		}
-		err = devm_request_irq(&pf->pdev->dev,
-				       pf->msix_entries[base + vector].vector,
-				       vsi->irq_handler, 0, q_vector->name,
-				       q_vector);
+		err = devm_request_irq(&pf->pdev->dev, irq_num,
+				       vsi->irq_handler, 0,
+				       q_vector->name, q_vector);
 		if (err) {
 			netdev_err(vsi->netdev,
 				   "MSIX request_irq failed, error: %d\n", err);
-- 
2.14.5

