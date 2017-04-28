From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 28 Apr 2017 16:53:15 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 1/3] i40evf: fix duplicate
	lines
In-Reply-To: <1493423597-18306-1-git-send-email-jesse.brandeburg@intel.com>
References: <1493423597-18306-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <1493423597-18306-2-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This removes two duplicate lines that snuck into the code somehow.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index deb2cb8..3cdac24 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -152,8 +152,6 @@ int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
 {
 	u32 caps;
 
-	adapter->current_op = I40E_VIRTCHNL_OP_GET_VF_RESOURCES;
-	adapter->aq_required &= ~I40EVF_FLAG_AQ_GET_CONFIG;
 	caps = I40E_VIRTCHNL_VF_OFFLOAD_L2 |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG |
-- 
1.8.3.1

