From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:39 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 1/9] ixgbe: remove
 undefined and conflicting bits
In-Reply-To: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1510862087-1924-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The PE and OSE error bits from the Advanced Receive Writeback
descriptor are undefined in the published Niantic family datasheets
and conflict with the defined SECERR bits, which we will need in
a coming patch.

The CE and LE error bits are also marked as reserved in the
datasheet, but I'll let someone else remove them.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index ffa0ee5..0a77941 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2375,8 +2375,6 @@ enum {
 #define IXGBE_RXDADV_ERR_HBO    0x00800000 /*Header Buffer Overflow */
 #define IXGBE_RXDADV_ERR_CE     0x01000000 /* CRC Error */
 #define IXGBE_RXDADV_ERR_LE     0x02000000 /* Length Error */
-#define IXGBE_RXDADV_ERR_PE     0x08000000 /* Packet Error */
-#define IXGBE_RXDADV_ERR_OSE    0x10000000 /* Oversize Error */
 #define IXGBE_RXDADV_ERR_USE    0x20000000 /* Undersize Error */
 #define IXGBE_RXDADV_ERR_TCPE   0x40000000 /* TCP/UDP Checksum Error */
 #define IXGBE_RXDADV_ERR_IPE    0x80000000 /* IP Checksum Error */
@@ -2482,8 +2480,6 @@ enum {
 #define IXGBE_RXDADV_ERR_FRAME_ERR_MASK ( \
 				      IXGBE_RXDADV_ERR_CE | \
 				      IXGBE_RXDADV_ERR_LE | \
-				      IXGBE_RXDADV_ERR_PE | \
-				      IXGBE_RXDADV_ERR_OSE | \
 				      IXGBE_RXDADV_ERR_USE)
 
 /* Multicast bit mask */
-- 
2.7.4

