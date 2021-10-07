From: Dave Ertman <david.m.ertman@intel.com>
Date: Thu,  7 Oct 2021 08:40:31 -0700
Subject: [Intel-wired-lan] [PATCH v2 net] ice: Respond to a
 NETDEV_UNREGISTER event for LAG
Message-ID: <20211007154031.52038-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the PF is a member of a link aggregate, and the driver
is removed, the process will hang unless we respond to the
NETDEV_UNREGISTER event that is sent to the event_handler
for LAG.

Add a case statement for the ice_lag_event_handler to unlink
the PF from the link aggregate.

Also remove code that was incorrectly applying a dev_hold to
peer_netdevs that were associated with the ice driver.

Fixes: df006dd4b1dca ("ice: Add initial support framework for LAG")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
v2: remove the code placing dev_hold on ice specific netdevs
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 37c18c66b5c7..e375ac849aec 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -100,9 +100,9 @@ static void ice_display_lag_info(struct ice_lag *lag)
  */
 static void ice_lag_info_event(struct ice_lag *lag, void *ptr)
 {
-	struct net_device *event_netdev, *netdev_tmp;
 	struct netdev_notifier_bonding_info *info;
 	struct netdev_bonding_info *bonding_info;
+	struct net_device *event_netdev;
 	const char *lag_netdev_name;
 
 	event_netdev = netdev_notifier_info_to_dev(ptr);
@@ -123,19 +123,6 @@ static void ice_lag_info_event(struct ice_lag *lag, void *ptr)
 		goto lag_out;
 	}
 
-	rcu_read_lock();
-	for_each_netdev_in_bond_rcu(lag->upper_netdev, netdev_tmp) {
-		if (!netif_is_ice(netdev_tmp))
-			continue;
-
-		if (netdev_tmp && netdev_tmp != lag->netdev &&
-		    lag->peer_netdev != netdev_tmp) {
-			dev_hold(netdev_tmp);
-			lag->peer_netdev = netdev_tmp;
-		}
-	}
-	rcu_read_unlock();
-
 	if (bonding_info->slave.state)
 		ice_lag_set_backup(lag);
 	else
@@ -319,6 +306,9 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
 	case NETDEV_BONDING_INFO:
 		ice_lag_info_event(lag, ptr);
 		break;
+	case NETDEV_UNREGISTER:
+		ice_lag_unlink(lag, ptr);
+		break;
 	default:
 		break;
 	}
-- 
2.31.1

