From: Ruud Bos <kernel.hbk@gmail.com>
Date: Thu, 28 Oct 2021 16:34:56 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 1/4] igb: move SDP config
 initialization to separate function
In-Reply-To: <20211028143459.903439-1-kernel.hbk@gmail.com>
References: <20211028143459.903439-1-kernel.hbk@gmail.com>
Message-ID: <20211028143459.903439-2-kernel.hbk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Allow reuse of SDP config struct initialization by moving it to a
separate function.

Signed-off-by: Ruud Bos <kernel.hbk@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 27 +++++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 0011b15e678c..c78d0c2a5341 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -69,6 +69,7 @@
 #define IGB_NBITS_82580			40
 
 static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter);
+static void igb_ptp_sdp_init(struct igb_adapter *adapter);
 
 /* SYSTIM read access for the 82576 */
 static u64 igb_ptp_read_82576(const struct cyclecounter *cc)
@@ -1192,7 +1193,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	struct net_device *netdev = adapter->netdev;
-	int i;
 
 	switch (hw->mac.type) {
 	case e1000_82576:
@@ -1233,13 +1233,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		break;
 	case e1000_i210:
 	case e1000_i211:
-		for (i = 0; i < IGB_N_SDP; i++) {
-			struct ptp_pin_desc *ppd = &adapter->sdp_config[i];
-
-			snprintf(ppd->name, sizeof(ppd->name), "SDP%d", i);
-			ppd->index = i;
-			ppd->func = PTP_PF_NONE;
-		}
+		igb_ptp_sdp_init(adapter);
 		snprintf(adapter->ptp_caps.name, 16, "%pm", netdev->dev_addr);
 		adapter->ptp_caps.owner = THIS_MODULE;
 		adapter->ptp_caps.max_adj = 62499999;
@@ -1284,6 +1278,23 @@ void igb_ptp_init(struct igb_adapter *adapter)
 	}
 }
 
+/**
+ * igb_ptp_sdp_init - utility function which inits the SDP config structs
+ * @adapter: Board private structure.
+ **/
+void igb_ptp_sdp_init(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < IGB_N_SDP; i++) {
+		struct ptp_pin_desc *ppd = &adapter->sdp_config[i];
+
+		snprintf(ppd->name, sizeof(ppd->name), "SDP%d", i);
+		ppd->index = i;
+		ppd->func = PTP_PF_NONE;
+	}
+}
+
 /**
  * igb_ptp_suspend - Disable PTP work items and prepare for suspend
  * @adapter: Board private structure
-- 
2.30.2

