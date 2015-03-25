From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:20 -0700
Subject: [Intel-wired-lan] [next-queue S2 10/15] i40e: fix up VXLAN messages
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-10-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

When the VXLAN ports are added and removed, the messaging was giving some
bogus index info, the port was always '0' for the delete, and the message
text style didn't match other messages in the driver.  Also, there was an
over-use of the tertiary statement which made reading a little harder
than necessary.

Change-ID: Ie805182a697b8b4c12024403ada87fd4e4fa2358
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9e19933..15cee4d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6608,7 +6608,6 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
-	u8 filter_index;
 	__be16 port;
 	int i;
 
@@ -6621,22 +6620,20 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 		if (pf->pending_vxlan_bitmap & (1 << i)) {
 			pf->pending_vxlan_bitmap &= ~(1 << i);
 			port = pf->vxlan_ports[i];
-			ret = port ?
-			      i40e_aq_add_udp_tunnel(hw, ntohs(port),
+			if (port)
+				ret = i40e_aq_add_udp_tunnel(hw, ntohs(port),
 						     I40E_AQC_TUNNEL_TYPE_VXLAN,
-						     &filter_index, NULL)
-			      : i40e_aq_del_udp_tunnel(hw, i, NULL);
+						     NULL, NULL);
+			else
+				ret = i40e_aq_del_udp_tunnel(hw, i, NULL);
 
 			if (ret) {
-				dev_info(&pf->pdev->dev, "Failed to execute AQ command for %s port %d with index %d\n",
-					 port ? "adding" : "deleting",
-					 ntohs(port), port ? i : i);
-
+				dev_info(&pf->pdev->dev,
+					 "%s vxlan port %d, index %d failed, err %d, aq_err %d\n",
+					 port ? "add" : "delete",
+					 ntohs(port), i, ret,
+					 pf->hw.aq.asq_last_status);
 				pf->vxlan_ports[i] = 0;
-			} else {
-				dev_info(&pf->pdev->dev, "%s port %d with AQ command with index %d\n",
-					 port ? "Added" : "Deleted",
-					 ntohs(port), port ? i : filter_index);
 			}
 		}
 	}
@@ -7829,7 +7826,8 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 
 	/* Check if port already exists */
 	if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
-		netdev_info(netdev, "Port %d already offloaded\n", ntohs(port));
+		netdev_info(netdev, "vxlan port %d already offloaded\n",
+			    ntohs(port));
 		return;
 	}
 
@@ -7837,7 +7835,7 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 	next_idx = i40e_get_vxlan_port_idx(pf, 0);
 
 	if (next_idx == I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
-		netdev_info(netdev, "Maximum number of UDP ports reached, not adding port %d\n",
+		netdev_info(netdev, "maximum number of vxlan UDP ports reached, not adding port %d\n",
 			    ntohs(port));
 		return;
 	}
@@ -7845,8 +7843,9 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 	/* New port: add it and mark its index in the bitmap */
 	pf->vxlan_ports[next_idx] = port;
 	pf->pending_vxlan_bitmap |= (1 << next_idx);
-
 	pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
+
+	dev_info(&pf->pdev->dev, "adding vxlan port %d\n", ntohs(port));
 }
 
 /**
@@ -7874,12 +7873,13 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 		 * and make it pending
 		 */
 		pf->vxlan_ports[idx] = 0;
-
 		pf->pending_vxlan_bitmap |= (1 << idx);
-
 		pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
+
+		dev_info(&pf->pdev->dev, "deleting vxlan port %d\n",
+			 ntohs(port));
 	} else {
-		netdev_warn(netdev, "Port %d was not found, not deleting\n",
+		netdev_warn(netdev, "vxlan port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
 }
-- 
1.9.3

