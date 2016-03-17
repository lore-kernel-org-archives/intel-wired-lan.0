From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 17 Mar 2016 09:41:27 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v3 09/12] i40e: Fix for supported
	link modes in 10GBaseT PHY's
In-Reply-To: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
References: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458232890-110933-10-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

100baseT/Full is now listed and supported link mode for 10GBaseT PHY's.
This is fix for the defect i.e. PHY type changes when link mode is changed.

Testing Hints: Use 'ethtool -s ethx advertise 0x008' to change supported
	link mode. Check if 100baseT is displayed.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 410d237..8a83d45 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -313,6 +313,13 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 			ecmd->advertising |= ADVERTISED_10000baseT_Full;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ecmd->advertising |= ADVERTISED_1000baseT_Full;
+		/* adding 100baseT support for 10GBASET_PHY */
+		if (pf->flags & I40E_FLAG_HAVE_10GBASET_PHY) {
+			ecmd->supported |= SUPPORTED_100baseT_Full;
+			ecmd->advertising |= ADVERTISED_100baseT_Full |
+					     ADVERTISED_1000baseT_Full |
+					     ADVERTISED_10000baseT_Full;
+		}
 		break;
 	case I40E_PHY_TYPE_1000BASE_T_OPTICAL:
 		ecmd->supported = SUPPORTED_Autoneg |
@@ -325,6 +332,15 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 				  SUPPORTED_100baseT_Full;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
 			ecmd->advertising |= ADVERTISED_100baseT_Full;
+		/* firmware detects 10G phy as 100M phy at 100M speed */
+		if (pf->flags & I40E_FLAG_HAVE_10GBASET_PHY) {
+			ecmd->supported |= SUPPORTED_10000baseT_Full |
+					   SUPPORTED_1000baseT_Full;
+			ecmd->advertising |= ADVERTISED_Autoneg |
+					     ADVERTISED_100baseT_Full |
+					     ADVERTISED_1000baseT_Full |
+					     ADVERTISED_10000baseT_Full;
+		}
 		break;
 	case I40E_PHY_TYPE_10GBASE_CR1_CU:
 	case I40E_PHY_TYPE_10GBASE_CR1:
-- 
2.4.3

