From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:53 -0800
Subject: [Intel-wired-lan] [PATCH S12 06/14] ice: implement ethtool set
 channels
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-7-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

Implement change the number of queues assigned to a VSI. This is
accessed from the 'ethtool -L' Linux command.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  3 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 85 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c     | 50 ++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 54 +++++++++++++++++-
 5 files changed, 182 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 89440775aea1..02cbd7d92491 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -257,6 +257,8 @@ struct ice_vsi {
 	u16 num_txq;			 /* Used Tx queues */
 	u16 alloc_rxq;			 /* Allocated Rx queues */
 	u16 num_rxq;			 /* Used Rx queues */
+	u16 req_txq;			 /* User requested Tx queues */
+	u16 req_rxq;			 /* User requested Rx queues */
 	u16 num_desc;
 	struct ice_tc_cfg tc_cfg;
 } ____cacheline_internodealigned_in_smp;
@@ -381,6 +383,7 @@ static inline void ice_vsi_set_tc_cfg(struct ice_vsi *vsi)
 }
 
 void ice_set_ethtool_ops(struct net_device *netdev);
+int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx);
 int ice_up(struct ice_vsi *vsi);
 int ice_down(struct ice_vsi *vsi);
 int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index eb8d149e317c..1be757f63876 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2079,6 +2079,89 @@ static int ice_set_rxfh(struct net_device *netdev, const u32 *indir,
 	return 0;
 }
 
+/**
+ * ice_get_max_txq - return the maximum number of Tx queues for in a PF
+ * @pf: pf structure
+ */
+static int ice_get_max_txq(struct ice_pf *pf)
+{
+	return min_t(int, num_online_cpus(),
+		     pf->hw.func_caps.common_cap.num_txq);
+}
+
+/**
+ * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
+ * @pf: pf structure
+ */
+static int ice_get_max_rxq(struct ice_pf *pf)
+{
+	return min_t(int, num_online_cpus(),
+		     pf->hw.func_caps.common_cap.num_rxq);
+}
+
+/**
+ * ice_get_channels - get the current and max supported channels
+ * @dev: network interface device structure
+ * @ch: ethtool channel data structure
+ */
+static void
+ice_get_channels(struct net_device *dev, struct ethtool_channels *ch)
+{
+	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+
+	/* check to see if VSI is active */
+	if (test_bit(__ICE_DOWN, vsi->state))
+		return;
+
+	/* report maximum channels */
+	ch->max_rx = ice_get_max_rxq(pf);
+	ch->max_tx = ice_get_max_txq(pf);
+
+	/* report current channels */
+	ch->rx_count = vsi->num_rxq;
+	ch->tx_count = vsi->num_txq;
+}
+
+/**
+ * ice_set_channels - set the number channels
+ * @dev: network interface device structure
+ * @ch: ethtool channel data structure
+ */
+static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
+{
+	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	int new_rx = 0, new_tx = 0;
+
+	/* do not support changing other_count */
+	if (ch->other_count)
+		return -EINVAL;
+
+	/* verify request for a valid number of channels */
+	if (ch->rx_count > ice_get_max_rxq(pf) ||
+	    ch->tx_count > ice_get_max_txq(pf))
+		return -EINVAL;
+
+	/* Use new Rx value only if changed */
+	if (ch->rx_count != vsi->num_rxq)
+		new_rx = ch->rx_count;
+
+	/* Use new Tx value only if changed */
+	if (ch->tx_count != vsi->num_txq)
+		new_tx = ch->tx_count;
+
+	/* verify that we have a valid request */
+	if (!new_rx && !new_tx)
+		return -EINVAL;
+
+	ice_vsi_recfg_qs(vsi, new_rx, new_tx);
+
+	return 0;
+}
+
 enum ice_container_type {
 	ICE_RX_CONTAINER,
 	ICE_TX_CONTAINER,
@@ -2360,6 +2443,8 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
 	.get_rxfh		= ice_get_rxfh,
 	.set_rxfh		= ice_set_rxfh,
+	.get_channels		= ice_get_channels,
+	.set_channels		= ice_set_channels,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_per_queue_coalesce = ice_get_per_q_coalesce,
 	.set_per_queue_coalesce = ice_set_per_q_coalesce,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5215180d08a3..1418251b9275 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -289,6 +289,14 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 	case ICE_VSI_PF:
 		vsi->alloc_txq = pf->num_lan_tx;
 		vsi->alloc_rxq = pf->num_lan_rx;
+		if (vsi->req_txq) {
+			vsi->alloc_txq = vsi->req_txq;
+			vsi->num_txq = vsi->req_txq;
+		}
+		if (vsi->req_rxq) {
+			vsi->alloc_rxq = vsi->req_rxq;
+			vsi->num_rxq = vsi->req_rxq;
+		}
 		vsi->num_desc = ALIGN(ICE_DFLT_NUM_DESC, ICE_REQ_DESC_MULTIPLE);
 		vsi->num_q_vectors = max_t(int, pf->num_lan_rx, pf->num_lan_tx);
 		break;
@@ -818,6 +826,9 @@ static void ice_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
 				max_rss = ICE_MAX_SMALL_RSS_QS;
 			qcount_rx = min_t(int, rx_numq_tc, max_rss);
 			qcount_rx = min_t(int, qcount_rx, vsi->rss_size);
+			if (!vsi->req_rxq)
+				qcount_rx = min_t(int, qcount_rx,
+						  vsi->rss_size);
 		}
 	}
 
@@ -905,11 +916,12 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 /**
  * ice_vsi_init - Create and initialize a VSI
  * @vsi: the VSI being configured
+ * @init_vsi: is this call creating a VSI
  *
  * This initializes a VSI context depending on the VSI type to be added and
  * passes it down to the add_vsi aq command to create a new VSI.
  */
-static int ice_vsi_init(struct ice_vsi *vsi)
+static int ice_vsi_init(struct ice_vsi *vsi, bool init_vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
@@ -930,7 +942,8 @@ static int ice_vsi_init(struct ice_vsi *vsi)
 		ctxt->vf_num = vsi->vf_id + hw->func_caps.vf_base_id;
 		break;
 	default:
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	ice_set_dflt_vsi_ctx(ctxt);
@@ -945,11 +958,22 @@ static int ice_vsi_init(struct ice_vsi *vsi)
 	ctxt->info.sw_id = vsi->port_info->sw_id;
 	ice_vsi_setup_q_map(vsi, ctxt);
 
-	ret = ice_add_vsi(hw, vsi->idx, ctxt, NULL);
-	if (ret) {
-		dev_err(&pf->pdev->dev,
-			"Add VSI failed, err %d\n", ret);
-		return -EIO;
+	if (init_vsi) {
+		ret = ice_add_vsi(hw, vsi->idx, ctxt, NULL);
+		if (ret) {
+			dev_err(&pf->pdev->dev,
+				"Add VSI failed, err %d\n", ret);
+			ret = -EIO;
+			goto out;
+		}
+	} else {
+		ret = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
+		if (ret) {
+			dev_err(&pf->pdev->dev,
+				"Update VSI failed, err %d\n", ret);
+			ret = -EIO;
+			goto out;
+		}
 	}
 
 	/* keep context for update VSI operations */
@@ -958,6 +982,7 @@ static int ice_vsi_init(struct ice_vsi *vsi)
 	/* record VSI number returned */
 	vsi->vsi_num = ctxt->vsi_num;
 
+out:
 	devm_kfree(&pf->pdev->dev, ctxt);
 	return ret;
 }
@@ -2133,7 +2158,7 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi,
 	ice_vsi_set_tc_cfg(vsi);
 
 	/* create the VSI */
-	ret = ice_vsi_init(vsi);
+	ret = ice_vsi_init(vsi, true);
 	if (ret)
 		goto unroll_get_qs;
 
@@ -2587,10 +2612,11 @@ int ice_vsi_release(struct ice_vsi *vsi)
 /**
  * ice_vsi_rebuild - Rebuild VSI after reset
  * @vsi: VSI to be rebuild
+ * @init_vsi: is this an initialization or a reconfigure of the VSI
  *
  * Returns 0 on success and negative value on failure
  */
-int ice_vsi_rebuild(struct ice_vsi *vsi)
+int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	struct ice_pf *pf;
@@ -2609,11 +2635,15 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_arrays(vsi, false);
 	ice_dev_onetime_setup(&vsi->back->hw);
+	if (vsi->req_txq || vsi->req_rxq)
+		ice_vsi_put_qs(vsi);
 	ice_vsi_set_num_qs(vsi);
+	if (vsi->req_txq || vsi->req_rxq)
+		ice_vsi_get_qs(vsi);
 	ice_vsi_set_tc_cfg(vsi);
 
 	/* Initialize VSI struct elements and create VSI in FW */
-	ret = ice_vsi_init(vsi);
+	ret = ice_vsi_init(vsi, init_vsi);
 	if (ret < 0)
 		goto err_vsi;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 7988a53729a9..7f8b08863dad 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -54,7 +54,7 @@ int ice_free_res(struct ice_res_tracker *res, u16 index, u16 id);
 int
 ice_get_res(struct ice_pf *pf, struct ice_res_tracker *res, u16 needed, u16 id);
 
-int ice_vsi_rebuild(struct ice_vsi *vsi);
+int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi);
 
 bool ice_is_reset_in_progress(unsigned long *state);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d353de4456f5..ad1bd3fe1f34 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3382,7 +3382,7 @@ static int ice_vsi_rebuild_all(struct ice_pf *pf)
 		if (pf->vsi[i]->type == ICE_VSI_VF)
 			continue;
 
-		err = ice_vsi_rebuild(pf->vsi[i]);
+		err = ice_vsi_rebuild(pf->vsi[i], true);
 		if (err) {
 			dev_err(&pf->pdev->dev,
 				"VSI at index %d rebuild failed\n",
@@ -3552,6 +3552,58 @@ static void ice_rebuild(struct ice_pf *pf)
 	dev_err(dev, "Rebuild failed, unload and reload driver\n");
 }
 
+/**
+ * ice_vsi_recfg_qs - Change the number of queues on a VSI
+ * @vsi: VSI being changed
+ * @new_rx: new number of Rx queues
+ * @new_tx: new number of Tx queues
+ *
+ * Only change the number of queues if new_tx, or new_rx is non-0.
+ *
+ * Returns 0 on success.
+ */
+int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx)
+{
+	struct ice_pf *pf = vsi->back;
+	int err = 0, timeout = 50;
+
+	if (!new_rx && !new_tx)
+		return -EINVAL;
+
+	while (test_and_set_bit(__ICE_CFG_BUSY, pf->state)) {
+		timeout--;
+		if (!timeout)
+			return -EBUSY;
+		usleep_range(1000, 2000);
+	}
+
+	/* set for the next time the netdev is started */
+	if (!netif_running(vsi->netdev)) {
+		if (new_tx)
+			vsi->req_txq = new_tx;
+		if (new_rx)
+			vsi->req_rxq = new_rx;
+
+		dev_dbg(&pf->pdev->dev, "Link is down, queue count change happens when link is brought up\n");
+		goto done;
+	}
+
+	ice_vsi_close(vsi);
+
+	if (new_tx)
+		vsi->req_txq = new_tx;
+
+	if (new_rx)
+		vsi->req_rxq = new_rx;
+
+	ice_vsi_rebuild(vsi, false);
+
+	ice_vsi_open(vsi);
+done:
+	clear_bit(__ICE_CFG_BUSY, pf->state);
+	return err;
+}
+
 /**
  * ice_change_mtu - NDO callback to change the MTU
  * @netdev: network interface device structure
-- 
2.14.5

