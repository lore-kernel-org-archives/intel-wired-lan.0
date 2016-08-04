From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Thu,  4 Aug 2016 11:37:03 -0700
Subject: [Intel-wired-lan] [next PATCH S41-V2 3/5] i40e: refactor tail_bump
	check
In-Reply-To: <1470335825-15534-1-git-send-email-bimmy.pujari@intel.com>
References: <1470335825-15534-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1470335825-15534-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch refactors tail bump check.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Ide0e19171d67d90cb2b06b8dcd4fa791ae120160
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 6 ++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5eb9ff2..266608a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2849,10 +2849,9 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 						  I40E_TXD_QW1_CMD_SHIFT);
 
 	/* notify HW of packet */
-	if (!tail_bump)
+	if (!tail_bump) {
 		prefetchw(tx_desc + 1);
-
-	if (tail_bump) {
+	} else {
 		/* Force memory writes to complete before letting h/w
 		 * know there are new descriptors to fetch.  (Only
 		 * applicable for weak-ordered memory model archs,
@@ -2861,7 +2860,6 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		wmb();
 		writel(i, tx_ring->tail);
 	}
-
 	return;
 
 dma_error:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 5968cc6..f3eb76f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -2086,10 +2086,9 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 						  I40E_TXD_QW1_CMD_SHIFT);
 
 	/* notify HW of packet */
-	if (!tail_bump)
+	if (!tail_bump) {
 		prefetchw(tx_desc + 1);
-
-	if (tail_bump) {
+	} else {
 		/* Force memory writes to complete before letting h/w
 		 * know there are new descriptors to fetch.  (Only
 		 * applicable for weak-ordered memory model archs,
@@ -2098,7 +2097,6 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		wmb();
 		writel(i, tx_ring->tail);
 	}
-
 	return;
 
 dma_error:
-- 
2.4.11

