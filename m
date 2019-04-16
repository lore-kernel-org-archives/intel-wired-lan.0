From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:41 -0700
Subject: [Intel-wired-lan] [PATCH S20 04/15] ice: Set minimum default Rx
 descriptor count to 512
In-Reply-To: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173052.28928-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we set the default number of Rx descriptors per
queue to the system's page size divided by the number of bytes per
descriptor. For 4K page size systems this is resulting in 128 Rx
descriptors per queue. This is causing more dropped packets than desired
in the default configuration. Fix this by setting the minimum default
Rx descriptor count per queue to 512.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b5990ba0ee4c..0555d09614d8 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -46,13 +46,20 @@ extern const char ice_drv_ver[];
 #define ICE_REQ_DESC_MULTIPLE	32
 #define ICE_MIN_NUM_DESC	ICE_REQ_DESC_MULTIPLE
 #define ICE_MAX_NUM_DESC	8160
-/* set default number of Rx/Tx descriptors to the minimum between
- * ICE_MAX_NUM_DESC and the number of descriptors to fill up an entire page
+#define ICE_DFLT_MIN_RX_DESC	512
+/* if the default number of Rx descriptors between ICE_MAX_NUM_DESC and the
+ * number of descriptors to fill up an entire page is greater than or equal to
+ * ICE_DFLT_MIN_RX_DESC set it based on page size, otherwise set it to
+ * ICE_DFLT_MIN_RX_DESC
+ */
+#define ICE_DFLT_NUM_RX_DESC \
+	min_t(u16, ICE_MAX_NUM_DESC, \
+	      max_t(u16, ALIGN(PAGE_SIZE / sizeof(union ice_32byte_rx_desc), \
+			       ICE_REQ_DESC_MULTIPLE), \
+		    ICE_DFLT_MIN_RX_DESC))
+/* set default number of Tx descriptors to the minimum between ICE_MAX_NUM_DESC
+ * and the number of descriptors to fill up an entire page
  */
-#define ICE_DFLT_NUM_RX_DESC	min_t(u16, ICE_MAX_NUM_DESC, \
-				      ALIGN(PAGE_SIZE / \
-					    sizeof(union ice_32byte_rx_desc), \
-					    ICE_REQ_DESC_MULTIPLE))
 #define ICE_DFLT_NUM_TX_DESC	min_t(u16, ICE_MAX_NUM_DESC, \
 				      ALIGN(PAGE_SIZE / \
 					    sizeof(struct ice_tx_desc), \
-- 
2.20.1

