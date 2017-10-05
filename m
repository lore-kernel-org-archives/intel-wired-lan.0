From: Alan Brady <alan.brady@intel.com>
Date: Thu,  5 Oct 2017 14:53:37 -0700
Subject: [Intel-wired-lan] [PATCH v3 07/14 net-next] i40e: fix whitespace
	issues in i40e_ethtool.c
In-Reply-To: <20171005215344.2886-1-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
Message-ID: <20171005215344.2886-8-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There's a number of minor incidental whitespace issues in this file.
This addresses most of the ones I could find.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 46 +++++++++++---------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a6143b9d86db..6296bb2e8bd3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -511,7 +511,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		break;
 	default:
 		/* if we got here and link is up something bad is afoot */
-		netdev_info(netdev, "WARNING: Link is up but PHY type 0x%x is not recognized.\n",
+		netdev_info(netdev,
+			    "WARNING: Link is up but PHY type 0x%x is not recognized.\n",
 			    hw_link_info->phy_type);
 	}
 
@@ -614,14 +615,12 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	ks->base.autoneg = ((hw_link_info->an_info & I40E_AQ_AN_COMPLETED) ?
 			    AUTONEG_ENABLE : AUTONEG_DISABLE);
 
+	/* Set media type settings */
 	switch (hw->phy.media_type) {
 	case I40E_MEDIA_TYPE_BACKPLANE:
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     Backplane);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+		ethtool_link_ksettings_add_link_mode(ks, supported, Backplane);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     Backplane);
 		ks->base.port = PORT_NONE;
@@ -652,16 +651,14 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 
 	switch (hw->fc.requested_mode) {
 	case I40E_FC_FULL:
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Pause);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
 		break;
 	case I40E_FC_TX_PAUSE:
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     Asym_Pause);
 		break;
 	case I40E_FC_RX_PAUSE:
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Pause);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
 						     Asym_Pause);
 		break;
@@ -708,17 +705,14 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		i40e_partition_setting_complaint(pf);
 		return -EOPNOTSUPP;
 	}
-
 	if (vsi != pf->vsi[pf->lan_vsi])
 		return -EOPNOTSUPP;
-
 	if (hw->phy.media_type != I40E_MEDIA_TYPE_BASET &&
 	    hw->phy.media_type != I40E_MEDIA_TYPE_FIBER &&
 	    hw->phy.media_type != I40E_MEDIA_TYPE_BACKPLANE &&
 	    hw->phy.media_type != I40E_MEDIA_TYPE_DA &&
 	    hw->phy.link_info.link_info & I40E_AQ_LINK_UP)
 		return -EOPNOTSUPP;
-
 	if (hw->device_id == I40E_DEV_ID_KX_B ||
 	    hw->device_id == I40E_DEV_ID_KX_C ||
 	    hw->device_id == I40E_DEV_ID_20G_KR2 ||
@@ -781,7 +775,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		if (!(hw->phy.link_info.an_info & I40E_AQ_AN_COMPLETED)) {
 			/* If autoneg is not supported, return error */
 			if (!ethtool_link_ksettings_test_link_mode(
-				     &safe_ks, supported, Autoneg)) {
+				      &safe_ks, supported, Autoneg)) {
 				netdev_info(netdev, "Autoneg not supported on this phy\n");
 				err = -EINVAL;
 				goto done;
@@ -842,7 +836,6 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	 */
 	if (!config.link_speed)
 		config.link_speed = abilities.link_speed;
-
 	if (change || (abilities.link_speed != config.link_speed)) {
 		/* copy over the rest of the abilities */
 		config.phy_type = abilities.phy_type;
@@ -870,7 +863,8 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		/* make the aq call */
 		status = i40e_aq_set_phy_config(hw, &config, NULL);
 		if (status) {
-			netdev_info(netdev, "Set phy config failed, err %s aq_err %s\n",
+			netdev_info(netdev,
+				    "Set phy config failed, err %s aq_err %s\n",
 				    i40e_stat_str(hw, status),
 				    i40e_aq_str(hw, hw->aq.asq_last_status));
 			err = -EAGAIN;
@@ -879,7 +873,8 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 
 		status = i40e_update_link_info(hw);
 		if (status)
-			netdev_dbg(netdev, "Updating link info failed with err %s aq_err %s\n",
+			netdev_dbg(netdev,
+				   "Updating link info failed with err %s aq_err %s\n",
 				   i40e_stat_str(hw, status),
 				   i40e_aq_str(hw, hw->aq.asq_last_status));
 
@@ -2070,14 +2065,13 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	ec->tx_max_coalesced_frames_irq = vsi->work_limit;
 	ec->rx_max_coalesced_frames_irq = vsi->work_limit;
 
-	/* rx and tx usecs has per queue value. If user doesn't specify the queue,
-	 * return queue 0's value to represent.
+	/* rx and tx usecs has per queue value. If user doesn't specify the
+	 * queue, return queue 0's value to represent.
 	 */
-	if (queue < 0) {
+	if (queue < 0)
 		queue = 0;
-	} else if (queue >= vsi->num_queue_pairs) {
+	else if (queue >= vsi->num_queue_pairs)
 		return -EINVAL;
-	}
 
 	rx_ring = vsi->rx_rings[queue];
 	tx_ring = vsi->tx_rings[queue];
@@ -2091,7 +2085,6 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	ec->rx_coalesce_usecs = rx_ring->rx_itr_setting & ~I40E_ITR_DYNAMIC;
 	ec->tx_coalesce_usecs = tx_ring->tx_itr_setting & ~I40E_ITR_DYNAMIC;
 
-
 	/* we use the _usecs_high to store/set the interrupt rate limit
 	 * that the hardware supports, that almost but not quite
 	 * fits the original intent of the ethtool variable,
@@ -2141,7 +2134,6 @@ static int i40e_get_per_queue_coalesce(struct net_device *netdev, u32 queue,
  *
  * Change the ITR settings for a specific queue.
  **/
-
 static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 				   struct ethtool_coalesce *ec,
 				   int queue)
@@ -2263,8 +2255,8 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 			   vsi->int_rate_limit);
 	}
 
-	/* rx and tx usecs has per queue value. If user doesn't specify the queue,
-	 * apply to all queues.
+	/* rx and tx usecs has per queue value. If user doesn't specify the
+	 * queue, apply to all queues.
 	 */
 	if (queue < 0) {
 		for (i = 0; i < vsi->num_queue_pairs; i++)
-- 
2.14.1

