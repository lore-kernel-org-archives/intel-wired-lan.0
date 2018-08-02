From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:27 -0700
Subject: [Intel-wired-lan] [next PATCH S94 04/13] i40e: Display message when
 entering and leaving recovery mode
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch adds notification in dmesg when the driver detects the NIC
entered recovery mode. It also displays appropriate information when the
adapter leaves recovery mode restoring normal functionality.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0a1ecdf..c1bccf8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13559,12 +13559,14 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
 	u32 val = rd32(&pf->hw, I40E_GL_FWSTS);
 
 	if (val & I40E_GL_FWSTS_FWS1B_MASK) {
-		dev_info(&pf->pdev->dev, "transition FW detected, running in recovery mode\n");
+		dev_notice(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
+		dev_notice(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
 		set_bit(__I40E_RECOVERY_MODE, pf->state);
 
 		return true;
 	}
-	clear_bit(__I40E_RECOVERY_MODE, pf->state);
+	if (test_and_clear_bit(__I40E_RECOVERY_MODE, pf->state))
+		dev_info(&pf->pdev->dev, "Reinitializing in normal mode with full functionality.\n");
 
 	return false;
 }
-- 
2.9.5

