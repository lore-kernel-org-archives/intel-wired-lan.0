From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  9 Jul 2020 09:16:08 -0700
Subject: [Intel-wired-lan] [PATCH S49 09/15] ice: support Total Port
 Shutdown on devices that support it
In-Reply-To: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
Message-ID: <20200709161614.61098-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

When the Port Disable bit is set in the Link Default Override Mask TLV PFA
module in the NVM, Total Port Shutdown mode is supported and enabled.  In
this mode, the driver should act as if the link-down-on-close ethool
private flag is always enabled and dis-allow any change to that flag.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 14 +++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 7d73d7be6dcb..9b4c70310c3a 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -362,6 +362,7 @@ enum ice_pf_flags {
 	ICE_FLAG_FD_ENA,
 	ICE_FLAG_ADV_FEATURES,
 	ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA,
+	ICE_FLAG_TOTAL_PORT_SHUTDOWN_ENA,
 	ICE_FLAG_NO_MEDIA,
 	ICE_FLAG_FW_LLDP_AGENT,
 	ICE_FLAG_ETHTOOL_CTXT,		/* set when ethtool holds RTNL lock */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f382faaf64e3..60abd261b8bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1196,6 +1196,17 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 
 	bitmap_xor(change_flags, pf->flags, orig_flags, ICE_PF_FLAGS_NBITS);
 
+	/* Do not allow change to link-down-on-close when Total Port Shutdown
+	 * is enabled.
+	 */
+	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, change_flags) &&
+	    test_bit(ICE_FLAG_TOTAL_PORT_SHUTDOWN_ENA, pf->flags)) {
+		dev_err(dev, "Setting link-down-on-close not supported on this port\n");
+		set_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags);
+		ret = -EINVAL;
+		goto ethtool_exit;
+	}
+
 	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, change_flags)) {
 		if (!test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags)) {
 			enum ice_status status;
@@ -1283,6 +1294,7 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 		change_bit(ICE_FLAG_VF_TRUE_PROMISC_ENA, pf->flags);
 		ret = -EAGAIN;
 	}
+ethtool_exit:
 	clear_bit(ICE_FLAG_ETHTOOL_CTXT, pf->flags);
 	return ret;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index abc7a38c1dd5..a44273769264 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1446,6 +1446,8 @@ static int ice_init_nvm_phy_type(struct ice_port_info *pi)
 /**
  * ice_init_link_dflt_override - Initialize link default override
  * @pi: port info structure
+ *
+ * Initialize link default override and PHY total port shutdown during probe
  */
 static void ice_init_link_dflt_override(struct ice_port_info *pi)
 {
@@ -1453,7 +1455,17 @@ static void ice_init_link_dflt_override(struct ice_port_info *pi)
 	struct ice_pf *pf = pi->hw->back;
 
 	ldo = &pf->link_dflt_override;
-	ice_get_link_default_override(ldo, pi);
+	if (ice_get_link_default_override(ldo, pi))
+		return;
+
+	if (!(ldo->options & ICE_LINK_OVERRIDE_PORT_DIS))
+		return;
+
+	/* Enable Total Port Shutdown (override/replace link-down-on-close
+	 * ethtool private flag) for ports with Port Disable bit set.
+	 */
+	set_bit(ICE_FLAG_TOTAL_PORT_SHUTDOWN_ENA, pf->flags);
+	set_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags);
 }
 
 /**
-- 
2.20.1

