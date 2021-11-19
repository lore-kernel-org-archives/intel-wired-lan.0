From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 19 Nov 2021 13:46:03 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for displaying message
 regarding NVM version
Message-ID: <20211119124603.19611-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When loading the i40e driver, it prints a message like:
'The driver for the device detected a newer version of the NVM image v1.x than
expected v1.y. Please install the most recent version of the network driver.'
This is misleading as the driver is working as expected.

Fix that by removing the second part of message and changing it from
dev_info to dev_dgb.

Fixes: 4fb29bddb ("i40e: The driver now prints the API version in error message")
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4664d07..d61def5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15469,15 +15469,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
 	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
-		dev_info(&pdev->dev,
-			 "The driver for the device detected a newer version of the NVM image v%u.%u than expected v%u.%u. Please install the most recent version of the network driver.\n",
+		dev_dbg(&pdev->dev,
+			"The driver for the device detected a newer version of the NVM image v%u.%u than expected v%u.%u.\n",
 			 hw->aq.api_maj_ver,
 			 hw->aq.api_min_ver,
 			 I40E_FW_API_VERSION_MAJOR,
 			 I40E_FW_MINOR_VERSION(hw));
 	else if (hw->aq.api_maj_ver == 1 && hw->aq.api_min_ver < 4)
-		dev_info(&pdev->dev,
-			 "The driver for the device detected an older version of the NVM image v%u.%u than expected v%u.%u. Please update the NVM image.\n",
+		dev_dbg(&pdev->dev,
+			"The driver for the device detected an older version of the NVM image v%u.%u than expected v%u.%u.\n",
 			 hw->aq.api_maj_ver,
 			 hw->aq.api_min_ver,
 			 I40E_FW_API_VERSION_MAJOR,
-- 
2.27.0

