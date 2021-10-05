From: Dave Ertman <david.m.ertman@intel.com>
Date: Tue,  5 Oct 2021 07:30:03 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Respond to a NETDEV_UNREGISTER
 event for LAG
Message-ID: <20211005143003.34845-1-david.m.ertman@intel.com>
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

Fixes: df006dd4b1dca ("Add initial support framework for LAG")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 37c18c66b5c7..1631f8995d3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -319,6 +319,9 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
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

