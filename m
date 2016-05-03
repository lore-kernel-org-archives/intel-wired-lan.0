From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:09 -0700
Subject: [Intel-wired-lan] [next PATCH S36 01/12] i40e: Add support for
	disabling all link and change bits needed for PHY interactions.
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kevin Scott <kevin.c.scott@intel.com>

Add flag to tell firmware to disable link on all ports.

This patch changes the bits set for telling firmware the PHY needs
to be modified by driver.  Without this patch, the setting will only
set that mode for the current port on the device.  Because the
MDIO interface is common for the copper device. The command needs to
set the mode for all ports.

Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I8baa7da91d384291ac95b41ae1a516604f8eb67f
---
Testing Hints :
Test by blinking led on one
or more ports on Fort Pond device and do something to interact
with the other PHY's on the same device at the same time, like
lanconf and Dump PHY NVM.

 drivers/net/ethernet/intel/i40e/i40e.h            | 4 +++-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 3 +++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7f52bfe..0d9038f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -111,7 +111,9 @@
 #define I40E_OEM_VER_PATCH_MASK    0xff
 #define I40E_OEM_VER_BUILD_SHIFT   8
 #define I40E_OEM_VER_SHIFT         24
-#define I40E_PHY_DEBUG_PORT        BIT(4)
+#define I40E_PHY_DEBUG_ALL \
+	(I40E_AQ_PHY_DEBUG_DISABLE_LINK_FW | \
+	I40E_AQ_PHY_DEBUG_DISABLE_ALL_LINK_FW)
 
 /* The values in here are decimal coded as hex as is the case in the NVM map*/
 #define I40E_CURRENT_NVM_VERSION_HI 0x2
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index eacbe74..11cf1a5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1833,7 +1833,10 @@ struct i40e_aqc_set_phy_debug {
 #define I40E_AQ_PHY_DEBUG_RESET_EXTERNAL_NONE	0x00
 #define I40E_AQ_PHY_DEBUG_RESET_EXTERNAL_HARD	0x01
 #define I40E_AQ_PHY_DEBUG_RESET_EXTERNAL_SOFT	0x02
+/* Disable link manageability on a single port */
 #define I40E_AQ_PHY_DEBUG_DISABLE_LINK_FW	0x10
+/* Disable link manageability on all ports */
+#define I40E_AQ_PHY_DEBUG_DISABLE_ALL_LINK_FW	0x20
 	u8	reserved[15];
 };
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0a5374e..8460723 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1880,7 +1880,7 @@ static int i40e_set_phys_id(struct net_device *netdev,
 		if (!(pf->flags & I40E_FLAG_HAVE_10GBASET_PHY)) {
 			pf->led_status = i40e_led_get(hw);
 		} else {
-			i40e_aq_set_phy_debug(hw, I40E_PHY_DEBUG_PORT, NULL);
+			i40e_aq_set_phy_debug(hw, I40E_PHY_DEBUG_ALL, NULL);
 			ret = i40e_led_get_phy(hw, &temp_status,
 					       &pf->phy_led_val);
 			pf->led_status = temp_status;
-- 
2.4.11

