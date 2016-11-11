From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:37 -0800
Subject: [Intel-wired-lan] [next PATCH S54 13/15] i40e: when adding or
	removing MAC filters, correctly handle VLANs
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-14-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Instead of using i40e_add_filter or i40e_del_filter directly, when
adding a MAC address, we should normally be using i40e_add_mac_filter or
i40e_del_mac_filter. These functions correctly handle the various cases
of VLAN mode or PVID settings. This ensures consistency and avoids the
issues that can occur with the recent addition of a WARN_ON() in
i40e_sync_vsi_filters.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I7fe62db063391fdd1180b2d6a6a3c5ab4307eeee
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  6 +++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++-------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 535a70a..59bc1f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9347,7 +9347,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 		 */
 		i40e_rm_default_mac_filter(vsi, mac_addr);
 		spin_lock_bh(&vsi->mac_filter_hash_lock);
-		i40e_add_filter(vsi, mac_addr, I40E_VLAN_ANY);
+		i40e_add_mac_filter(vsi, mac_addr);
 		spin_unlock_bh(&vsi->mac_filter_hash_lock);
 	} else {
 		/* relate the VSI_VMDQ name to the VSI_MAIN name */
@@ -9356,7 +9356,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 		random_ether_addr(mac_addr);
 
 		spin_lock_bh(&vsi->mac_filter_hash_lock);
-		i40e_add_filter(vsi, mac_addr, I40E_VLAN_ANY);
+		i40e_add_mac_filter(vsi, mac_addr);
 		spin_unlock_bh(&vsi->mac_filter_hash_lock);
 	}
 
@@ -9375,7 +9375,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	 */
 	eth_broadcast_addr(broadcast);
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
-	i40e_add_filter(vsi, broadcast, I40E_VLAN_ANY);
+	i40e_add_mac_filter(vsi, broadcast);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
 	ether_addr_copy(netdev->dev_addr, mac_addr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 49941dd..cbbf864 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -689,17 +689,15 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 
 		spin_lock_bh(&vsi->mac_filter_hash_lock);
 		if (is_valid_ether_addr(vf->default_lan_addr.addr)) {
-			f = i40e_add_filter(vsi, vf->default_lan_addr.addr,
-				       vf->port_vlan_id ?
-				       vf->port_vlan_id : -1);
+			f = i40e_add_mac_filter(vsi,
+						vf->default_lan_addr.addr);
 			if (!f)
 				dev_info(&pf->pdev->dev,
 					 "Could not add MAC filter %pM for VF %d\n",
 					vf->default_lan_addr.addr, vf->vf_id);
 		}
 		eth_broadcast_addr(broadcast);
-		f = i40e_add_filter(vsi, broadcast,
-				    vf->port_vlan_id ? vf->port_vlan_id : -1);
+		f = i40e_add_mac_filter(vsi, broadcast);
 		if (!f)
 			dev_info(&pf->pdev->dev,
 				 "Could not allocate VF broadcast filter\n");
@@ -2718,8 +2716,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 
 	/* delete the temporary mac address */
 	if (!is_zero_ether_addr(vf->default_lan_addr.addr))
-		i40e_del_filter(vsi, vf->default_lan_addr.addr,
-				vf->port_vlan_id ? vf->port_vlan_id : -1);
+		i40e_del_mac_filter(vsi, vf->default_lan_addr.addr);
 
 	/* Delete all the filters for this VSI - we're going to kill it
 	 * anyway.
-- 
2.4.11

