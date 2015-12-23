From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:53 -0800
Subject: [Intel-wired-lan] [next PATCH S25 13/16] i40e: add netdev info to
	vsi dump
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-14-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add a few more bits of netdev data into the debugfs output for dump vsi.
For now, we'll add the features, hw_features, vlan_features, and flags
bitflags and the state. More could be added later if needed.

Also, tweak a couple nearby output lines for output readability.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Reviewed-by: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Reviewed-by: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Change-ID: I9fb5a9da75c9ad7679498ce9ac3ba24d065ddd2e
---
Testing-Hints:
Do a "dump vsi" in debugfs and see the new prints in the output.

 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 10744a6..7aae056 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -379,19 +379,27 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		return;
 	}
 	dev_info(&pf->pdev->dev, "vsi seid %d\n", seid);
-	if (vsi->netdev)
-		dev_info(&pf->pdev->dev,
-			 "    netdev: name = %s\n",
-			 vsi->netdev->name);
+	if (vsi->netdev) {
+		struct net_device *nd = vsi->netdev;
+
+		dev_info(&pf->pdev->dev, "    netdev: name = %s, state = %lu, flags = 0x%08x\n",
+			 nd->name, nd->state, nd->flags);
+		dev_info(&pf->pdev->dev, "        features      = 0x%08lx\n",
+			 (unsigned long int)nd->features);
+		dev_info(&pf->pdev->dev, "        hw_features   = 0x%08lx\n",
+			 (unsigned long int)nd->hw_features);
+		dev_info(&pf->pdev->dev, "        vlan_features = 0x%08lx\n",
+			 (unsigned long int)nd->vlan_features);
+	}
 	if (vsi->active_vlans)
 		dev_info(&pf->pdev->dev,
 			 "    vlgrp: & = %p\n", vsi->active_vlans);
 	dev_info(&pf->pdev->dev,
-		 "    netdev_registered = %i, current_netdev_flags = 0x%04x, state = %li flags = 0x%08lx\n",
-		 vsi->netdev_registered,
-		 vsi->current_netdev_flags, vsi->state, vsi->flags);
+		 "    state = %li flags = 0x%08lx, netdev_registered = %i, current_netdev_flags = 0x%04x\n",
+		 vsi->state, vsi->flags,
+		 vsi->netdev_registered, vsi->current_netdev_flags);
 	if (vsi == pf->vsi[pf->lan_vsi])
-		dev_info(&pf->pdev->dev, "MAC address: %pM SAN MAC: %pM Port MAC: %pM\n",
+		dev_info(&pf->pdev->dev, "    MAC address: %pM SAN MAC: %pM Port MAC: %pM\n",
 			 pf->hw.mac.addr,
 			 pf->hw.mac.san_addr,
 			 pf->hw.mac.port_addr);
-- 
2.1.0

