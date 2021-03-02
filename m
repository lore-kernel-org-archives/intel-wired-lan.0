From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:41 -0800
Subject: [Intel-wired-lan] [PATCH S56 09/13] ice: Add new VSI states to
 track netdev alloc/registration
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Add two new VSI states, one to track if a netdev for the VSI has been
allocated and the other to track if the netdev has been registered.
Call unregister_netdev/free_netdev only when the corresponding state
bits are set.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 21 +++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c |  5 +++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 89ffc96702fa..79652b72c38b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -238,6 +238,8 @@ enum ice_pf_state {
 enum ice_vsi_state {
 	ICE_VSI_DOWN,
 	ICE_VSI_NEEDS_RESTART,
+	ICE_VSI_NETDEV_ALLOCD,
+	ICE_VSI_NETDEV_REGISTERED,
 	ICE_VSI_UMAC_FLTR_CHANGED,
 	ICE_VSI_MMAC_FLTR_CHANGED,
 	ICE_VSI_VLAN_FLTR_CHANGED,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ddcbd5bfd058..4136ab9b2950 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2775,11 +2775,14 @@ int ice_vsi_release(struct ice_vsi *vsi)
 	 * PF that is running the work queue items currently. This is done to
 	 * avoid check_flush_dependency() warning on this wq
 	 */
-	if (vsi->netdev && !ice_is_reset_in_progress(pf->state)) {
+	if (vsi->netdev && !ice_is_reset_in_progress(pf->state) &&
+	    (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state))) {
 		unregister_netdev(vsi->netdev);
-		ice_devlink_destroy_port(vsi);
+		clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
 	}
 
+	ice_devlink_destroy_port(vsi);
+
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
 
@@ -2834,10 +2837,16 @@ int ice_vsi_release(struct ice_vsi *vsi)
 	ice_vsi_delete(vsi);
 	ice_vsi_free_q_vectors(vsi);
 
-	/* make sure unregister_netdev() was called by checking ICE_DOWN */
-	if (vsi->netdev && test_bit(ICE_VSI_DOWN, vsi->state)) {
-		free_netdev(vsi->netdev);
-		vsi->netdev = NULL;
+	if (vsi->netdev) {
+		if (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state)) {
+			unregister_netdev(vsi->netdev);
+			clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
+		}
+		if (test_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state)) {
+			free_netdev(vsi->netdev);
+			vsi->netdev = NULL;
+			clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
+		}
 	}
 
 	if (vsi->type == ICE_VSI_VF &&
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1018b6da7362..4f35a4de33ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2997,6 +2997,7 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	if (!netdev)
 		return -ENOMEM;
 
+	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
 	vsi->netdev = netdev;
 	np = netdev_priv(netdev);
 	np->vsi = vsi;
@@ -3221,6 +3222,7 @@ static int ice_setup_pf_sw(struct ice_pf *pf)
 	if (vsi) {
 		ice_napi_del(vsi);
 		if (vsi->netdev) {
+			clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
 			free_netdev(vsi->netdev);
 			vsi->netdev = NULL;
 		}
@@ -3990,6 +3992,7 @@ static int ice_register_netdev(struct ice_pf *pf)
 	if (err)
 		goto err_register_netdev;
 
+	set_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
 	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_all_queues(vsi->netdev);
 	err = ice_devlink_create_port(vsi);
@@ -4001,9 +4004,11 @@ static int ice_register_netdev(struct ice_pf *pf)
 	return 0;
 err_devlink_create:
 	unregister_netdev(vsi->netdev);
+	clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
 err_register_netdev:
 	free_netdev(vsi->netdev);
 	vsi->netdev = NULL;
+	clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
 	return err;
 }
 
-- 
2.20.1

