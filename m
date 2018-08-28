From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 Aug 2018 10:16:05 -0700
Subject: [Intel-wired-lan] [next PATCH S96 5/9] i40e: add a helper function
 to validate a vf based on the vf id
In-Reply-To: <20180828171609.78242-1-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
Message-ID: <20180828171609.78242-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

When we are trying to change VF settings, it is possible for 2 race
conditions to happen. One, when the VF is created but not yet enabled.
Second, the VF is enabled but the vsi is still not created or not yet
re-created in the VF reset flow.

This patch introduces a helper function to validate that the vf is
enabled and that the vsi is set up. This patch also calls this
function from other functions which could get into these race conditions.
While we are poking around here, remove unnecessary parenthesis that
checkpatch was complaining about.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 62 ++++++++++++++--------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index ca423be..b299003 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3833,6 +3833,35 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 }
 
 /**
+ * i40e_validate_vf
+ * @pf: the physical function
+ * @vf_id: VF identifier
+ *
+ * Check that the VF is enabled and the vsi exists.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int i40e_validate_vf(struct i40e_pf *pf, int vf_id)
+{
+	struct i40e_vsi *vsi;
+	struct i40e_vf *vf;
+	int ret = 0;
+
+	if (vf_id >= pf->num_alloc_vfs) {
+		dev_err(&pf->pdev->dev,
+			"Invalid VF Identifier %d\n", vf_id);
+		ret = -EINVAL;
+		goto err_out;
+	}
+	vf = &pf->vf[vf_id];
+	vsi = i40e_find_vsi_from_id(pf, vf->lan_vsi_id);
+	if (!vsi)
+		ret = -EINVAL;
+err_out:
+	return ret;
+}
+
+/**
  * i40e_ndo_set_vf_mac
  * @netdev: network interface device structure
  * @vf_id: VF identifier
@@ -3853,14 +3882,11 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	u8 i;
 
 	/* validate the request */
-	if (vf_id >= pf->num_alloc_vfs) {
-		dev_err(&pf->pdev->dev,
-			"Invalid VF Identifier %d\n", vf_id);
-		ret = -EINVAL;
+	ret = i40e_validate_vf(pf, vf_id);
+	if (ret)
 		goto error_param;
-	}
 
-	vf = &(pf->vf[vf_id]);
+	vf = &pf->vf[vf_id];
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	/* When the VF is resetting wait until it is done.
@@ -3979,11 +4005,9 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	int ret = 0;
 
 	/* validate the request */
-	if (vf_id >= pf->num_alloc_vfs) {
-		dev_err(&pf->pdev->dev, "Invalid VF Identifier %d\n", vf_id);
-		ret = -EINVAL;
+	ret = i40e_validate_vf(pf, vf_id);
+	if (ret)
 		goto error_pvid;
-	}
 
 	if ((vlan_id > I40E_MAX_VLANID) || (qos > 7)) {
 		dev_err(&pf->pdev->dev, "Invalid VF Parameters\n");
@@ -3997,7 +4021,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		goto error_pvid;
 	}
 
-	vf = &(pf->vf[vf_id]);
+	vf = &pf->vf[vf_id];
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
 		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
@@ -4117,11 +4141,9 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	int ret = 0;
 
 	/* validate the request */
-	if (vf_id >= pf->num_alloc_vfs) {
-		dev_err(&pf->pdev->dev, "Invalid VF Identifier %d.\n", vf_id);
-		ret = -EINVAL;
+	ret = i40e_validate_vf(pf, vf_id);
+	if (ret)
 		goto error;
-	}
 
 	if (min_tx_rate) {
 		dev_err(&pf->pdev->dev, "Invalid min tx rate (%d) (greater than 0) specified for VF %d.\n",
@@ -4129,7 +4151,7 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 		return -EINVAL;
 	}
 
-	vf = &(pf->vf[vf_id]);
+	vf = &pf->vf[vf_id];
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
 		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
@@ -4165,13 +4187,11 @@ int i40e_ndo_get_vf_config(struct net_device *netdev,
 	int ret = 0;
 
 	/* validate the request */
-	if (vf_id >= pf->num_alloc_vfs) {
-		dev_err(&pf->pdev->dev, "Invalid VF Identifier %d\n", vf_id);
-		ret = -EINVAL;
+	ret = i40e_validate_vf(pf, vf_id);
+	if (ret)
 		goto error_param;
-	}
 
-	vf = &(pf->vf[vf_id]);
+	vf = &pf->vf[vf_id];
 	/* first vsi is always the LAN vsi */
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-- 
2.9.5

