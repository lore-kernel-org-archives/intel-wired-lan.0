From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:24:27 -0800
Subject: [Intel-wired-lan] [PATCH S16 06/11] ice: Update rings based on TC
 information
In-Reply-To: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232432.31659-7-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds a new function ice_vsi_cfg_dcb_rings which updates a
VSI's rings based on DCB traffic class information.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 38 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  8 ++++++
 drivers/net/ethernet/intel/ice/ice_lib.c     |  2 ++
 drivers/net/ethernet/intel/ice/ice_main.c    |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.h    |  3 +++
 5 files changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bb9c282ee35e..68df3d78a534 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -57,6 +57,44 @@ u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg)
 	return ret;
 }
 
+/**
+ * ice_vsi_cfg_dcb_rings - Update rings to reflect DCB TC
+ * @vsi: VSI owner of rings being updated
+ */
+void ice_vsi_cfg_dcb_rings(struct ice_vsi *vsi)
+{
+	struct ice_ring *tx_ring, *rx_ring;
+	u16 qoffset, qcount;
+	int i, n;
+
+	if (!test_bit(ICE_FLAG_DCB_ENA, vsi->back->flags)) {
+		/* Reset the TC information */
+		for (i = 0; i < vsi->num_txq; i++) {
+			tx_ring = vsi->tx_rings[i];
+			tx_ring->dcb_tc = 0;
+		}
+		for (i = 0; i < vsi->num_rxq; i++) {
+			rx_ring = vsi->rx_rings[i];
+			rx_ring->dcb_tc = 0;
+		}
+		return;
+	}
+
+	ice_for_each_traffic_class(n) {
+		if (!(vsi->tc_cfg.ena_tc & BIT(n)))
+			break;
+
+		qoffset = vsi->tc_cfg.tc_info[n].qoffset;
+		qcount = vsi->tc_cfg.tc_info[n].qcount_tx;
+		for (i = qoffset; i < (qoffset + qcount); i++) {
+			tx_ring = vsi->tx_rings[i];
+			rx_ring = vsi->rx_rings[i];
+			tx_ring->dcb_tc = n;
+			rx_ring->dcb_tc = n;
+		}
+	}
+}
+
 /**
  * ice_pf_dcb_recfg - Reconfigure all VEBs and VSIs
  * @pf: pointer to the PF struct
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index a2e42f85fa55..449e3735ca1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -10,10 +10,16 @@
 #ifdef CONFIG_DCB
 u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg *dcbcfg);
 u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
+void ice_vsi_cfg_dcb_rings(struct ice_vsi *vsi);
 int ice_init_pf_dcb(struct ice_pf *pf);
 void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 				    struct ice_rq_event_info *event);
+static inline void
+ice_set_cgd_num(struct ice_tlan_ctx *tlan_ctx, struct ice_ring *ring)
+{
+	tlan_ctx->cgd_num = ring->dcb_tc;
+}
 #else
 static inline u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg __always_unused *dcbcfg)
 {
@@ -31,6 +37,8 @@ static inline int ice_init_pf_dcb(struct ice_pf *pf)
 	return -EOPNOTSUPP;
 }
 
+#define ice_vsi_cfg_dcb_rings(vsi) do {} while (0)
 #define ice_dcb_process_lldp_set_mib_change(pf, event) do {} while (0)
+#define ice_set_cgd_num(tlan_ctx, ring) do {} while (0)
 #endif /* CONFIG_DCB */
 #endif /* _ICE_DCB_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f3574daa147c..f31129e4e9cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -125,6 +125,8 @@ ice_setup_tx_ctx(struct ice_ring *ring, struct ice_tlan_ctx *tlan_ctx, u16 pf_q)
 	/* Transmit Queue Length */
 	tlan_ctx->qlen = ring->count;
 
+	ice_set_cgd_num(tlan_ctx, ring);
+
 	/* PF number */
 	tlan_ctx->pf_num = hw->pf_id;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9b58f156ceee..367e9559b1ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2940,6 +2940,7 @@ static int ice_vsi_cfg(struct ice_vsi *vsi)
 		if (err)
 			return err;
 	}
+	ice_vsi_cfg_dcb_rings(vsi);
 
 	err = ice_vsi_cfg_lan_txqs(vsi);
 	if (!err)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 60131b84b021..53903f846834 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -160,6 +160,9 @@ struct ice_ring {
 	};
 	u16 q_index;			/* Queue number of ring */
 	u32 txq_teid;			/* Added Tx queue TEID */
+#ifdef CONFIG_DCB
+	u8 dcb_tc;		/* Traffic class of ring */
+#endif /* CONFIG_DCB */
 
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
-- 
2.14.5

