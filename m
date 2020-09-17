From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 13:13:43 -0700
Subject: [Intel-wired-lan] [PATCH S53 11/15] ice: Remove vlan_ena from vsi
 structure
In-Reply-To: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
Message-ID: <20200917201347.81570-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nick Nunley <nicholas.d.nunley@intel.com>

vlan_ena was introduced to track whether VLAN filters are enabled on
the device, but
1) checking for num_vlan > 1 already gives us this information, and is
currently used in this way throughout the code
2) the logic for vlan_ena is broken when multiple VLANS are active

Just remove vlan_ena and use num_vlan instead.

Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c | 11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b0ff591dba54..dc96f4baabb9 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -308,7 +308,6 @@ struct ice_vsi {
 	u8 irqs_ready:1;
 	u8 current_isup:1;		 /* Sync 'link up' logging */
 	u8 stat_offsets_loaded:1;
-	u8 vlan_ena:1;
 	u16 num_vlan;
 
 	/* queue information */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e626937c5e83..ac1fc443d9f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -224,7 +224,7 @@ static int ice_cfg_promisc(struct ice_vsi *vsi, u8 promisc_m, bool set_promisc)
 	if (vsi->type != ICE_VSI_PF)
 		return 0;
 
-	if (vsi->vlan_ena) {
+	if (vsi->num_vlan > 1) {
 		status = ice_set_vlan_vsi_promisc(hw, vsi->idx, promisc_m,
 						  set_promisc);
 	} else {
@@ -326,7 +326,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 	/* check for changes in promiscuous modes */
 	if (changed_flags & IFF_ALLMULTI) {
 		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
-			if (vsi->vlan_ena)
+			if (vsi->num_vlan > 1)
 				promisc_m = ICE_MCAST_VLAN_PROMISC_BITS;
 			else
 				promisc_m = ICE_MCAST_PROMISC_BITS;
@@ -340,7 +340,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 			}
 		} else {
 			/* !(vsi->current_netdev_flags & IFF_ALLMULTI) */
-			if (vsi->vlan_ena)
+			if (vsi->num_vlan > 1)
 				promisc_m = ICE_MCAST_VLAN_PROMISC_BITS;
 			else
 				promisc_m = ICE_MCAST_PROMISC_BITS;
@@ -3117,10 +3117,8 @@ ice_vlan_rx_add_vid(struct net_device *netdev, __always_unused __be16 proto,
 	 * packets aren't pruned by the device's internal switch on Rx
 	 */
 	ret = ice_vsi_add_vlan(vsi, vid, ICE_FWD_TO_VSI);
-	if (!ret) {
-		vsi->vlan_ena = true;
+	if (!ret)
 		set_bit(ICE_VSI_FLAG_VLAN_FLTR_CHANGED, vsi->flags);
-	}
 
 	return ret;
 }
@@ -3159,7 +3157,6 @@ ice_vlan_rx_kill_vid(struct net_device *netdev, __always_unused __be16 proto,
 	if (vsi->num_vlan == 1 && ice_vsi_is_vlan_pruning_ena(vsi))
 		ret = ice_cfg_vlan_pruning(vsi, false, false);
 
-	vsi->vlan_ena = false;
 	set_bit(ICE_VSI_FLAG_VLAN_FLTR_CHANGED, vsi->flags);
 	return ret;
 }
-- 
2.20.1

