From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:41 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 12/13] i40e: disallow
 programming multiple filters with same criteria
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Our hardware does not allow situations where two filters might conflict
when matching. Essentially hardware only programs one filter for each
set of matching criteria. We don't support filters with overlapping
input sets, because each flow type can only use a single input set.

Additionally, different flow types will never have overlapping matches,
because of how the hardware parses the flow type before checking
matching criteria.

For this reason, we do not need or use the location number when
programming filters to hardware.

In order to avoid confusing scenarios with filters that match the same
criteria but program the flow to different queues, do not allow multiple
filters that match identical criteria to be programmed.

This ensures that we avoid odd scenarios when deleting filters, and when
programming new filters that match the same criteria.

Instead, users that wish to update the criteria for a filter must use
the same location id, or must delete all the matching filters first.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 87 ++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9f6e4f0..83021c7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3841,6 +3841,87 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 }
 
 /**
+ * i40e_match_fdir_filter - Return true of two filters match
+ * @a: pointer to filter struct
+ * @b: pointer to filter struct
+ *
+ * Returns true if the two filters match exactly the same criteria. I.e. they
+ * match the same flow type and have the same parameters. We don't need to
+ * check any input-set since all filters of the same flow type must use the
+ * same input set.
+ **/
+static bool i40e_match_fdir_filter(struct i40e_fdir_filter *a,
+				   struct i40e_fdir_filter *b)
+{
+	/* The filters do not much if any of these criteria differ. */
+	if (a->dst_ip != b->dst_ip ||
+	    a->src_ip != b->src_ip ||
+	    a->dst_port != b->dst_port ||
+	    a->src_port != b->src_port ||
+	    a->flow_type != b->flow_type ||
+	    a->ip4_proto != b->ip4_proto)
+		return false;
+
+	return true;
+}
+
+/**
+ * i40e_disallow_matching_filters - Check that new filters differ
+ * @vsi: pointer to the targeted VSI
+ * @input: new filter to check
+ *
+ * Due to hardware limitations, it is not possible for two filters that match
+ * similar criteria to be programmed at the same time. This is true for a few
+ * reasons:
+ *
+ * (a) all filters matching a particular flow type must use the same input
+ * set, that is they must match the same criteria.
+ * (b) different flow types will never match the same packet, as the flow type
+ * is decided by hardware before checking which rules apply.
+ * (c) hardware has no way to distinguish which order filters apply in.
+ *
+ * Due to this, we can't really support using the location data to order
+ * filters in the hardware parsing. It is technically possible for the user to
+ * request two filters matching the same criteria but which select different
+ * queues. In this case, rather than keep both filters in the list, we reject
+ * the 2nd filter when the user requests adding it.
+ *
+ * This avoids needing to track location for programming the filter to
+ * hardware, and ensures that we avoid some strange scenarios involving
+ * deleting filters which match the same criteria.
+ **/
+static int i40e_disallow_matching_filters(struct i40e_vsi *vsi,
+					  struct i40e_fdir_filter *input)
+{
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_fdir_filter *rule;
+	struct hlist_node *node2;
+
+	/* Loop through every filter, and check that it doesn't match */
+	hlist_for_each_entry_safe(rule, node2,
+				  &pf->fdir_filter_list, fdir_node) {
+		/* Don't check the filters match if they share the same fd_id,
+		 * since the new filter is actually just updating the target
+		 * of the old filter.
+		 */
+		if (rule->fd_id == input->fd_id)
+			continue;
+
+		/* If any filters match, then print a warning message to the
+		 * kernel message buffer and bail out.
+		 */
+		if (i40e_match_fdir_filter(rule, input)) {
+			dev_warn(&pf->pdev->dev,
+				 "Existing user defined filter %d already matches this flow.\n",
+				 rule->fd_id);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/**
  * i40e_add_fdir_ethtool - Add/Remove Flow Director filters
  * @vsi: pointer to the targeted VSI
  * @cmd: command to get or set RX flow classification rules
@@ -3952,6 +4033,11 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 		input->flex_offset = userdef.flex_offset;
 	}
 
+	/* Avoid programming two filters with identical match criteria. */
+	ret = i40e_disallow_matching_filters(vsi, input);
+	if (ret)
+		goto free_filter_memory;
+
 	/* Add the input filter to the fdir_input_list, possibly replacing
 	 * a previous filter. Do not free the input structure after adding it
 	 * to the list as this would cause a use-after-free bug.
@@ -3965,6 +4051,7 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 remove_sw_rule:
 	hlist_del(&input->fdir_node);
 	pf->fdir_pf_active_filters--;
+free_filter_memory:
 	kfree(input);
 	return ret;
 }
-- 
2.9.5

