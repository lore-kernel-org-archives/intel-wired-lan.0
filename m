From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 26 Feb 2021 13:19:26 -0800
Subject: [Intel-wired-lan] [PATCH net 07/13] ice: prevent ice_open and
 ice_stop during reset
In-Reply-To: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
Message-ID: <20210226211932.46683-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Goreczny <krzysztof.goreczny@intel.com>

There is a possibility of race between ice_open or ice_stop calls
performed by OS and reset handling routine both trying to modify VSI
resources. Observed scenarios:
- reset handler deallocates memory in ice_vsi_free_arrays and ice_open
  tries to access it in ice_vsi_cfg_txq leading to driver crash
- reset handler deallocates memory in ice_vsi_free_arrays and ice_close
  tries to access it in ice_down leading to driver crash
- reset handler clears port scheduler topology and sets port state to
  ICE_SCHED_PORT_STATE_INIT leading to ice_ena_vsi_txq fail in ice_open

To prevent this additional checks in ice_open and ice_stop are
introduced to make sure that OS is not allowed to alter VSI config while
reset is in progress.

Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
Signed-off-by: Krzysztof Goreczny <krzysztof.goreczny@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c  |  4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 28 +++++++++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 264507762dc5..ae1c3a3b0780 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -639,6 +639,7 @@ int ice_fdir_create_dflt_rules(struct ice_pf *pf);
 int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
 			  struct ice_rq_event_info *event);
 int ice_open(struct net_device *netdev);
+int ice_open_internal(struct net_device *netdev);
 int ice_stop(struct net_device *netdev);
 void ice_service_task_schedule(struct ice_pf *pf);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 116f8556f4a8..638304abef73 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2622,7 +2622,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
 			if (!locked)
 				rtnl_lock();
 
-			err = ice_open(vsi->netdev);
+			err = ice_open_internal(vsi->netdev);
 
 			if (!locked)
 				rtnl_unlock();
@@ -2651,7 +2651,7 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 			if (!locked)
 				rtnl_lock();
 
-			ice_stop(vsi->netdev);
+			ice_vsi_close(vsi);
 
 			if (!locked)
 				rtnl_unlock();
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 53e053c997eb..255a07c1e33a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6632,6 +6632,28 @@ static void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
  * Returns 0 on success, negative value on failure
  */
 int ice_open(struct net_device *netdev)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = np->vsi->back;
+
+	if (ice_is_reset_in_progress(pf->state)) {
+		netdev_err(netdev, "can't open net device while reset is in progress");
+		return -EBUSY;
+	}
+
+	return ice_open_internal(netdev);
+}
+
+/**
+ * ice_open_internal - Called when a network interface becomes active
+ * @netdev: network interface device structure
+ *
+ * Internal ice_open implementation. Should not be used directly except for ice_open and reset
+ * handling routine
+ *
+ * Returns 0 on success, negative value on failure
+ */
+int ice_open_internal(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
@@ -6712,6 +6734,12 @@ int ice_stop(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+
+	if (ice_is_reset_in_progress(pf->state)) {
+		netdev_err(netdev, "can't stop net device while reset is in progress");
+		return -EBUSY;
+	}
 
 	ice_vsi_close(vsi);
 
-- 
2.20.1

