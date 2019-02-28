From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:26:00 -0800
Subject: [Intel-wired-lan] [PATCH S17 14/17] ice: Add missing PHY type to
 link settings
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-15-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>

The PHY type ICE_PHY_TYPE_LOW_25G_AUI_C2C is missing from
ice_get_settings_link_up() which is causing a warning
message for unrecognized PHY.  Add the PHY type to
correctly set the settings and avoid the warning message.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f995ed599cd9..0bfe696d8077 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1034,6 +1034,7 @@ ice_get_settings_link_up(struct ethtool_link_ksettings *ks,
 						     25000baseCR_Full);
 		break;
 	case ICE_PHY_TYPE_LOW_25G_AUI_AOC_ACC:
+	case ICE_PHY_TYPE_LOW_25G_AUI_C2C:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     25000baseCR_Full);
 		break;
-- 
2.14.5

