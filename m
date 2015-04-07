From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Tue,  7 Apr 2015 19:45:30 -0400
Subject: [Intel-wired-lan] [net-next S3 01/13] i40evf: fix bad indentation
Message-ID: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Not sure how this slipped through. Cosmetic change only.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Iefec17e6bc14985d8cb7925c0bac770aa37de7c9
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 6d5f3b2..a31bfd1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2029,7 +2029,7 @@ static void i40evf_init_task(struct work_struct *work)
 		if (err) {
 			dev_err(&pdev->dev, "Failed to set MAC type (%d)\n",
 				err);
-		goto err;
+			goto err;
 		}
 		err = i40evf_check_reset_complete(hw);
 		if (err) {
-- 
1.9.3

