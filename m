From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:41 -0400
Subject: [Intel-wired-lan] [next PATCH S16 12/15] i40e: Recognize
	1000Base_T_Optical phy type when link is up
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

1000Base_T_Optical got added to the function that figures out what
is supported when link is down but not when link is up. Add it in there
too so that we display the correct information.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I85ebcdfa7c02d898c44c673b1500552a53c8042e
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index baec2f8..d196e0b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -307,6 +307,12 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ecmd->advertising |= ADVERTISED_1000baseT_Full;
 		break;
+	case I40E_PHY_TYPE_1000BASE_T_OPTICAL:
+		ecmd->supported = SUPPORTED_Autoneg |
+				  SUPPORTED_1000baseT_Full;
+		ecmd->advertising = ADVERTISED_Autoneg |
+				    ADVERTISED_1000baseT_Full;
+		break;
 	case I40E_PHY_TYPE_100BASE_TX:
 		ecmd->supported = SUPPORTED_Autoneg |
 				  SUPPORTED_100baseT_Full;
-- 
1.9.3

