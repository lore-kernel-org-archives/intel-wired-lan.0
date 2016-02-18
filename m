From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Feb 2016 16:12:18 -0800
Subject: [Intel-wired-lan] [next PATCH S29 08/14] i40e: Fix PSOD's when npar
	enabled
In-Reply-To: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455754344-6372-9-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: John Underwood <johnx.underwood@intel.com>

Return from i40e_vsi_reinit_setup() if vsi param is NULL.
This makes this code consistent with all the other code that
checks for NULL before using one of the VSI pointers accessed
with an indexed variable. (Indexed VSI pointers are
intentionally set to NULL in i40e_vsi_clear() and
i40e_remove().

Signed-off-by: John Underwood <johnx.underwood@intel.com>
Change-ID: I3bc8b909c70fd2439334eeae994d151f61480985
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2a02f93..3c910ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9579,10 +9579,15 @@ vector_setup_out:
  **/
 static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 {
-	struct i40e_pf *pf = vsi->back;
+	struct i40e_pf *pf;
 	u8 enabled_tc;
 	int ret;
 
+	if (!vsi)
+		return NULL;
+
+	pf = vsi->back;
+
 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
 	i40e_vsi_clear_rings(vsi);
 
-- 
2.1.0

