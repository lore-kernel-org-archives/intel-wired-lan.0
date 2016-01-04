From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:03 -0800
Subject: [Intel-wired-lan] [next PATCH S26 03/12] i40e: fix bug in dma sync
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-4-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Driver was using an offset based off a dma handle while mapping and
unmapping using sync_single_range_for[cpu|device], where it should
be using dma handle (returned from alloc_coherent) and the offset of the
memory to be sync'd.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Nelson, Shannon <shannon.nelson@intel.com>
Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
Change-ID: I208256565b1595ff0e9171ab852de06b997917c6
---
Testing-Hints:
Test traffic, test with DMA API debugging enabled.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 8 ++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7ea2689..7d81c1f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1218,8 +1218,8 @@ void i40e_alloc_rx_buffers_ps(struct i40e_ring *rx_ring, u16 cleaned_count)
 		}
 
 		dma_sync_single_range_for_device(rx_ring->dev,
-						 bi->dma,
-						 0,
+						 rx_ring->rx_bi[0].dma,
+						 i * rx_ring->rx_hdr_len,
 						 rx_ring->rx_hdr_len,
 						 DMA_FROM_DEVICE);
 		/* Refresh the desc even if buffer_addrs didn't change
@@ -1534,8 +1534,8 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 			skb_record_rx_queue(skb, rx_ring->queue_index);
 			/* we are reusing so sync this buffer for CPU use */
 			dma_sync_single_range_for_cpu(rx_ring->dev,
-						      rx_bi->dma,
-						      0,
+						      rx_ring->rx_bi[0].dma,
+						      i * rx_ring->rx_hdr_len,
 						      rx_ring->rx_hdr_len,
 						      DMA_FROM_DEVICE);
 		}
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 0e2c627..a1d907c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -699,8 +699,8 @@ void i40evf_alloc_rx_buffers_ps(struct i40e_ring *rx_ring, u16 cleaned_count)
 		}
 
 		dma_sync_single_range_for_device(rx_ring->dev,
-						 bi->dma,
-						 0,
+						 rx_ring->rx_bi[0].dma,
+						 i * rx_ring->rx_hdr_len,
 						 rx_ring->rx_hdr_len,
 						 DMA_FROM_DEVICE);
 		/* Refresh the desc even if buffer_addrs didn't change
@@ -1006,8 +1006,8 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 			skb_record_rx_queue(skb, rx_ring->queue_index);
 			/* we are reusing so sync this buffer for CPU use */
 			dma_sync_single_range_for_cpu(rx_ring->dev,
-						      rx_bi->dma,
-						      0,
+						      rx_ring->rx_bi[0].dma,
+						      i * rx_ring->rx_hdr_len,
 						      rx_ring->rx_hdr_len,
 						      DMA_FROM_DEVICE);
 		}
-- 
2.1.0

