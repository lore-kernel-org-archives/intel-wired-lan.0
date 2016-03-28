From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Mon, 28 Mar 2016 04:17:14 -0700
Subject: [Intel-wired-lan] [next PATCH S32 03/14] i40e: Move HW flush
In-Reply-To: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459163845-28035-4-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch moves the HW flush routine to the end of the reset flow,
after the completion of writing to the device VFLR registers- the
benefit is to avoid problems in the passthrough routines.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Change-ID: Ieb56866f21895e6c1fc514b7328c3df79807a57c
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f93a649..21dd1be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -811,6 +811,7 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 	reg_idx = (hw->func_caps.vf_base_id + vf->vf_id) / 32;
 	bit_idx = (hw->func_caps.vf_base_id + vf->vf_id) % 32;
 	wr32(hw, I40E_GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
+	i40e_flush(hw);
 
 	if (i40e_quiesce_vf_pci(vf))
 		dev_err(&pf->pdev->dev, "VF %d PCI transactions stuck\n",
-- 
2.4.3

