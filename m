From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  2 Jul 2020 17:37:27 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/4] i40e,
 xsk: remove HW descriptor prefetch in AF_XDP path
In-Reply-To: <20200702153730.575738-1-bjorn.topel@gmail.com>
References: <20200702153730.575738-1-bjorn.topel@gmail.com>
Message-ID: <20200702153730.575738-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The software prefetching of HW descriptors has a negative impact on
the performance. Therefore, it is now removed.

Performance for the rx_drop benchmark increased with 2%.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 13 +++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx_common.h | 13 -------------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         | 12 ++++++++++++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 3e5c566ceb01..e1a76fc05b8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2299,6 +2299,19 @@ void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
 	}
 }
 
+/**
+ * i40e_inc_ntc: Advance the next_to_clean index
+ * @rx_ring: Rx ring
+ **/
+static void i40e_inc_ntc(struct i40e_ring *rx_ring)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+	prefetch(I40E_RX_DESC(rx_ring, ntc));
+}
+
 /**
  * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
  * @rx_ring: rx descriptor ring to transact packets on
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index 667c4dc4b39f..1397dd3c1c57 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -99,19 +99,6 @@ static inline bool i40e_rx_is_programming_status(u64 qword1)
 	return qword1 & I40E_RXD_QW1_LENGTH_SPH_MASK;
 }
 
-/**
- * i40e_inc_ntc: Advance the next_to_clean index
- * @rx_ring: Rx ring
- **/
-static inline void i40e_inc_ntc(struct i40e_ring *rx_ring)
-{
-	u32 ntc = rx_ring->next_to_clean + 1;
-
-	ntc = (ntc < rx_ring->count) ? ntc : 0;
-	rx_ring->next_to_clean = ntc;
-	prefetch(I40E_RX_DESC(rx_ring, ntc));
-}
-
 void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring);
 void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring);
 bool i40e_xsk_any_rx_ring_enabled(struct i40e_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 8ce57b507a21..1f2dd591dbf1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -253,6 +253,18 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	return skb;
 }
 
+/**
+ * i40e_inc_ntc: Advance the next_to_clean index
+ * @rx_ring: Rx ring
+ **/
+static void i40e_inc_ntc(struct i40e_ring *rx_ring)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+}
+
 /**
  * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
  * @rx_ring: Rx ring
-- 
2.25.1

