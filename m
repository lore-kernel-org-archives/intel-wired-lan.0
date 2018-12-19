From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Dec 2018 06:45:41 -0800
Subject: [Intel-wired-lan] [next PATCH S1 5/6] i40e: remove debugfs
 tx_timeout support
In-Reply-To: <20181219144542.85924-1-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
Message-ID: <20181219144542.85924-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

The tx_timeout command from debugfs was originally intended to support
early silicon validation efforts. It is no longer needed. Thus remove it to
avoid misuse of triggering tx_timeout through debugfs.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index a20d1cf058ad..c67d485d6f99 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1642,30 +1642,7 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 		count = buf_tmp - i40e_dbg_netdev_ops_buf + 1;
 	}
 
-	if (strncmp(i40e_dbg_netdev_ops_buf, "tx_timeout", 10) == 0) {
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i", &vsi_seid);
-		if (cnt != 1) {
-			dev_info(&pf->pdev->dev, "tx_timeout <vsi_seid>\n");
-			goto netdev_ops_write_done;
-		}
-		vsi = i40e_dbg_find_vsi(pf, vsi_seid);
-		if (!vsi) {
-			dev_info(&pf->pdev->dev,
-				 "tx_timeout: VSI %d not found\n", vsi_seid);
-		} else if (!vsi->netdev) {
-			dev_info(&pf->pdev->dev, "tx_timeout: no netdev for VSI %d\n",
-				 vsi_seid);
-		} else if (test_bit(__I40E_VSI_DOWN, vsi->state)) {
-			dev_info(&pf->pdev->dev, "tx_timeout: VSI %d not UP\n",
-				 vsi_seid);
-		} else if (rtnl_trylock()) {
-			vsi->netdev->netdev_ops->ndo_tx_timeout(vsi->netdev);
-			rtnl_unlock();
-			dev_info(&pf->pdev->dev, "tx_timeout called\n");
-		} else {
-			dev_info(&pf->pdev->dev, "Could not acquire RTNL - please try again\n");
-		}
-	} else if (strncmp(i40e_dbg_netdev_ops_buf, "change_mtu", 10) == 0) {
+	if (strncmp(i40e_dbg_netdev_ops_buf, "change_mtu", 10) == 0) {
 		int mtu;
 
 		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i %i",
@@ -1733,7 +1710,6 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 		dev_info(&pf->pdev->dev, "unknown command '%s'\n",
 			 i40e_dbg_netdev_ops_buf);
 		dev_info(&pf->pdev->dev, "available commands\n");
-		dev_info(&pf->pdev->dev, "  tx_timeout <vsi_seid>\n");
 		dev_info(&pf->pdev->dev, "  change_mtu <vsi_seid> <mtu>\n");
 		dev_info(&pf->pdev->dev, "  set_rx_mode <vsi_seid>\n");
 		dev_info(&pf->pdev->dev, "  napi <vsi_seid>\n");
-- 
2.19.2

