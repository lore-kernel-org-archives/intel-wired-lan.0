From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 30 Mar 2016 03:49:43 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S32 08/13] i40e: Restrict VF poll
	mode to only single function mode devices
In-Reply-To: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459334988-19951-9-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

The VFs can request their queues to be set up into polling mode, rather
than interrupt mode, which works well for supporting things like DPDK,
but this should not be available when working in an multi-function
support device.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Id36792e4e7422db8f2033336507211f68f14ff6f
---
Testing Hints:
    case 1:
	set up a DPDK VF in an NPAR environment
	the VF polling request should be failed and a message logged
    case 2:
	set up a DPDK VF in an SFP environment
	the VF polling request should succeed

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b353966..30f8cbe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1362,8 +1362,16 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2;
 	}
 
-	if (vf->driver_caps & I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING)
+	if (vf->driver_caps & I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING) {
+		if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+			dev_err(&pf->pdev->dev,
+				"VF %d requested polling mode: this feature is supported only when the device is running in single function per port (SFP) mode\n",
+				 vf->vf_id);
+			ret = I40E_ERR_PARAM;
+			goto err;
+		}
 		vfres->vf_offload_flags |= I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING;
+	}
 
 	if (pf->flags & I40E_FLAG_WB_ON_ITR_CAPABLE) {
 		if (vf->driver_caps & I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
-- 
2.4.3

