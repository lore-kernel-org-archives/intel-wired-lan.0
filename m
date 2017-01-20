From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 20 Jan 2017 14:10:58 -0800
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: move num_vfs_macvlans
 allocation into separate function
Message-ID: <20170120221058.7572.92313.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move the code allocating memory for list of MAC addresses that
the VFs can use for MACVLAN into its own function.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   48 +++++++++++++++---------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 39e109d..d10b25f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -46,42 +46,50 @@
 #include "ixgbe_sriov.h"
 
 #ifdef CONFIG_PCI_IOV
-static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter)
+static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	int num_vf_macvlans, i;
 	struct vf_macvlans *mv_list;
-
-	adapter->flags |= IXGBE_FLAG_SRIOV_ENABLED;
-	e_info(probe, "SR-IOV enabled with %d VFs\n", adapter->num_vfs);
-
-	/* Enable VMDq flag so device will be set in VM mode */
-	adapter->flags |= IXGBE_FLAG_VMDQ_ENABLED;
-	if (!adapter->ring_feature[RING_F_VMDQ].limit)
-		adapter->ring_feature[RING_F_VMDQ].limit = 1;
-	adapter->ring_feature[RING_F_VMDQ].offset = adapter->num_vfs;
+	int num_vf_macvlans, i;
 
 	num_vf_macvlans = hw->mac.num_rar_entries -
-	(IXGBE_MAX_PF_MACVLANS + 1 + adapter->num_vfs);
+			  (IXGBE_MAX_PF_MACVLANS + 1 + adapter->num_vfs);
+	if (!num_vf_macvlans)
+		return;
 
-	adapter->mv_list = mv_list = kcalloc(num_vf_macvlans,
-					     sizeof(struct vf_macvlans),
-					     GFP_KERNEL);
+	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
+			  GFP_KERNEL);
 	if (mv_list) {
 		/* Initialize list of VF macvlans */
 		INIT_LIST_HEAD(&adapter->vf_mvs.l);
 		for (i = 0; i < num_vf_macvlans; i++) {
-			mv_list->vf = -1;
-			mv_list->free = true;
-			list_add(&mv_list->l, &adapter->vf_mvs.l);
-			mv_list++;
+			mv_list[i].vf = -1;
+			mv_list[i].free = true;
+			list_add(&mv_list[i].l, &adapter->vf_mvs.l);
 		}
+		adapter->mv_list = mv_list;
 	}
+}
+
+static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	adapter->flags |= IXGBE_FLAG_SRIOV_ENABLED;
+	e_info(probe, "SR-IOV enabled with %d VFs\n", adapter->num_vfs);
+
+	/* Enable VMDq flag so device will be set in VM mode */
+	adapter->flags |= IXGBE_FLAG_VMDQ_ENABLED;
+	if (!adapter->ring_feature[RING_F_VMDQ].limit)
+		adapter->ring_feature[RING_F_VMDQ].limit = 1;
+	adapter->ring_feature[RING_F_VMDQ].offset = adapter->num_vfs;
 
 	/* Initialize default switching mode VEB */
 	IXGBE_WRITE_REG(hw, IXGBE_PFDTXGSWC, IXGBE_PFDTXGSWC_VT_LBEN);
 	adapter->bridge_mode = BRIDGE_MODE_VEB;
 
+	ixgbe_alloc_vf_macvlans(adapter);
+
 	/* If call to enable VFs succeeded then allocate memory
 	 * for per VF control structures.
 	 */
@@ -89,6 +97,8 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter)
 		kcalloc(adapter->num_vfs,
 			sizeof(struct vf_data_storage), GFP_KERNEL);
 	if (adapter->vfinfo) {
+		int i;
+
 		/* limit trafffic classes based on VFs enabled */
 		if ((adapter->hw.mac.type == ixgbe_mac_82599EB) &&
 		    (adapter->num_vfs < 16)) {

