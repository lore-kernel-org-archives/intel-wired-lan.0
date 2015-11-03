From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 02 Nov 2015 17:10:07 -0800
Subject: [Intel-wired-lan] [next PATCH 07/11] ixgbe: Reorder search to work
 from the top down instead of bottom up
In-Reply-To: <20151103005850.28233.63113.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
Message-ID: <20151103011007.28233.6659.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is meant to reduce the complexity of the search function used
for finding a VLVF entry associated with a given VLAN ID.  The previous
code was searching from bottom to top.  I reordered it to search from top
to bottom.  In addition I pulled an AND statement out of the loop and
instead replaced it with an OR statement outside the loop.  This should
help to reduce the overall size and complexity of the function.

There was also some formatting I cleaned up in regards to whitespace and
such.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   42 ++++++++++-------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 5fd860a8d6f7..73dcc0aec6dc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3002,7 +3002,7 @@ s32 ixgbe_init_uta_tables_generic(struct ixgbe_hw *hw)
 static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 {
 	s32 regindex, first_empty_slot;
-	u32 bits = 0;
+	u32 bits;
 
 	/* short cut the special case */
 	if (vlan == 0)
@@ -3014,33 +3014,29 @@ static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 	 */
 	first_empty_slot = vlvf_bypass ? IXGBE_ERR_NO_SPACE : 0;
 
-	/*
-	  * Search for the vlan id in the VLVF entries. Save off the first empty
-	  * slot found along the way
-	  */
-	for (regindex = 1; regindex < IXGBE_VLVF_ENTRIES; regindex++) {
+	/* add VLAN enable bit for comparison */
+	vlan |= IXGBE_VLVF_VIEN;
+
+	/* Search for the vlan id in the VLVF entries. Save off the first empty
+	 * slot found along the way.
+	 *
+	 * pre-decrement loop covering (IXGBE_VLVF_ENTRIES - 1) .. 1
+	 */
+	for (regindex = IXGBE_VLVF_ENTRIES; --regindex;) {
 		bits = IXGBE_READ_REG(hw, IXGBE_VLVF(regindex));
-		if (!bits && !(first_empty_slot))
+		if (bits == vlan)
+			return regindex;
+		if (!first_empty_slot && !bits)
 			first_empty_slot = regindex;
-		else if ((bits & 0x0FFF) == vlan)
-			break;
 	}
 
-	/*
-	  * If regindex is less than IXGBE_VLVF_ENTRIES, then we found the vlan
-	  * in the VLVF. Else use the first empty VLVF register for this
-	  * vlan id.
-	  */
-	if (regindex >= IXGBE_VLVF_ENTRIES) {
-		if (first_empty_slot)
-			regindex = first_empty_slot;
-		else {
-			hw_dbg(hw, "No space in VLVF.\n");
-			regindex = IXGBE_ERR_NO_SPACE;
-		}
-	}
+	/* If we are here then we didn't find the VLAN.  Return first empty
+	 * slot we found during our search, else error.
+	 */
+	if (!first_empty_slot)
+		hw_dbg(hw, "No space in VLVF.\n");
 
-	return regindex;
+	return first_empty_slot ? : IXGBE_ERR_NO_SPACE;
 }
 
 /**

