From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 18:05:11 -0700
Subject: [Intel-wired-lan] [next PATCH S45 09/10] i40e: removing unreachable
	code
In-Reply-To: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473210312-29592-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

The return value from i40e_shutdown_adminq() is always 0
(I40E_SUCCESS). So, the test for non-0 will never be true. Cleanup
by removing the test and debug print statement.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Change-ID: Ie51e8e37515c3e3a6a9ff26fa951d0e5e24343c1
---
Testing Hints:
   Found by static code analysis. Test by code inspection.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3be9675..f741649 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11405,11 +11405,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	}
 
 	/* shutdown the adminq */
-	ret_code = i40e_shutdown_adminq(hw);
-	if (ret_code)
-		dev_warn(&pdev->dev,
-			 "Failed to destroy the Admin Queue resources: %d\n",
-			 ret_code);
+	i40e_shutdown_adminq(hw);
 
 	/* destroy the locks only once, here */
 	mutex_destroy(&hw->aq.arq_mutex);
-- 
2.4.11

