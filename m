From: Vasyl Gomonovych <gomonovych@gmail.com>
Date: Thu, 12 Dec 2019 11:58:47 +0100
Subject: [Intel-wired-lan] [PATCH] igb: index regs_buff array via index
 variable
Message-ID: <20191212105847.16488-1-gomonovych@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is just a preparation for additional register dump in regs_buff.
To make new register insertion in the middle of regs_buff array easier
change array indexing to use local counter reg_ix.

---

Basically this path is just a subject to ask
How to add a new register to dump from dataseet
Because it is logically better to add an additional register
in the middle of an array but that will break ABI.
To not have the ABI problem we should just add it at the
end of the array and increase the array size.

---

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 110 ++++++++++---------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 3182b059bf55..4531f7ea9d99 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -459,6 +459,7 @@ static void igb_get_regs(struct net_device *netdev,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 *regs_buff = p;
 	u8 i;
+	int reg_ix = 0;
 
 	memset(p, 0, IGB_REGS_LEN * sizeof(u32));
 
@@ -603,116 +604,119 @@ static void igb_get_regs(struct net_device *netdev,
 	regs_buff[119] = adapter->stats.scvpc;
 	regs_buff[120] = adapter->stats.hrmpc;
 
+	reg_ix = 121;
 	for (i = 0; i < 4; i++)
-		regs_buff[121 + i] = rd32(E1000_SRRCTL(i));
+		regs_buff[reg_ix++] = rd32(E1000_SRRCTL(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[125 + i] = rd32(E1000_PSRTYPE(i));
+		regs_buff[reg_ix++] = rd32(E1000_PSRTYPE(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[129 + i] = rd32(E1000_RDBAL(i));
+		regs_buff[reg_ix++] = rd32(E1000_RDBAL(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[133 + i] = rd32(E1000_RDBAH(i));
+		regs_buff[reg_ix++] = rd32(E1000_RDBAH(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[137 + i] = rd32(E1000_RDLEN(i));
+		regs_buff[reg_ix++] = rd32(E1000_RDLEN(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[141 + i] = rd32(E1000_RDH(i));
+		regs_buff[reg_ix++] = rd32(E1000_RDH(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[145 + i] = rd32(E1000_RDT(i));
+		regs_buff[reg_ix++] = rd32(E1000_RDT(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[149 + i] = rd32(E1000_RXDCTL(i));
+		regs_buff[reg_ix++] = rd32(E1000_RXDCTL(i));
 
 	for (i = 0; i < 10; i++)
-		regs_buff[153 + i] = rd32(E1000_EITR(i));
+		regs_buff[reg_ix++] = rd32(E1000_EITR(i));
 	for (i = 0; i < 8; i++)
-		regs_buff[163 + i] = rd32(E1000_IMIR(i));
+		regs_buff[reg_ix++] = rd32(E1000_IMIR(i));
 	for (i = 0; i < 8; i++)
-		regs_buff[171 + i] = rd32(E1000_IMIREXT(i));
+		regs_buff[reg_ix++] = rd32(E1000_IMIREXT(i));
 	for (i = 0; i < 16; i++)
-		regs_buff[179 + i] = rd32(E1000_RAL(i));
+		regs_buff[reg_ix++] = rd32(E1000_RAL(i));
 	for (i = 0; i < 16; i++)
-		regs_buff[195 + i] = rd32(E1000_RAH(i));
+		regs_buff[reg_ix++] = rd32(E1000_RAH(i));
 
 	for (i = 0; i < 4; i++)
-		regs_buff[211 + i] = rd32(E1000_TDBAL(i));
+		regs_buff[reg_ix++] = rd32(E1000_TDBAL(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[215 + i] = rd32(E1000_TDBAH(i));
+		regs_buff[reg_ix++] = rd32(E1000_TDBAH(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[219 + i] = rd32(E1000_TDLEN(i));
+		regs_buff[reg_ix++] = rd32(E1000_TDLEN(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[223 + i] = rd32(E1000_TDH(i));
+		regs_buff[reg_ix++] = rd32(E1000_TDH(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[227 + i] = rd32(E1000_TDT(i));
+		regs_buff[reg_ix++] = rd32(E1000_TDT(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[231 + i] = rd32(E1000_TXDCTL(i));
+		regs_buff[reg_ix++] = rd32(E1000_TXDCTL(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[235 + i] = rd32(E1000_TDWBAL(i));
+		regs_buff[reg_ix++] = rd32(E1000_TDWBAL(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[239 + i] = rd32(E1000_TDWBAH(i));
+		regs_buff[reg_ix++] = rd32(E1000_TDWBAH(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[243 + i] = rd32(E1000_DCA_TXCTRL(i));
+		regs_buff[reg_ix++] = rd32(E1000_DCA_TXCTRL(i));
 
 	for (i = 0; i < 4; i++)
-		regs_buff[247 + i] = rd32(E1000_IP4AT_REG(i));
+		regs_buff[reg_ix++] = rd32(E1000_IP4AT_REG(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[251 + i] = rd32(E1000_IP6AT_REG(i));
+		regs_buff[reg_ix++] = rd32(E1000_IP6AT_REG(i));
 	for (i = 0; i < 32; i++)
-		regs_buff[255 + i] = rd32(E1000_WUPM_REG(i));
+		regs_buff[reg_ix++] = rd32(E1000_WUPM_REG(i));
 	for (i = 0; i < 128; i++)
-		regs_buff[287 + i] = rd32(E1000_FFMT_REG(i));
+		regs_buff[reg_ix++] = rd32(E1000_FFMT_REG(i));
 	for (i = 0; i < 128; i++)
-		regs_buff[415 + i] = rd32(E1000_FFVT_REG(i));
+		regs_buff[reg_ix++] = rd32(E1000_FFVT_REG(i));
 	for (i = 0; i < 4; i++)
-		regs_buff[543 + i] = rd32(E1000_FFLT_REG(i));
+		regs_buff[reg_ix++] = rd32(E1000_FFLT_REG(i));
 
-	regs_buff[547] = rd32(E1000_TDFH);
-	regs_buff[548] = rd32(E1000_TDFT);
-	regs_buff[549] = rd32(E1000_TDFHS);
-	regs_buff[550] = rd32(E1000_TDFPC);
+	regs_buff[reg_ix++] = rd32(E1000_TDFH);
+	regs_buff[reg_ix++] = rd32(E1000_TDFT);
+	regs_buff[reg_ix++] = rd32(E1000_TDFHS);
+	regs_buff[reg_ix++] = rd32(E1000_TDFPC);
 
 	if (hw->mac.type > e1000_82580) {
-		regs_buff[551] = adapter->stats.o2bgptc;
-		regs_buff[552] = adapter->stats.b2ospc;
-		regs_buff[553] = adapter->stats.o2bspc;
-		regs_buff[554] = adapter->stats.b2ogprc;
+		regs_buff[reg_ix++] = adapter->stats.o2bgptc;
+		regs_buff[reg_ix++] = adapter->stats.b2ospc;
+		regs_buff[reg_ix++] = adapter->stats.o2bspc;
+		regs_buff[reg_ix++] = adapter->stats.b2ogprc;
 	}
 
+	reg_ix = 555;
 	if (hw->mac.type == e1000_82576) {
 		for (i = 0; i < 12; i++)
-			regs_buff[555 + i] = rd32(E1000_SRRCTL(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_SRRCTL(i + 4));
 		for (i = 0; i < 4; i++)
-			regs_buff[567 + i] = rd32(E1000_PSRTYPE(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_PSRTYPE(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[571 + i] = rd32(E1000_RDBAL(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_RDBAL(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[583 + i] = rd32(E1000_RDBAH(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_RDBAH(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[595 + i] = rd32(E1000_RDLEN(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_RDLEN(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[607 + i] = rd32(E1000_RDH(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_RDH(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[619 + i] = rd32(E1000_RDT(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_RDT(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[631 + i] = rd32(E1000_RXDCTL(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_RXDCTL(i + 4));
 
 		for (i = 0; i < 12; i++)
-			regs_buff[643 + i] = rd32(E1000_TDBAL(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TDBAL(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[655 + i] = rd32(E1000_TDBAH(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TDBAH(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[667 + i] = rd32(E1000_TDLEN(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TDLEN(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[679 + i] = rd32(E1000_TDH(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TDH(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[691 + i] = rd32(E1000_TDT(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TDT(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[703 + i] = rd32(E1000_TXDCTL(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TXDCTL(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[715 + i] = rd32(E1000_TDWBAL(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TDWBAL(i + 4));
 		for (i = 0; i < 12; i++)
-			regs_buff[727 + i] = rd32(E1000_TDWBAH(i + 4));
+			regs_buff[reg_ix++] = rd32(E1000_TDWBAH(i + 4));
 	}
 
+	reg_ix = 739;
 	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211)
-		regs_buff[739] = rd32(E1000_I210_RR2DCDELAY);
+		regs_buff[reg_ix] = rd32(E1000_I210_RR2DCDELAY);
 }
 
 static int igb_get_eeprom_len(struct net_device *netdev)
-- 
2.17.1

