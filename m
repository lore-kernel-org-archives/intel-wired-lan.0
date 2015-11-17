From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 17 Nov 2015 10:52:17 -0800
Subject: [Intel-wired-lan] [V2: next,
	PATCH S22 10/13] i40e/i40evf: Add a new offload for RSS PCTYPE V2
	for X722
Message-ID: <1447786337-12249-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

X722 supports Expanded version of TCP, UDP PCTYPES for RSS.
Add a Virtchnl offload to support this.

Without this patch with X722 devices, driver will set wrong PCTYPES
for VF and UDP flows will not fan out.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I04fe4988253b7cd108c9179a643c969764efcb76
---
V2: This patch is merged with patch containing change-ID I85ddd530a7025eb0e5321048da84d058b46e7d67

Testing-Hints:
Try multiple UDP flows on VF driver to see they get spread out by RSS.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
index ae87982..3226946 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
@@ -153,6 +153,7 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR	0x00000020
 #define I40E_VIRTCHNL_VF_OFFLOAD_VLAN		0x00010000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING	0x00020000
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2	0x00040000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index 9f7b279..3b9d203 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -153,6 +153,7 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR	0x00000020
 #define I40E_VIRTCHNL_VF_OFFLOAD_VLAN		0x00010000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING	0x00020000
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2	0x00040000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 3c9c008..c1c5262 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -157,7 +157,9 @@ int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG |
 	       I40E_VIRTCHNL_VF_OFFLOAD_VLAN |
-	       I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR;
+	       I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR |
+	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2;
+
 	adapter->current_op = I40E_VIRTCHNL_OP_GET_VF_RESOURCES;
 	adapter->aq_required &= ~I40EVF_FLAG_AQ_GET_CONFIG;
 	if (PF_IS_V11(adapter))
-- 
2.1.0

