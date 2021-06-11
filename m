From: =?unknown-8bit?q?J=C4=99drzej?= Jagielski <jedrzej.jagielski@intel.com>
Date: Fri, 11 Jun 2021 22:54:35 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor arrow operator
 usage in i40e_update_adq_vsi_queues()
Message-ID: <20210611225435.95070-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use local pf & hw variables instead of multiple arrow operators.
Move pf & hw variables initialization after checking if vsi is not NULL.

Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fce05ad24..6a11002c8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5450,16 +5450,18 @@ static void i40e_vsi_update_queue_map(struct i40e_vsi *vsi,
  */
 int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset)
 {
-	struct i40e_pf *pf = vsi->back;
-	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vsi_context ctxt = {};
-	int ret = 0;
+	struct i40e_pf *pf;
+	struct i40e_hw *hw;
+	int ret;
 
 	if (!vsi)
 		return I40E_ERR_PARAM;
+	pf = vsi->back;
+	hw = &pf->hw;
 
 	ctxt.seid = vsi->seid;
-	ctxt.pf_num = vsi->back->hw.pf_id;
+	ctxt.pf_num = hw->pf_id;
 	ctxt.vf_num = vsi->vf_id + hw->func_caps.vf_base_id + vsi_offset;
 	ctxt.uplink_seid = vsi->uplink_seid;
 	ctxt.connection_type = I40E_AQ_VSI_CONN_TYPE_NORMAL;
@@ -5469,11 +5471,11 @@ int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset)
 	i40e_vsi_setup_queue_map(vsi, &ctxt, vsi->tc_config.enabled_tc,
 				 false);
 	if (vsi->reconfig_rss) {
-		vsi->rss_size = min_t(int, vsi->back->alloc_rss_size,
+		vsi->rss_size = min_t(int, pf->alloc_rss_size,
 				      vsi->num_queue_pairs);
 		ret = i40e_vsi_config_rss(vsi);
 		if (ret) {
-			dev_info(&vsi->back->pdev->dev, "Failed to reconfig rss for num_queues\n");
+			dev_info(&pf->pdev->dev, "Failed to reconfig rss for num_queues\n");
 			return ret;
 		}
 		vsi->reconfig_rss = false;
-- 
2.27.0

