From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  4 Dec 2017 21:35:07 -0800
Subject: [Intel-wired-lan] [next-queue 01/10] ixgbe: clean up ipsec defines
In-Reply-To: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1512452116-14795-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Clean up the ipsec/macsec descriptor bit definitions to match the rest
of the defines and file organization.  Also recognise the bit-definition
overlap in the error mask macro.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index ffa0ee5..3df0763 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2321,11 +2321,6 @@ enum {
 #define IXGBE_TXD_CMD_VLE    0x40000000 /* Add VLAN tag */
 #define IXGBE_TXD_STAT_DD    0x00000001 /* Descriptor Done */
 
-#define IXGBE_RXDADV_IPSEC_STATUS_SECP                  0x00020000
-#define IXGBE_RXDADV_IPSEC_ERROR_INVALID_PROTOCOL       0x08000000
-#define IXGBE_RXDADV_IPSEC_ERROR_INVALID_LENGTH         0x10000000
-#define IXGBE_RXDADV_IPSEC_ERROR_AUTH_FAILED            0x18000000
-#define IXGBE_RXDADV_IPSEC_ERROR_BIT_MASK               0x18000000
 /* Multiple Transmit Queue Command Register */
 #define IXGBE_MTQC_RT_ENA       0x1 /* DCB Enable */
 #define IXGBE_MTQC_VT_ENA       0x2 /* VMDQ2 Enable */
@@ -2377,6 +2372,9 @@ enum {
 #define IXGBE_RXDADV_ERR_LE     0x02000000 /* Length Error */
 #define IXGBE_RXDADV_ERR_PE     0x08000000 /* Packet Error */
 #define IXGBE_RXDADV_ERR_OSE    0x10000000 /* Oversize Error */
+#define IXGBE_RXDADV_ERR_IPSEC_INV_PROTOCOL  0x08000000 /* overlap ERR_PE  */
+#define IXGBE_RXDADV_ERR_IPSEC_INV_LENGTH    0x10000000 /* overlap ERR_OSE */
+#define IXGBE_RXDADV_ERR_IPSEC_AUTH_FAILED   0x18000000
 #define IXGBE_RXDADV_ERR_USE    0x20000000 /* Undersize Error */
 #define IXGBE_RXDADV_ERR_TCPE   0x40000000 /* TCP/UDP Checksum Error */
 #define IXGBE_RXDADV_ERR_IPE    0x80000000 /* IP Checksum Error */
@@ -2398,6 +2396,7 @@ enum {
 #define IXGBE_RXDADV_STAT_FCSTAT_FCPRSP 0x00000020 /* 10: Recv. FCP_RSP */
 #define IXGBE_RXDADV_STAT_FCSTAT_DDP    0x00000030 /* 11: Ctxt w/ DDP */
 #define IXGBE_RXDADV_STAT_TS		0x00010000 /* IEEE 1588 Time Stamp */
+#define IXGBE_RXDADV_STAT_SECP          0x00020000 /* IPsec/MACsec pkt found */
 
 /* PSRTYPE bit definitions */
 #define IXGBE_PSRTYPE_TCPHDR    0x00000010
@@ -2464,13 +2463,6 @@ enum {
 #define IXGBE_RXDADV_PKTTYPE_ETQF_MASK  0x00000070 /* ETQF has 8 indices */
 #define IXGBE_RXDADV_PKTTYPE_ETQF_SHIFT 4          /* Right-shift 4 bits */
 
-/* Security Processing bit Indication */
-#define IXGBE_RXDADV_LNKSEC_STATUS_SECP         0x00020000
-#define IXGBE_RXDADV_LNKSEC_ERROR_NO_SA_MATCH   0x08000000
-#define IXGBE_RXDADV_LNKSEC_ERROR_REPLAY_ERROR  0x10000000
-#define IXGBE_RXDADV_LNKSEC_ERROR_BIT_MASK      0x18000000
-#define IXGBE_RXDADV_LNKSEC_ERROR_BAD_SIG       0x18000000
-
 /* Masks to determine if packets should be dropped due to frame errors */
 #define IXGBE_RXD_ERR_FRAME_ERR_MASK ( \
 				      IXGBE_RXD_ERR_CE | \
@@ -2484,6 +2476,8 @@ enum {
 				      IXGBE_RXDADV_ERR_LE | \
 				      IXGBE_RXDADV_ERR_PE | \
 				      IXGBE_RXDADV_ERR_OSE | \
+				      IXGBE_RXDADV_ERR_IPSEC_INV_PROTOCOL | \
+				      IXGBE_RXDADV_ERR_IPSEC_INV_LENGTH | \
 				      IXGBE_RXDADV_ERR_USE)
 
 /* Multicast bit mask */
@@ -2893,6 +2887,7 @@ struct ixgbe_adv_tx_context_desc {
 				 IXGBE_ADVTXD_POPTS_SHIFT)
 #define IXGBE_ADVTXD_POPTS_TXSM (IXGBE_TXD_POPTS_TXSM << \
 				 IXGBE_ADVTXD_POPTS_SHIFT)
+#define IXGBE_ADVTXD_POPTS_IPSEC     0x00000400 /* IPSec offload request */
 #define IXGBE_ADVTXD_POPTS_ISCO_1ST  0x00000000 /* 1st TSO of iSCSI PDU */
 #define IXGBE_ADVTXD_POPTS_ISCO_MDL  0x00000800 /* Middle TSO of iSCSI PDU */
 #define IXGBE_ADVTXD_POPTS_ISCO_LAST 0x00001000 /* Last TSO of iSCSI PDU */
@@ -2908,7 +2903,6 @@ struct ixgbe_adv_tx_context_desc {
 #define IXGBE_ADVTXD_TUCMD_L4T_SCTP  0x00001000  /* L4 Packet TYPE of SCTP */
 #define IXGBE_ADVTXD_TUCMD_L4T_RSV     0x00001800 /* RSV L4 Packet TYPE */
 #define IXGBE_ADVTXD_TUCMD_MKRREQ    0x00002000 /*Req requires Markers and CRC*/
-#define IXGBE_ADVTXD_POPTS_IPSEC      0x00000400 /* IPSec offload request */
 #define IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP 0x00002000 /* IPSec Type ESP */
 #define IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN 0x00004000/* ESP Encrypt Enable */
 #define IXGBE_ADVTXT_TUCMD_FCOE      0x00008000       /* FCoE Frame Type */
-- 
2.7.4

