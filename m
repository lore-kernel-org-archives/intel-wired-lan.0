From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 18 Jan 2021 16:40:23 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 3/8] igc: Set the RX packet
 buffer size for TSN mode
In-Reply-To: <20210119004028.2809425-1-vinicius.gomes@intel.com>
References: <20210119004028.2809425-1-vinicius.gomes@intel.com>
Message-ID: <20210119004028.2809425-4-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation for supporting frame preemption, when entering TSN mode
set the receive packet buffer to 16KB for the Express MAC, 16KB for
the Preemptible MAC and 2KB for the BMC, according to the datasheet
section 7.1.3.2.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  2 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 32f5fd684139..0e78abfd99ee 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -351,6 +351,8 @@
 #define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
 
 #define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
+#define IGC_RXPBSIZE_TSN	0x00010090 /* 16KB for EXP + 16KB for BE + 2KB for BMC */
+#define IGC_RXPBSIZE_SIZE_MASK	0x0001FFFF
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 174103c4bea6..38451cf05ac6 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -24,7 +24,7 @@ static bool is_any_launchtime(struct igc_adapter *adapter)
 static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
-	u32 tqavctrl;
+	u32 tqavctrl, rxpbs;
 	int i;
 
 	if (!(adapter->flags & IGC_FLAG_TSN_QBV_ENABLED))
@@ -35,6 +35,11 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
+	rxpbs = rd32(IGC_RXPBS) & ~IGC_RXPBSIZE_SIZE_MASK;
+	rxpbs |= I225_RXPBSIZE_DEFAULT;
+
+	wr32(IGC_RXPBS, rxpbs);
+
 	tqavctrl = rd32(IGC_TQAVCTRL);
 	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
 		      IGC_TQAVCTRL_ENHANCED_QAV);
@@ -64,7 +69,7 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
 	u32 tqavctrl, baset_l, baset_h;
-	u32 sec, nsec, cycle;
+	u32 sec, nsec, cycle, rxpbs;
 	ktime_t base_time, systim;
 	int i;
 
@@ -79,6 +84,11 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
 	tqavctrl = rd32(IGC_TQAVCTRL);
+	rxpbs = rd32(IGC_RXPBS) & ~IGC_RXPBSIZE_SIZE_MASK;
+	rxpbs |= IGC_RXPBSIZE_TSN;
+
+	wr32(IGC_RXPBS, rxpbs);
+
 	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
 	wr32(IGC_TQAVCTRL, tqavctrl);
 
-- 
2.30.0

