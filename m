From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  5 Oct 2016 09:30:34 -0700
Subject: [Intel-wired-lan] [next PATCH S49-V2 04/15] i40e: refactor
	i40e_put_mac_in_vlan to avoid changing f->vlan
In-Reply-To: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475685046-16900-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When a pvid has been assigned to a VSI, the function
i40e_put_mac_in_vlan arbitrarily modifies all filters
to have the same vlan. This is obviously incorrect
because it could be modifying active filters without
putting them into the NEW state. The correct method
is to remove then re-add filters which is already done
in the code where we assign the PVID.

Fix this issue and a few other minor nits at the same
time. First, when we have a PVID don't even bother
looping and simply add the filter with the PVID immediately.

In the case of the loop, we now can remove several checks.
We also don't need to use i40e_find_filter first before
calling i40e_add_filter, since i40e_add_filter implicitely
does a lookup already.

Finally, update the return semantics of this function so
that on failure to add a filter it returns NULL, but on
success, it returns the last filter added. Otherwise,
we're just returning the last filter in the list. An
alternative fix might be to return 0 or an error code,
but this is pretty invasive to every call site.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I2325dfd843aec76d89fb0d7cb0e7c4f290a34840
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5908f7d..9a18c67 100644
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

