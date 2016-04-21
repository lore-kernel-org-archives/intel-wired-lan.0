From: Preethi Banala <preethi.banala@intel.com>
Date: Thu, 21 Apr 2016 11:28:57 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] ethtool/ixgbe: Reduce format string
	storage
In-Reply-To: <20160421182545.13330.59497.stgit@ixgbe-dev.jf.intel.com>
References: <20160421182545.13330.59497.stgit@ixgbe-dev.jf.intel.com>
Message-ID: <20160421182856.13330.56812.stgit@ixgbe-dev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce format string storage using for loop.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
---
 ixgbe.c |   57 ++++++++++++---------------------------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/ixgbe.c b/ixgbe.c
index 4f5af779f763..ff0e769cb7a8 100644
--- a/ixgbe.c
+++ b/ixgbe.c
@@ -1193,21 +1193,10 @@ ixgbe_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
 		"0x07F08: TDHMPN      (Tx Desc Handler Mem Page Num)   0x%08X\n",
 		regs_buff[1095]);
 
-	fprintf(stdout,
-		"0x07F10: TIC_DW0     (Tx Desc Hand. Mem Read Data 0)  0x%08X\n",
-		regs_buff[1096]);
-
-	fprintf(stdout,
-		"0x07F14: TIC_DW1     (Tx Desc Hand. Mem Read Data 1)  0x%08X\n",
-		regs_buff[1097]);
-
-	fprintf(stdout,
-		"0x07F18: TIC_DW2     (Tx Desc Hand. Mem Read Data 2)  0x%08X\n",
-		regs_buff[1098]);
-
-	fprintf(stdout,
-		"0x07F1C: TIC_DW3     (Tx Desc Hand. Mem Read Data 3)  0x%08X\n",
-		regs_buff[1099]);
+	for (i = 0; i < 4; i++)
+		fprintf(stdout,
+			"0x%05X: TIC_DW%d     (Tx Desc Hand. Mem Read Data %d)  0x%08X\n",
+			0x07F10 + (4 * i), i, i, regs_buff[1096 + i]);
 
 	fprintf(stdout,
 		"0x07F20: TDPROBE     (Tx Probe Mode Status)           0x%08X\n",
@@ -1217,41 +1206,19 @@ ixgbe_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
 		"0x0C600: TXBUFCTRL   (TX Buffer Access Control)       0x%08X\n",
 		regs_buff[1101]);
 
-	fprintf(stdout,
-		"0x0C610: TXBUFDATA0  (TX Buffer DATA 0)               0x%08X\n",
-		regs_buff[1102]);
-
-	fprintf(stdout,
-		"0x0C614: TXBUFDATA1  (TX Buffer DATA 1)               0x%08X\n",
-		regs_buff[1103]);
-
-	fprintf(stdout,
-		"0x0C618: TXBUFDATA2  (TX Buffer DATA 2)               0x%08X\n",
-		regs_buff[1104]);
-
-	fprintf(stdout,
-		"0x0C61C: TXBUFDATA3  (TX Buffer DATA 3)               0x%08X\n",
-		regs_buff[1105]);
+	for (i = 0; i < 4; i++)
+		fprintf(stdout,
+			"0x%05X: TXBUFDATA%d  (TX Buffer DATA %d)               0x%08X\n",
+			0x0C610 + (4 * i), i, i, regs_buff[1102 + i]);
 
 	fprintf(stdout,
 		"0x03600: RXBUFCTRL   (RX Buffer Access Control)       0x%08X\n",
 		regs_buff[1106]);
 
-	fprintf(stdout,
-		"0x03610: RXBUFDATA0  (RX Buffer DATA 0)               0x%08X\n",
-		regs_buff[1107]);
-
-	fprintf(stdout,
-		"0x03614: RXBUFDATA1  (RX Buffer DATA 1)               0x%08X\n",
-		regs_buff[1108]);
-
-	fprintf(stdout,
-		"0x03618: RXBUFDATA2  (RX Buffer DATA 2)               0x%08X\n",
-		regs_buff[1109]);
-
-	fprintf(stdout,
-		"0x0361C: RXBUFDATA3  (RX Buffer DATA 3)               0x%08X\n",
-		regs_buff[1110]);
+	for (i = 0; i < 4; i++)
+		fprintf(stdout,
+			"0x%05X: RXBUFDATA%d  (RX Buffer DATA %d)               0x%08X\n",
+			0x03610 + (4 * i), i, i, regs_buff[1107 + i]);
 
 	for (i = 0; i < 8; i++)
 		fprintf(stdout,

