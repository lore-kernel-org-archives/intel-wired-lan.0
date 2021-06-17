From: Karen Sornek <karen.sornek@intel.com>
Date: Thu, 17 Jun 2021 09:19:26 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add ensurance of
 MacVlan resources for every trusted VF
Message-ID: <20210617071926.256183-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Trusted VF can use up every resource available, leaving nothing
to other trusted VFs.
Introduce define, which calculates MacVlan resources available based
on maximum available MacVlan resources, bare minimum for each VF and
number of currently allocated VFs.

Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 31cabcaf00..67fa5f0041 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2735,12 +2735,21 @@ error_param:
 				      (u8 *)&stats, sizeof(stats));
 }
 
+#define I40E_MAX_MACVLAN_PER_HW 3072
+#define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
+	(num_ports))
 /* If the VF is not trusted restrict the number of MAC/VLAN it can program
  * MAC filters: 16 for multicast, 1 for MAC, 1 for broadcast
  */
 #define I40E_VC_MAX_MAC_ADDR_PER_VF (16 + 1 + 1)
 #define I40E_VC_MAX_VLAN_PER_VF 16
 
+#define I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(vf_num, num_ports)		\
+({	typeof(vf_num) vf_num_ = (vf_num);				\
+	typeof(num_ports) num_ports_ = (num_ports);			\
+	((I40E_MAX_MACVLAN_PER_PF(num_ports_) - vf_num_ *		\
+	I40E_VC_MAX_MAC_ADDR_PER_VF) / vf_num_) +			\
+	I40E_VC_MAX_MAC_ADDR_PER_VF; })
 /**
  * i40e_check_vf_permission
  * @vf: pointer to the VF info
@@ -2764,6 +2773,7 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 					   bool *is_quiet)
 {
 	struct i40e_pf *pf = vf->pf;
+	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
 	int mac2add_cnt = 0;
 	int i;
@@ -2809,12 +2819,26 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	 * number of addresses. Check to make sure that the additions do not
 	 * push us over the limit.
 	 */
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
-	    (i40e_count_filters(vsi) + mac2add_cnt) >
+	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+		if ((i40e_count_filters(vsi) + mac2add_cnt) >
 		    I40E_VC_MAX_MAC_ADDR_PER_VF) {
-		dev_err(&pf->pdev->dev,
-			"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
-		return -EPERM;
+			dev_err(&pf->pdev->dev,
+				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
+			return -EPERM;
+		}
+	/* If this VF is trusted, it can use more resources than untrusted.
+	 * However to ensure that every trusted VF has appropriate number of
+	 * resources, divide whole pool of resources per port and then across
+	 * all VFs.
+	 */
+	} else {
+		if ((i40e_count_filters(vsi) + mac2add_cnt) >
+		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
+						       hw->num_ports)) {
+			dev_err(&pf->pdev->dev,
+				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
+			return -EPERM;
+		}
 	}
 	return 0;
 }
-- 
2.27.0

