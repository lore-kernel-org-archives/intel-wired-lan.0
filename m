From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Mon, 16 May 2016 18:33:20 -0700
Subject: [Intel-wired-lan] [PATCH] [v1,
 next-queue] net: ixgbe: Error handler for duplicate filter
 locations in hardware for cls_u32 offloads
Message-ID: <20160517013320.2902.71585.stgit@terminator23.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For u32 classifier filters, avoid overwriting existing filter
in a hardware location without removing it first, to clean up
inconsistencies due to duplicate values for filter location.

Verified with the following filters:

# tc qdisc add dev enp5s0f1 ingress
# ethtool -K enp5s0f1 hw-tc-offload on

Create child hash tables:
# tc filter add dev enp5s0f1 parent ffff: protocol ip prio 99 \
	handle 1: u32 divisor 1
# tc filter add dev enp5s0f1 parent ffff: protocol ip prio 99 \
	handle 2: u32 divisor 1

Link to the child hash table from parent hash table:
# tc filter add dev enp5s0f1 protocol ip parent ffff: prio 99 \
	handle 800:0:11 u32 ht 800: link 1: \
	offset at 0 mask 0f00 shift 6 plus 0 eat \
	match ip protocol 6 ff match ip dst 15.0.0.1/32

# tc filter add dev enp5s0f1 protocol ip parent ffff: prio 99 \
	handle 800:0:12 u32 ht 800: link 2: \
	offset at 0 mask 0f00 shift 6 plus 0 eat \
	match ip protocol 17 ff match ip dst 16.0.0.1/32

Add filter into child hash table:
# tc filter add dev enp5s0f1 parent ffff: protocol ip \
	handle 1:0:3 u32 ht 1: \
	match tcp src 22 ffff action drop

Add another filter to the same location:
# tc filter add dev enp5s0f1 parent ffff: protocol ip \
	handle 2:0:3 u32 ht 2: \
	match tcp src 33 ffff action drop

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   41 +++++++++++++++----------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7a893ae..a36cd60 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8323,8 +8323,11 @@ static int ixgbe_delete_clsu32(struct ixgbe_adapter *adapter,
 	/* Clear this filter in the link data it is associated with */
 	if (uhtid != 0x800) {
 		jump = adapter->jump_tables[uhtid];
-		if (jump)
-			clear_bit(loc - 1, jump->child_loc_map);
+		if (!jump)
+			return -EINVAL;
+		if (!test_bit(loc - 1, jump->child_loc_map))
+			return -EINVAL;
+		clear_bit(loc - 1, jump->child_loc_map);
 	}
 
 	/* Check if the filter being deleted is a link */
@@ -8614,7 +8617,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 			mask = kzalloc(sizeof(*mask), GFP_KERNEL);
 			if (!mask) {
 				err = -ENOMEM;
-				goto err_out;
+				goto free_input;
 			}
 			jump->input = input;
 			jump->mask = mask;
@@ -8637,7 +8640,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 	mask = kzalloc(sizeof(*mask), GFP_KERNEL);
 	if (!mask) {
 		err = -ENOMEM;
-		goto err_out;
+		goto free_input;
 	}
 
 	if ((uhtid != 0x800) && (adapter->jump_tables[uhtid])) {
@@ -8647,6 +8650,20 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 		if ((adapter->jump_tables[uhtid])->mask)
 			memcpy(mask, (adapter->jump_tables[uhtid])->mask,
 			       sizeof(*mask));
+
+		/* Lookup in all child hash tables if this location is already
+		 * filled with a filter
+		 */
+		for (i = 1; i < IXGBE_MAX_LINK_HANDLE; i++) {
+			struct ixgbe_jump_table *link = adapter->jump_tables[i];
+
+			if (link && (test_bit(loc - 1, link->child_loc_map))) {
+				e_err(drv, "Filter exists in location: %x\n",
+				      loc);
+				err = -EINVAL;
+				goto err_out;
+			}
+		}
 	}
 	err = ixgbe_clsu32_build_input(input, mask, cls, field_ptr, NULL);
 	if (err)
@@ -8678,25 +8695,17 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 		ixgbe_update_ethtool_fdir_entry(adapter, input, input->sw_idx);
 	spin_unlock(&adapter->fdir_perfect_lock);
 
-	if ((uhtid != 0x800) && (adapter->jump_tables[uhtid])) {
-		struct ixgbe_jump_table *link = adapter->jump_tables[uhtid];
+	if ((uhtid != 0x800) && (adapter->jump_tables[uhtid]))
+		set_bit(loc - 1, (adapter->jump_tables[uhtid])->child_loc_map);
 
-		if (test_bit(loc - 1, link->child_loc_map)) {
-			e_err(drv, "Filter: %x exists in hash table: %x\n",
-			      loc, uhtid);
-			err = -EINVAL;
-			goto free_mask;
-		}
-		set_bit(loc - 1, link->child_loc_map);
-	}
 	kfree(mask);
 	return err;
 err_out_w_lock:
 	spin_unlock(&adapter->fdir_perfect_lock);
 err_out:
-	kfree(input);
-free_mask:
 	kfree(mask);
+free_input:
+	kfree(input);
 free_jump:
 	kfree(jump);
 	return err;

