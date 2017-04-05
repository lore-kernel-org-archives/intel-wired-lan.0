From: Alice Michael <alice.michael@intel.com>
Date: Wed,  5 Apr 2017 07:50:54 -0400
Subject: [Intel-wired-lan] [next S66 v2 02/11] i40e: Swap use of pf->flags
	and pf->hw_disabled_flags for ATR Eviction
In-Reply-To: <20170405115103.67374-1-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
Message-ID: <20170405115103.67374-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This is a minor cleanup so that we are always updating pf->flags when we
make a change to the private flags instead of updating a mix of either
pf->flags and/or pf->hw_disabled_flags.

In addition I went through and cleaned out all the spots where we were
using the X722 define in regards to this flag.

Lastly since we changed the logic I went through and flushed out any
redundancy and cleaned up the handling of the flags in the Tx path.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I79ff95a7272bb2533251ff11ef91e89ccb80b610
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d45f48c..a9a97dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2263,8 +2263,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	/* Due to lack of space, no more new filters can be programmed */
 	if (th->syn && (pf->hw_disabled_flags & I40E_FLAG_FD_ATR_ENABLED))
 		return;
-	if ((pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) &&
-	    (!(pf->hw_disabled_flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE))) {
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) {
 		/* HW ATR eviction will take care of removing filters on FIN
 		 * and RST packets.
 		 */
@@ -2326,8 +2325,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
 			I40E_TXD_FLTR_QW1_CNTINDEX_MASK;
 
-	if ((pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) &&
-	    (!(pf->hw_disabled_flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)))
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
 		dtype_cmd |= I40E_TXD_FLTR_QW1_ATR_MASK;
 
 	fdir_desc->qindex_flex_ptype_vsi = cpu_to_le32(flex_ptype);
-- 
2.9.3

