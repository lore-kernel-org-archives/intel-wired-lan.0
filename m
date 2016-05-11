From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 16:18:20 -0700
Subject: [Intel-wired-lan] [net v2 1/5] igb: introduce ptp_flags variable
	and use it to replace IGB_FLAG_PTP
In-Reply-To: <20160511231824.22542-1-jacob.e.keller@intel.com>
References: <20160511231824.22542-1-jacob.e.keller@intel.com>
Message-ID: <20160511231824.22542-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Upcoming patches will introduce new PTP specific flags. To avoid
cluttering the normal flags variable, introduce PTP specific "ptp_flags"
variable for this purpose, and move IGB_FLAG_PTP to become
IGB_PTP_ENABLED.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h     | 5 ++++-
 drivers/net/ethernet/intel/igb/igb_ptp.c | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index b9609afa5ca3..1e18a9eb16e0 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -445,6 +445,7 @@ struct igb_adapter {
 	unsigned long ptp_tx_start;
 	unsigned long last_rx_ptp_check;
 	unsigned long last_rx_timestamp;
+	unsigned int ptp_flags;
 	spinlock_t tmreg_lock;
 	struct cyclecounter cc;
 	struct timecounter tc;
@@ -474,12 +475,14 @@ struct igb_adapter {
 	u16 eee_advert;
 };
 
+/* flags controlling PTP/1588 function */
+#define IGB_PTP_ENABLED		BIT(0)
+
 #define IGB_FLAG_HAS_MSI		BIT(0)
 #define IGB_FLAG_DCA_ENABLED		BIT(1)
 #define IGB_FLAG_QUAD_PORT_A		BIT(2)
 #define IGB_FLAG_QUEUE_PAIRS		BIT(3)
 #define IGB_FLAG_DMAC			BIT(4)
-#define IGB_FLAG_PTP			BIT(5)
 #define IGB_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGB_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
 #define IGB_FLAG_WOL_SUPPORTED		BIT(8)
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index f097c5a8ab93..88e3b40415a1 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -684,7 +684,7 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
 	u32 tsyncrxctl = rd32(E1000_TSYNCRXCTL);
 	unsigned long rx_event;
 
-	if (hw->mac.type != e1000_82576)
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
 		return;
 
 	/* If we don't have a valid timestamp in the registers, just update the
@@ -1156,7 +1156,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 	} else {
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
-		adapter->flags |= IGB_FLAG_PTP;
+		adapter->ptp_flags |= IGB_PTP_ENABLED;
 	}
 }
 
@@ -1194,7 +1194,7 @@ void igb_ptp_stop(struct igb_adapter *adapter)
 		ptp_clock_unregister(adapter->ptp_clock);
 		dev_info(&adapter->pdev->dev, "removed PHC on %s\n",
 			 adapter->netdev->name);
-		adapter->flags &= ~IGB_FLAG_PTP;
+		adapter->ptp_flags &= ~IGB_PTP_ENABLED;
 	}
 }
 
@@ -1209,7 +1209,7 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned long flags;
 
-	if (!(adapter->flags & IGB_FLAG_PTP))
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
 		return;
 
 	/* reset the tstamp_config */
-- 
2.8.1.493.g7b22612

