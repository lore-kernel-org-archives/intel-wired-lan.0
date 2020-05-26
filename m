From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Date: Tue, 26 May 2020 12:51:12 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: make PF wait reset loop reliable
Message-ID: <20200526105112.3228-1-piotr.kwapulinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use jiffies to limit max waiting time for PF reset to succeed.
Previous wait loop was unreliable. It required unreasonably long time
to wait for PF reset after reboot when NIC was about to enter
recovery mode

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2a037ec..4b12a54 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14606,25 +14606,23 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
  **/
 static i40e_status i40e_pf_loop_reset(struct i40e_pf *pf)
 {
-	const unsigned short MAX_CNT = 1000;
-	const unsigned short MSECS = 10;
+	/* wait max 10 seconds for PF reset to succeed */
+	const unsigned long time_end = jiffies + 10 * HZ;
+
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
-	int cnt;
 
-	for (cnt = 0; cnt < MAX_CNT; ++cnt) {
+	ret = i40e_pf_reset(hw);
+	while (ret != I40E_SUCCESS && time_before(jiffies, time_end)) {
+		usleep_range(10000, 20000);
 		ret = i40e_pf_reset(hw);
-		if (!ret)
-			break;
-		msleep(MSECS);
 	}
 
-	if (cnt == MAX_CNT) {
+	if (ret == I40E_SUCCESS)
+		pf->pfr_count++;
+	else
 		dev_info(&pf->pdev->dev, "PF reset failed: %d\n", ret);
-		return ret;
-	}
 
-	pf->pfr_count++;
 	return ret;
 }
 
-- 
2.17.1

