From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:17 -0800
Subject: [Intel-wired-lan] [next PATCH S57 11/11] i40e: mark the value
	passed to csum_replace_by_diff as __wsum
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-12-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Fix, or rather, avoid a sparse warning caused by the fact that
csum_replace_by_diff expects to receive a __wsum value. Since the
calculation appears to work, simply typecast the passed paylen value to
__wsum to avoid the warning.

This seems pretty fishy since __wsum was obviously annotated as
a separate type on purpose, so this throws the entire calculation into
question. Since it currently appears to behave as expected, the typecast
is probably safe.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I4fdc5cddd589abc16098176e8a61127e761488f4
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 5 +++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8531f4b..a623de9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2335,7 +2335,8 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 
 			/* remove payload length from outer checksum */
 			paylen = skb->len - l4_offset;
-			csum_replace_by_diff(&l4.udp->check, htonl(paylen));
+			csum_replace_by_diff(&l4.udp->check,
+					     (__force __wsum)htonl(paylen));
 		}
 
 		/* reset pointers to inner headers */
@@ -2356,7 +2357,7 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 
 	/* remove payload length from inner checksum */
 	paylen = skb->len - l4_offset;
-	csum_replace_by_diff(&l4.tcp->check, htonl(paylen));
+	csum_replace_by_diff(&l4.tcp->check, (__force __wsum)htonl(paylen));
 
 	/* compute length of segmentation header */
 	*hdr_len = (l4.tcp->doff * 4) + l4_offset;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 45792dd..cd0e28f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1629,7 +1629,8 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 
 			/* remove payload length from outer checksum */
 			paylen = skb->len - l4_offset;
-			csum_replace_by_diff(&l4.udp->check, htonl(paylen));
+			csum_replace_by_diff(&l4.udp->check,
+					     (__force __wsum)htonl(paylen));
 		}
 
 		/* reset pointers to inner headers */
@@ -1650,7 +1651,7 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 
 	/* remove payload length from inner checksum */
 	paylen = skb->len - l4_offset;
-	csum_replace_by_diff(&l4.tcp->check, htonl(paylen));
+	csum_replace_by_diff(&l4.tcp->check, (__force __wsum)htonl(paylen));
 
 	/* compute length of segmentation header */
 	*hdr_len = (l4.tcp->doff * 4) + l4_offset;
-- 
2.4.11

