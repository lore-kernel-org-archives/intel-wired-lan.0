From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:17:07 -0700
Subject: [Intel-wired-lan] [PATCH S58 12/13] ice: remove return variable
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

We were saving the return value from ice_vsi_manage_rss_lut(), but
the errors from that function are not critical so change it to
return void and remove the code that saved the value.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 8 +++-----
 drivers/net/ethernet/intel/ice/ice_lib.h  | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c379b4ddffbd..29284c7d49b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1312,14 +1312,13 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
  * LUT, while in the event of enable request for RSS, it will reconfigure RSS
  * LUT.
  */
-int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
+void ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
 {
-	int err = 0;
 	u8 *lut;
 
 	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
 	if (!lut)
-		return -ENOMEM;
+		return;
 
 	if (ena) {
 		if (vsi->rss_lut_user)
@@ -1329,9 +1328,8 @@ int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
 					 vsi->rss_size);
 	}
 
-	err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+	ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
 	kfree(lut);
-	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 7775f1e36474..e5c46213b0b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -89,7 +89,7 @@ void ice_vsi_free_rx_rings(struct ice_vsi *vsi);
 
 void ice_vsi_free_tx_rings(struct ice_vsi *vsi);
 
-int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena);
+void ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena);
 
 void ice_update_tx_ring_stats(struct ice_ring *ring, u64 pkts, u64 bytes);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1f88faab3ada..d470eb74086f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5132,10 +5132,10 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 	 * separate if/else statements to guarantee each feature is checked
 	 */
 	if (features & NETIF_F_RXHASH && !(netdev->features & NETIF_F_RXHASH))
-		ret = ice_vsi_manage_rss_lut(vsi, true);
+		ice_vsi_manage_rss_lut(vsi, true);
 	else if (!(features & NETIF_F_RXHASH) &&
 		 netdev->features & NETIF_F_RXHASH)
-		ret = ice_vsi_manage_rss_lut(vsi, false);
+		ice_vsi_manage_rss_lut(vsi, false);
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) &&
 	    !(netdev->features & NETIF_F_HW_VLAN_CTAG_RX))
-- 
2.20.1

