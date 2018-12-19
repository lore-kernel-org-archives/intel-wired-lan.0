From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Dec 2018 10:03:32 -0800
Subject: [Intel-wired-lan] [PATCH S10 13/15] ice: Offload SCTP checksum
In-Reply-To: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181219180334.1104-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the ability to offload SCTP checksum calculations to the
NIC.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h           | 1 +
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c      | 1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c      | 6 ++++++
 4 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ac8bf7491d08..55944e089558 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -26,6 +26,7 @@
 #include <linux/bitmap.h>
 #include <linux/log2.h>
 #include <linux/ip.h>
+#include <linux/sctp.h>
 #include <linux/ipv6.h>
 #include <linux/if_bridge.h>
 #include <linux/avf/virtchnl.h>
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index bb51dd7defb5..bd7c01db8c63 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -346,6 +346,7 @@ enum ice_tx_desc_cmd_bits {
 	ICE_TX_DESC_CMD_IIPT_IPV4		= 0x0040, /* 2 BITS */
 	ICE_TX_DESC_CMD_IIPT_IPV4_CSUM		= 0x0060, /* 2 BITS */
 	ICE_TX_DESC_CMD_L4T_EOFT_TCP		= 0x0100, /* 2 BITS */
+	ICE_TX_DESC_CMD_L4T_EOFT_SCTP		= 0x0200, /* 2 BITS */
 	ICE_TX_DESC_CMD_L4T_EOFT_UDP		= 0x0300, /* 2 BITS */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 081337bd9dd4..fa9bdbaad2c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1528,6 +1528,7 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 
 	csumo_features = NETIF_F_RXCSUM	  |
 			 NETIF_F_IP_CSUM  |
+			 NETIF_F_SCTP_CRC |
 			 NETIF_F_IPV6_CSUM;
 
 	vlano_features = NETIF_F_HW_VLAN_CTAG_FILTER |
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f76a3666f2cd..8d053a5fa49a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1465,6 +1465,12 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		offset |= l4_len << ICE_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case IPPROTO_SCTP:
+		/* enable SCTP checksum offload */
+		cmd |= ICE_TX_DESC_CMD_L4T_EOFT_SCTP;
+		l4_len = sizeof(struct sctphdr) >> 2;
+		offset |= l4_len << ICE_TX_DESC_LEN_L4_LEN_S;
+		break;
+
 	default:
 		if (first->tx_flags & ICE_TX_FLAGS_TSO)
 			return -1;
-- 
2.14.5

