From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:25 -0800
Subject: [Intel-wired-lan] [next PATCH S23 05/13] i40e: Replace X722 mac
	check in ethtool get_settings
In-Reply-To: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449705033-4968-6-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

100M SGMII is only supported on X722.  Replace the mac check with
a feature flag check that is only set for the X722 device.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I53452d9af6af8cd9dca8500215fbc6ce93418f52
---
Testing Hints: Check that 100M SGMII is not listed as supported on X710
devices and is listed as supported on X722 devices.

 drivers/net/ethernet/intel/i40e/i40e.h         | 3 ++-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 3d0269b..4747219 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -334,7 +334,8 @@ struct i40e_pf {
 #define I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE	BIT_ULL(38)
 #define I40E_FLAG_LINK_POLLING_ENABLED		BIT_ULL(39)
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(40)
-#define I40E_FLAG_NO_PCI_LINK_CHECK		BIT_ULL(42)
+#define I40E_FLAG_NO_PCI_LINK_CHECK		BIT_ULL(41)
+#define I40E_FLAG_100M_SGMII_CAPABLE		BIT_ULL(42)
 
 	/* tracks features that get auto disabled by errors */
 	u64 auto_disable_flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c8b9dca..252a9dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -340,7 +340,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 				  SUPPORTED_1000baseT_Full;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ecmd->advertising |= ADVERTISED_1000baseT_Full;
-		if (pf->hw.mac.type == I40E_MAC_X722) {
+		if (pf->flags & I40E_FLAG_100M_SGMII_CAPABLE) {
 			ecmd->supported |= SUPPORTED_100baseT_Full;
 			if (hw_link_info->requested_speeds &
 			    I40E_LINK_SPEED_100MB)
-- 
2.1.0

