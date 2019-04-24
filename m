From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:47 -0700
Subject: [Intel-wired-lan] [next PATCH S5 02/10] i40e: add constraints for
 accessing veb array
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <20190424122055.27896-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Add veb array access boundary checks.
Ensure veb array index is smaller than I40E_MAX_VEB.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4e1aacd72b02..5716f8fe06ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9042,7 +9042,7 @@ static void i40e_link_event(struct i40e_pf *pf)
 	/* Notify the base of the switch tree connected to
 	 * the link.  Floating VEBs are not notified.
 	 */
-	if (pf->lan_veb != I40E_NO_VEB && pf->veb[pf->lan_veb])
+	if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
 		i40e_veb_link_event(pf->veb[pf->lan_veb], new_link);
 	else
 		i40e_vsi_link_event(vsi, new_link);
@@ -13001,7 +13001,7 @@ int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi)
 	struct i40e_pf *pf = vsi->back;
 
 	/* Uplink is not a bridge so default to VEB */
-	if (vsi->veb_idx == I40E_NO_VEB)
+	if (vsi->veb_idx >= I40E_MAX_VEB)
 		return 1;
 
 	veb = pf->veb[vsi->veb_idx];
@@ -14059,7 +14059,7 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 		/* Main VEB? */
 		if (uplink_seid != pf->mac_seid)
 			break;
-		if (pf->lan_veb == I40E_NO_VEB) {
+		if (pf->lan_veb >= I40E_MAX_VEB) {
 			int v;
 
 			/* find existing or else empty VEB */
@@ -14069,13 +14069,15 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 					break;
 				}
 			}
-			if (pf->lan_veb == I40E_NO_VEB) {
+			if (pf->lan_veb >= I40E_MAX_VEB) {
 				v = i40e_veb_mem_alloc(pf);
 				if (v < 0)
 					break;
 				pf->lan_veb = v;
 			}
 		}
+		if (pf->lan_veb >= I40E_MAX_VEB)
+			break;
 
 		pf->veb[pf->lan_veb]->seid = seid;
 		pf->veb[pf->lan_veb]->uplink_seid = pf->mac_seid;
@@ -14229,7 +14231,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
 		/* Set up the PF VSI associated with the PF's main VSI
 		 * that is already in the HW switch
 		 */
-		if (pf->lan_veb != I40E_NO_VEB && pf->veb[pf->lan_veb])
+		if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
 			uplink_seid = pf->veb[pf->lan_veb]->seid;
 		else
 			uplink_seid = pf->mac_seid;
-- 
2.19.2

