From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:59 -0800
Subject: [Intel-wired-lan] [PATCH S12 12/14] ice: Determine descriptor count
 and ring size based on PAGE_SIZE
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we set the default number of Tx and Rx descriptors to 128 by
default. For Rx this amounts to a full page (assuming 4K pages) because
each Rx descriptor is 32 Bytes, but for Tx it only amounts to a half
page because each Tx descriptor is 16 Bytes (assuming 4K pages).
Instead of assuming 4K pages, determine the ring size and the number of
descriptors for Tx and Rx based on a calculation using the PAGE_SIZE,
ICE_MAX_NUM_DESC, and ICE_REQ_DESC_MULTIPLE. This change is being made
to improve the performance of the driver when using the default
settings.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 16 ++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c  | 28 ++++++++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_txrx.c | 10 +++++-----
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 02cbd7d92491..652dbfb5ab4e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -42,10 +42,21 @@
 
 extern const char ice_drv_ver[];
 #define ICE_BAR0		0
-#define ICE_DFLT_NUM_DESC	128
 #define ICE_REQ_DESC_MULTIPLE	32
 #define ICE_MIN_NUM_DESC	ICE_REQ_DESC_MULTIPLE
 #define ICE_MAX_NUM_DESC	8160
+/* set default number of Rx/Tx descriptors to the minimum between
+ * ICE_MAX_NUM_DESC and the number of descriptors to fill up an entire page
+ */
+#define ICE_DFLT_NUM_RX_DESC	min_t(u16, ICE_MAX_NUM_DESC, \
+				      ALIGN(PAGE_SIZE / \
+					    sizeof(union ice_32byte_rx_desc), \
+					    ICE_REQ_DESC_MULTIPLE))
+#define ICE_DFLT_NUM_TX_DESC	min_t(u16, ICE_MAX_NUM_DESC, \
+				      ALIGN(PAGE_SIZE / \
+					    sizeof(struct ice_tx_desc), \
+					    ICE_REQ_DESC_MULTIPLE))
+
 #define ICE_DFLT_TRAFFIC_CLASS	BIT(0)
 #define ICE_INT_NAME_STR_LEN	(IFNAMSIZ + 16)
 #define ICE_ETHTOOL_FWVER_LEN	32
@@ -259,7 +270,8 @@ struct ice_vsi {
 	u16 num_rxq;			 /* Used Rx queues */
 	u16 req_txq;			 /* User requested Tx queues */
 	u16 req_rxq;			 /* User requested Rx queues */
-	u16 num_desc;
+	u16 num_rx_desc;
+	u16 num_tx_desc;
 	struct ice_tc_cfg tc_cfg;
 } ____cacheline_internodealigned_in_smp;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 40e9df15777b..864007bc945e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -276,7 +276,26 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi, bool alloc_qvectors)
 }
 
 /**
- * ice_vsi_set_num_qs - Set num queues, descriptors and vectors for a VSI
+ * ice_vsi_set_num_desc - Set number of descriptors for queues on this VSI
+ * @vsi: the VSI being configured
+ */
+static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
+{
+	switch (vsi->type) {
+	case ICE_VSI_PF:
+		vsi->num_rx_desc = ICE_DFLT_NUM_RX_DESC;
+		vsi->num_tx_desc = ICE_DFLT_NUM_TX_DESC;
+		break;
+	default:
+		dev_dbg(&vsi->back->pdev->dev,
+			"Not setting number of Tx/Rx descriptors for VSI type %d\n",
+			vsi->type);
+		break;
+	}
+}
+
+/**
+ * ice_vsi_set_num_qs - Set number of queues, descriptors and vectors for a VSI
  * @vsi: the VSI being configured
  *
  * Return 0 on success and a negative value on error
@@ -297,7 +316,6 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 			vsi->alloc_rxq = vsi->req_rxq;
 			vsi->num_rxq = vsi->req_rxq;
 		}
-		vsi->num_desc = ALIGN(ICE_DFLT_NUM_DESC, ICE_REQ_DESC_MULTIPLE);
 		vsi->num_q_vectors = max_t(int, pf->num_lan_rx, pf->num_lan_tx);
 		break;
 	case ICE_VSI_VF:
@@ -315,6 +333,8 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 			 vsi->type);
 		break;
 	}
+
+	ice_vsi_set_num_desc(vsi);
 }
 
 /**
@@ -1237,7 +1257,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->ring_active = false;
 		ring->vsi = vsi;
 		ring->dev = &pf->pdev->dev;
-		ring->count = vsi->num_desc;
+		ring->count = vsi->num_tx_desc;
 		vsi->tx_rings[i] = ring;
 	}
 
@@ -1256,7 +1276,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
 		ring->dev = &pf->pdev->dev;
-		ring->count = vsi->num_desc;
+		ring->count = vsi->num_rx_desc;
 		vsi->rx_rings[i] = ring;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index c289d97f477d..fad308c936b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -236,9 +236,9 @@ int ice_setup_tx_ring(struct ice_ring *tx_ring)
 	if (!tx_ring->tx_buf)
 		return -ENOMEM;
 
-	/* round up to nearest 4K */
+	/* round up to nearest page */
 	tx_ring->size = ALIGN(tx_ring->count * sizeof(struct ice_tx_desc),
-			      4096);
+			      PAGE_SIZE);
 	tx_ring->desc = dmam_alloc_coherent(dev, tx_ring->size, &tx_ring->dma,
 					    GFP_KERNEL);
 	if (!tx_ring->desc) {
@@ -339,9 +339,9 @@ int ice_setup_rx_ring(struct ice_ring *rx_ring)
 	if (!rx_ring->rx_buf)
 		return -ENOMEM;
 
-	/* round up to nearest 4K */
-	rx_ring->size = rx_ring->count * sizeof(union ice_32byte_rx_desc);
-	rx_ring->size = ALIGN(rx_ring->size, 4096);
+	/* round up to nearest page */
+	rx_ring->size = ALIGN(rx_ring->count * sizeof(union ice_32byte_rx_desc),
+			      PAGE_SIZE);
 	rx_ring->desc = dmam_alloc_coherent(dev, rx_ring->size, &rx_ring->dma,
 					    GFP_KERNEL);
 	if (!rx_ring->desc) {
-- 
2.14.5

