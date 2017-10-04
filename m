From: Alan Brady <alan.brady@intel.com>
Date: Wed,  4 Oct 2017 10:58:30 -0700
Subject: [Intel-wired-lan] [PATCH 04/13 net-next] i40e: fix clearing link
	masks in i40e_get_link_ksettings
In-Reply-To: <20171004175839.28364-1-alan.brady@intel.com>
References: <20171004175839.28364-1-alan.brady@intel.com>
Message-ID: <20171004175839.28364-5-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes two issues in i40e_get_link_ksettings.  It adds calls to
ethtool_link_ksettings_zero_link_mode to make sure advertising and
supported link masks are cleared before we start setting bits in them.

This also replaces some funky bit manipulations with a much nicer call
to ethtool_link_ksettings_del_link_mode when removing link modes.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 43294b6567c2..f0cde09c0bd5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -600,7 +600,9 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
 	bool link_up = hw_link_info->link_info & I40E_AQ_LINK_UP;
-	u32 advertising;
+
+	ethtool_link_ksettings_zero_link_mode(ks, supported);
+	ethtool_link_ksettings_zero_link_mode(ks, advertising);
 
 	if (link_up)
 		i40e_get_settings_link_up(hw, ks, netdev, pf);
@@ -664,13 +666,9 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 						     Asym_Pause);
 		break;
 	default:
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, ks->link_modes.advertising);
-
-		advertising &= ~(ADVERTISED_Pause | ADVERTISED_Asym_Pause);
-
-		ethtool_convert_legacy_u32_to_link_mode(
-			ks->link_modes.advertising, advertising);
+		ethtool_link_ksettings_del_link_mode(ks, advertising, Pause);
+		ethtool_link_ksettings_del_link_mode(ks, advertising,
+						     Asym_Pause);
 		break;
 	}
 
-- 
2.14.1

