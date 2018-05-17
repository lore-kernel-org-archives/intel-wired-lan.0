From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 May 2018 11:22:48 -0700
Subject: [Intel-wired-lan] [RFC PATCH 4/6] ixgbevf: add defines for IPsec
 offload request
In-Reply-To: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
References: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1526581370-30307-5-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix up the register definitions for using IPsec offloads and
add the new mailbox message IDs.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbevf/defines.h | 8 ++++++++
 drivers/net/ethernet/intel/ixgbevf/mbx.h     | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 71c8288..d2ab94a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -157,9 +157,14 @@ typedef u32 ixgbe_link_speed;
 #define IXGBE_RXDADV_STAT_FCSTAT_NODDP	0x00000010 /* 01: Ctxt w/o DDP */
 #define IXGBE_RXDADV_STAT_FCSTAT_FCPRSP	0x00000020 /* 10: Recv. FCP_RSP */
 #define IXGBE_RXDADV_STAT_FCSTAT_DDP	0x00000030 /* 11: Ctxt w/ DDP */
+#define IXGBE_RXDADV_STAT_SECP		0x00020000 /* IPsec/MACsec pkt found */
 
 #define IXGBE_RXDADV_RSSTYPE_MASK	0x0000000F
 #define IXGBE_RXDADV_PKTTYPE_MASK	0x0000FFF0
+#define IXGBE_RXDADV_PKTTYPE_IPV4       0x00000010 /* IPv4 hdr present */
+#define IXGBE_RXDADV_PKTTYPE_IPV6       0x00000040 /* IPv6 hdr present */
+#define IXGBE_RXDADV_PKTTYPE_IPSEC_ESP  0x00001000 /* IPSec ESP */
+#define IXGBE_RXDADV_PKTTYPE_IPSEC_AH   0x00002000 /* IPSec AH */
 #define IXGBE_RXDADV_PKTTYPE_MASK_EX	0x0001FFF0
 #define IXGBE_RXDADV_HDRBUFLEN_MASK	0x00007FE0
 #define IXGBE_RXDADV_RSCCNT_MASK	0x001E0000
@@ -274,9 +279,12 @@ struct ixgbe_adv_tx_context_desc {
 #define IXGBE_ADVTXD_TUCMD_L4T_UDP	0x00000000  /* L4 Packet TYPE of UDP */
 #define IXGBE_ADVTXD_TUCMD_L4T_TCP	0x00000800  /* L4 Packet TYPE of TCP */
 #define IXGBE_ADVTXD_TUCMD_L4T_SCTP	0x00001000  /* L4 Packet TYPE of SCTP */
+#define IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP   0x00002000 /* IPSec Type ESP */
+#define IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN 0x00004000 /* ESP Encrypt Enable */
 #define IXGBE_ADVTXD_IDX_SHIFT	4 /* Adv desc Index shift */
 #define IXGBE_ADVTXD_CC		0x00000080 /* Check Context */
 #define IXGBE_ADVTXD_POPTS_SHIFT	8  /* Adv desc POPTS shift */
+#define IXGBE_ADVTXD_POPTS_IPSEC        0x00000400 /* IPSec offload request */
 #define IXGBE_ADVTXD_POPTS_IXSM	(IXGBE_TXD_POPTS_IXSM << \
 				 IXGBE_ADVTXD_POPTS_SHIFT)
 #define IXGBE_ADVTXD_POPTS_TXSM	(IXGBE_TXD_POPTS_TXSM << \
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index 5ec947f..2607a35 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -86,6 +86,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_11,	/* API version 1.1, linux/freebsd VF driver */
 	ixgbe_mbox_api_12,	/* API version 1.2, linux/freebsd VF driver */
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
+	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -116,6 +117,10 @@ enum ixgbe_pfvf_api_rev {
 
 #define IXGBE_VF_UPDATE_XCAST_MODE	0x0c
 
+/* mailbox API, version 1.4 VF requests */
+#define IXGBE_VF_IPSEC_ADD	0x0d
+#define IXGBE_VF_IPSEC_DEL	0x0e
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN	4
 /* word in permanent address message with the current multicast type */
-- 
2.7.4

