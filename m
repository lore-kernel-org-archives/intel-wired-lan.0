From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed,  6 Jan 2016 17:06:31 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: fix merge bug
Message-ID: <1452128791-17584-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There was a bug (re-)introduced by a merge error when applying patches.
This fixes the issue by making the code schedule the work item as
originally intended for the fix included in commit 0e4425ed641f ("i40e:
fix: do not sleep in netdev_ops") and broken in commit ea02e90b4b49
("i40e: propagate properly").

Fixes: ea02e90b4b49 ("i40e: propagate properly")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5375d3e..590cf0b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1542,7 +1542,11 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 
 	ether_addr_copy(netdev->dev_addr, addr->sa_data);
 
-	return i40e_sync_vsi_filters(vsi);
+	/* schedule our worker thread which will take care of
+	 * applying the new filter changes
+	 */
+	i40e_service_event_schedule(vsi->back);
+	return 0;
 }
 
 /**
-- 
1.8.3.1

