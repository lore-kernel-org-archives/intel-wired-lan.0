From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:40:08 -0700
Subject: [Intel-wired-lan] [PATCH S59 13/13] ice: remove local variable
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Remove the local variable since it's only used once. Instead, use it
directly.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0034bbe9c9b3..101fa9d06477 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3026,7 +3026,6 @@ static void ice_set_netdev_features(struct net_device *netdev)
  */
 static int ice_cfg_netdev(struct ice_vsi *vsi)
 {
-	struct ice_pf *pf = vsi->back;
 	struct ice_netdev_priv *np;
 	struct net_device *netdev;
 	u8 mac_addr[ETH_ALEN];
@@ -3046,7 +3045,7 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	ice_set_ops(netdev);
 
 	if (vsi->type == ICE_VSI_PF) {
-		SET_NETDEV_DEV(netdev, ice_pf_to_dev(pf));
+		SET_NETDEV_DEV(netdev, ice_pf_to_dev(vsi->back));
 		ether_addr_copy(mac_addr, vsi->port_info->mac.perm_addr);
 		ether_addr_copy(netdev->dev_addr, mac_addr);
 		ether_addr_copy(netdev->perm_addr, mac_addr);
-- 
2.20.1

