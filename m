From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:38 -0700
Subject: [Intel-wired-lan] [next PATCH S4 09/11] i40e: Add support for X710
 B/P & SFP+ cards
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

New device ids are created to support X710 backplane and SFP+ cards.

This patch adds in i40e driver support for 2.5GbaseT and 5GbaseT speed.
It's implemented by checking I40E_CAP_PHY_TYPE_2_5GBASE_T,
I40E_CAP_PHY_TYPE_5GBASE_T bits from f/w and setting corresponding bits
in ethtool link ksettings supported and advertising masks.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 12 +++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c |  5 +++
 drivers/net/ethernet/intel/i40e/i40e_devids.h |  3 ++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 42 ++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 ++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  6 +++
 6 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index abcf79eb3261..6536023fa074 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1888,6 +1888,8 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
 	I40E_PHY_TYPE_25GBASE_AOC		= 0x23,
 	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
+	I40E_PHY_TYPE_2_5GBASE_T		= 0x30,
+	I40E_PHY_TYPE_5GBASE_T			= 0x31,
 	I40E_PHY_TYPE_MAX,
 	I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP	= 0xFD,
 	I40E_PHY_TYPE_EMPTY			= 0xFE,
@@ -1929,19 +1931,25 @@ enum i40e_aq_phy_type {
 				BIT_ULL(I40E_PHY_TYPE_25GBASE_SR) | \
 				BIT_ULL(I40E_PHY_TYPE_25GBASE_LR) | \
 				BIT_ULL(I40E_PHY_TYPE_25GBASE_AOC) | \
-				BIT_ULL(I40E_PHY_TYPE_25GBASE_ACC))
+				BIT_ULL(I40E_PHY_TYPE_25GBASE_ACC) | \
+				BIT_ULL(I40E_PHY_TYPE_2_5GBASE_T) | \
+				BIT_ULL(I40E_PHY_TYPE_5GBASE_T))
 
+#define I40E_LINK_SPEED_2_5GB_SHIFT	0x0
 #define I40E_LINK_SPEED_100MB_SHIFT	0x1
 #define I40E_LINK_SPEED_1000MB_SHIFT	0x2
 #define I40E_LINK_SPEED_10GB_SHIFT	0x3
 #define I40E_LINK_SPEED_40GB_SHIFT	0x4
 #define I40E_LINK_SPEED_20GB_SHIFT	0x5
 #define I40E_LINK_SPEED_25GB_SHIFT	0x6
+#define I40E_LINK_SPEED_5GB_SHIFT	0x7
 
 enum i40e_aq_link_speed {
 	I40E_LINK_SPEED_UNKNOWN	= 0,
 	I40E_LINK_SPEED_100MB	= BIT(I40E_LINK_SPEED_100MB_SHIFT),
 	I40E_LINK_SPEED_1GB	= BIT(I40E_LINK_SPEED_1000MB_SHIFT),
+	I40E_LINK_SPEED_2_5GB	= (1 << I40E_LINK_SPEED_2_5GB_SHIFT),
+	I40E_LINK_SPEED_5GB	= (1 << I40E_LINK_SPEED_5GB_SHIFT),
 	I40E_LINK_SPEED_10GB	= BIT(I40E_LINK_SPEED_10GB_SHIFT),
 	I40E_LINK_SPEED_40GB	= BIT(I40E_LINK_SPEED_40GB_SHIFT),
 	I40E_LINK_SPEED_20GB	= BIT(I40E_LINK_SPEED_20GB_SHIFT),
@@ -1987,6 +1995,8 @@ struct i40e_aq_get_phy_abilities_resp {
 #define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
 #define I40E_AQ_PHY_TYPE_EXT_25G_AOC	0x10
 #define I40E_AQ_PHY_TYPE_EXT_25G_ACC	0x20
+#define I40E_AQ_PHY_TYPE_EXT_2_5GBASE_T	0x40
+#define I40E_AQ_PHY_TYPE_EXT_5GBASE_T	0x80
 	u8	fec_cfg_curr_mod_ext_info;
 #define I40E_AQ_ENABLE_FEC_KR		0x01
 #define I40E_AQ_ENABLE_FEC_RS		0x02
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 8de6e007b4a0..ecb1adaa54ec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -28,6 +28,8 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_QSFP_C:
 		case I40E_DEV_ID_10G_BASE_T:
 		case I40E_DEV_ID_10G_BASE_T4:
+		case I40E_DEV_ID_10G_B:
+		case I40E_DEV_ID_10G_SFP:
 		case I40E_DEV_ID_20G_KR2:
 		case I40E_DEV_ID_20G_KR2_A:
 		case I40E_DEV_ID_25G_B:
@@ -1151,6 +1153,8 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
 		break;
 	case I40E_PHY_TYPE_100BASE_TX:
 	case I40E_PHY_TYPE_1000BASE_T:
+	case I40E_PHY_TYPE_2_5GBASE_T:
+	case I40E_PHY_TYPE_5GBASE_T:
 	case I40E_PHY_TYPE_10GBASE_T:
 		media = I40E_MEDIA_TYPE_BASET;
 		break;
@@ -4900,6 +4904,7 @@ i40e_status i40e_read_phy_register(struct i40e_hw *hw,
 		break;
 	case I40E_DEV_ID_10G_BASE_T:
 	case I40E_DEV_ID_10G_BASE_T4:
+	case I40E_DEV_ID_10G_BASE_T_BC:
 	case I40E_DEV_ID_10G_BASE_T_X722:
 	case I40E_DEV_ID_25G_B:
 	case I40E_DEV_ID_25G_SFP28:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index 16be4d5286bd..bac4da031f9b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -20,6 +20,9 @@
 #define I40E_DEV_ID_10G_BASE_T4		0x1589
 #define I40E_DEV_ID_25G_B		0x158A
 #define I40E_DEV_ID_25G_SFP28		0x158B
+#define I40E_DEV_ID_10G_BASE_T_BC	0x15FF
+#define I40E_DEV_ID_10G_B		0x104F
+#define I40E_DEV_ID_10G_SFP		0x104E
 #define I40E_DEV_ID_KX_X722		0x37CE
 #define I40E_DEV_ID_QSFP_X722		0x37CF
 #define I40E_DEV_ID_SFP_X722		0x37D0
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 74c2f15cf42e..d5e7e3babc41 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -508,6 +508,20 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     10000baseT_Full);
 	}
+	if (phy_types & I40E_CAP_PHY_TYPE_2_5GBASE_T) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     2500baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_2_5GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     2500baseT_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_5GBASE_T) {
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     5000baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_5GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     5000baseT_Full);
+	}
 	if (phy_types & I40E_CAP_PHY_TYPE_XLAUI ||
 	    phy_types & I40E_CAP_PHY_TYPE_XLPPI ||
 	    phy_types & I40E_CAP_PHY_TYPE_40GBASE_AOC)
@@ -674,13 +688,15 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_KR ||
 	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_CR ||
 	    phy_types & I40E_CAP_PHY_TYPE_20GBASE_KR2 ||
-	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_T ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_SR ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_LR ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_KX4 ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_KR ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1_CU ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1 ||
+	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_T ||
+	    phy_types & I40E_CAP_PHY_TYPE_5GBASE_T ||
+	    phy_types & I40E_CAP_PHY_TYPE_2_5GBASE_T ||
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL ||
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_T ||
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_SX ||
@@ -790,11 +806,17 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 							     10000baseT_Full);
 		break;
 	case I40E_PHY_TYPE_10GBASE_T:
+	case I40E_PHY_TYPE_5GBASE_T:
+	case I40E_PHY_TYPE_2_5GBASE_T:
 	case I40E_PHY_TYPE_1000BASE_T:
 	case I40E_PHY_TYPE_100BASE_TX:
 		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     5000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     2500baseT_Full);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     1000baseT_Full);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
@@ -803,6 +825,12 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     10000baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_5GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     5000baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_2_5GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     2500baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     1000baseT_Full);
@@ -958,6 +986,12 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_LINK_SPEED_10GB:
 		ks->base.speed = SPEED_10000;
 		break;
+	case I40E_LINK_SPEED_5GB:
+		ks->base.speed = SPEED_5000;
+		break;
+	case I40E_LINK_SPEED_2_5GB:
+		ks->base.speed = SPEED_2500;
+		break;
 	case I40E_LINK_SPEED_1GB:
 		ks->base.speed = SPEED_1000;
 		break;
@@ -1243,6 +1277,12 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  10000baseLR_Full))
 		config.link_speed |= I40E_LINK_SPEED_10GB;
+	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
+						  2500baseT_Full))
+		config.link_speed |= I40E_LINK_SPEED_2_5GB;
+	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
+						  5000baseT_Full))
+		config.link_speed |= I40E_LINK_SPEED_5GB;
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  20000baseKR2_Full))
 		config.link_speed |= I40E_LINK_SPEED_20GB;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a3b225502f23..21bc910dc99c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -69,6 +69,8 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_C), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP), 0},
+	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_B), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
@@ -6516,6 +6518,12 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 	case I40E_LINK_SPEED_10GB:
 		speed = "10 G";
 		break;
+	case I40E_LINK_SPEED_5GB:
+		speed = "5 G";
+		break;
+	case I40E_LINK_SPEED_2_5GB:
+		speed = "2.5 G";
+		break;
 	case I40E_LINK_SPEED_1GB:
 		speed = "1000 M";
 		break;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 820af0043cc8..8f43aa47c263 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -252,6 +252,12 @@ struct i40e_phy_info {
 					     I40E_PHY_TYPE_OFFSET)
 #define I40E_CAP_PHY_TYPE_25GBASE_ACC BIT_ULL(I40E_PHY_TYPE_25GBASE_ACC + \
 					     I40E_PHY_TYPE_OFFSET)
+/* Offset for 2.5G/5G PHY Types value to bit number conversion */
+#define I40E_PHY_TYPE_OFFSET2 (-10)
+#define I40E_CAP_PHY_TYPE_2_5GBASE_T BIT_ULL(I40E_PHY_TYPE_2_5GBASE_T + \
+					     I40E_PHY_TYPE_OFFSET2)
+#define I40E_CAP_PHY_TYPE_5GBASE_T BIT_ULL(I40E_PHY_TYPE_5GBASE_T + \
+					     I40E_PHY_TYPE_OFFSET2)
 #define I40E_HW_CAP_MAX_GPIO			30
 /* Capabilities of a PF or a VF or the whole device */
 struct i40e_hw_capabilities {
-- 
2.19.2

