From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 14 Sep 2016 16:24:37 -0700
Subject: [Intel-wired-lan] [next PATCH S47 7/9] i40e: group base mode VF
	offload flags
In-Reply-To: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473895479-23035-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Preethi Banala <preethi.banala@intel.com>

Group together the minimum set of offload capabilities that are always
supported by VF in base mode. This define would be used by PF to make
sure VF in base mode gets minimum of base capabilities .

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Change-ID: Id5e8f22ba169c8f0a38d22fc36b2cb531c02582c
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 4 ++++
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
index f861d31..974ba2b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
@@ -165,6 +165,10 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF		0X00080000
 #define I40E_VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM	0X00100000
 
+#define I40E_VF_BASE_MODE_OFFLOADS (I40E_VIRTCHNL_VF_OFFLOAD_L2 | \
+				    I40E_VIRTCHNL_VF_OFFLOAD_VLAN | \
+				    I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF)
+
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
 	u16 num_queue_pairs;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index bd691ad..fc374f8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -162,6 +162,10 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF		0X00080000
 #define I40E_VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM	0X00100000
 
+#define I40E_VF_BASE_MODE_OFFLOADS (I40E_VIRTCHNL_VF_OFFLOAD_L2 | \
+				    I40E_VIRTCHNL_VF_OFFLOAD_VLAN | \
+				    I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF)
+
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
 	u16 num_queue_pairs;
-- 
2.4.11

