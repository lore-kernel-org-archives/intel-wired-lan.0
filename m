From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:38 -0800
Subject: [Intel-wired-lan] [next PATCH S54 14/15] i40e: Deprecating unused
	macro and
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-15-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I40E_MAC_X710 was supposed to be for 10G and I40E_MAC_XL710
was supposed to be for 40G. But function i40e_is_mac_710
sets I40E_MAC_XL710 for all device IDS, I40E_MAC_X710 is not
used at all. As there is nothing to compare there is no need
for this function. Thus deprecating this extra macro and
removing this function entirely and replacing it with a direct
check.

Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
Change-ID: I7d1769954dccd574a290ac04adb836ebd156730e
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 13 -------------
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +++---
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 -
 drivers/net/ethernet/intel/i40evf/i40e_type.h |  1 -
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e5dcdd3..e24a4ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -134,19 +134,6 @@
 /* default to trying for four seconds */
 #define I40E_TRY_LINK_TIMEOUT	(4 * HZ)
 
-/**
- * i40e_is_mac_710 - Return true if MAC is X710/XL710
- * @hw: ptr to the hardware info
- **/
-static inline bool i40e_is_mac_710(struct i40e_hw *hw)
-{
-	if ((hw->mac.type == I40E_MAC_X710) ||
-	    (hw->mac.type == I40E_MAC_XL710))
-		return true;
-
-	return false;
-}
-
 /* driver state flags */
 enum i40e_state_t {
 	__I40E_TESTING,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 59bc1f6..cdcc229 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8687,7 +8687,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 				 pf->hw.func_caps.fd_filters_best_effort;
 	}
 
-	if (i40e_is_mac_710(&pf->hw) &&
+	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
 	    (pf->hw.aq.fw_maj_ver < 4))) {
 		pf->flags |= I40E_FLAG_RESTART_AUTONEG;
@@ -8696,13 +8696,13 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	}
 
 	/* Disable FW LLDP if FW < v4.3 */
-	if (i40e_is_mac_710(&pf->hw) &&
+	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 3)) ||
 	    (pf->hw.aq.fw_maj_ver < 4)))
 		pf->flags |= I40E_FLAG_STOP_FW_LLDP;
 
 	/* Use the FW Set LLDP MIB API if FW > v4.40 */
-	if (i40e_is_mac_710(&pf->hw) &&
+	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver >= 40)) ||
 	    (pf->hw.aq.fw_maj_ver >= 5)))
 		pf->flags |= I40E_FLAG_USE_SET_LLDP_MIB;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 71795b1..b54232b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -125,7 +125,6 @@ enum i40e_debug_mask {
  */
 enum i40e_mac_type {
 	I40E_MAC_UNKNOWN = 0,
-	I40E_MAC_X710,
 	I40E_MAC_XL710,
 	I40E_MAC_VF,
 	I40E_MAC_X722,
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 493c803..9187c43 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -100,7 +100,6 @@ enum i40e_debug_mask {
  */
 enum i40e_mac_type {
 	I40E_MAC_UNKNOWN = 0,
-	I40E_MAC_X710,
 	I40E_MAC_XL710,
 	I40E_MAC_VF,
 	I40E_MAC_X722,
-- 
2.4.11

