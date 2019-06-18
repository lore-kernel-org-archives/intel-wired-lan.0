From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Tue, 18 Jun 2019 14:55:12 +0300
Subject: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: minor ethool regdump
 amendment
Message-ID: <20190618115513.99661-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch has no functional impact and it is just a preparation
for the following patch. It removes an early return from the
'igb_get_regs()' function by moving the 82576-only registers
dump into an "if" block. With this preparation, we can dump more
non-82576 registers at the end of this function.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 70 ++++++++++----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index c645d9e648e0..401bc2bd6b21 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -675,41 +675,41 @@ static void igb_get_regs(struct net_device *netdev,
 		regs_buff[554] = adapter->stats.b2ogprc;
 	}
 
-	if (hw->mac.type != e1000_82576)
-		return;
-	for (i = 0; i < 12; i++)
-		regs_buff[555 + i] = rd32(E1000_SRRCTL(i + 4));
-	for (i = 0; i < 4; i++)
-		regs_buff[567 + i] = rd32(E1000_PSRTYPE(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[571 + i] = rd32(E1000_RDBAL(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[583 + i] = rd32(E1000_RDBAH(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[595 + i] = rd32(E1000_RDLEN(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[607 + i] = rd32(E1000_RDH(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[619 + i] = rd32(E1000_RDT(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[631 + i] = rd32(E1000_RXDCTL(i + 4));
-
-	for (i = 0; i < 12; i++)
-		regs_buff[643 + i] = rd32(E1000_TDBAL(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[655 + i] = rd32(E1000_TDBAH(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[667 + i] = rd32(E1000_TDLEN(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[679 + i] = rd32(E1000_TDH(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[691 + i] = rd32(E1000_TDT(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[703 + i] = rd32(E1000_TXDCTL(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[715 + i] = rd32(E1000_TDWBAL(i + 4));
-	for (i = 0; i < 12; i++)
-		regs_buff[727 + i] = rd32(E1000_TDWBAH(i + 4));
+	if (hw->mac.type == e1000_82576) {
+		for (i = 0; i < 12; i++)
+			regs_buff[555 + i] = rd32(E1000_SRRCTL(i + 4));
+		for (i = 0; i < 4; i++)
+			regs_buff[567 + i] = rd32(E1000_PSRTYPE(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[571 + i] = rd32(E1000_RDBAL(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[583 + i] = rd32(E1000_RDBAH(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[595 + i] = rd32(E1000_RDLEN(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[607 + i] = rd32(E1000_RDH(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[619 + i] = rd32(E1000_RDT(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[631 + i] = rd32(E1000_RXDCTL(i + 4));
+
+		for (i = 0; i < 12; i++)
+			regs_buff[643 + i] = rd32(E1000_TDBAL(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[655 + i] = rd32(E1000_TDBAH(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[667 + i] = rd32(E1000_TDLEN(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[679 + i] = rd32(E1000_TDH(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[691 + i] = rd32(E1000_TDT(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[703 + i] = rd32(E1000_TXDCTL(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[715 + i] = rd32(E1000_TDWBAL(i + 4));
+		for (i = 0; i < 12; i++)
+			regs_buff[727 + i] = rd32(E1000_TDWBAH(i + 4));
+	}
 }
 
 static int igb_get_eeprom_len(struct net_device *netdev)
-- 
2.20.1

