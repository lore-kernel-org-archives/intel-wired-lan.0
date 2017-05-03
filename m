From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:28:58 -0700
Subject: [Intel-wired-lan] [PATCH v4 09/15] i40e: add statistic indicating
	number of skipped Tx timestamps
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-10-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The i40e driver can only handle one Tx timestamp request at a time.
This means it is possible for an application timestamp request to be
ignored.

There is no easy way for an administrator to determine if this occurred.
Add a new statistic which tracks this, tx_hwtstamp_skipped.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index cdde3cc28fb5..aa46ae016539 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -506,6 +506,7 @@ struct i40e_pf {
 	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
 	u64 ptp_base_adj;
 	u32 tx_hwtstamp_timeouts;
+	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
 	u32 latch_event_flags;
 	spinlock_t ptp_rx_lock; /* Used to protect Rx timestamp registers. */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 7a8eb486b9ea..35a246f05520 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -147,6 +147,7 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("VF_admin_queue_requests", vf_aq_requests),
 	I40E_PF_STAT("arq_overflows", arq_overflows),
 	I40E_PF_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
+	I40E_PF_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
 	I40E_PF_STAT("fdir_flush_cnt", fd_flush_cnt),
 	I40E_PF_STAT("fdir_atr_match", stats.fd_atr_match),
 	I40E_PF_STAT("fdir_atr_tunnel_match", stats.fd_atr_tunnel_match),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 19984be0f70c..c69ee4b0cfe2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2630,6 +2630,7 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		pf->ptp_tx_skb = skb_get(skb);
 	} else {
+		pf->tx_hwtstamp_skipped++;
 		return 0;
 	}
 
-- 
2.13.0.rc0.317.gcc792a6cad5a

