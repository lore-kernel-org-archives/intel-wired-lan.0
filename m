From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:36 -0700
Subject: [Intel-wired-lan] [PATCH S27 13/15] ice: move code closer together
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This is a simple patch to move the assignment to a local variable
closer to the site where the local variable is used.  This
can help readability and also maybe performance, although the
performance enhancement is really dependent upon the compiler.

No functional change.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4fe1b332e67e..ec581b1f0fcb 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1068,9 +1068,6 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 			continue;
 		}
 
-		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
-			ICE_RX_FLEX_DESC_PTYPE_M;
-
 		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_L2TAG1P_S);
 		if (ice_test_staterr(rx_desc, stat_err_bits))
 			vlan_tag = le16_to_cpu(rx_desc->wb.l2tag1);
@@ -1087,6 +1084,9 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 
 		/* populate checksum, VLAN, and protocol */
+		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
+			ICE_RX_FLEX_DESC_PTYPE_M;
+
 		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
 
 		/* send completed skb up the stack */
-- 
2.20.1

