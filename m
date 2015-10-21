From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:05 -0400
Subject: [Intel-wired-lan] [next PATCH S19 04/15] i40e: remove BUG_ON from
	fcoe setup
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

There's no need to kill the kernel thread here. If this condition was
true, the probe() would have died long before we got here. In any case,
we'll get the same result when this code tries to use the vsi pointer
being checked.

Prompted by a recent Linus diatribe.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I62f531cac34d4fc28ff9657d5b2d9523ae5e33a4

---
Testing-hints: Internal code change, check that the patch was applied
and compiled correctly.
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
index fe5d9bf..579a46c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
@@ -1544,8 +1544,6 @@ void i40e_fcoe_vsi_setup(struct i40e_pf *pf)
 	if (!(pf->flags & I40E_FLAG_FCOE_ENABLED))
 		return;
 
-	BUG_ON(!pf->vsi[pf->lan_vsi]);
-
 	for (i = 0; i < pf->num_alloc_vsi; i++) {
 		vsi = pf->vsi[i];
 		if (vsi && vsi->type == I40E_VSI_FCOE) {
-- 
1.9.3

