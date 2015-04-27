From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:14 -0400
Subject: [Intel-wired-lan] [net-next S5 07/15] i40e: do a proper reset when
	disabling a VF
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The VF disable code was just whanging on the reset bit without properly
cleaning up the VF, which would leave the VF in an indeterminate state
from which it could not recover. Fix this by notifying the VF and then
by calling the normal VF reset routine.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I862b9dfa919368773cbdc212b805b520db2f7430
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5c7af7d..008ab29 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -160,13 +160,8 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
  **/
 static inline void i40e_vc_disable_vf(struct i40e_pf *pf, struct i40e_vf *vf)
 {
-	struct i40e_hw *hw = &pf->hw;
-	u32 reg;
-
-	reg = rd32(hw, I40E_VPGEN_VFRTRIG(vf->vf_id));
-	reg |= I40E_VPGEN_VFRTRIG_VFSWR_MASK;
-	wr32(hw, I40E_VPGEN_VFRTRIG(vf->vf_id), reg);
-	i40e_flush(hw);
+	i40e_vc_notify_vf_reset(vf);
+	i40e_reset_vf(vf, false);
 }
 
 /**
-- 
1.9.3

