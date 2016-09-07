From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 18:05:08 -0700
Subject: [Intel-wired-lan] [next PATCH S45 06/10] i40e: add encap csum VF
	offload flag
In-Reply-To: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473210312-29592-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Preethi Banala <preethi.banala@intel.com>

Add ENCAP_CSUM offload negotiation flag. Currently VF assumes checksum
offload for encapsulated packets is supported by default. Going forward,
this feature needs to be negotiated with PF before advertising to the
stack. Hence, we need a flag to control it.
This is in regards to prepping up for VF base mode functionality support.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Change-ID: Iaab1f25cc0abda5f2fbe3309092640f0e77d163e
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
index c92a3bd..f861d31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
@@ -163,6 +163,7 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING	0x00020000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2	0x00040000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF		0X00080000
+#define I40E_VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM	0X00100000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index f04ce6c..bd691ad 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -160,6 +160,7 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING	0x00020000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2	0x00040000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF		0X00080000
+#define I40E_VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM	0X00100000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
-- 
2.4.11

