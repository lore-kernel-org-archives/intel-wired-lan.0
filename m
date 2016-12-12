From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:15 -0800
Subject: [Intel-wired-lan] [next PATCH S57 09/11] i40e: properly convert
	le16 value to CPU format
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This ensures that the pvid which is stored in __le16 format is converted
to the CPU format. This will fix comparison issues on Big Endian
platforms.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I92c80d1315dc2a0f9f095d5a0c48d461beb052ed
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 128a21e..99ea5652 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1260,6 +1260,7 @@ static int i40e_correct_mac_vlan_filters(struct i40e_vsi *vsi,
 					 struct hlist_head *tmp_del_list,
 					 int vlan_filters)
 {
+	s16 pvid = le16_to_cpu(vsi->info.pvid);
 	struct i40e_mac_filter *f, *add_head;
 	struct i40e_new_mac_filter *new;
 	struct hlist_node *h;
@@ -1281,8 +1282,8 @@ static int i40e_correct_mac_vlan_filters(struct i40e_vsi *vsi,
 
 	/* Update the filters about to be added in place */
 	hlist_for_each_entry(new, tmp_add_list, hlist) {
-		if (vsi->info.pvid && new->f->vlan != vsi->info.pvid)
-			new->f->vlan = vsi->info.pvid;
+		if (pvid && new->f->vlan != pvid)
+			new->f->vlan = pvid;
 		else if (vlan_filters && new->f->vlan == I40E_VLAN_ANY)
 			new->f->vlan = 0;
 		else if (!vlan_filters && new->f->vlan == 0)
@@ -1296,12 +1297,12 @@ static int i40e_correct_mac_vlan_filters(struct i40e_vsi *vsi,
 		 * order to avoid duplicating code for adding the new filter
 		 * then deleting the old filter.
 		 */
-		if ((vsi->info.pvid && f->vlan != vsi->info.pvid) ||
+		if ((pvid && f->vlan != pvid) ||
 		    (vlan_filters && f->vlan == I40E_VLAN_ANY) ||
 		    (!vlan_filters && f->vlan == 0)) {
 			/* Determine the new vlan we will be adding */
-			if (vsi->info.pvid)
-				new_vlan = vsi->info.pvid;
+			if (pvid)
+				new_vlan = pvid;
 			else if (vlan_filters)
 				new_vlan = 0;
 			else
-- 
2.4.11

