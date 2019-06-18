From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Tue, 18 Jun 2019 14:55:13 +0300
Subject: [Intel-wired-lan] [PATCH 2/2] net: intel: igb: add RR2DCDELAY to
 ethtool registers dump
In-Reply-To: <20190618115513.99661-1-dedekind1@gmail.com>
References: <20190618115513.99661-1-dedekind1@gmail.com>
Message-ID: <20190618115513.99661-2-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch adds the RR2DCDELAY register to the ethtool registers dump.
RR2DCDELAY exists on I210 and I211 Intel Gigabit Ethernet chips and it stands
for "Read Request To Data Completion Delay". Here is how this register is
described in the I210 datasheet:

"This field captures the maximum PCIe split time in 16 ns units, which is the
maximum delay between the read request to the first data completion. This is
giving an estimation of the PCIe round trip time."

In other words, whenever I210 reads from the host memory (e.g., fetches a
descriptor from the ring), the chip measures every PCI DMA read transaction and
captures the maximum value. So it ends up containing the longest DMA
transaction time.

This register is very useful for troubleshooting and research purposes. If you
are dealing with time-sensitive networks, this register can help you get
an idea of your "I210-to-ring" latency. This helps answering questions like
"should I have PCIe ASPM enabled?" or "should I enable deep C-states?" on
my system.

It is safe to read this register at any point, reading it has no effect on
the I210 chip functionality.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_regs.h  | 2 ++
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
index 0ad737d2f289..9cb49980ec2d 100644
--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -409,6 +409,8 @@ do { \
 #define E1000_I210_TQAVCC(_n)	(0x3004 + ((_n) * 0x40))
 #define E1000_I210_TQAVHC(_n)	(0x300C + ((_n) * 0x40))
 
+#define E1000_I210_RR2DCDELAY	0x5BF4
+
 #define E1000_INVM_DATA_REG(_n)	(0x12120 + 4*(_n))
 #define E1000_INVM_SIZE		64 /* Number of INVM Data Registers */
 
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 401bc2bd6b21..3182b059bf55 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -448,7 +448,7 @@ static void igb_set_msglevel(struct net_device *netdev, u32 data)
 
 static int igb_get_regs_len(struct net_device *netdev)
 {
-#define IGB_REGS_LEN 739
+#define IGB_REGS_LEN 740
 	return IGB_REGS_LEN * sizeof(u32);
 }
 
@@ -710,6 +710,9 @@ static void igb_get_regs(struct net_device *netdev,
 		for (i = 0; i < 12; i++)
 			regs_buff[727 + i] = rd32(E1000_TDWBAH(i + 4));
 	}
+
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211)
+		regs_buff[739] = rd32(E1000_I210_RR2DCDELAY);
 }
 
 static int igb_get_eeprom_len(struct net_device *netdev)
-- 
2.20.1

