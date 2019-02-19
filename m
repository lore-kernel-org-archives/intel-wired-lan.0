From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:11 -0800
Subject: [Intel-wired-lan] [PATCH S15 11/14] ice: Remove "2 BITS" comment
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some enums in ice_tx_desc_cmd_bits have a trailing /* 2 BITS */ comment,
but the value has just one bit set (ex. ICE_TX_DESC_CMD_L4T_EOFT_SCTP
has the value 0x200 (i.e. only bit 9 is set). This is confusing and
misleading. So remove the comment.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 2e87b69aff4f..a8c3fe87d7aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -342,12 +342,12 @@ enum ice_tx_desc_cmd_bits {
 	ICE_TX_DESC_CMD_EOP			= 0x0001,
 	ICE_TX_DESC_CMD_RS			= 0x0002,
 	ICE_TX_DESC_CMD_IL2TAG1			= 0x0008,
-	ICE_TX_DESC_CMD_IIPT_IPV6		= 0x0020, /* 2 BITS */
-	ICE_TX_DESC_CMD_IIPT_IPV4		= 0x0040, /* 2 BITS */
-	ICE_TX_DESC_CMD_IIPT_IPV4_CSUM		= 0x0060, /* 2 BITS */
-	ICE_TX_DESC_CMD_L4T_EOFT_TCP		= 0x0100, /* 2 BITS */
-	ICE_TX_DESC_CMD_L4T_EOFT_SCTP		= 0x0200, /* 2 BITS */
-	ICE_TX_DESC_CMD_L4T_EOFT_UDP		= 0x0300, /* 2 BITS */
+	ICE_TX_DESC_CMD_IIPT_IPV6		= 0x0020,
+	ICE_TX_DESC_CMD_IIPT_IPV4		= 0x0040,
+	ICE_TX_DESC_CMD_IIPT_IPV4_CSUM		= 0x0060,
+	ICE_TX_DESC_CMD_L4T_EOFT_TCP		= 0x0100,
+	ICE_TX_DESC_CMD_L4T_EOFT_SCTP		= 0x0200,
+	ICE_TX_DESC_CMD_L4T_EOFT_UDP		= 0x0300,
 };
 
 #define ICE_TXD_QW1_OFFSET_S	16
-- 
2.14.5

