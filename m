From: Alice Michael <alice.michael@intel.com>
Date: Fri,  3 Nov 2017 07:05:09 -0400
Subject: [Intel-wired-lan] [next PATCH S82 7/9] i40e: link_down_on_close
 private flag support
In-Reply-To: <20171103110511.76793-1-alice.michael@intel.com>
References: <20171103110511.76793-1-alice.michael@intel.com>
Message-ID: <20171103110511.76793-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch introduces new ethtool private flag used for
forcing true link state. Function i40e_force_link_state that implements
this functionality was added, it sets phy_type = 0 in order to
work-around firmware's LESM. False positive error messages were
suppressed.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 71 ++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2e5ccdd..15dfb55 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -230,6 +230,8 @@ static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 	I40E_PRIV_FLAG("flow-director-atr", I40E_FLAG_FD_ATR_ENABLED, 0),
 	I40E_PRIV_FLAG("veb-stats", I40E_FLAG_VEB_STATS_ENABLED, 0),
 	I40E_PRIV_FLAG("hw-atr-eviction", I40E_FLAG_HW_ATR_EVICT_ENABLED, 0),
+	I40E_PRIV_FLAG("link-down-on-close",
+		       I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED, 0),
 	I40E_PRIV_FLAG("legacy-rx", I40E_FLAG_LEGACY_RX, 0),
 	I40E_PRIV_FLAG("disable-source-pruning",
 		       I40E_FLAG_SOURCE_PRUNING_DISABLED, 0),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3465663..8657ef6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6607,6 +6607,72 @@ int i40e_up(struct i40e_vsi *vsi)
 }
 
 /**
+ * i40e_force_link_state - Force the link status
+ * @pf: board private structure
+ * @is_up: whether the link state should be forced up or down
+ **/
+static void i40e_force_link_state(struct i40e_pf *pf, bool is_up)
+{
+	struct i40e_aq_get_phy_abilities_resp abilities;
+	struct i40e_aq_set_phy_config config = {0};
+	struct i40e_hw *hw = &pf->hw;
+	enum i40e_aq_phy_type cnt;
+	u64 mask = 0;
+	i40e_status err;
+
+	/* Get the current phy config */
+	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
+					   NULL);
+	if (err)
+		dev_dbg(&pf->pdev->dev,
+			"failed to get phy cap., ret =  %s last_status =  %s\n",
+			i40e_stat_str(hw, err),
+			i40e_aq_str(hw, hw->aq.asq_last_status));
+
+	/* If link needs to go up, but was not forced to go down,
+	 * no need for a flap
+	 */
+	if (is_up && abilities.phy_type != 0)
+		return;
+
+	/* To force link we need to set bits for all supported PHY types,
+	 * but there are now more than 32, so we need to split the bitmap
+	 * across two fields.
+	 */
+	for (cnt = I40E_PHY_TYPE_SGMII; cnt < I40E_PHY_TYPE_MAX; cnt++)
+		mask |= (1ULL << cnt);
+
+	config.phy_type = is_up ? cpu_to_le32((u32)(mask & 0xffffffff)) : 0;
+	config.phy_type_ext = is_up ? (u8)((mask >> 32) & 0xff) : 0;
+	/* Copy the old settings, except of phy_type */
+	config.abilities = abilities.abilities;
+	config.link_speed = abilities.link_speed;
+	config.eee_capability = abilities.eee_capability;
+	config.eeer = abilities.eeer_val;
+	config.low_power_ctrl = abilities.d3_lpan;
+	err = i40e_aq_set_phy_config(hw, &config, NULL);
+
+	if (err)
+		dev_dbg(&pf->pdev->dev,
+			"set phy config ret =  %s last_status =  %s\n",
+			i40e_stat_str(&pf->hw, err),
+			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+
+	/* Update the link info */
+	err = i40e_update_link_info(hw);
+	if (err) {
+		/* Wait a little bit (on 40G cards it sometimes takes a really
+		 * long time for link to come back from the atomic reset)
+		 * and try once more
+		 */
+		msleep(1000);
+		i40e_update_link_info(hw);
+	}
+
+	i40e_aq_set_link_restart_an(hw, true, NULL);
+}
+
+/**
  * i40e_down - Shutdown the connection processing
  * @vsi: the VSI being stopped
  **/
@@ -6623,6 +6689,9 @@ void i40e_down(struct i40e_vsi *vsi)
 	}
 	i40e_vsi_disable_irq(vsi);
 	i40e_vsi_stop_rings(vsi);
+	if ((vsi->type == I40E_VSI_MAIN) &&
+	    (vsi->back->flags & I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED))
+		i40e_force_link_state(vsi->back, false);
 	i40e_napi_disable_all(vsi);
 
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
@@ -7585,6 +7654,8 @@ int i40e_open(struct net_device *netdev)
 
 	netif_carrier_off(netdev);
 
+	i40e_force_link_state(pf, true);
+
 	err = i40e_vsi_open(vsi);
 	if (err)
 		return err;
-- 
2.9.5

