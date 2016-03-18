From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Fri, 18 Mar 2016 12:18:05 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v4 01/12] i40e: Enable Geneve
	offload for FW API ver > 1.4 for XL710/X710 devices
In-Reply-To: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458328696-135941-2-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

This patch enables the Capability for XL710/X710 devices with FW API
version higher than 1.4 to do geneve Rx offload.

Testing Hints: Test it on XL710 device with FW API version 1.5 and lower.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I9a8f87772c48d7d67dc85e3701d2e0b845034c0b
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 39b0009..31f6ee1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9093,6 +9093,12 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 					I40E_VLAN_ANY, false, true);
 			spin_unlock_bh(&vsi->mac_filter_list_lock);
 		}
+	} else if ((pf->hw.aq.api_maj_ver > 1) ||
+		   ((pf->hw.aq.api_maj_ver == 1) &&
+		    (pf->hw.aq.api_min_ver > 4))) {
+		/* Supported in FW API version higher than 1.4 */
+		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
+		pf->auto_disable_flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	} else {
 		/* relate the VSI_VMDQ name to the VSI_MAIN name */
 		snprintf(netdev->name, IFNAMSIZ, "%sv%%d",
-- 
2.4.3

