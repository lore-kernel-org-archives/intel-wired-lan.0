From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:36 -0400
Subject: [Intel-wired-lan] [next PATCH S16 07/15] i40e: Enhanced fix to
	protect 'mac_filter_list' accesses
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

This patch protects invocation of i40e_set_mac ---> i40e_del_filter using
'mac_filter_list_lock' to synchronize 'mac_filter_list' accesses with
service_task : i40e_sync_vsi_filters.

It also replaces spin_lock with spin_lock_bh where needed.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-ID: I7db30be69d7f065724ea1ab5cdcd24b54096b443
---
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 62 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 22 ++++----
 3 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
index 61df19e..fe5d9bf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
@@ -1516,12 +1516,12 @@ void i40e_fcoe_config_netdev(struct net_device *netdev, struct i40e_vsi *vsi)
 	 * same PCI function.
 	 */
 	netdev->dev_port = 1;
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 	i40e_add_filter(vsi, hw->mac.san_addr, 0, false, false);
 	i40e_add_filter(vsi, (u8[6]) FC_FCOE_FLOGI_MAC, 0, false, false);
 	i40e_add_filter(vsi, FIP_ALL_FCOE_MACS, 0, false, false);
 	i40e_add_filter(vsi, FIP_ALL_ENODE_MACS, 0, false, false);
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	/* use san mac */
 	ether_addr_copy(netdev->dev_addr, hw->mac.san_addr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5503763..d656182 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1544,8 +1544,10 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH;
 		i40e_aq_remove_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
 	} else {
+		spin_lock_bh(&vsi->mac_filter_list_lock);
 		i40e_del_filter(vsi, netdev->dev_addr, I40E_VLAN_ANY,
 				false, false);
+		spin_unlock_bh(&vsi->mac_filter_list_lock);
 	}
 
 	if (ether_addr_equal(addr->sa_data, hw->mac.addr)) {
@@ -1556,12 +1558,12 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		element.flags = cpu_to_le16(I40E_AQC_MACVLAN_ADD_PERFECT_MATCH);
 		i40e_aq_add_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
 	} else {
-		spin_lock(&vsi->mac_filter_list_lock);
+		spin_lock_bh(&vsi->mac_filter_list_lock);
 		f = i40e_add_filter(vsi, addr->sa_data, I40E_VLAN_ANY,
 				    false, false);
 		if (f)
 			f->is_laa = true;
-		spin_unlock(&vsi->mac_filter_list_lock);
+		spin_unlock_bh(&vsi->mac_filter_list_lock);
 	}
 
 	i40e_sync_vsi_filters(vsi);
@@ -1734,7 +1736,7 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 	struct netdev_hw_addr *mca;
 	struct netdev_hw_addr *ha;
 
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 
 	/* add addr if not already in the filter list */
 	netdev_for_each_uc_addr(uca, netdev) {
@@ -1783,7 +1785,7 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 bottom_of_search_loop:
 		continue;
 	}
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	/* check for other flag changes */
 	if (vsi->current_netdev_flags != vsi->netdev->flags) {
@@ -1908,7 +1910,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	if (vsi->flags & I40E_VSI_FLAG_FILTER_CHANGED) {
 		vsi->flags &= ~I40E_VSI_FLAG_FILTER_CHANGED;
 
-		spin_lock(&vsi->mac_filter_list_lock);
+		spin_lock_bh(&vsi->mac_filter_list_lock);
 		list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
 			if (!f->changed)
 				continue;
@@ -1943,7 +1945,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			i40e_undo_del_filter_entries(vsi, &tmp_del_list);
 			i40e_undo_add_filter_entries(vsi);
 		}
-		spin_unlock(&vsi->mac_filter_list_lock);
+		spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 		if (err_cond)
 			i40e_cleanup_add_list(&tmp_add_list);
@@ -1960,10 +1962,10 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			i40e_cleanup_add_list(&tmp_add_list);
 
 			/* Undo VSI's MAC filter entry element updates */
-			spin_lock(&vsi->mac_filter_list_lock);
+			spin_lock_bh(&vsi->mac_filter_list_lock);
 			i40e_undo_del_filter_entries(vsi, &tmp_del_list);
 			i40e_undo_add_filter_entries(vsi);
-			spin_unlock(&vsi->mac_filter_list_lock);
+			spin_unlock_bh(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 
@@ -2032,9 +2034,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			i40e_cleanup_add_list(&tmp_add_list);
 
 			/* Undo add filter entries from VSI MAC filter list */
-			spin_lock(&vsi->mac_filter_list_lock);
+			spin_lock_bh(&vsi->mac_filter_list_lock);
 			i40e_undo_add_filter_entries(vsi);
-			spin_unlock(&vsi->mac_filter_list_lock);
+			spin_unlock_bh(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 
@@ -2321,7 +2323,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 	is_netdev = !!(vsi->netdev);
 
 	/* Locked once because all functions invoked below iterates list*/
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 
 	if (is_netdev) {
 		add_f = i40e_add_filter(vsi, vsi->netdev->dev_addr, vid,
@@ -2330,7 +2332,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 			dev_info(&vsi->back->pdev->dev,
 				 "Could not add vlan filter %d for %pM\n",
 				 vid, vsi->netdev->dev_addr);
-			spin_unlock(&vsi->mac_filter_list_lock);
+			spin_unlock_bh(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 	}
@@ -2341,7 +2343,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 			dev_info(&vsi->back->pdev->dev,
 				 "Could not add vlan filter %d for %pM\n",
 				 vid, f->macaddr);
-			spin_unlock(&vsi->mac_filter_list_lock);
+			spin_unlock_bh(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 	}
@@ -2363,7 +2365,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 				dev_info(&vsi->back->pdev->dev,
 					 "Could not add filter 0 for %pM\n",
 					 vsi->netdev->dev_addr);
-				spin_unlock(&vsi->mac_filter_list_lock);
+				spin_unlock_bh(&vsi->mac_filter_list_lock);
 				return -ENOMEM;
 			}
 		}
@@ -2383,7 +2385,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 				dev_info(&vsi->back->pdev->dev,
 					 "Could not add filter 0 for %pM\n",
 					f->macaddr);
-				spin_unlock(&vsi->mac_filter_list_lock);
+				spin_unlock_bh(&vsi->mac_filter_list_lock);
 				return -ENOMEM;
 			}
 		}
@@ -2392,7 +2394,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 	/* Make sure to release before sync_vsi_filter because that
 	 * function will lock/unlock as necessary
 	 */
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	if (test_bit(__I40E_DOWN, &vsi->back->state) ||
 	    test_bit(__I40E_RESET_RECOVERY_PENDING, &vsi->back->state))
@@ -2419,7 +2421,7 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 	is_netdev = !!(netdev);
 
 	/* Locked once because all functions invoked below iterates list */
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 
 	if (is_netdev)
 		i40e_del_filter(vsi, netdev->dev_addr, vid, is_vf, is_netdev);
@@ -2451,7 +2453,7 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 			dev_info(&vsi->back->pdev->dev,
 				 "Could not add filter %d for %pM\n",
 				 I40E_VLAN_ANY, netdev->dev_addr);
-			spin_unlock(&vsi->mac_filter_list_lock);
+			spin_unlock_bh(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 	}
@@ -2465,7 +2467,7 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 				dev_info(&vsi->back->pdev->dev,
 					 "Could not add filter %d for %pM\n",
 					 I40E_VLAN_ANY, f->macaddr);
-				spin_unlock(&vsi->mac_filter_list_lock);
+				spin_unlock_bh(&vsi->mac_filter_list_lock);
 				return -ENOMEM;
 			}
 		}
@@ -2474,7 +2476,7 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 	/* Make sure to release before sync_vsi_filter because that
 	 * function with lock/unlock as necessary
 	 */
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	if (test_bit(__I40E_DOWN, &vsi->back->state) ||
 	    test_bit(__I40E_RESET_RECOVERY_PENDING, &vsi->back->state))
@@ -8660,10 +8662,10 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 		 * which must be replaced by a normal filter.
 		 */
 		if (!i40e_rm_default_mac_filter(vsi, mac_addr)) {
-			spin_lock(&vsi->mac_filter_list_lock);
+			spin_lock_bh(&vsi->mac_filter_list_lock);
 			i40e_add_filter(vsi, mac_addr,
 					I40E_VLAN_ANY, false, true);
-			spin_unlock(&vsi->mac_filter_list_lock);
+			spin_unlock_bh(&vsi->mac_filter_list_lock);
 		}
 	} else {
 		/* relate the VSI_VMDQ name to the VSI_MAIN name */
@@ -8671,14 +8673,14 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 			 pf->vsi[pf->lan_vsi]->netdev->name);
 		random_ether_addr(mac_addr);
 
-		spin_lock(&vsi->mac_filter_list_lock);
+		spin_lock_bh(&vsi->mac_filter_list_lock);
 		i40e_add_filter(vsi, mac_addr, I40E_VLAN_ANY, false, false);
-		spin_unlock(&vsi->mac_filter_list_lock);
+		spin_unlock_bh(&vsi->mac_filter_list_lock);
 	}
 
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 	i40e_add_filter(vsi, brdcast, I40E_VLAN_ANY, false, false);
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	ether_addr_copy(netdev->dev_addr, mac_addr);
 	ether_addr_copy(netdev->perm_addr, mac_addr);
@@ -8930,7 +8932,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		vsi->id = ctxt.vsi_number;
 	}
 
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 	/* If macvlan filters already exist, force them to get loaded */
 	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
 		f->changed = true;
@@ -8942,7 +8944,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 			found_laa_mac_filter = true;
 		}
 	}
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	if (found_laa_mac_filter) {
 		struct i40e_aqc_remove_macvlan_element_data element;
@@ -9027,11 +9029,11 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 		i40e_vsi_disable_irq(vsi);
 	}
 
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list)
 		i40e_del_filter(vsi, f->macaddr, f->vlan,
 				f->is_vf, f->is_netdev);
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	i40e_sync_vsi_filters(vsi);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 465b1e9..3ed8b98 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -548,7 +548,7 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		if (vf->port_vlan_id)
 			i40e_vsi_add_pvid(vsi, vf->port_vlan_id);
 
-		spin_lock(&vsi->mac_filter_list_lock);
+		spin_lock_bh(&vsi->mac_filter_list_lock);
 		f = i40e_add_filter(vsi, vf->default_lan_addr.addr,
 				    vf->port_vlan_id ? vf->port_vlan_id : -1,
 				    true, false);
@@ -561,7 +561,7 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		if (!f)
 			dev_info(&pf->pdev->dev,
 				 "Could not allocate VF broadcast filter\n");
-		spin_unlock(&vsi->mac_filter_list_lock);
+		spin_unlock_bh(&vsi->mac_filter_list_lock);
 	}
 
 	/* program mac filter */
@@ -1602,7 +1602,7 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	/* Lock once, because all function inside for loop accesses VSI's
 	 * MAC filter list which needs to be protected using same lock.
 	 */
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 
 	/* add new addresses to the list */
 	for (i = 0; i < al->num_elements; i++) {
@@ -1622,11 +1622,11 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 			dev_err(&pf->pdev->dev,
 				"Unable to add VF MAC filter\n");
 			ret = I40E_ERR_PARAM;
-			spin_unlock(&vsi->mac_filter_list_lock);
+			spin_unlock_bh(&vsi->mac_filter_list_lock);
 			goto error_param;
 		}
 	}
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
 	if (i40e_sync_vsi_filters(vsi))
@@ -1674,12 +1674,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 	/* delete addresses from the list */
 	for (i = 0; i < al->num_elements; i++)
 		i40e_del_filter(vsi, al->list[i].addr,
 				I40E_VLAN_ANY, true, false);
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
 	if (i40e_sync_vsi_filters(vsi))
@@ -2079,7 +2079,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	/* Lock once because below invoked function add/del_filter requires
 	 * mac_filter_list_lock to be held
 	 */
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 
 	/* delete the temporary mac address */
 	i40e_del_filter(vsi, vf->default_lan_addr.addr,
@@ -2092,7 +2092,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	list_for_each_entry(f, &vsi->mac_filter_list, list)
 		i40e_del_filter(vsi, f->macaddr, f->vlan, true, false);
 
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	dev_info(&pf->pdev->dev, "Setting MAC %pM on VF %d\n", mac, vf_id);
 	/* program mac filter */
@@ -2156,9 +2156,9 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
-	spin_lock(&vsi->mac_filter_list_lock);
+	spin_lock_bh(&vsi->mac_filter_list_lock);
 	is_vsi_in_vlan = i40e_is_vsi_in_vlan(vsi);
-	spin_unlock(&vsi->mac_filter_list_lock);
+	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	if (le16_to_cpu(vsi->info.pvid) == 0 && is_vsi_in_vlan) {
 		dev_err(&pf->pdev->dev,
-- 
1.9.3

