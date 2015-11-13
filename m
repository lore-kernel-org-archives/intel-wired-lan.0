From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 15:47:10 -0800
Subject: [Intel-wired-lan] [next PATCH S22 10/14] i40e: Add a Virtchnl
	offload for RSS PCTYPE V2
In-Reply-To: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447458434-4555-11-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

X722 supports Expanded version of TCP, UDP PCTYPES for RSS.
Add a Virtchnl offload to support this.

Without this patch VF drivers will not be able to support
the correct PCTYPES for X722 and UDP flows will not fan out.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Acked-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: I85ddd530a7025eb0e5321048da84d058b46e7d67
---
Testing Hints:
After applying the right driver changes to support the offload
for X722, try multiple UDP flows on VF driver to see they get
spread out by RSS.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 1 +
 2 files changed, 2 insertions(+)

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
-- 
2.1.0

