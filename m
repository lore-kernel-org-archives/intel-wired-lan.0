From: Alice Michael <alice.michael@intel.com>
Date: Fri, 23 Jun 2017 04:24:45 -0400
Subject: [Intel-wired-lan] [next PATCH S74-V2 04/10] i40e: Fix a bug with
	VMDq RSS queue allocation
In-Reply-To: <20170623082451.32671-1-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
Message-ID: <20170623082451.32671-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The X722 pf flag setup should happen before the VMDq RSS queue count is
initialized for VMDq VSI to get the right number of queues for RSS in
case of X722 devices.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 46 ++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b429550..798564c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9000,6 +9000,29 @@ static int i40e_sw_init(struct i40e_pf *pf)
 				 pf->hw.func_caps.fd_filters_best_effort;
 	}
 
+	if (pf->hw.mac.type == I40E_MAC_X722) {
+		pf->flags |= I40E_FLAG_RSS_AQ_CAPABLE
+			     | I40E_FLAG_128_QP_RSS_CAPABLE
+			     | I40E_FLAG_HW_ATR_EVICT_CAPABLE
+			     | I40E_FLAG_OUTER_UDP_CSUM_CAPABLE
+			     | I40E_FLAG_WB_ON_ITR_CAPABLE
+			     | I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE
+			     | I40E_FLAG_NO_PCI_LINK_CHECK
+			     | I40E_FLAG_USE_SET_LLDP_MIB
+			     | I40E_FLAG_GENEVE_OFFLOAD_CAPABLE
+			     | I40E_FLAG_PTP_L4_CAPABLE
+			     | I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE;
+	} else if ((pf->hw.aq.api_maj_ver > 1) ||
+		   ((pf->hw.aq.api_maj_ver == 1) &&
+		    (pf->hw.aq.api_min_ver > 4))) {
+		/* Supported in FW API version higher than 1.4 */
+		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
+	}
+
+	/* Enable HW ATR eviction if possible */
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
+		pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
+
 	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
 	    (pf->hw.aq.fw_maj_ver < 4))) {
@@ -9041,29 +9064,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
 					I40E_MAX_VF_COUNT);
 	}
 #endif /* CONFIG_PCI_IOV */
-	if (pf->hw.mac.type == I40E_MAC_X722) {
-		pf->flags |= I40E_FLAG_RSS_AQ_CAPABLE
-			     | I40E_FLAG_128_QP_RSS_CAPABLE
-			     | I40E_FLAG_HW_ATR_EVICT_CAPABLE
-			     | I40E_FLAG_OUTER_UDP_CSUM_CAPABLE
-			     | I40E_FLAG_WB_ON_ITR_CAPABLE
-			     | I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE
-			     | I40E_FLAG_NO_PCI_LINK_CHECK
-			     | I40E_FLAG_USE_SET_LLDP_MIB
-			     | I40E_FLAG_GENEVE_OFFLOAD_CAPABLE
-			     | I40E_FLAG_PTP_L4_CAPABLE
-			     | I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE;
-	} else if ((pf->hw.aq.api_maj_ver > 1) ||
-		   ((pf->hw.aq.api_maj_ver == 1) &&
-		    (pf->hw.aq.api_min_ver > 4))) {
-		/* Supported in FW API version higher than 1.4 */
-		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
-	}
-
-	/* Enable HW ATR eviction if possible */
-	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
-		pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
-
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
 	pf->lan_vsi = I40E_NO_VSI;
-- 
2.9.3

