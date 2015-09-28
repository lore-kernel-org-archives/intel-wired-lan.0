From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Mon, 28 Sep 2015 13:37:12 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix for recursive RTNL lock during
	PROMISC change
Message-ID: <1443472632-33873-1-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The sync_vsi_filters function can be called directly under RTNL
or through the timer subtask without one. This was causing a deadlock.

If sync_vsi_filters is called from a thread which held the lock,
and in another thread the PROMISC setting got changed we would
be executing the PROMISC change in the thread which already held
the lock alongside the other filter update. The PROMISC change
requires a reset if we are on a VEB, which requires it to be called
under RTNL.

Earlier the driver would call reset for PROMISC change without
checking if we were already under RTNL and would try to grab it
causing a deadlock. This patch changes the flow to see if we are
already under RTNL before trying to grab it.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h             |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 19 ++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 ++++----
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0ed6506..65e9db6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -678,7 +678,7 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 					bool is_vf, bool is_netdev);
 void i40e_del_filter(struct i40e_vsi *vsi, u8 *macaddr, s16 vlan,
 		     bool is_vf, bool is_netdev);
-int i40e_sync_vsi_filters(struct i40e_vsi *vsi);
+int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl);
 struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 				u16 uplink, u32 param1);
 int i40e_vsi_release(struct i40e_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 2f0e2f5..c38e9ee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1138,7 +1138,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		}
 
 		f = i40e_add_filter(vsi, ma, vlan, false, false);
-		ret = i40e_sync_vsi_filters(vsi);
+		ret = i40e_sync_vsi_filters(vsi, true);
 		if (f && !ret)
 			dev_info(&pf->pdev->dev,
 				 "add macaddr: %pM vlan=%d added to VSI %d\n",
@@ -1175,7 +1175,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		}
 
 		i40e_del_filter(vsi, ma, vlan, false, false);
-		ret = i40e_sync_vsi_filters(vsi);
+		ret = i40e_sync_vsi_filters(vsi, true);
 		if (!ret)
 			dev_info(&pf->pdev->dev,
 				 "del macaddr: %pM vlan=%d removed from VSI %d\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f8401d0..0c590a1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1564,7 +1564,7 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		spin_unlock(&vsi->mac_filter_list_lock);
 	}
 
-	i40e_sync_vsi_filters(vsi);
+	i40e_sync_vsi_filters(vsi, false);
 	ether_addr_copy(netdev->dev_addr, addr->sa_data);
 
 	return 0;
@@ -1868,12 +1868,13 @@ static void i40e_cleanup_add_list(struct list_head *add_list)
 /**
  * i40e_sync_vsi_filters - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
+ * @grab_rtnl: whether RTNL needs to be grabbed
  *
  * Push any outstanding VSI filter changes through the AdminQ.
  *
  * Returns 0 or error value
  **/
-int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
+int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 {
 	struct list_head tmp_del_list, tmp_add_list;
 	struct i40e_mac_filter *f, *ftmp, *fclone;
@@ -2128,7 +2129,11 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			 */
 			if (pf->cur_promisc != cur_promisc) {
 				pf->cur_promisc = cur_promisc;
-				i40e_do_reset_safe(pf,
+				if (grab_rtnl)
+					i40e_do_reset_safe(pf,
+						BIT(__I40E_PF_RESET_REQUESTED));
+				else
+					i40e_do_reset(pf,
 						BIT(__I40E_PF_RESET_REQUESTED));
 			}
 		} else {
@@ -2179,7 +2184,7 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v] &&
 		    (pf->vsi[v]->flags & I40E_VSI_FLAG_FILTER_CHANGED))
-			i40e_sync_vsi_filters(pf->vsi[v]);
+			i40e_sync_vsi_filters(pf->vsi[v], true);
 	}
 }
 
@@ -2398,7 +2403,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 	    test_bit(__I40E_RESET_RECOVERY_PENDING, &vsi->back->state))
 		return 0;
 
-	return i40e_sync_vsi_filters(vsi);
+	return i40e_sync_vsi_filters(vsi, false);
 }
 
 /**
@@ -2480,7 +2485,7 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 	    test_bit(__I40E_RESET_RECOVERY_PENDING, &vsi->back->state))
 		return 0;
 
-	return i40e_sync_vsi_filters(vsi);
+	return i40e_sync_vsi_filters(vsi, false);
 }
 
 /**
@@ -9032,7 +9037,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 				f->is_vf, f->is_netdev);
 	spin_unlock(&vsi->mac_filter_list_lock);
 
-	i40e_sync_vsi_filters(vsi);
+	i40e_sync_vsi_filters(vsi, false);
 
 	i40e_vsi_delete(vsi);
 	i40e_vsi_free_q_vectors(vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 465b1e9..769faf7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -565,7 +565,7 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 	}
 
 	/* program mac filter */
-	ret = i40e_sync_vsi_filters(vsi);
+	ret = i40e_sync_vsi_filters(vsi, false);
 	if (ret)
 		dev_err(&pf->pdev->dev, "Unable to program ucast filters\n");
 
@@ -1629,7 +1629,7 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	spin_unlock(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
-	if (i40e_sync_vsi_filters(vsi))
+	if (i40e_sync_vsi_filters(vsi, false))
 		dev_err(&pf->pdev->dev, "Unable to program VF MAC filters\n");
 
 error_param:
@@ -1682,7 +1682,7 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	spin_unlock(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
-	if (i40e_sync_vsi_filters(vsi))
+	if (i40e_sync_vsi_filters(vsi, false))
 		dev_err(&pf->pdev->dev, "Unable to program VF MAC filters\n");
 
 error_param:
@@ -2096,7 +2096,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 
 	dev_info(&pf->pdev->dev, "Setting MAC %pM on VF %d\n", mac, vf_id);
 	/* program mac filter */
-	if (i40e_sync_vsi_filters(vsi)) {
+	if (i40e_sync_vsi_filters(vsi, false)) {
 		dev_err(&pf->pdev->dev, "Unable to program ucast filters\n");
 		ret = -EIO;
 		goto error_param;
-- 
1.8.1.4

