From: Dave Ertman <david.m.ertman@intel.com>
Date: Fri, 18 Feb 2022 12:39:25 -0800
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix error with handling of
 bonding MTU
Message-ID: <20220218203925.1890573-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When a bonded interface is destroyed, .ndo_change_mtu can be called
during the tear-down process while the RTNL lock is held.  This is a
problem since the auxiliary driver linked to the LAN driver needs to be
notified of the MTU change, and this requires grabbing a device_lock on
the auxiliary_device's dev.  Currently this is being attempted in the
same execution context as the call to .ndo_change_mtu which is causing a
dead-lock.

Move the notification of the changed MTU to a separate execution context
(watchdog service task) and eliminate the "before" notification.

Fixes: 348048e724a0e ("ice: Implement iidc operations")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
v2: target change from net-next to net
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 29 +++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a9fa701aaa95..058334db37a9 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -484,6 +484,7 @@ enum ice_pf_flags {
 	ICE_FLAG_MDD_AUTO_RESET_VF,
 	ICE_FLAG_LINK_LENIENT_MODE_ENA,
 	ICE_FLAG_PLUG_AUX_DEV,
+	ICE_FLAG_MTU_CHANGED,
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 17a9bb461dc3..d47d00c5b456 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2256,6 +2256,17 @@ static void ice_service_task(struct work_struct *work)
 	if (test_and_clear_bit(ICE_FLAG_PLUG_AUX_DEV, pf->flags))
 		ice_plug_aux_dev(pf);
 
+	if (test_and_clear_bit(ICE_FLAG_MTU_CHANGED, pf->flags)) {
+		struct iidc_event *event;
+
+		event = kzalloc(sizeof(*event), GFP_KERNEL);
+		if (event) {
+			set_bit(IIDC_EVENT_AFTER_MTU_CHANGE, event->type);
+			ice_send_event_to_aux(pf, event);
+			kfree(event);
+		}
+	}
+
 	ice_clean_adminq_subtask(pf);
 	ice_check_media_subtask(pf);
 	ice_check_for_hang_subtask(pf);
@@ -6820,7 +6831,6 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
-	struct iidc_event *event;
 	u8 count = 0;
 	int err = 0;
 
@@ -6855,14 +6865,6 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EBUSY;
 	}
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
-	if (!event)
-		return -ENOMEM;
-
-	set_bit(IIDC_EVENT_BEFORE_MTU_CHANGE, event->type);
-	ice_send_event_to_aux(pf, event);
-	clear_bit(IIDC_EVENT_BEFORE_MTU_CHANGE, event->type);
-
 	netdev->mtu = (unsigned int)new_mtu;
 
 	/* if VSI is up, bring it down and then back up */
@@ -6870,21 +6872,18 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 		err = ice_down(vsi);
 		if (err) {
 			netdev_err(netdev, "change MTU if_down err %d\n", err);
-			goto event_after;
+			return err;
 		}
 
 		err = ice_up(vsi);
 		if (err) {
 			netdev_err(netdev, "change MTU if_up err %d\n", err);
-			goto event_after;
+			return err;
 		}
 	}
 
 	netdev_dbg(netdev, "changed MTU to %d\n", new_mtu);
-event_after:
-	set_bit(IIDC_EVENT_AFTER_MTU_CHANGE, event->type);
-	ice_send_event_to_aux(pf, event);
-	kfree(event);
+	set_bit(ICE_FLAG_MTU_CHANGED, pf->flags);
 
 	return err;
 }
-- 
2.33.1

