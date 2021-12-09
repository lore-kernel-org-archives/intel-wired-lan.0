From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Thu,  9 Dec 2021 10:58:46 +0100
Subject: [Intel-wired-lan] [PATCH net v4] i40e: Fix for displaying message
 regarding NVM version When loading the i40e driver,
 it prints a message like: 'The driver for the device detected a newer
 version of the NVM image v1.x than expected v1.y. Please install the most
 recent version of the network driver.' This is misleading as the driver is
 working as expected.
Message-ID: <20211209095846.12221-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix that by removing the second part of message and changing it from
dev_info to dev_dgb.

Fixes: 4fb29bddb ("i40e: The driver now prints the API version in error message")
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v4: Removed the word "expected' as this might have been misleading
 v3: Changed the patch after community review
 v2: Fixed the fixes tag to be 12 digits long
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4664d07..1688e2d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15469,8 +15469,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
 	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
-		dev_info(&pdev->dev,
-			 "The driver for the device detected a newer version of the NVM image v%u.%u than expected v%u.%u. Please install the most recent version of the network driver.\n",
+		dev_dbg(&pdev->dev,
+			"The driver for the device detected a newer version of the NVM image v%u.%u than v%u.%u.\n",
 			 hw->aq.api_maj_ver,
 			 hw->aq.api_min_ver,
 			 I40E_FW_API_VERSION_MAJOR,
-- 
2.27.0

