From: Alice Michael <alice.michael@intel.com>
Date: Mon, 10 Apr 2017 05:18:43 -0400
Subject: [Intel-wired-lan] [next PATCH S67 v2 1/1] i40e: Fix support for
	flow director programming status
Message-ID: <20170410091843.12047-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch fixes an issue I introduced when I converted the code over to
using the length field to determine if a descriptor was done or not. It
turns out that we are also processing programming descriptors in the Rx
path and need to have these processed even though the length field will be
0 on these packets.  What will happen with a programming descriptor is that
we will receive a descriptor that has the SPH bit set, and the header
length and packet length fields cleared.

To account for this we should be checking for the bit for split header
being set even though we aren't actually using header split. This bit is
set in the length field to indicate if a programming descriptor response is
contained in the descriptor. Since we don't support header split we don't
need to perform the extra checks of using a fixed value for the entire
length field.

In addition I am moving the function for checking if a filter is a
programming status filter into the i40e_txrx.c file since there is no
longer support for FCoE it doesn't make sense to keep this file in i40e.h.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I12c359c3dc70adb9d6b92b27324bb2c7f04c1a06
---
Testing Hints:
	It is necessary to triggger filter configuration failures to see
	the programming status show up. In order to test it myself I had
	modified the driver to not evict ATR filters and ran a TCP_CRR
	test. Without this patch the test hangs, with it the test runs
	without errors.

 drivers/net/ethernet/intel/i40e/i40e.h        | 15 --------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 50 ++++++++++++++++++++-------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  9 ++---
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d4afbf1..a33a733 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -798,21 +798,6 @@ static inline void i40e_vsi_setup_irqhandler(struct i40e_vsi *vsi,
 }
 
 /**
- * i40e_rx_is_programming_status - check for programming status descriptor
- * @qw: the first quad word of the program status descriptor
- *
- * The value of in the descriptor length field indicate if this
- * is a programming status descriptor for flow director or FCoE
- * by the value of I40E_RX_PROG_STATUS_DESC_LENGTH, otherwise
- * it is a packet descriptor.
- **/
-static inline bool i40e_rx_is_programming_status(u64 qw)
-{
-	return I40E_RX_PROG_STATUS_DESC_LENGTH ==
-		(qw >> I40E_RX_PROG_STATUS_DESC_LENGTH_SHIFT);
-}
-
-/**
  * i40e_get_fd_cnt_all - get the total FD filter space available
  * @pf: pointer to the PF struct
  **/
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 3f2a39a..5f04929 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1038,9 +1038,29 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 }
 
 /**
+ * i40e_rx_is_programming_status - check for programming status descriptor
+ * @qw: qword representing status_error_len in CPU ordering
+ *
+ * The value of in the descriptor length field indicate if this
+ * is a programming status descriptor for flow director or FCoE
+ * by the value of I40E_RX_PROG_STATUS_DESC_LENGTH, otherwise
+ * it is a packet descriptor.
+ **/
+static inline bool i40e_rx_is_programming_status(u64 qw)
+{
+	/* The Rx filter programming status and SPH bit occupy the same
+	 * spot in the descriptor. Since we don't support packet split we
+	 * can just reuse the bit as an indication that this is a
+	 * programming status descriptor.
+	 */
+	return qw & I40E_RXD_QW1_LENGTH_SPH_MASK;
+}
+
+/**
  * i40e_clean_programming_status - clean the programming status descriptor
  * @rx_ring: the rx ring that has this descriptor
  * @rx_desc: the rx descriptor written back by HW
+ * @qw: qword representing status_error_len in CPU ordering
  *
  * Flow director should handle FD_FILTER_STATUS to check its filter programming
  * status being successful or not and take actions accordingly. FCoE should
@@ -1048,12 +1068,18 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
  *
  **/
 static void i40e_clean_programming_status(struct i40e_ring *rx_ring,
-					  union i40e_rx_desc *rx_desc)
+					  union i40e_rx_desc *rx_desc,
+					  u64 qw)
 {
-	u64 qw;
+	u32 ntc = rx_ring->next_to_clean + 1;
 	u8 id;
 
-	qw = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+	/* fetch, update, and store next to clean */
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+
+	prefetch(I40E_RX_DESC(rx_ring, ntc));
+
 	id = (qw & I40E_RX_PROG_STATUS_DESC_QW1_PROGID_MASK) >>
 		  I40E_RX_PROG_STATUS_DESC_QW1_PROGID_SHIFT;
 
@@ -1967,11 +1993,6 @@ static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
 
 	prefetch(I40E_RX_DESC(rx_ring, ntc));
 
-#define staterrlen rx_desc->wb.qword1.status_error_len
-	if (unlikely(i40e_rx_is_programming_status(le64_to_cpu(staterrlen)))) {
-		i40e_clean_programming_status(rx_ring, rx_desc);
-		return true;
-	}
 	/* if we are the last buffer then there is nothing else to do */
 #define I40E_RXD_EOF BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)
 	if (likely(i40e_test_staterr(rx_desc, I40E_RXD_EOF)))
@@ -2025,10 +2046,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 * hardware wrote DD then the length will be non-zero
 		 */
 		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-		size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
-		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
-		if (!size)
-			break;
 
 		/* This memory barrier is needed to keep us from reading
 		 * any other fields out of the rx_desc until we have
@@ -2036,6 +2053,15 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
+		if (unlikely(i40e_rx_is_programming_status(qword))) {
+			i40e_clean_programming_status(rx_ring, rx_desc, qword);
+			continue;
+		}
+		size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
+		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
+		if (!size)
+			break;
+
 		rx_buffer = i40e_get_rx_buffer(rx_ring, size);
 
 		/* retrieve a buffer from the ring */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index fc4b14a..80931e3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1317,10 +1317,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 * hardware wrote DD then the length will be non-zero
 		 */
 		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-		size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
-		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
-		if (!size)
-			break;
 
 		/* This memory barrier is needed to keep us from reading
 		 * any other fields out of the rx_desc until we have
@@ -1328,6 +1324,11 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
+		size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
+		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
+		if (!size)
+			break;
+
 		rx_buffer = i40e_get_rx_buffer(rx_ring, size);
 
 		/* retrieve a buffer from the ring */
-- 
2.9.3

