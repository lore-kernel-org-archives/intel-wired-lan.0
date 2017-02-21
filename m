From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:43 -0800
Subject: [Intel-wired-lan] [next PATCH S61 05/10] i40e: Add support for 25G
	in ethtool
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

Implemented functions for the updated get and set commands
in ethtool: ETHTOOL_GLINKSETTING and ETHTOOL_SLINKSETTINGS.
These new commands will replace the existing functionality
of ETHTOOL_GSET and ETHTOOL_SSET, which have been deprecated.

Macros for 25G support were added to the include files at the
same time as the new ethtool commands. So, 25G support has
been implemented in the new functions.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Change-ID: I3824ed616cf92bc8bdce3e976277a0cf94d0cd35
---
Testing Hints: The kernel macros required by this patch are
available in Linux kernels after 4.7. Also, the 25G macros have
been back ported into RHEL7.3. This functionality was added in
ethtool version 4.5.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 583 +++++++++++++++++++++++++
 1 file changed, 583 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 382fd2c..9c14d69 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -846,6 +846,587 @@ static int i40e_set_settings(struct net_device *netdev,
 	return err;
 }
 
+#define ETHTOOL_LINK_MODE_MASK_U32  \
+	DIV_ROUND_UP(__ETHTOOL_LINK_MODE_MASK_NBITS, 32)
+
+/**
+ * ethtool_link_ksettings_clear_link_mode - unset a bit in link_ksettings
+ * link mode mask
+ *   @ptr : pointer to ethtool_link_ksettings
+ *   @name : one of supported, advertising or lp_advertising
+ *   @mode : one of ETHTOOL_LINK_MODE_*_BIT
+ * (not atomic and no bounds checking)
+ **/
+#define ethtool_link_ksettings_clear_link_mode(ptr, name, mode)           \
+	__clear_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
+
+/**
+ * i40e_get_link_settings_link_down - Get the Link settings when link is down
+ * @hw: hw structure
+ * @ksettings: ethtool command to fill in
+ * @pf: pointer to physical function struct
+ *
+ * Reports link settings that can be determined when link is down
+ **/
+static void i40e_get_link_settings_link_down(struct i40e_hw *hw,
+				       struct ethtool_link_ksettings *ksettings,
+				       struct i40e_pf *pf)
+{
+	struct i40e_link_status *hw_link_info = &pf->hw.phy.link_info;
+	u64 phy_types = pf->hw.phy.phy_types;
+
+	i40e_phy_type_to_ethtool(pf, (u32 *)&ksettings->link_modes.supported[0],
+				 (u32 *)&ksettings->link_modes.advertising[0]);
+	/* need to add 25G PHY types */
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_KR) {
+		ethtool_link_ksettings_add_link_mode(ksettings, supported,
+						     25000baseKR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
+			ethtool_link_ksettings_add_link_mode(ksettings,
+							     advertising,
+							     25000baseKR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_CR) {
+		ethtool_link_ksettings_add_link_mode(ksettings, supported,
+						     25000baseCR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
+			ethtool_link_ksettings_add_link_mode(ksettings,
+							     advertising,
+							     25000baseCR_Full);
+	}
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_SR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_LR) {
+		ethtool_link_ksettings_add_link_mode(ksettings, supported,
+						     25000baseSR_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
+			ethtool_link_ksettings_add_link_mode(ksettings,
+							     advertising,
+							     25000baseSR_Full);
+	}
+	ksettings->base.speed = SPEED_UNKNOWN;
+	ksettings->base.duplex = DUPLEX_UNKNOWN;
+}
+
+/**
+ * i40e_get_link_settings_link_up - Get Link info and duplex settings
+ * @hw: hw structure
+ * @ksettings: ethtool structure to fill in
+ * @netdev: network interface device structure
+ * @pf: pointer to physical function struct
+ **/
+static void i40e_get_link_settings_link_up(struct i40e_hw *hw,
+					   struct ethtool_link_ksettings *ks,
+					   struct net_device *netdev,
+					   struct i40e_pf *pf)
+{
+	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
+	u32 link_speed = hw_link_info->link_speed;
+	struct ethtool_link_ksettings cap_ksettings;
+	int idx;
+
+	/* Initialize supported and advertised settings based on phy settings */
+	switch (hw_link_info->phy_type) {
+	case I40E_PHY_TYPE_40GBASE_CR4:
+	case I40E_PHY_TYPE_40GBASE_CR4_CU:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseCR4_Full);
+		break;
+	case I40E_PHY_TYPE_XLAUI:
+	case I40E_PHY_TYPE_XLPPI:
+	case I40E_PHY_TYPE_40GBASE_AOC:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseCR4_Full);
+		break;
+	case I40E_PHY_TYPE_40GBASE_SR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseSR4_Full);
+		break;
+	case I40E_PHY_TYPE_40GBASE_LR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseLR4_Full);
+		break;
+	case I40E_PHY_TYPE_10GBASE_SR:
+	case I40E_PHY_TYPE_10GBASE_LR:
+	case I40E_PHY_TYPE_1000BASE_SX:
+	case I40E_PHY_TYPE_1000BASE_LX:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseT_Full);
+		if (hw_link_info->module_type[2] &
+		    I40E_MODULE_TYPE_1000BASE_SX ||
+		    hw_link_info->module_type[2] &
+		    I40E_MODULE_TYPE_1000BASE_LX) {
+			ethtool_link_ksettings_add_link_mode(ks, supported,
+							     1000baseT_Full);
+			if (hw_link_info->requested_speeds &
+			    I40E_LINK_SPEED_1GB)
+				ethtool_link_ksettings_add_link_mode(ks,
+								advertising,
+								1000baseT_Full);
+		}
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseT_Full);
+		break;
+	case I40E_PHY_TYPE_10GBASE_T:
+	case I40E_PHY_TYPE_1000BASE_T:
+	case I40E_PHY_TYPE_100BASE_TX:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     100baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     10000baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     1000baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     100baseT_Full);
+		break;
+	case I40E_PHY_TYPE_1000BASE_T_OPTICAL:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     1000baseT_Full);
+		break;
+	case I40E_PHY_TYPE_10GBASE_CR1_CU:
+	case I40E_PHY_TYPE_10GBASE_CR1:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     10000baseT_Full);
+		break;
+	case I40E_PHY_TYPE_XAUI:
+	case I40E_PHY_TYPE_XFI:
+	case I40E_PHY_TYPE_SFI:
+	case I40E_PHY_TYPE_10GBASE_SFPP_CU:
+	case I40E_PHY_TYPE_10GBASE_AOC:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseT_Full);
+		break;
+	case I40E_PHY_TYPE_SGMII:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseT_Full);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     1000baseT_Full);
+		if (pf->flags & I40E_FLAG_100M_SGMII_CAPABLE) {
+			ethtool_link_ksettings_add_link_mode(ks, supported,
+							     100baseT_Full);
+			if (hw_link_info->requested_speeds &
+			    I40E_LINK_SPEED_100MB)
+				ethtool_link_ksettings_add_link_mode(ks,
+								 advertising,
+								 100baseT_Full);
+		}
+		break;
+	case I40E_PHY_TYPE_40GBASE_KR4:
+	case I40E_PHY_TYPE_20GBASE_KR2:
+	case I40E_PHY_TYPE_10GBASE_KR:
+	case I40E_PHY_TYPE_10GBASE_KX4:
+	case I40E_PHY_TYPE_1000BASE_KX:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     40000baseKR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     20000baseKR2_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     10000baseKX4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     1000baseKX_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseKR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     20000baseKR2_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     10000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     10000baseKX4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     1000baseKX_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		break;
+	case I40E_PHY_TYPE_25GBASE_KR:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     25000baseKR_Full);
+		break;
+	case I40E_PHY_TYPE_25GBASE_CR:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseCR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     25000baseCR_Full);
+		break;
+	case I40E_PHY_TYPE_25GBASE_SR:
+	case I40E_PHY_TYPE_25GBASE_LR:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     25000baseSR_Full);
+		break;
+	default:
+		/* if we got here and link is up something bad is afoot */
+		netdev_info(netdev,
+			    "WARNING: Link is up but PHY type 0x%x is not recognized.\n",
+			    hw_link_info->phy_type);
+	}
+
+	/* Now that we've worked out everything that could be supported by the
+	 * current phy type, get what is supported by the NVM and and them to
+	 * get what is truly supported
+	 */
+	memset(&cap_ksettings, 0, sizeof(struct ethtool_link_ksettings));
+	cap_ksettings.base.cmd = ks->base.cmd;
+	cap_ksettings.base.link_mode_masks_nwords =
+					   ks->base.link_mode_masks_nwords;
+	i40e_get_link_settings_link_down(hw, &cap_ksettings, pf);
+
+	for (idx = 0; idx < ETHTOOL_LINK_MODE_MASK_U32; idx++) {
+		ks->base.link_mode_masks[idx] &=
+					cap_ksettings.base.link_mode_masks[idx];
+		ks->base.link_mode_masks[idx + ETHTOOL_LINK_MODE_MASK_U32] &=
+					cap_ksettings.base.link_mode_masks[idx +
+					ETHTOOL_LINK_MODE_MASK_U32];
+	}
+
+	/* Set speed and duplex */
+	switch (link_speed) {
+	case I40E_LINK_SPEED_40GB:
+		ks->base.speed = SPEED_40000;
+		break;
+	case I40E_LINK_SPEED_25GB:
+		ks->base.speed = SPEED_25000;
+		break;
+	case I40E_LINK_SPEED_20GB:
+		ks->base.speed = SPEED_20000;
+		break;
+	case I40E_LINK_SPEED_10GB:
+		ks->base.speed = SPEED_10000;
+		break;
+	case I40E_LINK_SPEED_1GB:
+		ks->base.speed = SPEED_1000;
+		break;
+	case I40E_LINK_SPEED_100MB:
+		ks->base.speed = SPEED_100;
+		break;
+	default:
+		break;
+	}
+	ks->base.duplex = DUPLEX_FULL;
+}
+
+/**
+ * i40e_get_link_settings - Get Link Speed and Duplex settings
+ * @netdev: network interface device structure
+ * @ksettings: ethtool command
+ *
+ * Reports speed/duplex settings based on media_type
+ **/
+static int i40e_get_link_settings(struct net_device *netdev,
+				  struct ethtool_link_ksettings *ks)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
+	bool link_up = hw_link_info->link_info & I40E_AQ_LINK_UP;
+	struct ethtool_link_settings *settings = &ks->base;
+
+	ethtool_link_ksettings_zero_link_mode(ks, supported);
+	ethtool_link_ksettings_zero_link_mode(ks, advertising);
+
+	if (link_up)
+		i40e_get_link_settings_link_up(hw, ks, netdev, pf);
+	else
+		i40e_get_link_settings_link_down(hw, ks, pf);
+
+	/* Now set the settings that don't rely on link being up/down */
+	/* Set autoneg settings */
+	settings->autoneg = (hw_link_info->an_info & I40E_AQ_AN_COMPLETED ?
+			  AUTONEG_ENABLE : AUTONEG_DISABLE);
+
+	/* Set media type settings */
+	switch (hw->phy.media_type) {
+	case I40E_MEDIA_TYPE_BACKPLANE:
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported, Backplane);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     Backplane);
+		settings->port = PORT_NONE;
+		break;
+	case I40E_MEDIA_TYPE_BASET:
+		ethtool_link_ksettings_add_link_mode(ks, supported, TP);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, TP);
+		settings->port = PORT_TP;
+		break;
+	case I40E_MEDIA_TYPE_DA:
+	case I40E_MEDIA_TYPE_CX4:
+		ethtool_link_ksettings_add_link_mode(ks, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FIBRE);
+		settings->port = PORT_DA;
+		break;
+	case I40E_MEDIA_TYPE_FIBER:
+		ethtool_link_ksettings_add_link_mode(ks, supported, FIBRE);
+		settings->port = PORT_FIBRE;
+		break;
+	case I40E_MEDIA_TYPE_UNKNOWN:
+	default:
+		settings->port = PORT_OTHER;
+		break;
+	}
+
+	/* Set flow control settings */
+	ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
+
+	switch (hw->fc.requested_mode) {
+	case I40E_FC_FULL:
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
+		break;
+	case I40E_FC_TX_PAUSE:
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     Asym_Pause);
+		break;
+	case I40E_FC_RX_PAUSE:
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     Asym_Pause);
+		break;
+	default:
+		ethtool_link_ksettings_clear_link_mode(ks, advertising, Pause);
+		ethtool_link_ksettings_clear_link_mode(ks, advertising,
+						       Asym_Pause);
+		break;
+	}
+	return 0;
+}
+
+/**
+ * i40e_set_link_settings - Set Speed and Duplex
+ * @netdev: network interface device structure
+ * @ksettings_passed: ethtool command
+ *
+ * Set speed/duplex per media_types advertised/forced
+ **/
+static int i40e_set_link_settings(struct net_device *netdev,
+			  const struct ethtool_link_ksettings *ksettings_passed)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_aq_get_phy_abilities_resp abilities;
+	struct i40e_aq_set_phy_config config;
+	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_hw *hw = &pf->hw;
+	struct ethtool_link_ksettings safe_ksettings;
+	i40e_status status = 0;
+	bool autoneg_changed = false;
+	int err = 0;
+	u8 autoneg;
+	struct ethtool_link_ksettings ksettings_real, *ksettings;
+	u32 advertise[ETHTOOL_LINK_MODE_MASK_U32];
+
+	ksettings = &ksettings_real;
+	*ksettings = *ksettings_passed;
+
+	/* Changing port settings is not supported if this isn't the
+	 * port's controlling PF
+	 */
+	if (hw->partition_id != 1) {
+		i40e_partition_setting_complaint(pf);
+		return -EOPNOTSUPP;
+	}
+	if (vsi != pf->vsi[pf->lan_vsi])
+		return -EOPNOTSUPP;
+	if (hw->phy.media_type != I40E_MEDIA_TYPE_BASET &&
+	    hw->phy.media_type != I40E_MEDIA_TYPE_FIBER &&
+	    hw->phy.media_type != I40E_MEDIA_TYPE_BACKPLANE &&
+	    hw->phy.media_type != I40E_MEDIA_TYPE_DA &&
+	    hw->phy.link_info.link_info & I40E_AQ_LINK_UP)
+		return -EOPNOTSUPP;
+	if (hw->device_id == I40E_DEV_ID_KX_B ||
+	    hw->device_id == I40E_DEV_ID_KX_C ||
+	    hw->device_id == I40E_DEV_ID_20G_KR2 ||
+	    hw->device_id == I40E_DEV_ID_20G_KR2_A) {
+		netdev_info(netdev,
+			    "Changing settings is not supported on backplane.\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* get our own copy of the bits to check against */
+	memset(&safe_ksettings, 0, sizeof(struct ethtool_link_ksettings));
+	safe_ksettings.base.cmd                    = ksettings->base.cmd;
+	safe_ksettings.base.link_mode_masks_nwords =
+		ksettings->base.link_mode_masks_nwords;
+	i40e_get_link_settings(netdev, &safe_ksettings);
+
+	/* save autoneg and speed out of ksettings */
+	autoneg = ksettings->base.autoneg;
+	memcpy((void *)advertise,
+	       &ksettings->base.link_mode_masks[ETHTOOL_LINK_MODE_MASK_U32],
+	       sizeof(advertise));
+
+	/* set autoneg and speed back to what they currently are */
+	ksettings->base.autoneg = safe_ksettings.base.autoneg;
+	memcpy((void *)ksettings->link_modes.advertising,
+	       safe_ksettings.link_modes.advertising,
+	       sizeof(advertise));
+
+	/* If ksettings and safe_ksettings are not the same now, then they are
+	 * trying to set something that we do not support
+	 */
+	if (memcmp(ksettings, &safe_ksettings,
+		   sizeof(struct ethtool_link_settings)))
+		return -EOPNOTSUPP;
+	while (test_bit(__I40E_CONFIG_BUSY, &vsi->state))
+		usleep_range(1000, 2000);
+
+	/* Get the current phy config */
+	status = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
+					      NULL);
+	if (status)
+		return -EAGAIN;
+
+	/* Copy abilities to config in case autoneg is not
+	 * set below
+	 */
+	memset(&config, 0, sizeof(struct i40e_aq_set_phy_config));
+	config.abilities = abilities.abilities;
+
+	/* Check autoneg */
+	if (autoneg == AUTONEG_ENABLE) {
+		/* If autoneg was not already enabled */
+		if (!(hw->phy.link_info.an_info & I40E_AQ_AN_COMPLETED)) {
+			/* If autoneg is not supported, return error */
+			if (!(safe_ksettings.link_modes.supported[0] &
+			      SUPPORTED_Autoneg)) {
+				netdev_info(netdev,
+					    "Autoneg not supported on this phy\n");
+				return -EINVAL;
+			}
+			/* Autoneg is allowed to change */
+			config.abilities = abilities.abilities |
+					   I40E_AQ_PHY_ENABLE_AN;
+			autoneg_changed = true;
+		}
+	} else {
+		/* If autoneg is currently enabled */
+		if (hw->phy.link_info.an_info & I40E_AQ_AN_COMPLETED) {
+			/* If autoneg is supported 10GBASE_T is the only phy
+			 * that can disable it, so otherwise return error
+			 */
+			if (safe_ksettings.link_modes.supported[0] &
+			    SUPPORTED_Autoneg &&
+			    hw->phy.link_info.phy_type !=
+			    I40E_PHY_TYPE_10GBASE_T) {
+				netdev_info(netdev,
+					    "Autoneg cannot be disabled on this phy\n");
+				return -EINVAL;
+			}
+			/* Autoneg is allowed to change */
+			config.abilities = abilities.abilities &
+					   ~I40E_AQ_PHY_ENABLE_AN;
+			autoneg_changed = true;
+		}
+	}
+	if (advertise[0] & ADVERTISED_100baseT_Full)
+		config.link_speed |= I40E_LINK_SPEED_100MB;
+	if (advertise[0] & ADVERTISED_1000baseT_Full ||
+	    advertise[0] & ADVERTISED_1000baseKX_Full)
+		config.link_speed |= I40E_LINK_SPEED_1GB;
+	if (advertise[0] & ADVERTISED_10000baseT_Full ||
+	    advertise[0] & ADVERTISED_10000baseKX4_Full ||
+	    advertise[0] & ADVERTISED_10000baseKR_Full)
+		config.link_speed |= I40E_LINK_SPEED_10GB;
+	if (advertise[0] & ADVERTISED_20000baseKR2_Full)
+		config.link_speed |= I40E_LINK_SPEED_20GB;
+	if (ethtool_link_ksettings_test_link_mode(ksettings, advertising,
+						  25000baseCR_Full) ||
+	    ethtool_link_ksettings_test_link_mode(ksettings, advertising,
+						  25000baseKR_Full) ||
+	    ethtool_link_ksettings_test_link_mode(ksettings, advertising,
+						  25000baseSR_Full))
+		config.link_speed |= I40E_LINK_SPEED_25GB;
+	if (advertise[0] & ADVERTISED_40000baseKR4_Full ||
+	    advertise[0] & ADVERTISED_40000baseCR4_Full ||
+	    advertise[0] & ADVERTISED_40000baseSR4_Full ||
+	    advertise[0] & ADVERTISED_40000baseLR4_Full)
+		config.link_speed |= I40E_LINK_SPEED_40GB;
+
+	/* If speed didn't get set, set it to what it currently is.
+	 * This is needed because if advertise is 0 (as it is when autoneg
+	 * is disabled) then speed won't get set.
+	 */
+	if (!config.link_speed)
+		config.link_speed = abilities.link_speed;
+	if (autoneg_changed || (abilities.link_speed != config.link_speed)) {
+		/* copy over the rest of the abilities */
+		config.phy_type = abilities.phy_type;
+		config.phy_type_ext = abilities.phy_type_ext;
+		config.eee_capability = abilities.eee_capability;
+		config.eeer = abilities.eeer_val;
+		config.low_power_ctrl = abilities.d3_lpan;
+		config.fec_config = abilities.fec_cfg_curr_mod_ext_info &
+				    I40E_AQ_PHY_FEC_CONFIG_MASK;
+
+		/* save the requested speeds */
+		hw->phy.link_info.requested_speeds = config.link_speed;
+		/* set link and auto negotiation so changes take effect */
+		config.abilities |= I40E_AQ_PHY_ENABLE_ATOMIC_LINK;
+		/* If link is up put link down */
+		if (hw->phy.link_info.link_info & I40E_AQ_LINK_UP) {
+			/* Tell the OS link is going down, the link will go
+			 * back up when fw says it is ready asynchronously
+			 */
+			i40e_print_link_message(vsi, false);
+			netif_carrier_off(netdev);
+			netif_tx_stop_all_queues(netdev);
+		}
+
+		/* make the aq call */
+		status = i40e_aq_set_phy_config(hw, &config, NULL);
+		if (status) {
+			netdev_info(netdev,
+				    "Set phy config failed, err %s aq_err %s\n",
+				    i40e_stat_str(hw, status),
+				    i40e_aq_str(hw, hw->aq.asq_last_status));
+			return -EAGAIN;
+		}
+		status = i40e_update_link_info(hw);
+		if (status)
+			netdev_dbg(netdev,
+				   "Updating link info failed with err %s aq_err %s\n",
+				   i40e_stat_str(hw, status),
+				   i40e_aq_str(hw, hw->aq.asq_last_status));
+	} else {
+		netdev_info(netdev,
+			    "Nothing changed, exiting without setting anything.\n");
+	}
+	return err;
+}
+
 static int i40e_nway_reset(struct net_device *netdev)
 {
 	/* restart autonegotiation */
@@ -3198,6 +3779,8 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.set_priv_flags		= i40e_set_priv_flags,
 	.get_per_queue_coalesce	= i40e_get_per_queue_coalesce,
 	.set_per_queue_coalesce	= i40e_set_per_queue_coalesce,
+	.get_link_ksettings = i40e_get_link_settings,
+	.set_link_ksettings = i40e_set_link_settings,
 };
 
 void i40e_set_ethtool_ops(struct net_device *netdev)
-- 
2.4.11

