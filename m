From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:32 -0700
Subject: [Intel-wired-lan] [next PATCH S35 12/14] i40e/i40evf: Remove unused
	hardware receive descriptor code
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-13-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The hardware supports a 16 byte descriptor for receive, but the
driver was never using it in production.  There was no performance
benefit to the real driver of 16 byte descriptors, so drop a whole
lot of complexity while getting rid of the code.

Also since the previous patch made us use no-split mode all the
time, drop any support in the driver for any other value in dtype
and assume it is always zero (aka no-split).

Hooray for code removal!

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I2257e902e4dad84a07b94db6d2e6f4ce69b27bc0
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  7 +------
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 20 +++-----------------
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 18 +++++-------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 26 ++++++++++----------------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 26 ++++++++++----------------
 5 files changed, 29 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5e23cc9..5831a7f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -122,10 +122,7 @@
 #define XSTRINGIFY(bar) STRINGIFY(bar)
 
 #define I40E_RX_DESC(R, i)			\
-	((ring_is_16byte_desc_enabled(R))	\
-		? (union i40e_32byte_rx_desc *)	\
-			(&(((union i40e_16byte_rx_desc *)((R)->desc))[i])) \
-		: (&(((union i40e_32byte_rx_desc *)((R)->desc))[i])))
+	(&(((union i40e_32byte_rx_desc *)((R)->desc))[i]))
 #define I40E_TX_DESC(R, i)			\
 	(&(((struct i40e_tx_desc *)((R)->desc))[i]))
 #define I40E_TX_CTXTDESC(R, i)			\
@@ -342,7 +339,6 @@ struct i40e_pf {
 #ifdef I40E_FCOE
 #define I40E_FLAG_FCOE_ENABLED			BIT_ULL(11)
 #endif /* I40E_FCOE */
-#define I40E_FLAG_16BYTE_RX_DESC_ENABLED	BIT_ULL(13)
 #define I40E_FLAG_CLEAN_ADMINQ			BIT_ULL(14)
 #define I40E_FLAG_FILTER_SYNC			BIT_ULL(15)
 #define I40E_FLAG_SERVICE_CLIENT_REQUESTED	BIT_ULL(16)
@@ -547,7 +543,6 @@ struct i40e_vsi {
 
 	u16 max_frame;
 	u16 rx_buf_len;
-	u8  dtype;
 
 	/* List of q_vectors allocated to this VSI */
 	struct i40e_q_vector **q_vectors;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 519cfc8..ee9ba06 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -271,7 +271,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 "    rx_rings[%i]: rx_buf_len = %d, dtype = %d\n",
 			 i,
 			 rx_ring->rx_buf_len,
-			 rx_ring->dtype);
+			 0);
 		dev_info(&pf->pdev->dev,
 			 "    rx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
 			 i,
@@ -327,7 +327,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 tx_ring->reg_idx);
 		dev_info(&pf->pdev->dev,
 			 "    tx_rings[%i]: dtype = %d\n",
-			 i, tx_ring->dtype);
+			 i, 0);
 		dev_info(&pf->pdev->dev,
 			 "    tx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
 			 i,
@@ -366,7 +366,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		 vsi->work_limit);
 	dev_info(&pf->pdev->dev,
 		 "    max_frame = %d, rx_buf_len = %d dtype = %d\n",
-		 vsi->max_frame, vsi->rx_buf_len, vsi->dtype);
+		 vsi->max_frame, vsi->rx_buf_len, 0);
 	dev_info(&pf->pdev->dev,
 		 "    num_q_vectors = %i, base_vector = %i\n",
 		 vsi->num_q_vectors, vsi->base_vector);
@@ -591,13 +591,6 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
 					 "   d[%03x] = 0x%016llx 0x%016llx\n",
 					 i, txd->buffer_addr,
 					 txd->cmd_type_offset_bsz);
-			} else if (sizeof(union i40e_rx_desc) ==
-				   sizeof(union i40e_16byte_rx_desc)) {
-				rxd = I40E_RX_DESC(ring, i);
-				dev_info(&pf->pdev->dev,
-					 "   d[%03x] = 0x%016llx 0x%016llx\n",
-					 i, rxd->read.pkt_addr,
-					 rxd->read.hdr_addr);
 			} else {
 				rxd = I40E_RX_DESC(ring, i);
 				dev_info(&pf->pdev->dev,
@@ -619,13 +612,6 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
 				 "vsi = %02i tx ring = %02i d[%03x] = 0x%016llx 0x%016llx\n",
 				 vsi_seid, ring_id, desc_n,
 				 txd->buffer_addr, txd->cmd_type_offset_bsz);
-		} else if (sizeof(union i40e_rx_desc) ==
-			   sizeof(union i40e_16byte_rx_desc)) {
-			rxd = I40E_RX_DESC(ring, desc_n);
-			dev_info(&pf->pdev->dev,
-				 "vsi = %02i rx ring = %02i d[%03x] = 0x%016llx 0x%016llx\n",
-				 vsi_seid, ring_id, desc_n,
-				 rxd->read.pkt_addr, rxd->read.hdr_addr);
 		} else {
 			rxd = I40E_RX_DESC(ring, desc_n);
 			dev_info(&pf->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b5713ae..80390ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2862,14 +2862,12 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	rx_ctx.base = (ring->dma / 128);
 	rx_ctx.qlen = ring->count;
 
-	if (vsi->back->flags & I40E_FLAG_16BYTE_RX_DESC_ENABLED) {
-		set_ring_16byte_desc_enabled(ring);
-		rx_ctx.dsize = 0;
-	} else {
-		rx_ctx.dsize = 1;
-	}
+	/* use 32 byte descriptors */
+	rx_ctx.dsize = 1;
 
-	rx_ctx.dtype = vsi->dtype;
+	/* descriptor type is always zero
+	 * rx_ctx.dtype = 0;
+	 */
 	rx_ctx.hsplit_0 = 0;
 
 	rx_ctx.rxmax = min_t(u16, vsi->max_frame, chain_len * ring->rx_buf_len);
@@ -2949,7 +2947,6 @@ static int i40e_vsi_configure_rx(struct i40e_vsi *vsi)
 		vsi->max_frame = I40E_RXBUFFER_2048;
 
 	vsi->rx_buf_len = I40E_RXBUFFER_2048;
-	vsi->dtype = I40E_RX_DTYPE_NO_SPLIT;
 
 #ifdef I40E_FCOE
 	/* setup rx buffer for FCoE */
@@ -2957,7 +2954,6 @@ static int i40e_vsi_configure_rx(struct i40e_vsi *vsi)
 	    (vsi->back->flags & I40E_FLAG_FCOE_ENABLED)) {
 		vsi->rx_buf_len = I40E_RXBUFFER_3072;
 		vsi->max_frame = I40E_RXBUFFER_3072;
-		vsi->dtype = I40E_RX_DTYPE_NO_SPLIT;
 	}
 
 #endif /* I40E_FCOE */
@@ -7477,10 +7473,6 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		rx_ring->count = vsi->num_desc;
 		rx_ring->size = 0;
 		rx_ring->dcb_tc = 0;
-		if (pf->flags & I40E_FLAG_16BYTE_RX_DESC_ENABLED)
-			set_ring_16byte_desc_enabled(rx_ring);
-		else
-			clear_ring_16byte_desc_enabled(rx_ring);
 		rx_ring->rx_itr_setting = pf->rx_itr_default;
 		vsi->rx_rings[i] = rx_ring;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 54ddbd4..b78c810 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -260,16 +260,18 @@ struct i40e_rx_queue_stats {
 enum i40e_ring_state_t {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
-	__UNUSED,
-	__I40E_RX_16BYTE_DESC_ENABLED,
 };
 
-#define ring_is_16byte_desc_enabled(ring) \
-	test_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
-#define set_ring_16byte_desc_enabled(ring) \
-	set_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
-#define clear_ring_16byte_desc_enabled(ring) \
-	clear_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
+/* some useful defines for virtchannel interface, which
+ * is the only remaining user of header split
+ */
+#define I40E_RX_DTYPE_NO_SPLIT      0
+#define I40E_RX_DTYPE_HEADER_SPLIT  1
+#define I40E_RX_DTYPE_SPLIT_ALWAYS  2
+#define I40E_RX_SPLIT_L2      0x1
+#define I40E_RX_SPLIT_IP      0x2
+#define I40E_RX_SPLIT_TCP_UDP 0x4
+#define I40E_RX_SPLIT_SCTP    0x8
 
 /* struct that defines a descriptor ring, associated with a VSI */
 struct i40e_ring {
@@ -297,14 +299,6 @@ struct i40e_ring {
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
 	u16 rx_buf_len;
-	u8  dtype;
-#define I40E_RX_DTYPE_NO_SPLIT      0
-#define I40E_RX_DTYPE_HEADER_SPLIT  1
-#define I40E_RX_DTYPE_SPLIT_ALWAYS  2
-#define I40E_RX_SPLIT_L2      0x1
-#define I40E_RX_SPLIT_IP      0x2
-#define I40E_RX_SPLIT_TCP_UDP 0x4
-#define I40E_RX_SPLIT_SCTP    0x8
 
 	/* used in interrupt processing */
 	u16 next_to_use;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 0bffbd9..0112277 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -259,16 +259,18 @@ struct i40e_rx_queue_stats {
 enum i40e_ring_state_t {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
-	__UNUSED,
-	__I40E_RX_16BYTE_DESC_ENABLED,
 };
 
-#define ring_is_16byte_desc_enabled(ring) \
-	test_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
-#define set_ring_16byte_desc_enabled(ring) \
-	set_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
-#define clear_ring_16byte_desc_enabled(ring) \
-	clear_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
+/* some useful defines for virtchannel interface, which
+ * is the only remaining user of header split
+ */
+#define I40E_RX_DTYPE_NO_SPLIT      0
+#define I40E_RX_DTYPE_HEADER_SPLIT  1
+#define I40E_RX_DTYPE_SPLIT_ALWAYS  2
+#define I40E_RX_SPLIT_L2      0x1
+#define I40E_RX_SPLIT_IP      0x2
+#define I40E_RX_SPLIT_TCP_UDP 0x4
+#define I40E_RX_SPLIT_SCTP    0x8
 
 /* struct that defines a descriptor ring, associated with a VSI */
 struct i40e_ring {
@@ -288,14 +290,6 @@ struct i40e_ring {
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
 	u16 rx_buf_len;
-	u8  dtype;
-#define I40E_RX_DTYPE_NO_SPLIT      0
-#define I40E_RX_DTYPE_HEADER_SPLIT  1
-#define I40E_RX_DTYPE_SPLIT_ALWAYS  2
-#define I40E_RX_SPLIT_L2      0x1
-#define I40E_RX_SPLIT_IP      0x2
-#define I40E_RX_SPLIT_TCP_UDP 0x4
-#define I40E_RX_SPLIT_SCTP    0x8
 
 	/* used in interrupt processing */
 	u16 next_to_use;
-- 
2.4.3

