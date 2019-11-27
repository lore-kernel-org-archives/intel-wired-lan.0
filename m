From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 26 Nov 2019 17:04:35 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 5/5] igc: Use Start of
 Packet signal from PHY for timestamping
In-Reply-To: <20191127010435.1733698-1-vinicius.gomes@intel.com>
References: <20191127010435.1733698-1-vinicius.gomes@intel.com>
Message-ID: <20191127010435.1733698-6-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For better accuracy, i225 is able to do timestamping using the Start of
Packet signal from the PHY.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 ++
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index e978fd484fc8..8e1f2e27cc0b 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -364,6 +364,7 @@
 #define IGC_TSYNCRXCTL_TYPE_EVENT_V2	0x0A
 #define IGC_TSYNCRXCTL_ENABLED		0x00000010  /* enable Rx timestamping */
 #define IGC_TSYNCRXCTL_SYSCFI		0x00000020  /* Sys clock frequency */
+#define IGC_TSYNCRXCTL_RXSYNSIG		0x00000400  /* Sample RX tstamp in PHY sop */
 
 /* Time Sync Receive Configuration */
 #define IGC_TSYNCRXCFG_PTP_V1_CTRLT_MASK	0x000000FF
@@ -387,6 +388,7 @@
 #define IGC_TSYNCTXCTL_SYNC_COMP_ERR		0x20000000  /* sync err */
 #define IGC_TSYNCTXCTL_SYNC_COMP		0x40000000  /* sync complete */
 #define IGC_TSYNCTXCTL_START_SYNC		0x80000000  /* initiate sync */
+#define IGC_TSYNCTXCTL_TXSYNSIG			0x00000020  /* Sample TX tstamp in PHY sop */
 
 /* Receive Checksum Control */
 #define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index b63a03157ec1..86ca93cb2fc5 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -368,6 +368,7 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	if (tsync_rx_ctl) {
 		tsync_rx_ctl = IGC_TSYNCRXCTL_ENABLED;
 		tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_ALL;
+		tsync_rx_ctl |= IGC_TSYNCRXCTL_RXSYNSIG;
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		is_l2 = true;
 		is_l4 = true;
@@ -384,8 +385,10 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 		}
 	}
 
-	if (tsync_tx_ctl)
+	if (tsync_tx_ctl) {
 		tsync_tx_ctl = IGC_TSYNCTXCTL_ENABLED;
+		tsync_tx_ctl |= IGC_TSYNCTXCTL_TXSYNSIG;
+	}
 
 	/* enable/disable TX */
 	regval = rd32(IGC_TSYNCTXCTL);
-- 
2.24.0

