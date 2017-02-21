From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:45 -0800
Subject: [Intel-wired-lan] [next PATCH S61 07/10] i40e: removed no longer
	needed delays
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Removed no longer needed delays & structs associated with them.
At preproduction stage those delays were needed but now these
delays are not needed.

Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9426174..bbd69a0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4206,8 +4206,6 @@ static int i40e_vsi_control_txq(struct i40e_vsi *vsi, bool enable, int pf_q)
  **/
 static int i40e_vsi_control_tx(struct i40e_vsi *vsi, bool enable)
 {
-	struct i40e_pf *pf = vsi->back;
-	struct i40e_hw *hw = &pf->hw;
 	int i, pf_q, ret = 0;
 
 	pf_q = vsi->base_queue;
@@ -4225,9 +4223,6 @@ static int i40e_vsi_control_tx(struct i40e_vsi *vsi, bool enable)
 				break;
 		}
 	}
-
-	if (hw->revision_id == 0)
-		mdelay(50);
 	return ret;
 }
 
-- 
2.4.11

