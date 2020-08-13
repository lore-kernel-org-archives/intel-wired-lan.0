From: Stefan Assmann <sassmann@kpanic.de>
Date: Thu, 13 Aug 2020 13:26:38 +0200
Subject: [Intel-wired-lan] [PATCH v2] i40e: fix return of uninitialized
 aq_ret in i40e_set_vsi_promisc
Message-ID: <20200813112638.12699-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function ?i40e_set_vsi_promisc?:
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1176:14: error: ?aq_ret? may be used uninitialized in this function [-Werror=maybe-uninitialized]
  i40e_status aq_ret;

In case the code inside the if statement and the for loop does not get
executed aq_ret will be uninitialized when the variable gets returned at
the end of the function.

Avoid this by changing num_vlans from int to u16, so aq_ret always gets
set. Making this change in additional places as num_vlans should never
be negative.

Fixes: 37d318d7805f ("i40e: Remove scheduling while atomic possibility")
Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8e133d6545bd..90ef810cba97 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1115,7 +1115,7 @@ static int i40e_quiesce_vf_pci(struct i40e_vf *vf)
 static int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
 {
 	struct i40e_mac_filter *f;
-	int num_vlans = 0, bkt;
+	u16 num_vlans = 0, bkt;
 
 	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
 		if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
@@ -1134,7 +1134,7 @@ static int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
  *
  * Called to get number of VLANs and VLAN list present in mac_filter_hash.
  **/
-static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, int *num_vlans,
+static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, u16 *num_vlans,
 					   s16 **vlan_list)
 {
 	struct i40e_mac_filter *f;
@@ -1169,7 +1169,7 @@ static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, int *num_vlans,
  **/
 static i40e_status
 i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
-		     bool unicast_enable, s16 *vl, int num_vlans)
+		     bool unicast_enable, s16 *vl, u16 num_vlans)
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
@@ -1258,7 +1258,7 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 	i40e_status aq_ret = I40E_SUCCESS;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi;
-	int num_vlans;
+	u16 num_vlans;
 	s16 *vl;
 
 	vsi = i40e_find_vsi_from_id(pf, vsi_id);
-- 
2.26.2

