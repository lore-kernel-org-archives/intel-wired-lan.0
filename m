From: Alice Michael <alice.michael@intel.com>
Date: Fri, 26 Oct 2018 14:33:33 -0700
Subject: [Intel-wired-lan] [next PATCH S98 6/6] i40e: suppress bogus error
 message
In-Reply-To: <20181026213333.51495-1-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
Message-ID: <20181026213333.51495-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The i40e driver complains about unprivileged VFs trying to configure
promiscuous mode each time a VF reset occurs. This isn't the fault of
the poor VF driver - the PF driver itself is making the request.

To fix this, skip the privilege check if the request is to disable all
promiscuous activity. This gets rid of the bogus message, but doesn't
affect privilege checks, since we really only care if the unprivileged
VF is trying to enable promiscuous mode.

Testing Hints (required if no HSD): watch dmesg log while VF resets
occur. You can trigger a VFR by unloading i40evf or shutting down the VM
with an assigned VF.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index ac5698e..c41e8ad 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1112,7 +1112,8 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
 		return I40E_ERR_PARAM;
 
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
+	    (allmulti || alluni)) {
 		dev_err(&pf->pdev->dev,
 			"Unprivileged VF %d is attempting to configure promiscuous mode\n",
 			vf->vf_id);
-- 
2.9.5

