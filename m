From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  3 Sep 2019 01:31:07 -0700
Subject: [Intel-wired-lan] [PATCH S28 v2 8/9] ice: change default number of
 receive descriptors
In-Reply-To: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
Message-ID: <20190903083108.19593-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver should start out with a reasonable number of descriptors that
can prevent drops due to a CPU being in a power management state.
Change the default number of descriptors to 2048.
The user can always change the value at runtime.  Transmit descriptor
counts are not modified because they don't need to change due to the
speed of the interface, or for power managed CPUs, but the code is
simplified to a fixed value for the transmit default.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6c4faf7551f6..b36e1cf0e461 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -47,23 +47,8 @@ extern const char ice_drv_ver[];
 #define ICE_MIN_NUM_DESC	64
 #define ICE_MAX_NUM_DESC	8160
 #define ICE_DFLT_MIN_RX_DESC	512
-/* if the default number of Rx descriptors between ICE_MAX_NUM_DESC and the
- * number of descriptors to fill up an entire page is greater than or equal to
- * ICE_DFLT_MIN_RX_DESC set it based on page size, otherwise set it to
- * ICE_DFLT_MIN_RX_DESC
- */
-#define ICE_DFLT_NUM_RX_DESC \
-	min_t(u16, ICE_MAX_NUM_DESC, \
-	      max_t(u16, ALIGN(PAGE_SIZE / sizeof(union ice_32byte_rx_desc), \
-			       ICE_REQ_DESC_MULTIPLE), \
-		    ICE_DFLT_MIN_RX_DESC))
-/* set default number of Tx descriptors to the minimum between ICE_MAX_NUM_DESC
- * and the number of descriptors to fill up an entire page
- */
-#define ICE_DFLT_NUM_TX_DESC	min_t(u16, ICE_MAX_NUM_DESC, \
-				      ALIGN(PAGE_SIZE / \
-					    sizeof(struct ice_tx_desc), \
-					    ICE_REQ_DESC_MULTIPLE))
+#define ICE_DFLT_NUM_TX_DESC	256
+#define ICE_DFLT_NUM_RX_DESC	2048
 
 #define ICE_DFLT_TRAFFIC_CLASS	BIT(0)
 #define ICE_INT_NAME_STR_LEN	(IFNAMSIZ + 16)
-- 
2.20.1

