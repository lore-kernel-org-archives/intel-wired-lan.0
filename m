From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Fri, 17 Nov 2017 15:35:57 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix reporting
 incorrect error codes
Message-ID: <151096175699.30716.6788678147370883532.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Adding cloud filters could fail for a number of reasons,
unsupported filter fields for example, which fails during
validation of fields itself. This will not result in admin
command errors and converting the admin queue status to posix
error code using i40e_aq_rc_to_posix would result in incorrect
error values. If the failure was due to AQ error itself,
reporting that correclty is handled in the inner function.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4d0f81d..565ce12 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7470,7 +7470,6 @@ static int i40e_configure_clsflower(struct i40e_vsi *vsi,
 		dev_err(&pf->pdev->dev,
 			"Failed to add cloud filter, err %s\n",
 			i40e_stat_str(&pf->hw, err));
-		err = i40e_aq_rc_to_posix(err, pf->hw.aq.asq_last_status);
 		goto err;
 	}
 

