From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Tue, 05 Jan 2016 10:08:28 -0800
Subject: [Intel-wired-lan] [PATCH] igb: enable WoL for OEM devices
	regardless of EEPROM setting
Message-ID: <20160105180828.14555.93037.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Override EEPROM settings for specific OEM devices.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 637135e..f413ce1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2590,6 +2590,26 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		adapter->wol = 0;
 	}
 
+	/* Some vendors want the ability to Use the EEPROM setting as
+	 * enable/disable only, and not for capability
+	 */
+	if ((((hw->mac.type == e1000_i350) ||
+	      (hw->mac.type == e1000_i354))) &&
+			((pdev->subsystem_vendor == PCI_VENDOR_ID_DELL))) {
+		adapter->flags |= IGB_FLAG_WOL_SUPPORTED;
+		adapter->wol = 0;
+	}
+	if (hw->mac.type == e1000_i350) {
+		if (((pdev->subsystem_device == 0x5001) ||
+		     (pdev->subsystem_device == 0x5002)) &&
+				(hw->bus.func == 0)) {
+			adapter->flags |= IGB_FLAG_WOL_SUPPORTED;
+			adapter->wol = 0;
+		}
+		if (pdev->subsystem_device == 0x1F52)
+			adapter->flags |= IGB_FLAG_WOL_SUPPORTED;
+	}
+
 	device_set_wakeup_enable(&adapter->pdev->dev,
 				 adapter->flags & IGB_FLAG_WOL_SUPPORTED);
 

