From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:28:56 -0700
Subject: [Intel-wired-lan] [PATCH v4 07/15] ixgbe: avoid permanent lock of
	*_PTP_TX_IN_PROGRESS
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ixgbe driver uses a state bit lock to avoid handling more than one Tx
timestamp request at once. This is required because hardware is limited
to a single set of registers for Tx timestamps.

The state bit lock is not properly cleaned up during
ixgbe_xmit_frame_ring() if the transmit fails such as due to DMA or TSO
failure. In some hardware this results in blocking timestamps until the
service task times out. In other hardware this results in a permanent
lock of the timestamp bit because we never receive an interrupt
indicating the timestamp occurred, since indeed the packet was never
transmitted.

Fix this by checking for DMA and TSO errors in ixgbe_xmit_frame_ring() and
properly cleaning up after ourselves when these occur.

Reported-by: Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a3b7d18924a5..f93330bc7b97 100644
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

