From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Fri, 20 Aug 2021 10:30:25 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor parameters
 name in i40e_print_input_set
Message-ID: <20210820103025.9816-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change function parameter old/new in i40e_print_input_set.
To avoid UT compilation problem with old/new name
added suffix 'input' to the name of parameters.

Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2c9e4eeb7270..addf7543a48a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4054,49 +4054,50 @@ static u64 i40e_pit_index_to_mask(int pit_index)
 /**
  * i40e_print_input_set - Show changes between two input sets
  * @vsi: the vsi being configured
- * @old: the old input set
- * @new: the new input set
+ * @old_input: the old input set
+ * @new_input: the new input set
  *
  * Print the difference between old and new input sets by showing which series
  * of words are toggled on or off. Only displays the bits we actually support
  * changing.
  **/
-static void i40e_print_input_set(struct i40e_vsi *vsi, u64 old, u64 new)
+static void i40e_print_input_set(struct i40e_vsi *vsi, u64 old_input,
+				 u64 new_input)
 {
 	struct i40e_pf *pf = vsi->back;
 	bool old_value, new_value;
 	int i;
 
-	old_value = !!(old & I40E_L3_SRC_MASK);
-	new_value = !!(new & I40E_L3_SRC_MASK);
+	old_value = !!(old_input & I40E_L3_SRC_MASK);
+	new_value = !!(new_input & I40E_L3_SRC_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L3 source address: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_L3_DST_MASK);
-	new_value = !!(new & I40E_L3_DST_MASK);
+	old_value = !!(old_input & I40E_L3_DST_MASK);
+	new_value = !!(new_input & I40E_L3_DST_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L3 destination address: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_L4_SRC_MASK);
-	new_value = !!(new & I40E_L4_SRC_MASK);
+	old_value = !!(old_input & I40E_L4_SRC_MASK);
+	new_value = !!(new_input & I40E_L4_SRC_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L4 source port: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_L4_DST_MASK);
-	new_value = !!(new & I40E_L4_DST_MASK);
+	old_value = !!(old_input & I40E_L4_DST_MASK);
+	new_value = !!(new_input & I40E_L4_DST_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L4 destination port: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_VERIFY_TAG_MASK);
-	new_value = !!(new & I40E_VERIFY_TAG_MASK);
+	old_value = !!(old_input & I40E_VERIFY_TAG_MASK);
+	new_value = !!(new_input & I40E_VERIFY_TAG_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "SCTP verification tag: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
@@ -4106,8 +4107,8 @@ static void i40e_print_input_set(struct i40e_vsi *vsi, u64 old, u64 new)
 	for (i = 0; i < I40E_FLEX_INDEX_ENTRIES; i++) {
 		u64 flex_mask = i40e_pit_index_to_mask(i);
 
-		old_value = !!(old & flex_mask);
-		new_value = !!(new & flex_mask);
+		old_value = !!(old_input & flex_mask);
+		new_value = !!(new_input & flex_mask);
 		if (old_value != new_value)
 			netif_info(pf, drv, vsi->netdev, "FLEX index %d: %s -> %s\n",
 				   i,
@@ -4116,9 +4117,9 @@ static void i40e_print_input_set(struct i40e_vsi *vsi, u64 old, u64 new)
 	}
 
 	netif_info(pf, drv, vsi->netdev, "  Current input set: %0llx\n",
-		   old);
+		   old_input);
 	netif_info(pf, drv, vsi->netdev, "Requested input set: %0llx\n",
-		   new);
+		   new_input);
 }
 
 /**
-- 
2.27.0

