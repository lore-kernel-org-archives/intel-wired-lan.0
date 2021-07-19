From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Mon, 19 Jul 2021 13:27:59 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix crash in switchdev mode
 during VFR
Message-ID: <1626694079-4328-1-git-send-email-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During VF reset VF VSI is released, because of that there was
a risk of calling ice_repr_get_stats64 or ice_get_drvinfo when
VF VSI was NULL. The solution is to use ice_check_vf_ready_for_cfg
function.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 27 ++++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_repr.c        |  6 +++++-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  6 ++++++
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 2858805cdeea..1abe756f9f46 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -170,10 +170,9 @@ struct ice_priv_flag {
 #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
 
 static void
-ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
+__ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo,
+		  struct ice_vsi *vsi)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = ice_get_netdev_priv_vsi(np);
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
 	struct ice_orom_info *orom;
@@ -196,6 +195,26 @@ struct ice_priv_flag {
 	drvinfo->n_priv_flags = ICE_PRIV_FLAG_ARRAY_SIZE;
 }
 
+static void
+ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+
+	__ice_get_drvinfo(netdev, drvinfo, np->vsi);
+}
+
+static void
+ice_repr_get_drvinfo(struct net_device *netdev,
+		     struct ethtool_drvinfo *drvinfo)
+{
+	struct ice_repr *repr = ice_netdev_to_repr(netdev);
+
+	if (ice_check_vf_ready_for_cfg(repr->vf))
+		return;
+
+	__ice_get_drvinfo(netdev, drvinfo, repr->src_vsi);
+}
+
 static int ice_get_regs_len(struct net_device __always_unused *netdev)
 {
 	return sizeof(ice_regs_dump_list);
@@ -4061,7 +4080,7 @@ void ice_set_ethtool_safe_mode_ops(struct net_device *netdev)
 }
 
 static const struct ethtool_ops ice_ethtool_repr_ops = {
-	.get_drvinfo		= ice_get_drvinfo,
+	.get_drvinfo		= ice_repr_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_strings		= ice_get_strings,
 	.get_ethtool_stats      = ice_get_ethtool_stats,
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index ababed89f25a..b02e5462b851 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -48,8 +48,12 @@ static int ice_repr_get_sw_port_id(struct ice_repr *repr)
 ice_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->repr->src_vsi;
 	struct ice_eth_stats *eth_stats;
+	struct ice_vsi *vsi;
+
+	if (ice_check_vf_ready_for_cfg(np->repr->vf))
+		return;
+	vsi = np->repr->src_vsi;
 
 	ice_update_vsi_stats(vsi);
 	eth_stats = &vsi->eth_stats;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 501331b6f70b..0600ccf096f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2815,7 +2815,7 @@ static void ice_wait_on_vf_reset(struct ice_vf *vf)
  * disabled, and initialized so it can be configured and/or queried by a host
  * administrator.
  */
-static int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
+int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
 {
 	struct ice_pf *pf;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 6bad277d16fc..8aed26a86dd1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -176,6 +176,8 @@ struct ice_vf {
 
 int ice_set_vf_link_state(struct net_device *netdev, int vf_id, int link_state);
 
+int ice_check_vf_ready_for_cfg(struct ice_vf *vf);
+
 int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena);
 
 int ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector);
@@ -203,6 +205,10 @@ static inline void ice_vc_notify_link_state(struct ice_pf *pf) { }
 static inline void ice_vc_notify_reset(struct ice_pf *pf) { }
 static inline void ice_vc_notify_vf_link_state(struct ice_vf *vf) { }
 static inline void ice_vc_change_ops_to_repr(struct ice_vc_vf_ops *ops) { }
+static inline int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
+{
+	return -EOPNOTSUPP;
+}
 static inline void ice_vc_set_dflt_vf_ops(struct ice_vc_vf_ops *ops) { }
 static inline void ice_set_vf_state_qs_dis(struct ice_vf *vf) { }
 static inline
-- 
1.8.3.1

