From: Alice Michael <alice.michael@intel.com>
Date: Tue, 18 Jul 2017 10:06:15 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V3 11/13] i40e: Add new phy types
	for 25G AOC and ACC support.
Message-ID: <20170718140615.3250-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

This patch adds support for 25G Active Optical Cables (AOC) and Active
Copper Cables (ACC) phy types. 

Signed-off-by: Krzysztof Malek <krzysztof.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 5 +++++
 drivers/net/ethernet/intel/i40e/i40e_common.c       | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c      | 9 +++++++++
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 5 +++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 5d5f422..6945510 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1744,6 +1744,9 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
 	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
+	I40E_PHY_TYPE_25GBASE_AOC		= 0x23,
+	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
+
 	I40E_PHY_TYPE_MAX
 };
 
@@ -1801,6 +1804,8 @@ struct i40e_aq_get_phy_abilities_resp {
 #define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
 #define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
 #define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+#define I40E_AQ_PHY_TYPE_EXT_25G_AOC	0x10
+#define I40E_AQ_PHY_TYPE_EXT_25G_ACC	0x20
 	u8	fec_cfg_curr_mod_ext_info;
 #define I40E_AQ_ENABLE_FEC_KR		0x01
 #define I40E_AQ_ENABLE_FEC_RS		0x02
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 111426b..f1d8b5c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1180,6 +1180,8 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
 	case I40E_PHY_TYPE_40GBASE_AOC:
 	case I40E_PHY_TYPE_10GBASE_AOC:
 	case I40E_PHY_TYPE_25GBASE_CR:
+	case I40E_PHY_TYPE_25GBASE_AOC:
+	case I40E_PHY_TYPE_25GBASE_ACC:
 		media = I40E_MEDIA_TYPE_DA;
 		break;
 	case I40E_PHY_TYPE_1000BASE_KX:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 326fc18..6b07e90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -665,6 +665,15 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(cmd, advertising,
 						     Asym_Pause);
 		break;
+	case I40E_PHY_TYPE_25GBASE_AOC:
+	case I40E_PHY_TYPE_25GBASE_ACC:
+		ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     25000baseCR_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     25000baseCR_Full);
+		break;
 	default:
 		ethtool_convert_link_mode_to_legacy_u32(
 			&advertising, cmd->link_modes.advertising);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 83e63e5..77e6e06 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1740,6 +1740,9 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
 	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
+	I40E_PHY_TYPE_25GBASE_AOC		= 0x23,
+	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
+
 	I40E_PHY_TYPE_MAX
 };
 
@@ -1797,6 +1800,8 @@ struct i40e_aq_get_phy_abilities_resp {
 #define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
 #define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
 #define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
+#define I40E_AQ_PHY_TYPE_EXT_25G_AOC	0x10
+#define I40E_AQ_PHY_TYPE_EXT_25G_ACC	0x20
 	u8	fec_cfg_curr_mod_ext_info;
 #define I40E_AQ_ENABLE_FEC_KR		0x01
 #define I40E_AQ_ENABLE_FEC_RS		0x02
-- 
2.9.3

