From: Andre Guedes <andre.guedes@intel.com>
Date: Wed,  3 Jun 2020 17:01:01 -0700
Subject: [Intel-wired-lan] [PATCH 2/6] igc: Remove duplicate code in tx
 timestamp handling
In-Reply-To: <20200604000105.15059-1-andre.guedes@intel.com>
References: <20200604000105.15059-1-andre.guedes@intel.com>
Message-ID: <20200604000105.15059-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The functions igc_ptp_tx_hang() and igc_ptp_tx_work() have duplicate
code which handles tx timestamp timeouts. This patch does a trivial
refactoring by moving that code to its own function and reusing it.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 34 +++++++++++-------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 82e6c6c962d5..b1b23c6bf689 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -386,11 +386,23 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	return 0;
 }
 
+static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	adapter->ptp_tx_skb = NULL;
+	adapter->tx_hwtstamp_timeouts++;
+	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
+	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
+	rd32(IGC_TXSTMPH);
+	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
+}
+
 void igc_ptp_tx_hang(struct igc_adapter *adapter)
 {
 	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
 					      IGC_PTP_TX_TIMEOUT);
-	struct igc_hw *hw = &adapter->hw;
 
 	if (!adapter->ptp_tx_skb)
 		return;
@@ -404,15 +416,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
 	 */
 	if (timeout) {
 		cancel_work_sync(&adapter->ptp_tx_work);
-		dev_kfree_skb_any(adapter->ptp_tx_skb);
-		adapter->ptp_tx_skb = NULL;
-		clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
-		adapter->tx_hwtstamp_timeouts++;
-		/* Clear the Tx valid bit in TSYNCTXCTL register to enable
-		 * interrupt
-		 */
-		rd32(IGC_TXSTMPH);
-		netdev_warn(adapter->netdev, "Clearing Tx timestamp hang\n");
+		igc_ptp_tx_timeout(adapter);
 	}
 }
 
@@ -467,15 +471,7 @@ static void igc_ptp_tx_work(struct work_struct *work)
 
 	if (time_is_before_jiffies(adapter->ptp_tx_start +
 				   IGC_PTP_TX_TIMEOUT)) {
-		dev_kfree_skb_any(adapter->ptp_tx_skb);
-		adapter->ptp_tx_skb = NULL;
-		clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
-		adapter->tx_hwtstamp_timeouts++;
-		/* Clear the tx valid bit in TSYNCTXCTL register to enable
-		 * interrupt
-		 */
-		rd32(IGC_TXSTMPH);
-		netdev_warn(adapter->netdev, "Clearing Tx timestamp hang\n");
+		igc_ptp_tx_timeout(adapter);
 		return;
 	}
 
-- 
2.26.2

