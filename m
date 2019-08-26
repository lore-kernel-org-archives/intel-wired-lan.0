From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Aug 2019 11:16:49 -0700
Subject: [Intel-wired-lan] [next PATCH S9 1/7] i40e: Allow updating OROM
 when a NIC is in recovery mode
Message-ID: <20190826181655.15106-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Allow OROM update with nvmupdate tool when a NIC is in recovery mode.
Implemented by not exiting a recovery mode after firmware EMP reset
and before actual OROM update.
Previously it was not possible to do the OROM update with nvmupdate
tool.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a71369546c23..ed8e62cb5417 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14559,8 +14559,8 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
 
 		return true;
 	}
-	if (test_and_clear_bit(__I40E_RECOVERY_MODE, pf->state))
-		dev_info(&pf->pdev->dev, "Reinitializing in normal mode with full functionality.\n");
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
+		dev_info(&pf->pdev->dev, "Please do POR to initialize adapter in normal mode with full functionality.\n");
 
 	return false;
 }
-- 
2.21.0

