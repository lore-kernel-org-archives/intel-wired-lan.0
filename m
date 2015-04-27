From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:21 -0400
Subject: [Intel-wired-lan] [net-next S5 14/15] i40e/i40evf: remove last_rx
	reference in receive
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver was suffering a slow down in RX performance
due to accessing this cache line from all receive queues,
which resulted in a performance improvement for
forwarding packets with this patch.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ie841a72289207eadf8a16b1013ffe83dfec6db1d
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 --
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 44aa93e..ecde75b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1658,7 +1658,6 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 		skb_mark_napi_id(skb, &rx_ring->q_vector->napi);
 		i40e_receive_skb(rx_ring, skb, vlan_tag);
 
-		rx_ring->netdev->last_rx = jiffies;
 		rx_desc->wb.qword1.status_error_len = 0;
 
 	} while (likely(total_rx_packets < budget));
@@ -1791,7 +1790,6 @@ static int i40e_clean_rx_irq_1buf(struct i40e_ring *rx_ring, int budget)
 #endif
 		i40e_receive_skb(rx_ring, skb, vlan_tag);
 
-		rx_ring->netdev->last_rx = jiffies;
 		rx_desc->wb.qword1.status_error_len = 0;
 	} while (likely(total_rx_packets < budget));
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index cce2e23..0e052ee 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1126,7 +1126,6 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 		skb_mark_napi_id(skb, &rx_ring->q_vector->napi);
 		i40e_receive_skb(rx_ring, skb, vlan_tag);
 
-		rx_ring->netdev->last_rx = jiffies;
 		rx_desc->wb.qword1.status_error_len = 0;
 
 	} while (likely(total_rx_packets < budget));
@@ -1241,7 +1240,6 @@ static int i40e_clean_rx_irq_1buf(struct i40e_ring *rx_ring, int budget)
 			 : 0;
 		i40e_receive_skb(rx_ring, skb, vlan_tag);
 
-		rx_ring->netdev->last_rx = jiffies;
 		rx_desc->wb.qword1.status_error_len = 0;
 	} while (likely(total_rx_packets < budget));
 
-- 
1.9.3

