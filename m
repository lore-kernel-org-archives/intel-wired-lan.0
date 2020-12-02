From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue,  1 Dec 2020 20:53:24 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 8/9] igc: Add support for
 exposing frame preemption stats registers
In-Reply-To: <20201202045325.3254757-1-vinicius.gomes@intel.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
Message-ID: <20201202045325.3254757-9-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Expose the Frame Preemption counters, so the number of
express/preemptible packets can be monitored by userspace.

These registers are cleared when read, so the value shown is the
number of events that happened since the last read.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  8 ++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 492c6592c150..14a14a61de45 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -325,6 +325,14 @@ static void igc_ethtool_get_regs(struct net_device *netdev,
 
 	regs_buff[213] = adapter->stats.tlpic;
 	regs_buff[214] = adapter->stats.rlpic;
+	regs_buff[215] = rd32(IGC_PRMPTDTCNT);
+	regs_buff[216] = rd32(IGC_PRMEVNTTCNT);
+	regs_buff[217] = rd32(IGC_PRMPTDRCNT);
+	regs_buff[218] = rd32(IGC_PRMEVNTRCNT);
+	regs_buff[219] = rd32(IGC_PRMPBLTCNT);
+	regs_buff[220] = rd32(IGC_PRMPBLRCNT);
+	regs_buff[221] = rd32(IGC_PRMEXPTCNT);
+	regs_buff[222] = rd32(IGC_PRMEXPRCNT);
 }
 
 static void igc_ethtool_get_wol(struct net_device *netdev,
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index b52dd9d737e8..69e295d69d84 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -197,6 +197,16 @@
 
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
2.29.2

