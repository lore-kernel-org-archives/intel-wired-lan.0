From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri,  2 Oct 2015 17:57:21 -0700
Subject: [Intel-wired-lan] [net PATCH] i40e: fix annoying message
Message-ID: <1443833841-2862-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver was printing a message about not being able
to assign VMDq because of a lack of MSI-X vectors.

This was because a line was missing that initialized a variable,
simply a merge error.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 851dcec..1672671 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8164,6 +8164,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	if (pf->hw.func_caps.vmdq) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
 		pf->flags |= I40E_FLAG_VMDQ_ENABLED;
+		pf->num_vmdq_qps = i40e_default_queues_per_vmdq(pf);
 	}
 
 #ifdef I40E_FCOE
-- 
2.1.0

