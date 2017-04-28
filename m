From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 28 Apr 2017 10:16:52 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/5] net-intel: avoid permanent lock of
	*_PTP_TX_IN_PROGRESS
In-Reply-To: <20170428171655.13650-1-jacob.e.keller@intel.com>
References: <20170428171655.13650-1-jacob.e.keller@intel.com>
Message-ID: <20170428171655.13650-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several drivers share a pattern for Tx timestamping using a bit lock to
indicate when the timestamp is in progress so that multiple packets
cannot be timestamped at once. This is required because we only have one
set of Tx timestamp registers. There exist a few corner cases where we
were not properly cleaning up after ourselves on failure to transmit,
which potentially resulted in the state bit being locked forever.

Add some code at the end of the *_xmit_frame() routines to check and
make sure we cleanup in the case of failure. For the *_tx_map()
functions, we also need to add a return code to indicate when DMA
failure occurred.

This resolves a possible permanent lock of the PTP_TX_IN_PROGRESS bit
for igb, ixgbe, and i40e. The e1000e driver does not have the same
problem due to the ordering of the Tx flow.

Reported-by: Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 26 ++++++++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_main.c     | 23 ++++++++++++++++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++++++++++++++-----
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 29321a6167a6..19984be0f70c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2932,10 +2932,12 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
  * @hdr_len:  size of the packet header
  * @td_cmd:   the command field in the descriptor
  * @td_offset: offset for checksum or crc
+ *
+ * Returns 0 on success, -1 on failure to DMA
  **/
-static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
-			       struct i40e_tx_buffer *first, u32 tx_flags,
-			       const u8 hdr_len, u32 td_cmd, u32 td_offset)
+static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
+			      struct i40e_tx_buffer *first, u32 tx_flags,
+			      const u8 hdr_len, u32 td_cmd, u32 td_offset)
 {
 	unsigned int data_len = skb->data_len;
 	unsigned int size = skb_headlen(skb);
@@ -3093,7 +3095,7 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		mmiowb();
 	}
 
-	return;
+	return 0;
 
 dma_error:
 	dev_info(tx_ring->dev, "TX DMA map failed\n");
@@ -3110,6 +3112,8 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	}
 
 	tx_ring->next_to_use = i;
+
+	return -1;
 }
 
 /**
@@ -3210,8 +3214,9 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	 */
 	i40e_atr(tx_ring, skb, tx_flags);
 
-	i40e_tx_map(tx_ring, skb, first, tx_flags, hdr_len,
-		    td_cmd, td_offset);
+	if (i40e_tx_map(tx_ring, skb, first, tx_flags, hdr_len,
+			td_cmd, td_offset))
+		goto cleanup_tx_tstamp;
 
 	return NETDEV_TX_OK;
 
@@ -3219,6 +3224,15 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	i40e_trace(xmit_frame_ring_drop, first->skb, tx_ring);
 	dev_kfree_skb_any(first->skb);
 	first->skb = NULL;
+cleanup_tx_tstamp:
+	if (unlikely(tx_flags & I40E_TX_FLAGS_TSYN)) {
+		struct i40e_pf *pf = i40e_netdev_to_pf(tx_ring->netdev);
+
+		dev_kfree_skb_any(pf->ptp_tx_skb);
+		pf->ptp_tx_skb = NULL;
+		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+	}
+
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index dbb4e3cf7dbf..978908f426a7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5201,9 +5201,9 @@ static inline int igb_maybe_stop_tx(struct igb_ring *tx_ring, const u16 size)
 	return __igb_maybe_stop_tx(tx_ring, size);
 }
 
-static void igb_tx_map(struct igb_ring *tx_ring,
-		       struct igb_tx_buffer *first,
-		       const u8 hdr_len)
+static int igb_tx_map(struct igb_ring *tx_ring,
+		      struct igb_tx_buffer *first,
+		      const u8 hdr_len)
 {
 	struct sk_buff *skb = first->skb;
 	struct igb_tx_buffer *tx_buffer;
@@ -5314,7 +5314,7 @@ static void igb_tx_map(struct igb_ring *tx_ring,
 		 */
 		mmiowb();
 	}
-	return;
+	return 0;
 
 dma_error:
 	dev_err(tx_ring->dev, "TX DMA map failed\n");
@@ -5345,6 +5345,8 @@ static void igb_tx_map(struct igb_ring *tx_ring,
 	tx_buffer->skb = NULL;
 
 	tx_ring->next_to_use = i;
+
+	return -1;
 }
 
 netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
@@ -5410,13 +5412,24 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 	else if (!tso)
 		igb_tx_csum(tx_ring, first);
 
-	igb_tx_map(tx_ring, first, hdr_len);
+	if (igb_tx_map(tx_ring, first, hdr_len))
+		goto cleanup_tx_tstamp;
 
 	return NETDEV_TX_OK;
 
 out_drop:
 	dev_kfree_skb_any(first->skb);
 	first->skb = NULL;
+cleanup_tx_tstamp:
+	if (unlikely(tx_flags & IGB_TX_FLAGS_TSTAMP)) {
+		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
+
+		dev_kfree_skb_any(adapter->ptp_tx_skb);
+		adapter->ptp_tx_skb = NULL;
+		if (adapter->hw.mac.type == e1000_82576)
+			cancel_work_sync(&adapter->ptp_tx_work);
+		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
+	}
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 68d849346cdf..54bf0f9f5573 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7885,9 +7885,9 @@ static inline int ixgbe_maybe_stop_tx(struct ixgbe_ring *tx_ring, u16 size)
 #define IXGBE_TXD_CMD (IXGBE_TXD_CMD_EOP | \
 		       IXGBE_TXD_CMD_RS)
 
-static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
-			 struct ixgbe_tx_buffer *first,
-			 const u8 hdr_len)
+static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
+			struct ixgbe_tx_buffer *first,
+			const u8 hdr_len)
 {
 	struct sk_buff *skb = first->skb;
 	struct ixgbe_tx_buffer *tx_buffer;
@@ -8014,7 +8014,7 @@ static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 		mmiowb();
 	}
 
-	return;
+	return 0;
 dma_error:
 	dev_err(tx_ring->dev, "TX DMA map failed\n");
 	tx_buffer = &tx_ring->tx_buffer_info[i];
@@ -8044,6 +8044,8 @@ static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	first->skb = NULL;
 
 	tx_ring->next_to_use = i;
+
+	return -1;
 }
 
 static void ixgbe_atr(struct ixgbe_ring *ring,
@@ -8416,13 +8418,21 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 #ifdef IXGBE_FCOE
 xmit_fcoe:
 #endif /* IXGBE_FCOE */
-	ixgbe_tx_map(tx_ring, first, hdr_len);
+	if (ixgbe_tx_map(tx_ring, first, hdr_len))
+		goto cleanup_tx_timestamp;
 
 	return NETDEV_TX_OK;
 
 out_drop:
 	dev_kfree_skb_any(first->skb);
 	first->skb = NULL;
+cleanup_tx_timestamp:
+	if (unlikely(tx_flags & IXGBE_TX_FLAGS_TSTAMP)) {
+		dev_kfree_skb_any(adapter->ptp_tx_skb);
+		adapter->ptp_tx_skb = NULL;
+		cancel_work_sync(&adapter->ptp_tx_work);
+		clear_bit_unlock(__IXGBE_PTP_TX_IN_PROGRESS, &adapter->state);
+	}
 
 	return NETDEV_TX_OK;
 }
-- 
2.13.0.rc0.317.gcc792a6cad5a

