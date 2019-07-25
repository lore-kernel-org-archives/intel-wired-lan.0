From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 02:53:50 -0700
Subject: [Intel-wired-lan] [PATCH S25 01/12] ice: update ethtool stats
 on-demand
Message-ID: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Users expect ethtool statistics to be updated on-demand when invoking
'ethtool -S <iface>' instead of providing a snapshot of statistics taken
once a second (the frequency of the watchdog task where stats are currently
updated).  Update stats every time 'ethtool -S <iface>' is run.

Also, fix an indentation style issue and an unnecessary local variable
initialization in ice_get_ethtool_stats() discovered while investigating
the subject issue.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 2 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 +++++--
 drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 0e233b7c40bc..2165366e9250 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -450,6 +450,8 @@ int ice_vsi_setup_tx_rings(struct ice_vsi *vsi);
 int ice_vsi_setup_rx_rings(struct ice_vsi *vsi);
 void ice_set_ethtool_ops(struct net_device *netdev);
 int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx);
+void ice_update_vsi_stats(struct ice_vsi *vsi);
+void ice_update_pf_stats(struct ice_pf *pf);
 int ice_up(struct ice_vsi *vsi);
 int ice_down(struct ice_vsi *vsi);
 int ice_vsi_cfg(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b60bcbcf9bf2..4b2494e7fa78 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1319,14 +1319,17 @@ ice_get_ethtool_stats(struct net_device *netdev,
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct ice_ring *ring;
-	unsigned int j = 0;
+	unsigned int j;
 	int i = 0;
 	char *p;
 
+	ice_update_pf_stats(pf);
+	ice_update_vsi_stats(vsi);
+
 	for (j = 0; j < ICE_VSI_STATS_LEN; j++) {
 		p = (char *)vsi + ice_gstrings_vsi_stats[j].stat_offset;
 		data[i++] = (ice_gstrings_vsi_stats[j].sizeof_stat ==
-			    sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+			     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
 	/* populate per queue stats */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 833f0efc93f9..17358a10866d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -34,8 +34,6 @@ static const struct net_device_ops ice_netdev_ops;
 static void ice_rebuild(struct ice_pf *pf);
 
 static void ice_vsi_release_all(struct ice_pf *pf);
-static void ice_update_vsi_stats(struct ice_vsi *vsi);
-static void ice_update_pf_stats(struct ice_pf *pf);
 
 /**
  * ice_get_tx_pending - returns number of Tx descriptors not processed
@@ -3290,7 +3288,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
  * ice_update_vsi_stats - Update VSI stats counters
  * @vsi: the VSI to be updated
  */
-static void ice_update_vsi_stats(struct ice_vsi *vsi)
+void ice_update_vsi_stats(struct ice_vsi *vsi)
 {
 	struct rtnl_link_stats64 *cur_ns = &vsi->net_stats;
 	struct ice_eth_stats *cur_es = &vsi->eth_stats;
@@ -3326,7 +3324,7 @@ static void ice_update_vsi_stats(struct ice_vsi *vsi)
  * ice_update_pf_stats - Update PF port stats counters
  * @pf: PF whose stats needs to be updated
  */
-static void ice_update_pf_stats(struct ice_pf *pf)
+void ice_update_pf_stats(struct ice_pf *pf)
 {
 	struct ice_hw_port_stats *prev_ps, *cur_ps;
 	struct ice_hw *hw = &pf->hw;
-- 
2.20.1

