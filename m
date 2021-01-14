From: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Date: Thu, 14 Jan 2021 14:33:16 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/4] i40e: remove unnecessary
 cleaned_count updates
In-Reply-To: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
References: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
Message-ID: <20210114143318.2171-3-cristian.dumitrescu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For performance reasons, remove the redundant updates of the cleaned_count
variable, as its value can be computed based on the ring next-to-clean
variable, which is consistently udpated.

Signed-off-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index dc11ecd1a55c..453ef30d9498 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -300,7 +300,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			bi = i40e_rx_bi(rx_ring, next_to_clean);
 			xsk_buff_free(*bi);
 			*bi = NULL;
-			cleaned_count++;
 			next_to_clean = (next_to_clean + 1) & count_mask;
 			continue;
 		}
@@ -325,7 +324,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			total_rx_bytes += size;
 			total_rx_packets++;
 
-			cleaned_count++;
 			next_to_clean = (next_to_clean + 1) & count_mask;
 			continue;
 		}
@@ -344,7 +342,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			break;
 		}
 
-		cleaned_count++;
 		next_to_clean = (next_to_clean + 1) & count_mask;
 
 		if (eth_skb_pad(skb))
@@ -358,6 +355,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 	}
 
 	rx_ring->next_to_clean = next_to_clean;
+	cleaned_count = (next_to_clean - rx_ring->next_to_use - 1) & count_mask;
 
 	if (cleaned_count >= I40E_RX_BUFFER_WRITE)
 		failure = !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
-- 
2.25.1

