From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:41 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/14] iavf: tracing
 infrastructure rename
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-12-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rename the i40e_trace file and fix up all the callers
to the new names inside the iavf_trace.h file.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  2 +-
 .../intel/iavf/{i40e_trace.h => iavf_trace.h}      | 28 +++++++++++-----------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        | 14 +++++------
 3 files changed, 22 insertions(+), 22 deletions(-)
 rename drivers/net/ethernet/intel/iavf/{i40e_trace.h => iavf_trace.h} (85%)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 63c5d97b1658..b8edf43e36f1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -9,7 +9,7 @@
  * CREATE_TRACE_POINTS defined
  */
 #define CREATE_TRACE_POINTS
-#include "i40e_trace.h"
+#include "iavf_trace.h"
 
 static int iavf_setup_all_tx_resources(struct iavf_adapter *adapter);
 static int iavf_setup_all_rx_resources(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/i40e_trace.h b/drivers/net/ethernet/intel/iavf/iavf_trace.h
similarity index 85%
rename from drivers/net/ethernet/intel/iavf/i40e_trace.h
rename to drivers/net/ethernet/intel/iavf/iavf_trace.h
index 552cfbfcce71..24f34d79f20a 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_trace.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_trace.h
@@ -5,7 +5,7 @@
 
 /* The trace subsystem name for iavf will be "iavf".
  *
- * This file is named i40e_trace.h.
+ * This file is named iavf_trace.h.
  *
  * Since this include file's name is different from the trace
  * subsystem name, we'll have to define TRACE_INCLUDE_FILE at the end
@@ -23,14 +23,14 @@
 #include <linux/tracepoint.h>
 
 /**
- * i40e_trace() macro enables shared code to refer to trace points
+ * iavf_trace() macro enables shared code to refer to trace points
  * like:
  *
- * trace_i40e{,vf}_example(args...)
+ * trace_iavf{,vf}_example(args...)
  *
  * ... as:
  *
- * i40e_trace(example, args...)
+ * iavf_trace(example, args...)
  *
  * ... to resolve to the PF or VF version of the tracepoint without
  * ifdefs, and to allow tracepoints to be disabled entirely at build
@@ -39,18 +39,18 @@
  * Trace point should always be referred to in the driver via this
  * macro.
  *
- * Similarly, i40e_trace_enabled(trace_name) wraps references to
- * trace_i40e{,vf}_<trace_name>_enabled() functions.
+ * Similarly, iavf_trace_enabled(trace_name) wraps references to
+ * trace_iavf{,vf}_<trace_name>_enabled() functions.
  */
-#define _I40E_TRACE_NAME(trace_name) (trace_ ## iavf ## _ ## trace_name)
-#define I40E_TRACE_NAME(trace_name) _I40E_TRACE_NAME(trace_name)
+#define _IAVF_TRACE_NAME(trace_name) (trace_ ## iavf ## _ ## trace_name)
+#define IAVF_TRACE_NAME(trace_name) _IAVF_TRACE_NAME(trace_name)
 
-#define i40e_trace(trace_name, args...) I40E_TRACE_NAME(trace_name)(args)
+#define iavf_trace(trace_name, args...) IAVF_TRACE_NAME(trace_name)(args)
 
-#define i40e_trace_enabled(trace_name) I40E_TRACE_NAME(trace_name##_enabled)()
+#define iavf_trace_enabled(trace_name) IAVF_TRACE_NAME(trace_name##_enabled)()
 
 /* Events common to PF and VF. Corresponding versions will be defined
- * for both, named trace_i40e_* and trace_iavf_*. The i40e_trace()
+ * for both, named trace_iavf_* and trace_iavf_*. The iavf_trace()
  * macro above will select the right trace point name for the driver
  * being built from shared code.
  */
@@ -195,8 +195,8 @@ DEFINE_EVENT(
 
 /* Events unique to the VF. */
 
-#endif /* _I40E_TRACE_H_ */
-/* This must be outside ifdef _I40E_TRACE_H */
+#endif /* _IAVF_TRACE_H_ */
+/* This must be outside ifdef _IAVF_TRACE_H */
 
 /* This trace include file is not located in the .../include/trace
  * with the kernel tracepoint definitions, because we're a loadable
@@ -205,5 +205,5 @@ DEFINE_EVENT(
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE i40e_trace
+#define TRACE_INCLUDE_FILE iavf_trace
 #include <trace/define_trace.h>
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 66d9f1bf9467..5164e812f009 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -5,7 +5,7 @@
 #include <net/busy_poll.h>
 
 #include "iavf.h"
-#include "i40e_trace.h"
+#include "iavf_trace.h"
 #include "i40e_prototype.h"
 
 static inline __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
@@ -211,7 +211,7 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		/* prevent any other reads prior to eop_desc */
 		smp_rmb();
 
-		i40e_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
+		iavf_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
 		/* if the descriptor isn't done, no work yet to do */
 		if (!(eop_desc->cmd_type_offset_bsz &
 		      cpu_to_le64(IAVF_TX_DESC_DTYPE_DESC_DONE)))
@@ -239,7 +239,7 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 
 		/* unmap remaining buffers */
 		while (tx_desc != eop_desc) {
-			i40e_trace(clean_tx_irq_unmap,
+			iavf_trace(clean_tx_irq_unmap,
 				   tx_ring, tx_desc, tx_buf);
 
 			tx_buf++;
@@ -1503,7 +1503,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		if (!size)
 			break;
 
-		i40e_trace(clean_rx_irq, rx_ring, rx_desc, skb);
+		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
 		rx_buffer = i40e_get_rx_buffer(rx_ring, size);
 
 		/* retrieve a buffer from the ring */
@@ -1557,7 +1557,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		vlan_tag = (qword & BIT(IAVF_RX_DESC_STATUS_L2TAG1P_SHIFT)) ?
 			   le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1) : 0;
 
-		i40e_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
+		iavf_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
 		i40e_receive_skb(rx_ring, skb, vlan_tag);
 		skb = NULL;
 
@@ -2407,7 +2407,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	/* prefetch the data, we'll need it later */
 	prefetch(skb->data);
 
-	i40e_trace(xmit_frame_ring, skb, tx_ring);
+	iavf_trace(xmit_frame_ring, skb, tx_ring);
 
 	count = i40e_xmit_descriptor_count(skb);
 	if (i40e_chk_linearize(skb, count)) {
@@ -2476,7 +2476,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 out_drop:
-	i40e_trace(xmit_frame_ring_drop, first->skb, tx_ring);
+	iavf_trace(xmit_frame_ring_drop, first->skb, tx_ring);
 	dev_kfree_skb_any(first->skb);
 	first->skb = NULL;
 	return NETDEV_TX_OK;
-- 
2.14.4

