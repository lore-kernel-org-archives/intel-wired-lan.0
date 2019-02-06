From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 15:08:23 -0800
Subject: [Intel-wired-lan] [next PATCH S2-V2 09/12] i40e: The driver now
 prints the API version in error message
In-Reply-To: <20190206230826.24970-1-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
Message-ID: <20190206230826.24970-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

Added the API version in the error message for clarity.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bae4c05e9d7e..081bd7ce1b4f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14512,7 +14512,11 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		if (err == I40E_ERR_FIRMWARE_API_VERSION)
 			dev_info(&pdev->dev,
-				 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
+				 "The driver for the device stopped because the NVM image v%u.%u is newer than expected v%u.%u. You must install the most recent version of the network driver.\n",
+				 hw->aq.api_maj_ver,
+				 hw->aq.api_min_ver,
+				 I40E_FW_API_VERSION_MAJOR,
+				 I40E_FW_MINOR_VERSION(hw));
 		else
 			dev_info(&pdev->dev,
 				 "The driver for the device stopped because the device firmware failed to init. Try updating your NVM image.\n");
@@ -14530,10 +14534,18 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
 	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
 		dev_info(&pdev->dev,
-			 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
+			 "The driver for the device detected a newer version of the NVM image v%u.%u than expected v%u.%u. Please install the most recent version of the network driver.\n",
+			 hw->aq.api_maj_ver,
+			 hw->aq.api_min_ver,
+			 I40E_FW_API_VERSION_MAJOR,
+			 I40E_FW_MINOR_VERSION(hw));
 	else if (hw->aq.api_maj_ver == 1 && hw->aq.api_min_ver < 4)
 		dev_info(&pdev->dev,
-			 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+			 "The driver for the device detected an older version of the NVM image v%u.%u than expected v%u.%u. Please update the NVM image.\n",
+			 hw->aq.api_maj_ver,
+			 hw->aq.api_min_ver,
+			 I40E_FW_API_VERSION_MAJOR,
+			 I40E_FW_MINOR_VERSION(hw));
 
 	i40e_verify_eeprom(pf);
 
-- 
2.19.2

