From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:17 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 11/13] i40e: Fix unrecognized
	PHY type warning message for 25G AOC/ACC
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <20170714131019.52530-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

For 25G ACC and AOC PHY types a warning message appears like
"Link is up but PHY type 0x23 is not recognized". This commit
adds a case statement in i40e_get_link_settings_link_up() for
25G AOC/ACC PHY types to set correct parameters.

Signed-off-by: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a868c8d..9212c35 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -665,6 +665,15 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(cmd, advertising,
 						     Asym_Pause);
 		break;
+	case I40E_PHY_TYPE_25GBASE_AOC:
+	case I40E_PHY_TYPE_25GBASE_ACC:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseCR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     25000baseCR_Full);
+		break;
 	default:
 		ethtool_convert_link_mode_to_legacy_u32(
 			&advertising, cmd->link_modes.advertising);
-- 
2.9.3

