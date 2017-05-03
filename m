From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:28:52 -0700
Subject: [Intel-wired-lan] [PATCH v4 03/15] igb: fix race condition with
	PTP_TX_IN_PROGRESS bits
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hardware related to the igb driver has a limiation of only handling one
Tx timestamp at a time. Thus, the driver uses a state bit lock to
enforce that only one timestamp request is honored at a time.

Unfortunately this suffers from a simple race condition. The bit lock is
not cleared until after skb_tstamp_tx() is called notifying the stack of
a new Tx timestamp. Even a well behaved application which sends only one
timestamp request at once and waits for a response might wake up and
send a new packet before the bit lock is cleared. This results in
needlessly dropping some Tx timestamp requests.

We can fix this by unlocking the state bit as soon as we read the
Timestamp register, as this is the first point at which it is safe to
unlock.

To avoid issues with the skb pointer, we'll use a copy of the pointer
and set the global variable in the driver structure to NULL first. This
ensures that the next timestamp request does not modify our local copy
of the skb pointer.

This ensures that well behaved applications do not accidentally race
with the unlock bit. Obviously an application which sends multiple Tx
timestamp requests at once will still only timestamp one packet at
a time. Unfortunately there is nothing we can do about this.

Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 7a3fd4d74592..a2da5738bfb5 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -721,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
  **/
 static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 {
+	struct sk_buff *skb = adapter->ptp_tx_skb;
 	struct e1000_hw *hw = &adapter->hw;
 	struct skb_shared_hwtstamps shhwtstamps;
 	u64 regval;
@@ -748,10 +749,17 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 	shhwtstamps.hwtstamp =
 		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
 
-	skb_tstamp_tx(adapter->ptp_tx_skb, &shhwtstamps);
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	/* Clear the lock early before calling skb_tstamp_tx so that
+	 * applications are not woken up before the lock bit is clear. We use
+	 * a copy of the skb pointer to ensure other threads can't change it
+	 * while we're notifying the stack.
+	 */
 	adapter->ptp_tx_skb = NULL;
 	clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
+
+	/* Notify the stack and free the skb after we've unlocked */
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
 }
 
 /**
-- 
2.13.0.rc0.317.gcc792a6cad5a

