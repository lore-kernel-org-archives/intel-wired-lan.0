From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed,  2 Sep 2020 16:36:56 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v1 1/2] igc: Export a way to
 read the PTP timer
Message-ID: <20200902233657.4051914-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The next patch will need a way to retrieve the current timestamp from
the NIC's PTP clock.

The 'i225' suffix is removed, if anything model specific is needed,
those specifics should be hidden by this function.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h     | 1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 2e5720d34a16..35baae900c1f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -550,6 +550,7 @@ void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, void *va,
 int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
+void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
 
 #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 344bb67018f1..927af8ae2bef 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -17,8 +17,7 @@
 #define IGC_PTP_TX_TIMEOUT		(HZ * 15)
 
 /* SYSTIM read access for I225 */
-static void igc_ptp_read_i225(struct igc_adapter *adapter,
-			      struct timespec64 *ts)
+void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts)
 {
 	struct igc_hw *hw = &adapter->hw;
 	u32 sec, nsec;
@@ -75,7 +74,7 @@ static int igc_ptp_adjtime_i225(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&igc->tmreg_lock, flags);
 
-	igc_ptp_read_i225(igc, &now);
+	igc_ptp_read(igc, &now);
 	now = timespec64_add(now, then);
 	igc_ptp_write_i225(igc, (const struct timespec64 *)&now);
 
@@ -517,7 +516,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 
 static void igc_ptp_time_save(struct igc_adapter *adapter)
 {
-	igc_ptp_read_i225(adapter, &adapter->prev_ptp_time);
+	igc_ptp_read(adapter, &adapter->prev_ptp_time);
 	adapter->ptp_reset_start = ktime_get();
 }
 
-- 
2.28.0

