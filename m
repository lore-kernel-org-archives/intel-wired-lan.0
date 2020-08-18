From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 18 Aug 2020 16:40:01 -0700
Subject: [Intel-wired-lan] [PATCH net v2 1/2] igc: Fix wrong timestamp
 latency numbers
Message-ID: <20200818234002.3057510-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changes from v1:
  - Added Fixes tag

The previous timestamping latency numbers were obtained by
interpolating the i210 numbers with the i225 crystal clock value. That
calculation was wrong.

Use the correct values from real measurements.

Fixes: 81b055205e8b ("igc: Add support for RX timestamping")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 3070dfdb7eb4..2d566f3c827b 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -299,18 +299,14 @@ extern char igc_driver_name[];
 #define IGC_RX_HDR_LEN			IGC_RXBUFFER_256
 
 /* Transmit and receive latency (for PTP timestamps) */
-/* FIXME: These values were estimated using the ones that i225 has as
- * basis, they seem to provide good numbers with ptp4l/phc2sys, but we
- * need to confirm them.
- */
-#define IGC_I225_TX_LATENCY_10		9542
-#define IGC_I225_TX_LATENCY_100		1024
-#define IGC_I225_TX_LATENCY_1000	178
-#define IGC_I225_TX_LATENCY_2500	64
-#define IGC_I225_RX_LATENCY_10		20662
-#define IGC_I225_RX_LATENCY_100		2213
-#define IGC_I225_RX_LATENCY_1000	448
-#define IGC_I225_RX_LATENCY_2500	160
+#define IGC_I225_TX_LATENCY_10		240
+#define IGC_I225_TX_LATENCY_100		58
+#define IGC_I225_TX_LATENCY_1000	80
+#define IGC_I225_TX_LATENCY_2500	1325
+#define IGC_I225_RX_LATENCY_10		6450
+#define IGC_I225_RX_LATENCY_100		185
+#define IGC_I225_RX_LATENCY_1000	300
+#define IGC_I225_RX_LATENCY_2500	1485
 
 /* RX and TX descriptor control thresholds.
  * PTHRESH - MAC will consider prefetch if it has fewer than this number of
-- 
2.28.0

