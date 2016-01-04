From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:06 -0800
Subject: [Intel-wired-lan] [next PATCH S26 06/12] i40e: fix: do not sleep in
	netdev_ops
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-7-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver was being called by vlan, bonding, teaming operations
that expected to be able to hold locks like rcu_read_lock().

This causes the driver to be held to the requirement to not sleep,
and was found by the kernel debug options for checking sleep
inside critical section, and the locking validator.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Nelson, Shannon <shannon.nelson@intel.com>
Change-ID: Ibc68c835f5ffa8ffe0638ffe910a66fc5649a7f7
---
Testing-Hints:
Add and remove vlan, over and under bonding and teaming driver,
add and delete mac address, run debug kernel with lock validator.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 052314c..37d6979 100644
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
@@ -1766,6 +1770,11 @@ bottom_of_search_loop:
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
 	}
+
+	/* schedule our worker thread which will take care of
+	 * applying the new filter changes
+	 */
+	i40e_service_event_schedule(vsi->back);
 }
 
 /**
-- 
2.1.0

