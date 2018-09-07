From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  7 Sep 2018 10:18:48 +0200
Subject: [Intel-wired-lan] [PATCH v2 4/4] i40e: disallow changing the number
 of descriptors when AF_XDP is on
In-Reply-To: <20180907081848.5438-1-bjorn.topel@gmail.com>
References: <20180907081848.5438-1-bjorn.topel@gmail.com>
Message-ID: <20180907081848.5438-5-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

When an AF_XDP UMEM is attached to any of the Rx rings, we disallow a
user to change the number of descriptors via e.g. "ethtool -G IFNAME".

Otherwise, the size of the stash/reuse queue can grow unbounded, which
would result in OOM or leaking userspace buffers.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  9 +++++++-
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 22 +++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d7d3974beca2..3cd2c88c72f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5,7 +5,7 @@
 
 #include "i40e.h"
 #include "i40e_diag.h"
-
+#include "i40e_txrx_common.h"
 #include "i40e_ethtool_stats.h"
 
 #define I40E_PF_STAT(_name, _stat) \
@@ -1493,6 +1493,13 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	    (new_rx_count == vsi->rx_rings[0]->count))
 		return 0;
 
+	/* If there is a AF_XDP UMEM attached to any of Rx rings,
+	 * disallow changing the number of descriptors -- regardless
+	 * if the netdev is running or not.
+	 */
+	if (i40e_xsk_any_rx_ring_enabled(vsi))
+		return -EBUSY;
+
 	while (test_and_set_bit(__I40E_CONFIG_BUSY, pf->state)) {
 		timeout--;
 		if (!timeout)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index 8d46acff6f2e..09809dffe399 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -89,5 +89,6 @@ static inline void i40e_arm_wb(struct i40e_ring *tx_ring,
 
 void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring);
 void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring);
+bool i40e_xsk_any_rx_ring_enabled(struct i40e_vsi *vsi);
 
 #endif /* I40E_TXRX_COMMON_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index e4b62e871afc..119f59ec7cc0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -944,3 +944,25 @@ void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring)
 	if (xsk_frames)
 		xsk_umem_complete_tx(umem, xsk_frames);
 }
+
+/**
+ * i40e_xsk_any_rx_ring_enabled - Checks whether any of the Rx rings
+ * has AF_XDP UMEM attached
+ * @vsi: vsi
+ *
+ * Returns true if any of the Rx rings has an AF_XDP UMEM attached
+ **/
+bool i40e_xsk_any_rx_ring_enabled(struct i40e_vsi *vsi)
+{
+	int i;
+
+	if (!vsi->xsk_umems)
+		return false;
+
+	for (i = 0; i < vsi->num_queue_pairs; i++) {
+		if (vsi->xsk_umems[i])
+			return true;
+	}
+
+	return false;
+}
-- 
2.17.1

