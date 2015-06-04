From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  4 Jun 2015 16:23:57 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 3/8] i40e:
	support virtual channel API 1.1
In-Reply-To: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433449442-31420-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Store off the VF API version for use when figuring out the VF driver
capabilities. Add support for the VF driver handing its capabilities to
the PF driver and then use this information when sending VF resource
information back to the VF driver.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ic00d0eeeb5b8118085e12f068ef857089a8f7c2d
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 25 ++++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b639510..1bfc4d0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1113,12 +1113,13 @@ static int i40e_vc_send_resp_to_vf(struct i40e_vf *vf,
  *
  * called from the VF to request the API version used by the PF
  **/
-static int i40e_vc_get_version_msg(struct i40e_vf *vf)
+static int i40e_vc_get_version_msg(struct i40e_vf *vf, u8 *msg)
 {
 	struct i40e_virtchnl_version_info info = {
 		I40E_VIRTCHNL_VERSION_MAJOR, I40E_VIRTCHNL_VERSION_MINOR
 	};
 
+	vf->vf_ver = *(struct i40e_virtchnl_version_info *)msg;
 	return i40e_vc_send_msg_to_vf(vf, I40E_VIRTCHNL_OP_VERSION,
 				      I40E_SUCCESS, (u8 *)&info,
 				      sizeof(struct
@@ -1133,7 +1134,7 @@ static int i40e_vc_get_version_msg(struct i40e_vf *vf)
  *
  * called from the VF to request its resources
  **/
-static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf)
+static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 {
 	struct i40e_virtchnl_vf_resource *vfres = NULL;
 	struct i40e_pf *pf = vf->pf;
@@ -1157,11 +1158,18 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf)
 		len = 0;
 		goto err;
 	}
+	if (VF_IS_V11(vf))
+		vf->driver_caps = *(u32 *)msg;
+	else
+		vf->driver_caps = I40E_VIRTCHNL_VF_OFFLOAD_L2 |
+				  I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG |
+				  I40E_VIRTCHNL_VF_OFFLOAD_VLAN;
 
 	vfres->vf_offload_flags = I40E_VIRTCHNL_VF_OFFLOAD_L2;
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi->info.pvid)
-		vfres->vf_offload_flags |= I40E_VIRTCHNL_VF_OFFLOAD_VLAN;
+		vfres->vf_offload_flags |= I40E_VIRTCHNL_VF_OFFLOAD_VLAN |
+					   I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG;
 
 	vfres->num_vsis = num_vsis;
 	vfres->num_queue_pairs = vf->num_queue_pairs;
@@ -1763,9 +1771,14 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 		valid_len = sizeof(struct i40e_virtchnl_version_info);
 		break;
 	case I40E_VIRTCHNL_OP_RESET_VF:
-	case I40E_VIRTCHNL_OP_GET_VF_RESOURCES:
 		valid_len = 0;
 		break;
+	case I40E_VIRTCHNL_OP_GET_VF_RESOURCES:
+		if (VF_IS_V11(vf))
+			valid_len = sizeof(u32);
+		else
+			valid_len = 0;
+		break;
 	case I40E_VIRTCHNL_OP_CONFIG_TX_QUEUE:
 		valid_len = sizeof(struct i40e_virtchnl_txq_info);
 		break;
@@ -1878,10 +1891,10 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, u16 vf_id, u32 v_opcode,
 
 	switch (v_opcode) {
 	case I40E_VIRTCHNL_OP_VERSION:
-		ret = i40e_vc_get_version_msg(vf);
+		ret = i40e_vc_get_version_msg(vf, msg);
 		break;
 	case I40E_VIRTCHNL_OP_GET_VF_RESOURCES:
-		ret = i40e_vc_get_vf_resources_msg(vf);
+		ret = i40e_vc_get_vf_resources_msg(vf, msg);
 		break;
 	case I40E_VIRTCHNL_OP_RESET_VF:
 		i40e_vc_reset_vf_msg(vf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index d254a5e..736f6f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -78,6 +78,8 @@ struct i40e_vf {
 	u16 vf_id;
 	/* all VF vsis connect to the same parent */
 	enum i40e_switch_element_types parent_type;
+	struct i40e_virtchnl_version_info vf_ver;
+	u32 driver_caps; /* reported by VF driver */
 
 	/* VF Port Extender (PE) stag if used */
 	u16 stag;
-- 
1.9.3

