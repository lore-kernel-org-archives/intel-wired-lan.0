From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue,  7 Nov 2017 12:06:07 -0800
Subject: [Intel-wired-lan] [net] i40e: fix the calculation of VFs mac
 addresses
Message-ID: <20171107200607.62104-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Zijie Pan <zijie.pan@6wind.com>

num_mac should be increased only after the call to i40e_add_mac_filter().

Fixes: 5f527ba962e2 ("i40e: Limit the number of MAC and VLAN addresses that can be added for VFs")
CC: Anjali Singhai Jain <anjali.singhai@intel.com>
CC: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Zijie Pan <zijie.pan@6wind.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Tushar Dave <tushar.n.dave@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4d1e670f490e..2d1f3dbe67f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2115,18 +2115,19 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 		struct i40e_mac_filter *f;
 
 		f = i40e_find_mac(vsi, al->list[i].addr);
-		if (!f)
+		if (!f) {
 			f = i40e_add_mac_filter(vsi, al->list[i].addr);
 
-		if (!f) {
-			dev_err(&pf->pdev->dev,
-				"Unable to add MAC filter %pM for VF %d\n",
-				 al->list[i].addr, vf->vf_id);
-			ret = I40E_ERR_PARAM;
-			spin_unlock_bh(&vsi->mac_filter_hash_lock);
-			goto error_param;
-		} else {
-			vf->num_mac++;
+			if (!f) {
+				dev_err(&pf->pdev->dev,
+					"Unable to add MAC filter %pM for VF %d\n",
+					al->list[i].addr, vf->vf_id);
+				ret = I40E_ERR_PARAM;
+				spin_unlock_bh(&vsi->mac_filter_hash_lock);
+				goto error_param;
+			} else {
+				vf->num_mac++;
+			}
 		}
 	}
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
