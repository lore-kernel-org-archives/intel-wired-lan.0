From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:08 -0400
Subject: [Intel-wired-lan] [net-next S5 01/15] i40e/i40evf: improve tx
	performance with a small tweak
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Add a prefetch for the next tx descriptor to be used when we know
there are more coming.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ibb9acab11d508eec2db7da795df74debc16eeacb
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 ++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e1596dc..74022ac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2623,6 +2623,8 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	    netif_xmit_stopped(netdev_get_tx_queue(tx_ring->netdev,
 						   tx_ring->queue_index)))
 		writel(i, tx_ring->tail);
+	else
+		prefetchw(tx_desc + 1);
 
 	return;
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 11de5a5..e629762 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1844,6 +1844,8 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	    netif_xmit_stopped(netdev_get_tx_queue(tx_ring->netdev,
 						   tx_ring->queue_index)))
 		writel(i, tx_ring->tail);
+	else
+		prefetchw(tx_desc + 1);
 
 	return;
 
-- 
1.9.3

