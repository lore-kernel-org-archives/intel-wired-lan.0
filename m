From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 15 May 2020 18:29:48 -0700
Subject: [Intel-wired-lan] [next-queue RFC 4/4] igc: Add support for
 exposing frame preemption stats registers
In-Reply-To: <20200516012948.3173993-1-vinicius.gomes@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
Message-ID: <20200516012948.3173993-5-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[WIP]

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  9 +++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 48d5d18..09d72f7 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -322,6 +322,15 @@ static void igc_ethtool_get_regs(struct net_device *netdev,
 
 	for (i = 0; i < 8; i++)
 		regs_buff[205 + i] = rd32(IGC_ETQF(i));
+
+	regs_buff[214] = rd32(IGC_PRMPTDTCNT);
+	regs_buff[215] = rd32(IGC_PRMEVNTTCNT);
+	regs_buff[216] = rd32(IGC_PRMPTDRCNT);
+	regs_buff[217] = rd32(IGC_PRMEVNTRCNT);
+	regs_buff[218] = rd32(IGC_PRMPBLTCNT);
+	regs_buff[219] = rd32(IGC_PRMPBLRCNT);
+	regs_buff[220] = rd32(IGC_PRMEXPTCNT);
+	regs_buff[221] = rd32(IGC_PRMEXPRCNT);
 }
 
 static void igc_ethtool_get_wol(struct net_device *netdev,
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 7f999cf..010bb48 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -211,6 +211,16 @@
 
 #define IGC_FTQF(_n)	(0x059E0 + (4 * (_n)))  /* 5-tuple Queue Fltr */
 
+/* Time sync registers - preemption statistics */
+#define IGC_PRMPTDTCNT	0x04280  /* Good TX Preempted Packets */
+#define IGC_PRMEVNTTCNT	0x04298  /* TX Preemption event counter */
+#define IGC_PRMPTDRCNT	0x04284  /* Good RX Preempted Packets */
+#define IGC_PRMEVNTRCNT	0x0429C  /* RX Preemption event counter */
+#define IGC_PRMPBLTCNT	0x04288  /* Good TX Preemptable Packets */
+#define IGC_PRMPBLRCNT	0x0428C  /* Good RX Preemptable Packets */
+#define IGC_PRMEXPTCNT	0x04290  /* Good TX Express Packets */
+#define IGC_PRMEXPRCNT	0x042A0  /* Preemption Exception Counter */
+
 /* Transmit Scheduling Registers */
 #define IGC_TQAVCTRL		0x3570
 #define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
-- 
2.26.2

