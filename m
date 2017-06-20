From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 20 Jun 2017 15:16:57 -0700
Subject: [Intel-wired-lan] [next PATCH S73-V2 5/9] i40e: fix odd formatting
	and indent
In-Reply-To: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170620221701.46765-5-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The compiler warned on an oddly indented bit of code, and when
investigating that, noted that the functions themselves had
an odd flow. The if condition was checked, and would exclude
a call to AQ, but then the aq_ret would be checked unconditionally
which just looks really weird, and is likely to cause objections.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index ecbe40e..e81cf4d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1741,16 +1741,14 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf,
 							    NULL);
 	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
 		hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
-			aq_ret = 0;
-			if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID) {
-				aq_ret =
-				i40e_aq_set_vsi_uc_promisc_on_vlan(hw,
-								   vsi->seid,
-								   alluni,
-								   f->vlan,
-								   NULL);
-				aq_err = pf->hw.aq.asq_last_status;
-			}
+			if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
+				continue;
+			aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw,
+								    vsi->seid,
+								    alluni,
+								    f->vlan,
+								    NULL);
+			aq_err = pf->hw.aq.asq_last_status;
 			if (aq_ret)
 				dev_err(&pf->pdev->dev,
 					"Could not add VLAN %d to Unicast promiscuous domain err %s aq_err %s\n",
-- 
2.9.3

