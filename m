From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 18 Aug 2021 18:21:24 -0400
Subject: [Intel-wired-lan] [PATCH net-next] ice: remove msleep from reading
 PR stats
Message-ID: <20210818222124.15467-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Calling msleep in context of reading PR statistics in case
of having maximum number on VFs on machine leads to strange
call trace in rcu_note_context_switch.

msleep function is called in ice_check_vf_ready_for_cfg.

As waiting for reset isn't needed in case of getting stats,
change this function to ice_is_vf_disabled to check if VF is
running or not.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
This commit should be squashed with "ice: Fix crash in switchdev mode
during VFR"

 drivers/net/ethernet/intel/ice/ice_repr.c        | 2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 8fd90ac661b1..c49eeea7cb67 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -52,7 +52,7 @@ ice_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 	struct ice_eth_stats *eth_stats;
 	struct ice_vsi *vsi;
 
-	if (ice_check_vf_ready_for_cfg(np->repr->vf))
+	if (ice_is_vf_disabled(np->repr->vf))
 		return;
 	vsi = np->repr->src_vsi;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 0ed7f1ec6172..0bb8b64d1c1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1533,7 +1533,7 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr)
  *
  * Returns true if the PF or VF is disabled, false otherwise.
  */
-static bool ice_is_vf_disabled(struct ice_vf *vf)
+bool ice_is_vf_disabled(struct ice_vf *vf)
 {
 	struct ice_pf *pf = vf->pf;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 9c2cad78231f..9de19cc97f48 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -183,6 +183,8 @@ int ice_set_vf_link_state(struct net_device *netdev, int vf_id, int link_state);
 
 int ice_check_vf_ready_for_cfg(struct ice_vf *vf);
 
+bool ice_is_vf_disabled(struct ice_vf *vf);
+
 int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena);
 
 int ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector);
@@ -216,6 +218,11 @@ static inline int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool ice_is_vf_disabled(struct ice_vf *vf)
+{
+	return true;
+}
 static inline void ice_vc_set_dflt_vf_ops(struct ice_vc_vf_ops *ops) { }
 static inline void ice_set_vf_state_qs_dis(struct ice_vf *vf) { }
 static inline
-- 
2.31.1

