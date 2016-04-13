From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:21 -0700
Subject: [Intel-wired-lan] [next PATCH S34 01/12] i40e: Change the default
	for VFs to be not privileged
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-2-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Make sure a VF is not trusted/privileged until its explicitly
set for trust through the new NDO op interface.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-Id: I476385c290d2b4901d8fceb29de43546accdc499
---
Testing Hints (Required if no HSD):
With this now a VF cannot add filters or enable promisc unless trusted.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5be10cf..e2c3149 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -860,7 +860,11 @@ static int i40e_alloc_vf_res(struct i40e_vf *vf)
 	if (ret)
 		goto error_alloc;
 	total_queue_pairs += pf->vsi[vf->lan_vsi_idx]->alloc_queue_pairs;
-	set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+
+	if (vf->trusted)
+		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
 
 	/* store the total qps number for the runtime
 	 * VF req validation
@@ -1847,15 +1851,17 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf, u8 *macaddr)
 		dev_err(&pf->pdev->dev, "invalid VF MAC addr %pM\n", macaddr);
 		ret = I40E_ERR_INVALID_MAC_ADDR;
 	} else if (vf->pf_set_mac && !is_multicast_ether_addr(macaddr) &&
+		   !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
 		   !ether_addr_equal(macaddr, vf->default_lan_addr.addr)) {
 		/* If the host VMM administrator has set the VF MAC address
 		 * administratively via the ndo_set_vf_mac command then deny
 		 * permission to the VF to add or delete unicast MAC addresses.
+		 * Unless the VF is privileged and then it can do whatever.
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
 		dev_err(&pf->pdev->dev,
-			"VF attempting to override administratively set MAC address\nPlease reload the VF driver to resume normal operation\n");
+			"VF attempting to override administratively set MAC address, reload the VF driver to resume normal operation\n");
 		ret = -EPERM;
 	}
 	return ret;
@@ -1880,7 +1886,6 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	int i;
 
 	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
 		ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -1954,7 +1959,6 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	int i;
 
 	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
 		ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -2207,7 +2211,6 @@ static int i40e_vc_config_rss_key(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	i40e_status aq_ret = 0;
 
 	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vsi_id) ||
 	    (vrk->key_len != I40E_HKEY_ARRAY_SIZE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -2240,7 +2243,6 @@ static int i40e_vc_config_rss_lut(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	i40e_status aq_ret = 0;
 
 	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vsi_id) ||
 	    (vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -2270,8 +2272,7 @@ static int i40e_vc_get_rss_hena(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	i40e_status aq_ret = 0;
 	int len = 0;
 
-	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -2307,8 +2308,7 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status aq_ret = 0;
 
-	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
-- 
2.4.3

