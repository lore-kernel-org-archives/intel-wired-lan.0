From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:12 -0700
Subject: [Intel-wired-lan] [next-queue S2 02/15] i40e: validate VSI param
	from VFs
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-2-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Validate that the VF has sent us a valid VSI index before actually using
that index. Without this code, a malicious or buggy VF driver could
panic the host by sending an invalid index into the VSI array.

Change-ID: I66a177687a0dcc281ec83e714d3813d70d18c8b4
Reported-by: Nick Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 0a93684..bb18412 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -57,6 +57,8 @@ static inline bool i40e_vc_isvalid_vsi_id(struct i40e_vf *vf, u8 vsi_id)
 {
 	struct i40e_pf *pf = vf->pf;
 
+	if (vsi_id > pf->num_alloc_vsi)
+		return false;
 	return pf->vsi[vsi_id]->vf_id == vf->vf_id;
 }
 
-- 
1.9.3

