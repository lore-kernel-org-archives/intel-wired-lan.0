From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 16:18:23 -0700
Subject: [Intel-wired-lan] [net v2 4/5] igb: implement igb_ptp_suspend
In-Reply-To: <20160511231824.22542-1-jacob.e.keller@intel.com>
References: <20160511231824.22542-1-jacob.e.keller@intel.com>
Message-ID: <20160511231824.22542-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make igb_ptp_stop take advantage of this new function to reduce code
duplication.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h     |  1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index fcba5ebba5ab..8f3e99cef9c2 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -550,6 +550,7 @@ void igb_set_fw_version(struct igb_adapter *);
 void igb_ptp_init(struct igb_adapter *adapter);
 void igb_ptp_stop(struct igb_adapter *adapter);
 void igb_ptp_reset(struct igb_adapter *adapter);
+void igb_ptp_suspend(struct igb_adapter *adapter);
 void igb_ptp_resume(struct igb_adapter *adapter);
 void igb_ptp_rx_hang(struct igb_adapter *adapter);
 void igb_ptp_rx_rgtstamp(struct igb_q_vector *q_vector, struct sk_buff *skb);
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 6c7d05d35894..a54c512deb45 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1162,12 +1162,13 @@ void igb_ptp_init(struct igb_adapter *adapter)
 }
 
 /**
- * igb_ptp_stop - Disable PTP device and stop the overflow check.
- * @adapter: Board private structure.
+ * igb_ptp_suspend - Disable PTP work items and prepare for suspend
+ * @adapter: Board private structure
  *
- * This function stops the PTP support and cancels the delayed work.
- **/
-void igb_ptp_stop(struct igb_adapter *adapter)
+ * This function stops the overflow check work and PTP Tx timestamp work, and
+ * will prepare the device for OS suspend.
+ */
+void igb_ptp_suspend(struct igb_adapter *adapter)
 {
 	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
 		return;
@@ -1181,6 +1182,17 @@ void igb_ptp_stop(struct igb_adapter *adapter)
 		adapter->ptp_tx_skb = NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 	}
+}
+
+/**
+ * igb_ptp_stop - Disable PTP device and stop the overflow check.
+ * @adapter: Board private structure.
+ *
+ * This function stops the PTP support and cancels the delayed work.
+ **/
+void igb_ptp_stop(struct igb_adapter *adapter)
+{
+	igb_ptp_suspend(adapter);
 
 	if (adapter->ptp_clock) {
 		ptp_clock_unregister(adapter->ptp_clock);
-- 
2.8.1.493.g7b22612

