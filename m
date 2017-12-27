From: Daniel Hua <daniel.hua@ni.com>
Date: Wed, 27 Dec 2017 10:17:44 +0800
Subject: [Intel-wired-lan] [PATCH] igb: bug fix Tx interrupt is not triggered
In-Reply-To: <1514341064-8105-1-git-send-email-daniel.hua@ni.com>
References: <1514341064-8105-1-git-send-email-daniel.hua@ni.com>
Message-ID: <1514341064-8105-2-git-send-email-daniel.hua@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Daniel Hua <daniel.hua@ni.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 841c2a0..0746b19 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -643,6 +643,10 @@ static void igb_ptp_tx_work(struct work_struct *work)
 		adapter->ptp_tx_skb = NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 		return;
 	}
@@ -717,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
  */
 void igb_ptp_tx_hang(struct igb_adapter *adapter)
 {
+	struct e1000_hw *hw = &adapter->hw;
 	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
 					      IGB_PTP_TX_TIMEOUT);
 
@@ -736,6 +741,10 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 		adapter->ptp_tx_skb = NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 	}
 }
-- 
1.9.1

