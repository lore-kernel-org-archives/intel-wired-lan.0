From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Oct 2019 07:09:51 -0700
Subject: [Intel-wired-lan] [PATCH S31 13/15] ice: Get rid of
 ice_cleanup_header
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20191009140953.14087-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

ice_cleanup_hdrs() has been stripped of most of its content, it only serves
as a wrapper for eth_skb_pad(). We can get rid of it altogether and
simplify the codebase.

Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 27 ++---------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8e3a69d3884d..96b13421e449 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -944,27 +944,6 @@ static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	rx_buf->skb = NULL;
 }
 
-/**
- * ice_cleanup_headers - Correct empty headers
- * @skb: pointer to current skb being fixed
- *
- * Also address the case where we are pulling data in on pages only
- * and as such no data is present in the skb header.
- *
- * In addition if skb is not at least 60 bytes we need to pad it so that
- * it is large enough to qualify as a valid Ethernet frame.
- *
- * Returns true if an error was encountered and skb was freed.
- */
-static bool ice_cleanup_headers(struct sk_buff *skb)
-{
-	/* if eth_skb_pad returns an error the skb was freed */
-	if (eth_skb_pad(skb))
-		return true;
-
-	return false;
-}
-
 /**
  * ice_is_non_eop - process handling of non-EOP buffers
  * @rx_ring: Rx ring being processed
@@ -1124,10 +1103,8 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		if (ice_test_staterr(rx_desc, stat_err_bits))
 			vlan_tag = le16_to_cpu(rx_desc->wb.l2tag1);
 
-		/* correct empty headers and pad skb if needed (to make valid
-		 * ethernet frame
-		 */
-		if (ice_cleanup_headers(skb)) {
+		/* pad the skb if needed, to make a valid ethernet frame */
+		if (eth_skb_pad(skb)) {
 			skb = NULL;
 			continue;
 		}
-- 
2.20.1

