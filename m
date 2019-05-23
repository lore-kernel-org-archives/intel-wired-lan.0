From: Lihong Yang <lihong.yang@intel.com>
Date: Thu, 23 May 2019 16:45:33 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Do not check VF state in
 i40e_ndo_get_vf_config
Message-ID: <20190523234533.48418-1-lihong.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The VF configuration returned in i40e_ndo_get_vf_config is
already stored by the PF. There is no dependency on any
specific state of the VF to return the configuration.
Drop the check against I40E_VF_STATE_INIT since it is not
needed.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4f4521d39725..38484ed6880d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4299,10 +4299,8 @@ int i40e_ndo_get_vf_config(struct net_device *netdev,
 	vf = &pf->vf[vf_id];
 	/* first vsi is always the LAN vsi */
 	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
-		ret = -EAGAIN;
+	if (!vsi) {
+		ret = -ENOENT;
 		goto error_param;
 	}
 
-- 
2.20.1

