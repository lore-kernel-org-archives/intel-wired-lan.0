From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:19 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 13/13] i40e: relax warning
	message in case of version mismatch
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <20170714131019.52530-13-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

FVL and FPK devices are often on different firmware release
schedules. This change relaxes the minor version warning message,
so it is only displayed for older FW warning version for old
firmware FVL3 or earlier.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d83a9e6..93fa941 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11355,8 +11355,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	    hw->aq.api_min_ver > I40E_FW_API_VERSION_MINOR)
 		dev_info(&pdev->dev,
 			 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
-	else if (hw->aq.api_maj_ver < I40E_FW_API_VERSION_MAJOR ||
-		 hw->aq.api_min_ver < (I40E_FW_API_VERSION_MINOR - 1))
+	else if (hw->aq.api_maj_ver == 1 && hw->aq.api_min_ver < 4)
 		dev_info(&pdev->dev,
 			 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
 
-- 
2.9.3

