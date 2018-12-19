From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Dec 2018 06:45:38 -0800
Subject: [Intel-wired-lan] [next PATCH S1 2/6] i40e: Add support FEC
 configuration for Fortville 25G
In-Reply-To: <20181219144542.85924-1-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
Message-ID: <20181219144542.85924-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Damian Dybek <damian.dybek@intel.com>

This patch adds support for setting/getting FEC configuration
using ethtool options:
       set/show-priv-flags rs-fec/base-r-fec
       set/show-fec off/rs/baser/auto for kernels version >= 4.14

Signed-off-by: Damian Dybek <damian.dybek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |   4 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 228 +++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  26 ++
 3 files changed, 256 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 45bbd2d4910b..107edcf2cf19 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -545,6 +545,8 @@ struct i40e_pf {
 #define I40E_FLAG_FD_SB_INACTIVE		BIT(22)
 #define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT(23)
 #define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
+#define I40E_FLAG_RS_FEC			BIT(25)
+#define I40E_FLAG_BASE_R_FEC			BIT(26)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
@@ -1114,6 +1116,8 @@ i40e_status i40e_set_partition_bw_setting(struct i40e_pf *pf);
 i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf);
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
 
+void i40e_set_fec_in_flags(u8 fec_cfg, u32 *flags);
+
 static inline bool i40e_enabled_xdp_vsi(struct i40e_vsi *vsi)
 {
 	return !!vsi->xdp_prog;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 399537bafce8..1592b8244661 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -438,6 +438,8 @@ static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 	I40E_PRIV_FLAG("disable-source-pruning",
 		       I40E_FLAG_SOURCE_PRUNING_DISABLED, 0),
 	I40E_PRIV_FLAG("disable-fw-lldp", I40E_FLAG_DISABLE_FW_LLDP, 0),
+	I40E_PRIV_FLAG("rs-fec", I40E_FLAG_RS_FEC, 0),
+	I40E_PRIV_FLAG("base-r-fec", I40E_FLAG_BASE_R_FEC, 0),
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gstrings_priv_flags)
@@ -606,6 +608,24 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     25000baseCR_Full);
 	}
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_KR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_CR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_SR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_LR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_AOC ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_ACC) {
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
+		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB) {
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     FEC_NONE);
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     FEC_RS);
+			ethtool_link_ksettings_add_link_mode(ks, advertising,
+							     FEC_BASER);
+		}
+	}
 	/* need to add new 10G PHY types */
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1 ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1_CU) {
@@ -721,6 +741,13 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     25000baseSR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_BASER);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     10000baseSR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
@@ -825,6 +852,9 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     40000baseKR4_Full);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     25000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     20000baseKR2_Full);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
@@ -838,6 +868,10 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     40000baseKR4_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_BASER);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     20000baseKR2_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
@@ -855,6 +889,13 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 						     25000baseCR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseCR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_BASER);
 		break;
 	case I40E_PHY_TYPE_25GBASE_AOC:
 	case I40E_PHY_TYPE_25GBASE_ACC:
@@ -862,9 +903,15 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     25000baseCR_Full);
-
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     25000baseCR_Full);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_NONE);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     FEC_BASER);
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     10000baseCR_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
@@ -1261,6 +1308,154 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	return err;
 }
 
+static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_aq_get_phy_abilities_resp abilities;
+	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	i40e_status status = 0;
+	u32 flags = 0;
+	int err = 0;
+
+	flags = READ_ONCE(pf->flags);
+	i40e_set_fec_in_flags(fec_cfg, &flags);
+
+	/* Get the current phy config */
+	memset(&abilities, 0, sizeof(abilities));
+	status = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
+					      NULL);
+	if (status) {
+		err = -EAGAIN;
+		goto done;
+	}
+
+	if (abilities.fec_cfg_curr_mod_ext_info != fec_cfg) {
+		struct i40e_aq_set_phy_config config;
+
+		memset(&config, 0, sizeof(config));
+		config.phy_type = abilities.phy_type;
+		config.abilities = abilities.abilities;
+		config.phy_type_ext = abilities.phy_type_ext;
+		config.link_speed = abilities.link_speed;
+		config.eee_capability = abilities.eee_capability;
+		config.eeer = abilities.eeer_val;
+		config.low_power_ctrl = abilities.d3_lpan;
+		config.fec_config = fec_cfg & I40E_AQ_PHY_FEC_CONFIG_MASK;
+		status = i40e_aq_set_phy_config(hw, &config, NULL);
+		if (status) {
+			netdev_info(netdev,
+				    "Set phy config failed, err %s aq_err %s\n",
+				    i40e_stat_str(hw, status),
+				    i40e_aq_str(hw, hw->aq.asq_last_status));
+			err = -EAGAIN;
+			goto done;
+		}
+		pf->flags = flags;
+		status = i40e_update_link_info(hw);
+		if (status)
+			/* debug level message only due to relation to the link
+			 * itself rather than to the FEC settings
+			 * (e.g. no physical connection etc.)
+			 */
+			netdev_dbg(netdev,
+				   "Updating link info failed with err %s aq_err %s\n",
+				   i40e_stat_str(hw, status),
+				   i40e_aq_str(hw, hw->aq.asq_last_status));
+	}
+
+done:
+	return err;
+}
+
+static int i40e_get_fec_param(struct net_device *netdev,
+			      struct ethtool_fecparam *fecparam)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_aq_get_phy_abilities_resp abilities;
+	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	i40e_status status = 0;
+	int err = 0;
+
+	/* Get the current phy config */
+	memset(&abilities, 0, sizeof(abilities));
+	status = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
+					      NULL);
+	if (status) {
+		err = -EAGAIN;
+		goto done;
+	}
+
+	fecparam->fec = 0;
+	if (abilities.fec_cfg_curr_mod_ext_info & I40E_AQ_SET_FEC_AUTO)
+		fecparam->fec |= ETHTOOL_FEC_AUTO;
+	if ((abilities.fec_cfg_curr_mod_ext_info &
+	     I40E_AQ_SET_FEC_REQUEST_RS) ||
+	    (abilities.fec_cfg_curr_mod_ext_info &
+	     I40E_AQ_SET_FEC_ABILITY_RS))
+		fecparam->fec |= ETHTOOL_FEC_RS;
+	if ((abilities.fec_cfg_curr_mod_ext_info &
+	     I40E_AQ_SET_FEC_REQUEST_KR) ||
+	    (abilities.fec_cfg_curr_mod_ext_info & I40E_AQ_SET_FEC_ABILITY_KR))
+		fecparam->fec |= ETHTOOL_FEC_BASER;
+	if (abilities.fec_cfg_curr_mod_ext_info == 0)
+		fecparam->fec |= ETHTOOL_FEC_OFF;
+
+	if (hw->phy.link_info.fec_info & I40E_AQ_CONFIG_FEC_KR_ENA)
+		fecparam->active_fec = ETHTOOL_FEC_BASER;
+	else if (hw->phy.link_info.fec_info & I40E_AQ_CONFIG_FEC_RS_ENA)
+		fecparam->active_fec = ETHTOOL_FEC_RS;
+	else
+		fecparam->active_fec = ETHTOOL_FEC_OFF;
+done:
+	return err;
+}
+
+static int i40e_set_fec_param(struct net_device *netdev,
+			      struct ethtool_fecparam *fecparam)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	u8 fec_cfg = 0;
+	int err = 0;
+
+	if (hw->device_id != I40E_DEV_ID_25G_SFP28 &&
+	    hw->device_id != I40E_DEV_ID_25G_B) {
+		err = -EPERM;
+		goto done;
+	}
+
+	switch (fecparam->fec) {
+	case ETHTOOL_FEC_AUTO:
+		fec_cfg = I40E_AQ_SET_FEC_AUTO;
+		break;
+	case ETHTOOL_FEC_RS:
+		fec_cfg = (I40E_AQ_SET_FEC_REQUEST_RS |
+			     I40E_AQ_SET_FEC_ABILITY_RS);
+		break;
+	case ETHTOOL_FEC_BASER:
+		fec_cfg = (I40E_AQ_SET_FEC_REQUEST_KR |
+			     I40E_AQ_SET_FEC_ABILITY_KR);
+		break;
+	case ETHTOOL_FEC_OFF:
+	case ETHTOOL_FEC_NONE:
+		fec_cfg = 0;
+		break;
+	default:
+		dev_warn(&pf->pdev->dev, "Unsupported FEC mode: %d",
+			 fecparam->fec);
+		err = -EINVAL;
+		goto done;
+	}
+
+	err = i40e_set_fec_cfg(netdev, fec_cfg);
+
+done:
+	return err;
+}
+
 static int i40e_nway_reset(struct net_device *netdev)
 {
 	/* restart autonegotiation */
@@ -1376,7 +1571,7 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 	else if (!pause->rx_pause && !pause->tx_pause)
 		hw->fc.requested_mode = I40E_FC_NONE;
 	else
-		 return -EINVAL;
+		return -EINVAL;
 
 	/* Tell the OS link is going down, the link will go back up when fw
 	 * says it is ready asynchronously
@@ -4676,6 +4871,15 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		}
 	}
 
+	if (((changed_flags & I40E_FLAG_RS_FEC) ||
+	     (changed_flags & I40E_FLAG_BASE_R_FEC)) &&
+	    pf->hw.device_id != I40E_DEV_ID_25G_SFP28 &&
+	    pf->hw.device_id != I40E_DEV_ID_25G_B) {
+		dev_warn(&pf->pdev->dev,
+			 "Device does not support changing FEC configuration\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Now that we've checked to ensure that the new flags are valid, load
 	 * them into place. Since we only modify flags either (a) during
 	 * initialization or (b) while holding the RTNL lock, we don't need
@@ -4714,6 +4918,24 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		}
 	}
 
+	if ((changed_flags & I40E_FLAG_RS_FEC) ||
+	    (changed_flags & I40E_FLAG_BASE_R_FEC)) {
+		u8 fec_cfg = 0;
+
+		if (pf->flags & I40E_FLAG_RS_FEC &&
+		    pf->flags & I40E_FLAG_BASE_R_FEC) {
+			fec_cfg = I40E_AQ_SET_FEC_AUTO;
+		} else if (pf->flags & I40E_FLAG_RS_FEC) {
+			fec_cfg = (I40E_AQ_SET_FEC_REQUEST_RS |
+				   I40E_AQ_SET_FEC_ABILITY_RS);
+		} else if (pf->flags & I40E_FLAG_BASE_R_FEC) {
+			fec_cfg = (I40E_AQ_SET_FEC_REQUEST_KR |
+				   I40E_AQ_SET_FEC_ABILITY_KR);
+		}
+		if (i40e_set_fec_cfg(dev, fec_cfg))
+			dev_warn(&pf->pdev->dev, "Cannot change FEC config\n");
+	}
+
 	if ((changed_flags & pf->flags &
 	     I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED) &&
 	    (pf->flags & I40E_FLAG_MFP_ENABLED))
@@ -4954,6 +5176,8 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.set_per_queue_coalesce	= i40e_set_per_queue_coalesce,
 	.get_link_ksettings	= i40e_get_link_ksettings,
 	.set_link_ksettings	= i40e_set_link_ksettings,
+	.get_fecparam = i40e_get_fec_param,
+	.set_fecparam = i40e_set_fec_param,
 };
 
 void i40e_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b4ae4ba84aa3..c001e0279af3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14500,6 +14500,29 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	return err;
 }
 
+/**
+ * i40e_set_fec_in_flags - helper function for setting FEC options in flags
+ * @fec_cfg: FEC option to set in flags
+ * @flags: ptr to flags in which we set FEC option
+ **/
+void i40e_set_fec_in_flags(u8 fec_cfg, u32 *flags)
+{
+	if (fec_cfg & I40E_AQ_SET_FEC_AUTO)
+		*flags |= I40E_FLAG_RS_FEC | I40E_FLAG_BASE_R_FEC;
+	if ((fec_cfg & I40E_AQ_SET_FEC_REQUEST_RS) ||
+	    (fec_cfg & I40E_AQ_SET_FEC_ABILITY_RS)) {
+		*flags |= I40E_FLAG_RS_FEC;
+		*flags &= ~I40E_FLAG_BASE_R_FEC;
+	}
+	if ((fec_cfg & I40E_AQ_SET_FEC_REQUEST_KR) ||
+	    (fec_cfg & I40E_AQ_SET_FEC_ABILITY_KR)) {
+		*flags |= I40E_FLAG_BASE_R_FEC;
+		*flags &= ~I40E_FLAG_RS_FEC;
+	}
+	if (fec_cfg == 0)
+		*flags &= ~(I40E_FLAG_RS_FEC | I40E_FLAG_BASE_R_FEC);
+}
+
 /**
  * i40e_probe - Device initialization routine
  * @pdev: PCI device information struct
@@ -14997,6 +15020,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
 
+	/* set the FEC config due to the board capabilities */
+	i40e_set_fec_in_flags(abilities.fec_cfg_curr_mod_ext_info, &pf->flags);
+
 	/* get the supported phy types from the fw */
 	err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
 	if (err)
-- 
2.19.2

