From: Alice Michael <alice.michael@intel.com>
Date: Fri, 16 Mar 2018 01:26:30 -0700
Subject: [Intel-wired-lan] [next PATCH S89 1/8] i40e: move
 I40E_FLAG_FILTER_SYNC to a state bit
Message-ID: <20180316082637.49915-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The I40E_FLAG_FILTER_SYNC flag is modified during run time possibly when
the RTNL lock is not held. Thus, it should not be part of pf->flags, and
instead should be using atomic bit operations in the pf->state field.

Create a __I40E_MACVLAN_SYNC_PENDING state bit, and use it instead of
the old I40E_FLAG_FILTER_SYNC flag.

This is part of a larger effort to remove the need for cmpxchg64 in
i40e_set_priv_flags().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1e1cd52..e83fb37 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -162,6 +162,7 @@ enum i40e_state_t {
 	__I40E_RESET_FAILED,
 	__I40E_PORT_SUSPENDED,
 	__I40E_VF_DISABLE,
+	__I40E_MACVLAN_SYNC_PENDING,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_STATE_SIZE__,
 };
@@ -516,7 +517,7 @@ struct i40e_pf {
 #define I40E_FLAG_MSIX_ENABLED			BIT_ULL(2)
 #define I40E_FLAG_RSS_ENABLED			BIT_ULL(3)
 #define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(4)
-#define I40E_FLAG_FILTER_SYNC			BIT_ULL(5)
+/* Gap for BIT_ULL(5) */
 #define I40E_FLAG_SRIOV_ENABLED			BIT_ULL(6)
 #define I40E_FLAG_DCB_CAPABLE			BIT_ULL(7)
 #define I40E_FLAG_DCB_ENABLED			BIT_ULL(8)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5a77dbf..e96c22a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1382,7 +1382,7 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 		hash_add(vsi->mac_filter_hash, &f->hlist, key);
 
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
+		set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
 	}
 
 	/* If we're asked to add a filter that has been marked for removal, it
@@ -1432,7 +1432,7 @@ void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f)
 	}
 
 	vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-	vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
+	set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->state);
 }
 
 /**
@@ -1955,7 +1955,7 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 	/* check for other flag changes */
 	if (vsi->current_netdev_flags != vsi->netdev->flags) {
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
+		set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
 	}
 }
 
@@ -2577,9 +2577,10 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 {
 	int v;
 
-	if (!pf || !(pf->flags & I40E_FLAG_FILTER_SYNC))
+	if (!pf)
+		return;
+	if (!test_and_clear_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state))
 		return;
-	pf->flags &= ~I40E_FLAG_FILTER_SYNC;
 
 	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v] &&
@@ -2588,7 +2589,8 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 
 			if (ret) {
 				/* come back and try again later */
-				pf->flags |= I40E_FLAG_FILTER_SYNC;
+				set_bit(__I40E_MACVLAN_SYNC_PENDING,
+					pf->state);
 				break;
 			}
 		}
@@ -12240,7 +12242,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 
 	if (f_count) {
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-		pf->flags |= I40E_FLAG_FILTER_SYNC;
+		set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
 	}
 
 	/* Update VSI BW information */
-- 
2.9.5

