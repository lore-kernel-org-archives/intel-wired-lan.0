From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Tue, 28 Jul 2015 13:02:00 -0400
Subject: [Intel-wired-lan] [net PATCH] i40e: Set defport behavior for the
	Main VSI when in promiscuous mode
Message-ID: <1438102920-189224-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

This fixes bugs where the port is not receiving multicast or vlan tagged
packets when in promiscuous mode. This can occur when a SW bridge is
created on top of the device.

This also fixes issues where the promiscuous behavior setting was not
being preserved across a reset caused by features being enabled or
disabled.

We are using defport instead of doing a true promiscuous mode because we do
not need to receive the SRIOV or VMDq VSI directed traffic which would suck
up bandwidth and is really not intended for the SW bridge.

In addition, with defport we get VLAN promiscuous behavior which is not
possible from the VSI level promiscuous setting.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: Ie21985eac32d5af1c02e9d71c6430a90d5bab40f
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 36 ++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index ec76c3f..2198991 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -362,6 +362,7 @@ struct i40e_pf {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *i40e_dbg_pf;
 #endif /* CONFIG_DEBUG_FS */
+	bool cur_promisc;
 
 	u16 instance; /* A unique number per i40e_pf instance in the system */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 48a52b3..9295768 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1885,13 +1885,36 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		cur_promisc = (!!(vsi->current_netdev_flags & IFF_PROMISC) ||
 			       test_bit(__I40E_FILTER_OVERFLOW_PROMISC,
 					&vsi->state));
-		aq_ret = i40e_aq_set_vsi_unicast_promiscuous(&vsi->back->hw,
+		if (vsi->type == I40E_VSI_MAIN && pf->lan_veb != I40E_NO_VEB) {
+			/*  set defport ON for Main VSI instead of true promisc
+			 *  this way we will get all unicast/multicast and vlan
+			 *  promisc behavior but will not get VF or VMDq traffic
+			 *  replicated on the Main VSI.
+			 */
+			if (pf->cur_promisc != cur_promisc) {
+				pf->cur_promisc = cur_promisc;
+				i40e_do_reset_safe(pf,
+						BIT(__I40E_PF_RESET_REQUESTED));
+			}
+		} else {
+			aq_ret = i40e_aq_set_vsi_unicast_promiscuous(
+							     &vsi->back->hw,
 							     vsi->seid,
 							     cur_promisc, NULL);
-		if (aq_ret)
-			dev_info(&pf->pdev->dev,
-				 "set uni promisc failed, err %d, aq_err %d\n",
-				 aq_ret, pf->hw.aq.asq_last_status);
+			if (aq_ret)
+				dev_info(&pf->pdev->dev,
+					 "set unicast promisc failed, err %d, aq_err %d\n",
+					 aq_ret, pf->hw.aq.asq_last_status);
+			aq_ret = i40e_aq_set_vsi_multicast_promiscuous(
+								&vsi->back->hw,
+								vsi->seid,
+								cur_promisc,
+								NULL);
+			if (aq_ret)
+				dev_info(&pf->pdev->dev,
+					 "set multicast promisc failed, err %d, aq_err %d\n",
+					 aq_ret, pf->hw.aq.asq_last_status);
+		}
 		aq_ret = i40e_aq_set_vsi_broadcast(&vsi->back->hw,
 						   vsi->seid,
 						   cur_promisc, NULL);
@@ -3929,6 +3952,7 @@ static void i40e_vsi_close(struct i40e_vsi *vsi)
 	i40e_vsi_free_irq(vsi);
 	i40e_vsi_free_tx_resources(vsi);
 	i40e_vsi_free_rx_resources(vsi);
+	vsi->current_netdev_flags = 0;
 }
 
 /**
@@ -9090,7 +9114,7 @@ void i40e_veb_release(struct i40e_veb *veb)
  **/
 static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 {
-	bool is_default = false;
+	bool is_default = veb->pf->cur_promisc;
 	bool is_cloud = false;
 	int ret;
 
-- 
1.9.3

