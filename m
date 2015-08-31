From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:48 -0400
Subject: [Intel-wired-lan] [next PATCH S14 08/15] i40e: don't panic on VSI
	allocation failure
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some circumstances, the firmware may fail to allocate a VSI for a VF.
When this happens, the driver does not react well to the bad news and
has a panic attack.

To fix this problem, check the return value from i40e_alloc_vf_res and
don't try to configure the device further if it failed. Additionally,
explicitly clear the INIT bit when we free VF resources, so that this
bit will be in the proper state in the failure case, and won't blow up
elsewhere.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I6a20ce2b59c3458fd832032e88fa28cd42500189
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index e27430d..17c21b9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -703,6 +703,7 @@ static void i40e_free_vf_res(struct i40e_vf *vf)
 	 */
 	vf->num_queue_pairs = 0;
 	vf->vf_states = 0;
+	clear_bit(I40E_VF_STAT_INIT, &vf->vf_states);
 }
 
 /**
@@ -841,11 +842,11 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 complete_reset:
 	/* reallocate VF resources to reset the VSI state */
 	i40e_free_vf_res(vf);
-	i40e_alloc_vf_res(vf);
-	i40e_enable_vf_mappings(vf);
-	set_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states);
-	clear_bit(I40E_VF_STAT_DISABLED, &vf->vf_states);
-
+	if (!i40e_alloc_vf_res(vf)) {
+		i40e_enable_vf_mappings(vf);
+		set_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states);
+		clear_bit(I40E_VF_STAT_DISABLED, &vf->vf_states);
+	}
 	/* tell the VF the reset is done */
 	wr32(hw, I40E_VFGEN_RSTAT1(vf->vf_id), I40E_VFR_VFACTIVE);
 	i40e_flush(hw);
-- 
1.9.3

