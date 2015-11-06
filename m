From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:03 -0800
Subject: [Intel-wired-lan] [next PATCH S21 05/14] i40e: Fix memory leaks,
	sideband filter programming
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-6-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

This patch fixes the memory leak which would be seen otherwise when user
programs flow-director filter using ethtool (sideband filter programming).

When ethtool is used to program flow directory filter, 'raw_buf' gets
allocated and it is supposed to be freed as part of queue cleanup. But
check of 'tx_buffer->skb' was preventing it from being freed.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-ID: Ief4f0a1a32a653180498bf6e987c1b4342ab8923
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 19 ++++++++++++++-----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 10 +++++-----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9be0a90..a22efca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -235,6 +235,9 @@ static int i40e_add_del_fdir_udpv4(struct i40e_vsi *vsi,
 				 "Filter deleted for PCTYPE %d loc = %d\n",
 				 fd_data->pctype, fd_data->fd_id);
 	}
+	if (err)
+		kfree(raw_packet);
+
 	return err ? -EOPNOTSUPP : 0;
 }
 
@@ -312,6 +315,9 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 				 fd_data->pctype, fd_data->fd_id);
 	}
 
+	if (err)
+		kfree(raw_packet);
+
 	return err ? -EOPNOTSUPP : 0;
 }
 
@@ -387,6 +393,9 @@ static int i40e_add_del_fdir_ipv4(struct i40e_vsi *vsi,
 		}
 	}
 
+	if (err)
+		kfree(raw_packet);
+
 	return err ? -EOPNOTSUPP : 0;
 }
 
@@ -526,11 +535,7 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 					    struct i40e_tx_buffer *tx_buffer)
 {
 	if (tx_buffer->skb) {
-		if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
-			kfree(tx_buffer->raw_buf);
-		else
-			dev_kfree_skb_any(tx_buffer->skb);
-
+		dev_kfree_skb_any(tx_buffer->skb);
 		if (dma_unmap_len(tx_buffer, len))
 			dma_unmap_single(ring->dev,
 					 dma_unmap_addr(tx_buffer, dma),
@@ -542,6 +547,10 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 			       dma_unmap_len(tx_buffer, len),
 			       DMA_TO_DEVICE);
 	}
+
+	if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
+		kfree(tx_buffer->raw_buf);
+
 	tx_buffer->next_to_watch = NULL;
 	tx_buffer->skb = NULL;
 	dma_unmap_len_set(tx_buffer, len, 0);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 3a531fe..4e6aacb 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -51,11 +51,7 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 					    struct i40e_tx_buffer *tx_buffer)
 {
 	if (tx_buffer->skb) {
-		if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
-			kfree(tx_buffer->raw_buf);
-		else
-			dev_kfree_skb_any(tx_buffer->skb);
-
+		dev_kfree_skb_any(tx_buffer->skb);
 		if (dma_unmap_len(tx_buffer, len))
 			dma_unmap_single(ring->dev,
 					 dma_unmap_addr(tx_buffer, dma),
@@ -67,6 +63,10 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 			       dma_unmap_len(tx_buffer, len),
 			       DMA_TO_DEVICE);
 	}
+
+	if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
+		kfree(tx_buffer->raw_buf);
+
 	tx_buffer->next_to_watch = NULL;
 	tx_buffer->skb = NULL;
 	dma_unmap_len_set(tx_buffer, len, 0);
-- 
2.1.0

