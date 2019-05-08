From: Nikunj Kela <nkela@cisco.com>
Date: Wed,  8 May 2019 23:14:29 +0000
Subject: [Intel-wired-lan] [PATCH] igb: add parameter to ignore nvm checksum
 validation
Message-ID: <1557357269-9498-1-git-send-email-nkela@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some of the broken NICs don't have EEPROM programmed correctly. It results
in probe to fail. This change adds a module parameter that can be used to
ignore nvm checksum validation.

Cc: xe-linux-external at cisco.com
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 39f33af..0ae1324 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -247,6 +247,11 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+static bool ignore_nvm_checksum;
+module_param(ignore_nvm_checksum, bool, 0);
+MODULE_PARM_DESC(ignore_nvm_checksum,
+		"Set to ignore nvm checksum validation (defaults N)");
+
 struct igb_reg_info {
 	u32 ofs;
 	char *name;
@@ -3191,18 +3196,29 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case e1000_i211:
 		if (igb_get_flash_presence_i210(hw)) {
 			if (hw->nvm.ops.validate(hw) < 0) {
-				dev_err(&pdev->dev,
+				if (ignore_nvm_checksum) {
+					dev_warn(&pdev->dev,
 					"The NVM Checksum Is Not Valid\n");
-				err = -EIO;
-				goto err_eeprom;
+				} else {
+					dev_err(&pdev->dev,
+					"The NVM Checksum Is Not Valid\n");
+					err = -EIO;
+					goto err_eeprom;
+				}
 			}
 		}
 		break;
 	default:
 		if (hw->nvm.ops.validate(hw) < 0) {
-			dev_err(&pdev->dev, "The NVM Checksum Is Not Valid\n");
-			err = -EIO;
-			goto err_eeprom;
+			if (ignore_nvm_checksum) {
+				dev_warn(&pdev->dev,
+					"The NVM Checksum Is Not Valid\n");
+			} else {
+				dev_err(&pdev->dev,
+					"The NVM Checksum Is Not Valid\n");
+				err = -EIO;
+				goto err_eeprom;
+			}
 		}
 		break;
 	}
-- 
2.5.0

