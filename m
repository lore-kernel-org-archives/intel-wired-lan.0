From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:46 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 01/11] i40e: use the safe hash
	table iterator when deleting mac filters
Message-ID: <20170907120556.45699-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

This patch replaces hash_for_each function with hash_for_each_safe
when calling  __i40e_del_filter. The hash_for_each_safe function is
the right one to use when iterating over a hash table to safely remove
a hash entry. Otherwise, incorrect values may be read from freed memory.

Detected by CoverityScan, CID 1402048 Read from pointer after free

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8bedc74c..d8fbdda 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2880,6 +2880,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	struct i40e_mac_filter *f;
 	struct i40e_vf *vf;
 	int ret = 0;
+	struct hlist_node *h;
 	int bkt;
 
 	/* validate the request */
@@ -2918,7 +2919,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	/* Delete all the filters for this VSI - we're going to kill it
 	 * anyway.
 	 */
-	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist)
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
 		__i40e_del_filter(vsi, f);
 
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
-- 
2.9.4

