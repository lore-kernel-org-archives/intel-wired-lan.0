From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:14 -0800
Subject: [Intel-wired-lan] [next PATCH S28 07/15] i40e: Removal of code
	which relies on BASE VEB SEID
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-8-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

Fixed mapping of SEID is removed from specification. Hence
this patch removes code which was using hardcoded base VEB SEID.

Changed FCoE code to use "hw->pf_id" to obtain correct "idx"
and verified.

Removed defines for BASE VSI/VEB SEID and BASE_PF_SEID since it
is not used anymore.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-ID: Id507cf4b1fae1c0145e3f08ae9ea5846ea5840de
---
Testing Hints:
	Please test using debugfs hook for "dump veb <seid>".
		echo "dump veb [seid]" > command
	Here "seid" is VEB seid and it is optional argument. If "seid"
	is not specified, it dumps all VEBs.

	After this patch, user shall see output in dmesg. Without this patch,
	if SEID is not in range, user will see error like
		"<seid>: bad seid"

 drivers/net/ethernet/intel/i40e/i40e.h         |  3 ---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 16 +++-------------
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 +-
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e37af29..ceb72d8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -64,9 +64,6 @@
 #include "i40e_dcb.h"
 
 /* Useful i40e defaults */
-#define I40E_BASE_PF_SEID     16
-#define I40E_BASE_VSI_SEID    512
-#define I40E_BASE_VEB_SEID    288
 #define I40E_MAX_VEB          16
 
 #define I40E_MAX_NUM_DESCRIPTORS      4096
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 631c2d6..2a44f2e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -61,13 +61,9 @@ static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
 {
 	int i;
 
-	if ((seid < I40E_BASE_VEB_SEID) ||
-	    (seid > (I40E_BASE_VEB_SEID + I40E_MAX_VEB)))
-		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
-	else
-		for (i = 0; i < I40E_MAX_VEB; i++)
-			if (pf->veb[i] && pf->veb[i]->seid == seid)
-				return pf->veb[i];
+	for (i = 0; i < I40E_MAX_VEB; i++)
+		if (pf->veb[i] && pf->veb[i]->seid == seid)
+			return pf->veb[i];
 	return NULL;
 }
 
@@ -691,12 +687,6 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
 {
 	struct i40e_veb *veb;
 
-	if ((seid < I40E_BASE_VEB_SEID) ||
-	    (seid >= (I40E_MAX_VEB + I40E_BASE_VEB_SEID))) {
-		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
-		return;
-	}
-
 	veb = i40e_dbg_find_veb(pf, seid);
 	if (!veb) {
 		dev_info(&pf->pdev->dev, "can't find veb %d\n", seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4f4262e..90e37f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -768,7 +768,7 @@ static void i40e_update_fcoe_stats(struct i40e_vsi *vsi)
 	if (vsi->type != I40E_VSI_FCOE)
 		return;
 
-	idx = (pf->pf_seid - I40E_BASE_PF_SEID) + I40E_FCOE_PF_STAT_OFFSET;
+	idx = hw->pf_id + I40E_FCOE_PF_STAT_OFFSET;
 	fs = &vsi->fcoe_stats;
 	ofs = &vsi->fcoe_stats_offsets;
 
-- 
2.1.0

