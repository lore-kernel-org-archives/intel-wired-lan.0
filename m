From: Stefan Assmann <sassmann@kpanic.de>
Date: Tue, 12 Mar 2019 12:18:02 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: print PCI vendor and device ID
 during probe
Message-ID: <20190312111802.21203-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Printing each devices PCI vendor and device ID has the advantage of
easily revealing what hardware we're dealing with exactly. It's no
longer necessary to match the PCI bus information to the lspci output.

Helps with bug reports where no lspci output is available.

Output before
i40e 0000:08:00.0: fw 6.1.49420 api 1.7 nvm 6.80 0x80003c64 1.2007.0
and after
i40e 0000:08:00.0: fw 6.1.49420 api 1.7 nvm 6.80 0x80003c64 1.2007.0 [8086:1572] [8086:0004]

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index da62218eb70a..01ad4bec4347 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14023,11 +14023,12 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	i40e_get_oem_version(hw);
 
-	/* provide nvm, fw, api versions */
-	dev_info(&pdev->dev, "fw %d.%d.%05d api %d.%d nvm %s\n",
+	/* provide nvm, fw, api versions, vendor:device id, subsys vendor:device id */
+	dev_info(&pdev->dev, "fw %d.%d.%05d api %d.%d nvm %s [%04x:%04x] [%04x:%04x]\n",
 		 hw->aq.fw_maj_ver, hw->aq.fw_min_ver, hw->aq.fw_build,
 		 hw->aq.api_maj_ver, hw->aq.api_min_ver,
-		 i40e_nvm_version_str(hw));
+		 i40e_nvm_version_str(hw), hw->vendor_id, hw->device_id,
+		 hw->subsystem_vendor_id, hw->subsystem_device_id);
 
 	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
 	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
-- 
2.20.1

