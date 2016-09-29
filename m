From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Thu, 29 Sep 2016 10:11:24 -0700
Subject: [Intel-wired-lan] [next PATCH S49 04/15] i40e: fix
	i40e_put_mac_in_vlan to return actual filter added
In-Reply-To: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
References: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475169095-20873-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Rather than returning an arbitrary first filter in the list, which will
thus return non-null as long as there is even one filter in the list
unless an add fails, we should return an actual filter we added. This
way, if there is no matching vlan we error out correctly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I2325dfd843aec76d89fb0d7cb0e7c4f290a34840
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e31821d..1519b46 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1312,27 +1312,28 @@ void i40e_del_filter(struct i40e_vsi *vsi, const u8 *macaddr, s16 vlan)
  * @vsi: the VSI to be searched
  * @macaddr: the mac address to be filtered
  *
- * Goes through all the macvlan filters and adds a
- * macvlan filter for each unique vlan that already exists
+ * Goes through all the macvlan filters and adds a macvlan filter for each
+ * unique vlan that already exists. If a PVID has been assigned, instead only
+ * add the macaddr to that VLAN.
  *
- * Returns first filter found on success, else NULL
+ * Returns last filter added on success, else NULL
  **/
 struct i40e_mac_filter *i40e_put_mac_in_vlan(struct i40e_vsi *vsi,
 					     const u8 *macaddr)
 {
-	struct i40e_mac_filter *f;
+	struct i40e_mac_filter *f, *add = NULL;
+
+	if (vsi->info.pvid)
+		return i40e_add_filter(vsi, macaddr,
+				       le16_to_cpu(vsi->info.pvid));
 
 	list_for_each_entry(f, &vsi->mac_filter_list, list) {
-		if (vsi->info.pvid)
-			f->vlan = le16_to_cpu(vsi->info.pvid);
-		if (!i40e_find_filter(vsi, macaddr, f->vlan)) {
-			if (!i40e_add_filter(vsi, macaddr, f->vlan))
-				return NULL;
-		}
+		add = i40e_add_filter(vsi, macaddr, f->vlan);
+		if (!add)
+			return NULL;
 	}
 
-	return list_first_entry_or_null(&vsi->mac_filter_list,
-					struct i40e_mac_filter, list);
+	return add;
 }
 
 /**
-- 
2.4.11

