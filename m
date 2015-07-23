From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:31 -0400
Subject: [Intel-wired-lan] [next PATCH S9 02/15] i40e: Fix a port VLAN
	configuration bug
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

If a port VLAN is set for a given virtual function (VF) before the VF
driver is loaded then a configuration error results in which the port
VLAN is ignored when the VF driver is subsequently loaded.  This causes
the VF's MAC/VLAN filters to not use the correct VLAN filter.  This
patch ensures that the port VLAN filter is considered at the right time
during configuration of the VF's MAC/VLAN filters.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: I28f404cbc21a4c6d70a7980b87c77f13f06685a4
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ccddddf..fe3bfb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1186,7 +1186,7 @@ bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi)
 	 * so we have to go through all the list in order to make sure
 	 */
 	list_for_each_entry(f, &vsi->mac_filter_list, list) {
-		if (f->vlan >= 0)
+		if (f->vlan >= 0 || vsi->info.pvid)
 			return true;
 	}
 
-- 
1.9.3

