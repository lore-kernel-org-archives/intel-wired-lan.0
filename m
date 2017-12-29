From: Daniel Hua <daniel.hua@ni.com>
Date: Fri, 29 Dec 2017 16:02:32 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Clear TXSTMP when ptp_tx_work() is
 timeout
Message-ID: <1514534552-10574-1-git-send-email-daniel.hua@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Daniel Hua <daniel.hua@ni.com>
---
Problem description:
After ethernet cable connect and disconnect for several iterations on a
device with i210, tx timestamp will stop being put into the socket.

Steps to reproduce:
1. Setup a device with i210 and wire it to a 802.1AS capable switch (
Extreme Networks Summit x440 is used in our case)
2. Have the gptp daemon running on the device and make sure it is synced 
with the switch
3. Have the switch disable and enable the port, wait for the device gets
resynced with the switch
4. Iterates step 3 until the device is not albe to get resynced
5. Review the log in dmesg and you will see warning message "igb : clearing
Tx timestamp hang"

Root cause:
If ptp_tx_work() gets scheduled just before the port gets disabled, a LINK
DOWN event will be processed before ptp_tx_work(), which may cause timeout
in ptp_tx_work(). In the timeout logic, the TSYNCTXCTL's TXTT bit (Transmit
timestamp valid bit) is not cleared, causing no new timestamp loaded to
TXSTMP register. Consequently therefore, no new interrupt is triggerred by
TSICR.TXTS bit and no more Tx timestamp send to the socket.
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

