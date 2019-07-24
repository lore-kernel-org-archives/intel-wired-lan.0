From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 24 Jul 2019 10:05:46 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Add NVM checksum validation
Message-ID: <20190724070546.16436-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add NVM checksum validation during probe functionality.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e5114bebd30b..c855d9cbe431 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4134,6 +4134,15 @@ static int igc_probe(struct pci_dev *pdev,
 	 */
 	hw->mac.ops.reset_hw(hw);
 
+	if (igc_get_flash_presence_i225(hw)) {
+		if (hw->nvm.ops.validate(hw) < 0) {
+			dev_err(&pdev->dev,
+				"The NVM Checksum Is Not Valid\n");
+			err = -EIO;
+			goto err_eeprom;
+		}
+	}
+
 	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
 		/* copy the MAC address out of the NVM */
 		if (hw->mac.ops.read_mac_addr(hw))
-- 
2.11.0

