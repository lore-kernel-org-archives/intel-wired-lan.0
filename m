From: Andre Guedes <andre.guedes@intel.com>
Date: Mon, 10 Aug 2020 14:08:30 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] igc: Clean RX descriptor error flags
Message-ID: <20200810210832.34699-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I225 advanced receive descriptor doesn't have the following extend error
bits: CE, SE, SEQ, CXE. In addition to that, the bit TCPE is called L4E
in the datasheet.

This patch cleans up the code accordingly, and gets rid of the macro
IGC_RXDEXT_ERR_FRAME_ERR_MASK since it doesn't make much sense anymore.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 14 +-------------
 drivers/net/ethernet/intel/igc/igc_main.c    |  5 ++---
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 28885be15ee8..21695476b8a5 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -324,22 +324,10 @@
 /* Advanced Receive Descriptor bit definitions */
 #define IGC_RXDADV_STAT_TSIP	0x08000 /* timestamp in packet */
 
-#define IGC_RXDEXT_STATERR_CE		0x01000000
-#define IGC_RXDEXT_STATERR_SE		0x02000000
-#define IGC_RXDEXT_STATERR_SEQ		0x04000000
-#define IGC_RXDEXT_STATERR_CXE		0x10000000
-#define IGC_RXDEXT_STATERR_TCPE		0x20000000
+#define IGC_RXDEXT_STATERR_L4E		0x20000000
 #define IGC_RXDEXT_STATERR_IPE		0x40000000
 #define IGC_RXDEXT_STATERR_RXE		0x80000000
 
-/* Same mask, but for extended and packet split descriptors */
-#define IGC_RXDEXT_ERR_FRAME_ERR_MASK ( \
-	IGC_RXDEXT_STATERR_CE  |	\
-	IGC_RXDEXT_STATERR_SE  |	\
-	IGC_RXDEXT_STATERR_SEQ |	\
-	IGC_RXDEXT_STATERR_CXE |	\
-	IGC_RXDEXT_STATERR_RXE)
-
 #define IGC_MRQC_RSS_FIELD_IPV4_TCP	0x00010000
 #define IGC_MRQC_RSS_FIELD_IPV4		0x00020000
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP_EX	0x00040000
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b303d05e0870..298f408519f4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1437,7 +1437,7 @@ static void igc_rx_checksum(struct igc_ring *ring,
 
 	/* TCP/UDP checksum error bit is set */
 	if (igc_test_staterr(rx_desc,
-			     IGC_RXDEXT_STATERR_TCPE |
+			     IGC_RXDEXT_STATERR_L4E |
 			     IGC_RXDEXT_STATERR_IPE)) {
 		/* work around errata with sctp packets where the TCPE aka
 		 * L4E bit is set incorrectly on 64 byte (60 byte w/o crc)
@@ -1752,8 +1752,7 @@ static bool igc_cleanup_headers(struct igc_ring *rx_ring,
 				union igc_adv_rx_desc *rx_desc,
 				struct sk_buff *skb)
 {
-	if (unlikely((igc_test_staterr(rx_desc,
-				       IGC_RXDEXT_ERR_FRAME_ERR_MASK)))) {
+	if (unlikely(igc_test_staterr(rx_desc, IGC_RXDEXT_STATERR_RXE))) {
 		struct net_device *netdev = rx_ring->netdev;
 
 		if (!(netdev->features & NETIF_F_RXALL)) {
-- 
2.26.2

