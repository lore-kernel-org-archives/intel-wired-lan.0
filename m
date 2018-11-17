From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 16 Nov 2018 16:19:23 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v1 1/2] igb: Change RXPBSIZE
 size when setting Qav mode
Message-ID: <20181117001924.1525-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>

Section 4.5.9 of the datasheet says that the total size of all packet
buffers combined (TxPB 0 + 1 + 2 + 3 + RxPB + BMC2OS + OS2BMC) must not
exceed 60KB. Today we are configuring a total of 62KB, so reduce the
RxPB from 32KB to 30KB in order to respect that.

The choice of changing RxPBSIZE here is mainly because it seems more
correct to give more priority to the transmit packet buffers over the
receiver ones when running in Qav mode. Also, the BMC2OS and OS2BMC
sizes are already too short.

Signed-off-by: Jesus Sanchez-Palencia <jesus.s.palencia@gmail.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h | 1 +
 drivers/net/ethernet/intel/igb/igb_main.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 8a28f3388f69..01fcfc6f3415 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -334,6 +334,7 @@
 
 #define I210_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
 #define I210_RXPBSIZE_MASK		0x0000003F
+#define I210_RXPBSIZE_PB_30KB		0x0000001E
 #define I210_RXPBSIZE_PB_32KB		0x00000020
 #define I210_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
 #define I210_TXPBSIZE_MASK		0xC0FFFFFF
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index bb4f3f64fbf0..e135adf46980 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1934,7 +1934,7 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)
 
 		val = rd32(E1000_RXPBS);
 		val &= ~I210_RXPBSIZE_MASK;
-		val |= I210_RXPBSIZE_PB_32KB;
+		val |= I210_RXPBSIZE_PB_30KB;
 		wr32(E1000_RXPBS, val);
 
 		/* Section 8.12.9 states that MAX_TPKT_SIZE from DTXMXPKTSZ
-- 
2.19.1

