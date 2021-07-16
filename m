From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 16 Jul 2021 11:33:56 +0200
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix pre-set max number of
 queues for VF
Message-ID: <20210716093356.7800-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After setting pre-set combined to 16 queues and reserving 16 queues by
tc qdisc, pre-set maximum combined queues returned to default value
after VF reset being 4 and this generated errors during removing tc.
Fixed by removing clear num_req_queues before reset VF.

Fixes: e284fc280473 (i40e: Add and delete cloud filter)
Change-Id: Ib2db315e4b04eeb15e12301edf833014a929e914
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v2: Refactored commit message
 v3: Fixed wrong e-mail address in commit message
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4da982b..c007fba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3873,11 +3873,6 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 
 	/* set this flag only after making sure all inputs are sane */
 	vf->adq_enabled = true;
-	/* num_req_queues is set when user changes number of queues via ethtool
-	 * and this causes issue for default VSI(which depends on this variable)
-	 * when ADq is enabled, hence reset it.
-	 */
-	vf->num_req_queues = 0;
 
 	/* reset the VF in order to allocate resources */
 	i40e_vc_reset_vf(vf, true);
-- 
2.27.0

