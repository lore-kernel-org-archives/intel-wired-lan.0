From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 27 Sep 2016 11:28:49 -0700
Subject: [Intel-wired-lan] [next PATCH S48 2/7] i40e: Fix for ethtool LED
	blinking on X722 for 1GbE.
In-Reply-To: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475000934-27335-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch fixes the problem where when the 'ethtool -p'
functionality is stopped, the activity LED on X722 for
1GbE stops and no longer blinks. This patch fixes
the problem by including the device ID for 1GbE X722
under the existing codepath for the 10GBaseT X722 device.
Without this patch, the ethtool LED blinking does not
function properly on X722 devices for 1GbE.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Change-ID: I84192ebd0682fb7f4cf009818c21191eaffac7ea
---
Testing Hints: On X722 for 1GbE, the LED should
continue to blink after 'ethtool -p <ethX>' is stopped.

 drivers/net/ethernet/intel/i40e/i40e.h         | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index b9a5349..ddaa37e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -355,7 +355,7 @@ struct i40e_pf {
 #define I40E_FLAG_NO_DCB_SUPPORT		BIT_ULL(45)
 #define I40E_FLAG_USE_SET_LLDP_MIB		BIT_ULL(46)
 #define I40E_FLAG_STOP_FW_LLDP			BIT_ULL(47)
-#define I40E_FLAG_HAVE_10GBASET_PHY		BIT_ULL(48)
+#define I40E_FLAG_HAVE_BASET_PHY		BIT_ULL(48)
 #define I40E_FLAG_PF_MAC			BIT_ULL(50)
 #define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT_ULL(51)
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2d02654..8b6eaf4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1915,7 +1915,7 @@ static int i40e_set_phys_id(struct net_device *netdev,
 
 	switch (state) {
 	case ETHTOOL_ID_ACTIVE:
-		if (!(pf->flags & I40E_FLAG_HAVE_10GBASET_PHY)) {
+		if (!(pf->flags & I40E_FLAG_HAVE_BASET_PHY)) {
 			pf->led_status = i40e_led_get(hw);
 		} else {
 			i40e_aq_set_phy_debug(hw, I40E_PHY_DEBUG_ALL, NULL);
@@ -1925,19 +1925,19 @@ static int i40e_set_phys_id(struct net_device *netdev,
 		}
 		return blink_freq;
 	case ETHTOOL_ID_ON:
-		if (!(pf->flags & I40E_FLAG_HAVE_10GBASET_PHY))
+		if (!(pf->flags & I40E_FLAG_HAVE_BASET_PHY))
 			i40e_led_set(hw, 0xf, false);
 		else
 			ret = i40e_led_set_phy(hw, true, pf->led_status, 0);
 		break;
 	case ETHTOOL_ID_OFF:
-		if (!(pf->flags & I40E_FLAG_HAVE_10GBASET_PHY))
+		if (!(pf->flags & I40E_FLAG_HAVE_BASET_PHY))
 			i40e_led_set(hw, 0x0, false);
 		else
 			ret = i40e_led_set_phy(hw, false, pf->led_status, 0);
 		break;
 	case ETHTOOL_ID_INACTIVE:
-		if (!(pf->flags & I40E_FLAG_HAVE_10GBASET_PHY)) {
+		if (!(pf->flags & I40E_FLAG_HAVE_BASET_PHY)) {
 			i40e_led_set(hw, false, pf->led_status);
 		} else {
 			ret = i40e_led_set_phy(hw, false, pf->led_status,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b2c9f9d..e6ab33c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11237,8 +11237,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 						       pf->main_vsi_seid);
 
 	if ((pf->hw.device_id == I40E_DEV_ID_10G_BASE_T) ||
-	    (pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4))
-		pf->flags |= I40E_FLAG_HAVE_10GBASET_PHY;
+	    (pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4) ||
+	    (pf->hw.device_id == I40E_DEV_ID_1G_BASE_T_X722))
+		pf->flags |= I40E_FLAG_HAVE_BASET_PHY;
 
 	/* print a string summarizing features */
 	i40e_print_features(pf);
-- 
2.4.11

