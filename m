From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Fri, 06 May 2016 19:09:51 -0700
Subject: [Intel-wired-lan] [PATCH] [v1,
 next-queue] net: ixgbe: Fix deleting link filters for cls_u32
 offloads
Message-ID: <20160507020951.3203.46579.stgit@terminator23.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On deleting filters which are links to a child hash table, the filters
in the child hash table must be cleared from the hardware if there
is no link between the parent and child hash table.

Verified with the following filters:

# tc qdisc add dev enp5s0f1 ingress
# ethtool -K enp5s0f1 hw-tc-offload on

Create a child hash table:
# tc filter add dev enp5s0f1 parent ffff: protocol ip prio 99 \
	handle 1: u32 divisor 1

Link to the child hash table from parent hash table:
# tc filter add dev enp5s0f1 protocol ip parent ffff: prio 99 \
	handle 800:0:10 u32 ht 800: link 1: \
	offset at 0 mask 0f00 shift 6 plus 0 eat \
	match ip protocol 6 ff match ip dst 15.0.0.1/32

Add filters into child hash table:
# tc filter add dev enp5s0f1 parent ffff: protocol ip \
	handle 1:0:2 u32 ht 1: \
	match tcp src 22 ffff action drop
# tc filter add dev enp5s0f1 parent ffff: protocol ip \
        handle 1:0:3 u32 ht 1: \
        match tcp src 33 ffff action drop

Delete link filter from parent hash table:
# tc filter del dev enp5s0f1 parent ffff: prio 99 \
	handle 800:0:10 u32

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   75 ++++++++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_model.h |    4 +
 2 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7bbf9b1..24a20ce 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8308,14 +8308,50 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 static int ixgbe_delete_clsu32(struct ixgbe_adapter *adapter,
 			       struct tc_cls_u32_offload *cls)
 {
+	u32 hdl = cls->knode.handle;
 	u32 uhtid = TC_U32_USERHTID(cls->knode.handle);
-	u32 loc;
-	int err;
+	u32 loc = cls->knode.handle & 0xfffff;
+	int err = 0, i, j;
+	struct ixgbe_jump_table *jump = NULL;
+
+	if (loc > IXGBE_MAX_HW_ENTRIES)
+		return -EINVAL;
 
 	if ((uhtid != 0x800) && (uhtid >= IXGBE_MAX_LINK_HANDLE))
 		return -EINVAL;
 
-	loc = cls->knode.handle & 0xfffff;
+	/* Clear this filter in the link data it is associated with */
+	if (uhtid != 0x800) {
+		jump = adapter->jump_tables[uhtid];
+		if (jump)
+			clear_bit(loc - 1, jump->child_loc_map);
+	}
+
+	/* Check if the filter being deleted is a link */
+	for (i = 1; i < IXGBE_MAX_LINK_HANDLE; i++) {
+		jump = adapter->jump_tables[i];
+		if (jump && jump->link_hdl == hdl) {
+			/* Delete filters in the hardware in the child hash
+			 * table associated with this link
+			 */
+			for (j = 0; j < IXGBE_MAX_HW_ENTRIES; j++) {
+				if (!test_bit(j, jump->child_loc_map))
+					continue;
+				spin_lock(&adapter->fdir_perfect_lock);
+				err = ixgbe_update_ethtool_fdir_entry(adapter,
+								      NULL,
+								      j + 1);
+				spin_unlock(&adapter->fdir_perfect_lock);
+				clear_bit(j, jump->child_loc_map);
+			}
+			/* Remove resources for this link */
+			kfree(jump->input);
+			kfree(jump->mask);
+			kfree(jump);
+			adapter->jump_tables[i] = NULL;
+			return err;
+		}
+	}
 
 	spin_lock(&adapter->fdir_perfect_lock);
 	err = ixgbe_update_ethtool_fdir_entry(adapter, NULL, loc);
@@ -8549,6 +8585,18 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 		if (!test_bit(link_uhtid - 1, &adapter->tables))
 			return err;
 
+		/* Multiple filters as links to the same hash table are not
+		 * supported. To add a new filter with the same next header
+		 * but different match/jump conditions, create a new hash table
+		 * and link to it.
+		 */
+		if (adapter->jump_tables[link_uhtid] &&
+		    (adapter->jump_tables[link_uhtid])->link_hdl) {
+			e_err(drv, "Link filter exists for link: %x\n",
+			      link_uhtid);
+			return err;
+		}
+
 		for (i = 0; nexthdr[i].jump; i++) {
 			if (nexthdr[i].o != cls->knode.sel->offoff ||
 			    nexthdr[i].s != cls->knode.sel->offshift ||
@@ -8566,10 +8614,12 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 			mask = kzalloc(sizeof(*mask), GFP_KERNEL);
 			if (!mask) {
 				err = -ENOMEM;
-				goto free_input;
+				goto err_out;
 			}
 			jump->input = input;
 			jump->mask = mask;
+			jump->link_hdl = cls->knode.handle;
+
 			err = ixgbe_clsu32_build_input(input, mask, cls,
 						       field_ptr, &nexthdr[i]);
 			if (!err) {
@@ -8587,7 +8637,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 	mask = kzalloc(sizeof(*mask), GFP_KERNEL);
 	if (!mask) {
 		err = -ENOMEM;
-		goto free_input;
+		goto err_out;
 	}
 
 	if ((uhtid != 0x800) && (adapter->jump_tables[uhtid])) {
@@ -8628,14 +8678,25 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 		ixgbe_update_ethtool_fdir_entry(adapter, input, input->sw_idx);
 	spin_unlock(&adapter->fdir_perfect_lock);
 
+	if ((uhtid != 0x800) && (adapter->jump_tables[uhtid])) {
+		struct ixgbe_jump_table *link = adapter->jump_tables[uhtid];
+
+		if (test_bit(loc - 1, link->child_loc_map)) {
+			e_err(drv, "Filter: %x exists in hash table: %x\n",
+			      loc, uhtid);
+			err = -EINVAL;
+			goto free_mask;
+		}
+		set_bit(loc - 1, link->child_loc_map);
+	}
 	kfree(mask);
 	return err;
 err_out_w_lock:
 	spin_unlock(&adapter->fdir_perfect_lock);
 err_out:
-	kfree(mask);
-free_input:
 	kfree(input);
+free_mask:
+	kfree(mask);
 free_jump:
 	kfree(jump);
 	return err;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
index a8bed3d..538a1c54 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
@@ -42,8 +42,12 @@ struct ixgbe_jump_table {
 	struct ixgbe_mat_field *mat;
 	struct ixgbe_fdir_filter *input;
 	union ixgbe_atr_input *mask;
+	u32 link_hdl;
+	unsigned long child_loc_map[32];
 };
 
+#define IXGBE_MAX_HW_ENTRIES 2045
+
 static inline int ixgbe_mat_prgm_sip(struct ixgbe_fdir_filter *input,
 				     union ixgbe_atr_input *mask,
 				     u32 val, u32 m)

