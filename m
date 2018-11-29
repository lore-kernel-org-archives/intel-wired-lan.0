From: =?unknown-8bit?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 29 Nov 2018 14:50:07 +0100
Subject: [Intel-wired-lan] [PATCH net 2/2] i40e: DRY rx_ptype handling code
In-Reply-To: <90749780c319ce8901aec8b42216f506f5e93c2a.1543499290.git.mirq-linux@rere.qmqm.pl>
References: <90749780c319ce8901aec8b42216f506f5e93c2a.1543499290.git.mirq-linux@rere.qmqm.pl>
Message-ID: <f359246e863f245651cd936fdb619e47569ac4aa.1543499290.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move rx_ptype extracting to i40e_process_skb_fields() to avoid
duplicating the code.

Signed-off-by: Micha? Miros?aw <michal.miroslaw@atendesoftware.pl>
Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 12 ++++--------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  6 +-----
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2cd69c65d722..48872d51fd31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1775,8 +1775,7 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
  * other fields within the skb.
  **/
 void i40e_process_skb_fields(struct i40e_ring *rx_ring,
-			     union i40e_rx_desc *rx_desc, struct sk_buff *skb,
-			     u8 rx_ptype)
+			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
 {
 	u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
 	u32 rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
@@ -1784,6 +1783,8 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 	u32 tsynvalid = rx_status & I40E_RXD_QW1_STATUS_TSYNVALID_MASK;
 	u32 tsyn = (rx_status & I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
 		   I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT;
+	u8 rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
+		      I40E_RXD_QW1_PTYPE_SHIFT;
 
 	if (unlikely(tsynvalid))
 		i40e_ptp_rx_hwtstamp(rx_ring->vsi->back, skb, tsyn);
@@ -2338,7 +2339,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		struct i40e_rx_buffer *rx_buffer;
 		union i40e_rx_desc *rx_desc;
 		unsigned int size;
-		u8 rx_ptype;
 		u64 qword;
 
 		/* return some buffers to hardware, one at a time is too slow */
@@ -2431,12 +2431,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
 
-		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-		rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
-			   I40E_RXD_QW1_PTYPE_SHIFT;
-
 		/* populate checksum, VLAN, and protocol */
-		i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
+		i40e_process_skb_fields(rx_ring, rx_desc, skb);
 
 		i40e_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index e783a872707c..605d839d99e3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -634,7 +634,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		struct i40e_rx_buffer *bi;
 		union i40e_rx_desc *rx_desc;
 		unsigned int size;
-		u8 rx_ptype;
 		u64 qword;
 
 		if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
@@ -712,10 +711,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
 
-		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-		rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
-			   I40E_RXD_QW1_PTYPE_SHIFT;
-		i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
+		i40e_process_skb_fields(rx_ring, rx_desc, skb);
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 	}
 
-- 
2.19.2

