From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon,  5 Feb 2018 13:03:34 -0800
Subject: [Intel-wired-lan] [S86 v3 5/8] i40e: do not force filter failure in
 overflow promiscuous
In-Reply-To: <20180205210337.22102-1-jeffrey.t.kirsher@intel.com>
References: <20180205210337.22102-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180205210337.22102-5-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Broadcast filters can now cause overflow promiscuous to trigger when
adding "too many" VLANs to all the ports of a device and the driver
needs a way to exit overflow promiscuous once triggered.

Currently the driver looks to see if there are "too many" filters and/or
we have any failed filters to determine when it is safe to exit overflow
promiscuous.  If we trigger overflow promiscuous with broadcast filters,
any new filters added will be "auto-failed" until we exit overflow
promiscuous.  Since the user can't manually remove the failed broadcast
filters for VLANs (nor should we expect the user to do such), there is
no way to exit overflow promiscuous without reloading the driver.

The easiest way to do this is to remove the shortcut to "auto-fail"
filters in overflow promscuous.  If the user removes the VLANs, the
failed filters will be removed and since we're no longer "auto-failing"
new filters, we'll eventually get a good set of filters and exit
overflow promiscuous.

This has the side benefit of making filter state more explicit in that
if a filter says it's failed we know for a fact it failed and not just
assuming it will if we're in overflow promiscuous.  This is nice because
if the user removes some filters and then adds some, even if we're in
overflow promiscuous, the filter might succeed; we were just assuming it
won't because the user hasn't rectified other existing failed filters.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index dc5ef4d5eceb..bbbadcc1400f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1374,14 +1374,7 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 
 		ether_addr_copy(f->macaddr, macaddr);
 		f->vlan = vlan;
-		/* If we're in overflow promisc mode, set the state directly
-		 * to failed, so we don't bother to try sending the filter
-		 * to the hardware.
-		 */
-		if (test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state))
-			f->state = I40E_FILTER_FAILED;
-		else
-			f->state = I40E_FILTER_NEW;
+		f->state = I40E_FILTER_NEW;
 		INIT_HLIST_NODE(&f->hlist);
 
 		key = i40e_addr_to_hkey(macaddr);
@@ -2419,12 +2412,6 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 
 		num_add = 0;
 		hlist_for_each_entry_safe(new, h, &tmp_add_list, hlist) {
-			if (test_bit(__I40E_VSI_OVERFLOW_PROMISC,
-				     vsi->state)) {
-				new->state = I40E_FILTER_FAILED;
-				continue;
-			}
-
 			/* handle broadcast filters by updating the broadcast
 			 * promiscuous flag instead of adding a MAC filter.
 			 */
-- 
2.14.3

