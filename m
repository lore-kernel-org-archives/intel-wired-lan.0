From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Thu, 17 Feb 2022 10:45:32 +0100
Subject: [Intel-wired-lan] [PATCH net v1] Revert "i40e: Fix reset bw limit
 when DCB enabled with 1 TC"
Message-ID: <20220217094532.14543-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Revert of a patch that instead of fixing a AQ error when trying
to reset bw limit introduced a several regression related to
creation and managing tc. Currently there are errors when creating
a tc on both pf and vf.

This reverts commit 3d2504663c41104b4359a15f35670cfa82de1bbf.

Fixes: 3d250466 (i40e: Fix reset bw limit when DCB enabled with 1 TC)
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8572993..2f8ddfa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5372,15 +5372,7 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_vsi *vsi, u8 enabled_tc,
 	/* There is no need to reset BW when mqprio mode is on.  */
 	if (pf->flags & I40E_FLAG_TC_MQPRIO)
 		return 0;
-
-	if (!vsi->mqprio_qopt.qopt.hw) {
-		if (pf->flags & I40E_FLAG_DCB_ENABLED)
-			goto skip_reset;
-
-		if (IS_ENABLED(CONFIG_I40E_DCB) &&
-		    i40e_dcb_hw_get_num_tc(&pf->hw) == 1)
-			goto skip_reset;
-
+	if (!vsi->mqprio_qopt.qopt.hw && !(pf->flags & I40E_FLAG_DCB_ENABLED)) {
 		ret = i40e_set_bw_limit(vsi, vsi->seid, 0);
 		if (ret)
 			dev_info(&pf->pdev->dev,
@@ -5388,8 +5380,6 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_vsi *vsi, u8 enabled_tc,
 				 vsi->seid);
 		return ret;
 	}
-
-skip_reset:
 	memset(&bw_data, 0, sizeof(bw_data));
 	bw_data.tc_valid_bits = enabled_tc;
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++)
-- 
2.27.0

