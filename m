From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 28 Apr 2017 16:53:16 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 2/3] i40evf: fix merge error
	in older patch
In-Reply-To: <1493423597-18306-2-git-send-email-jesse.brandeburg@intel.com>
References: <1493423597-18306-1-git-send-email-jesse.brandeburg@intel.com>
 <1493423597-18306-2-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <1493423597-18306-3-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a missing line that was missed while merging,
which results in a driver feature in the VF not working to
enable RSS as a negotiated feature.

Fixes: 43a3d9ba34c9c ("i40evf: Allow PF driver to configure RSS")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 3cdac24..91b21f2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -153,6 +153,7 @@ int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
 	u32 caps;
 
 	caps = I40E_VIRTCHNL_VF_OFFLOAD_L2 |
+	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG |
 	       I40E_VIRTCHNL_VF_OFFLOAD_VLAN |
-- 
1.8.3.1

