From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:39:13 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 11/11] i40e: always remove old
	filter when adding new FDir filter
In-Reply-To: <20170206223913.31525-1-jacob.e.keller@intel.com>
References: <20170206223913.31525-1-jacob.e.keller@intel.com>
Message-ID: <20170206223913.31525-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The previous code relied on i40e_match_fdir_input_set to determine when
determining whether to free the old filter. Change this code so that we
simply unconditionally delete the old filter, even if it's identical to
the new filter. This ensures that we don't leak any memory, and that we
always update the filters as expected.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 32 ++++++--------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index da36621379cc..f825181ec7c2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2582,24 +2582,6 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	return 0;
 }
 
-/**
- * i40e_match_fdir_input_set - Match a new filter against an existing one
- * @rule: The filter already added
- * @input: The new filter to comapre against
- *
- * Returns true if the two input set match
- **/
-static bool i40e_match_fdir_input_set(struct i40e_fdir_filter *rule,
-				      struct i40e_fdir_filter *input)
-{
-	if ((rule->dst_ip != input->dst_ip) ||
-	    (rule->src_ip != input->src_ip) ||
-	    (rule->dst_port != input->dst_port) ||
-	    (rule->src_port != input->src_port))
-		return false;
-	return true;
-}
-
 /**
  * i40e_update_ethtool_fdir_entry - Updates the fdir filter entry
  * @vsi: Pointer to the targeted VSI
@@ -2635,22 +2617,22 @@ static int i40e_update_ethtool_fdir_entry(struct i40e_vsi *vsi,
 
 	/* if there is an old rule occupying our place remove it */
 	if (rule && (rule->fd_id == sw_idx)) {
-		if (input && !i40e_match_fdir_input_set(rule, input))
-			err = i40e_add_del_fdir(vsi, rule, false);
-		else if (!input)
-			err = i40e_add_del_fdir(vsi, rule, false);
+		/* Remove this rule, since we're either deleting it, or
+		 * replacing it.
+		 */
+		err = i40e_add_del_fdir(vsi, rule, false);
 		hlist_del(&rule->fdir_node);
 		kfree(rule);
 		pf->fdir_pf_active_filters--;
 	}
 
-	/* If no input this was a delete, err should be 0 if a rule was
-	 * successfully found and removed from the list else -EINVAL
+	/* If we weren't given an input, this is a delete, so just return the
+	 * error code indicating if there was an entry at the requested slot
 	 */
 	if (!input)
 		return err;
 
-	/* initialize node and set software index */
+	/* Otherwise, install the new rule as requested */
 	INIT_HLIST_NODE(&input->fdir_node);
 
 	/* add filter to the list */
-- 
2.12.0.rc0.151.g8a5726c42288

