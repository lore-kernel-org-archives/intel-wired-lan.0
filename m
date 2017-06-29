From: Alice Michael <alice.michael@intel.com>
Date: Thu, 29 Jun 2017 04:36:43 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V2 12/12] i40e: Add support for
	'ethtool -m'
In-Reply-To: <20170629083643.82018-1-alice.michael@intel.com>
References: <20170629083643.82018-1-alice.michael@intel.com>
Message-ID: <20170629083643.82018-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch adds support for 'ethtool -m' command which displays
information about (Q)SFP+ module plugged into NIC's cage.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 149 +++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index b273c24..06f17ff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4196,6 +4196,153 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	return 0;
 }
 
+#define I40E_I2C_EEPROM_DEV_ADDR	0xA0
+#define I40E_I2C_EEPROM_DEV_ADDR2	0xA2
+#define I40E_MODULE_TYPE_ADDR		0x00
+#define I40E_MODULE_REVISION_ADDR	0x01
+#define I40E_MODULE_SFF_8472_COMP	0x5E
+#define I40E_MODULE_SFF_8472_SWAP	0x5C
+#define I40E_MODULE_SFF_ADDR_MODE	0x04
+#define I40E_MODULE_TYPE_SFP		0x03
+#define I40E_MODULE_TYPE_QSFP_PLUS	0x0D
+#define I40E_MODULE_TYPE_QSFP28		0x11
+
+/**
+ * i40e_get_module_info - get (Q)SFP+ module type info
+ * @netdev: network interface device structure
+ * @modinfo: module EEPROM size and layout information structure
+ **/
+static int i40e_get_module_info(struct net_device *netdev,
+				struct ethtool_modinfo *modinfo)
+{
+	i40e_status status;
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	u32 sff8472_comp = 0;
+	u32 sff8472_swap = 0;
+	u32 sff8636_rev = 0;
+	u32 type = 0;
+
+	/* Check if firmware supports reading module EEPROM. */
+	if (!(hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
+	      hw->aq.api_min_ver >= 7)) {
+		netdev_err(vsi->netdev, "Module EEPROM memory read not supported. Please update the NVM image.\n");
+		return -EINVAL;
+	}
+
+	status = i40e_aq_get_phy_register(hw,
+			I40E_AQ_PHY_REG_ACCESS_EXTERNAL_MODULE,
+			I40E_I2C_EEPROM_DEV_ADDR, I40E_MODULE_TYPE_ADDR,
+			&type, NULL);
+	if (status)
+		return -EIO;
+
+	switch (type) {
+	case I40E_MODULE_TYPE_SFP:
+		status = i40e_aq_get_phy_register(hw,
+				I40E_AQ_PHY_REG_ACCESS_EXTERNAL_MODULE,
+				I40E_I2C_EEPROM_DEV_ADDR,
+				I40E_MODULE_SFF_8472_COMP,
+				&sff8472_comp, NULL);
+		if (status)
+			return -EIO;
+
+		status = i40e_aq_get_phy_register(hw,
+				I40E_AQ_PHY_REG_ACCESS_EXTERNAL_MODULE,
+				I40E_I2C_EEPROM_DEV_ADDR,
+				I40E_MODULE_SFF_8472_SWAP,
+				&sff8472_swap, NULL);
+		if (status)
+			return -EIO;
+
+		/* Check if the module requires address swap to access
+		 * the other EEPROM memory page.
+		 */
+		if (sff8472_swap & I40E_MODULE_SFF_ADDR_MODE) {
+			netdev_warn(vsi->netdev, "Module address swap to access page 0xA2 is not supported.\n");
+			modinfo->type = ETH_MODULE_SFF_8079;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
+		} else if (sff8472_comp == 0x00) {
+			/* Module is not SFF-8472 compliant */
+			modinfo->type = ETH_MODULE_SFF_8079;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
+		} else {
+			modinfo->type = ETH_MODULE_SFF_8472;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+		}
+		break;
+	case I40E_MODULE_TYPE_QSFP_PLUS:
+		status = i40e_aq_get_phy_register(hw,
+				I40E_AQ_PHY_REG_ACCESS_EXTERNAL_MODULE,
+				I40E_I2C_EEPROM_DEV_ADDR,
+				I40E_MODULE_REVISION_ADDR,
+				&sff8636_rev, NULL);
+		if (status)
+			return -EIO;
+		/* Determine revision compliance byte */
+		if (sff8636_rev > 0x02) {
+			/* Module is SFF-8636 compliant */
+			modinfo->type = ETH_MODULE_SFF_8636;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+		} else {
+			modinfo->type = ETH_MODULE_SFF_8436;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		}
+		break;
+	case I40E_MODULE_TYPE_QSFP28:
+		modinfo->type = ETH_MODULE_SFF_8636;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+		break;
+	default:
+		netdev_err(vsi->netdev, "Module type unrecognized\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * i40e_get_module_eeprom - fills buffer with (Q)SFP+ module memory contents
+ * @netdev: network interface device structure
+ * @ee: EEPROM dump request structure
+ * @data: buffer to be filled with EEPROM contents
+ **/
+static int i40e_get_module_eeprom(struct net_device *netdev,
+				  struct ethtool_eeprom *ee,
+				  u8 *data)
+{
+	i40e_status status;
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	u32 value = 0;
+	int i;
+
+	if (!ee || !ee->len || !data)
+		return -EINVAL;
+
+	for (i = 0; i < ee->len; i++) {
+		u32 offset = i + ee->offset;
+		u32 addr = I40E_I2C_EEPROM_DEV_ADDR;
+
+		/* Check if we need to access the other memory page */
+		if (offset >= ETH_MODULE_SFF_8079_LEN) {
+			offset -= ETH_MODULE_SFF_8079_LEN;
+			addr = I40E_I2C_EEPROM_DEV_ADDR2;
+		}
+
+		status = i40e_aq_get_phy_register(hw,
+				I40E_AQ_PHY_REG_ACCESS_EXTERNAL_MODULE,
+				addr, offset, &value, NULL);
+		if (status)
+			return -EIO;
+		data[i] = value;
+	}
+	return 0;
+}
+
 static const struct ethtool_ops i40e_ethtool_ops = {
 	.get_drvinfo		= i40e_get_drvinfo,
 	.get_regs_len		= i40e_get_regs_len,
@@ -4228,6 +4375,8 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.set_rxfh		= i40e_set_rxfh,
 	.get_channels		= i40e_get_channels,
 	.set_channels		= i40e_set_channels,
+	.get_module_info	= i40e_get_module_info,
+	.get_module_eeprom	= i40e_get_module_eeprom,
 	.get_ts_info		= i40e_get_ts_info,
 	.get_priv_flags		= i40e_get_priv_flags,
 	.set_priv_flags		= i40e_set_priv_flags,
-- 
2.9.3

