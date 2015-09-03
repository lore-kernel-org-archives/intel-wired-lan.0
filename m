From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:59 -0400
Subject: [Intel-wired-lan] [next PATCH S15 12/15] i40e: X722 is on the IOSF
	bus and does not report the PCI bus info
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

X722 will report Gen 1x1 in the PCI config space as it is on
IOSF bus, so skip the PCI bus link/speed check.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: Icd5f5751dc7fb00dccf0d5dc5a0a644948e7062e
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 69 ++++++++++++++++++++---------
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index a2a1d22..a404036 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -336,6 +336,7 @@ struct i40e_pf {
 #define I40E_FLAG_LINK_POLLING_ENABLED		BIT_ULL(39)
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(40)
 #define I40E_FLAG_GENEVE_OFFLOAD_CAPABLE	BIT_ULL(41)
+#define I40E_FLAG_NO_PCI_LINK_CHECK		BIT_ULL(42)
 
 	/* tracks features that get auto disabled by errors */
 	u64 auto_disable_flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6a28c04..4bcf4a1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10555,26 +10555,55 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i40e_fcoe_vsi_setup(pf);
 
 #endif
-	/* Get the negotiated link width and speed from PCI config space */
-	pcie_capability_read_word(pf->pdev, PCI_EXP_LNKSTA, &link_status);
-
-	i40e_set_pci_config_data(hw, link_status);
-
-	dev_info(&pdev->dev, "PCI-Express: %s %s\n",
-		(hw->bus.speed == i40e_bus_speed_8000 ? "Speed 8.0GT/s" :
-		 hw->bus.speed == i40e_bus_speed_5000 ? "Speed 5.0GT/s" :
-		 hw->bus.speed == i40e_bus_speed_2500 ? "Speed 2.5GT/s" :
-		 "Unknown"),
-		(hw->bus.width == i40e_bus_width_pcie_x8 ? "Width x8" :
-		 hw->bus.width == i40e_bus_width_pcie_x4 ? "Width x4" :
-		 hw->bus.width == i40e_bus_width_pcie_x2 ? "Width x2" :
-		 hw->bus.width == i40e_bus_width_pcie_x1 ? "Width x1" :
-		 "Unknown"));
-
-	if (hw->bus.width < i40e_bus_width_pcie_x8 ||
-	    hw->bus.speed < i40e_bus_speed_8000) {
-		dev_warn(&pdev->dev, "PCI-Express bandwidth available for this device may be insufficient for optimal performance.\n");
-		dev_warn(&pdev->dev, "Please move the device to a different PCI-e link with more lanes and/or higher transfer rate.\n");
+#define PCI_SPEED_SIZE 8
+#define PCI_WIDTH_SIZE 8
+	/* Devices on the IOSF bus do not have this information
+	 * and will report PCI Gen 1 x 1 by default so don't bother
+	 * checking them.
+	 */
+	if (!(pf->flags & I40E_FLAG_NO_PCI_LINK_CHECK)) {
+		char speed[PCI_SPEED_SIZE] = "Unknown";
+		char width[PCI_WIDTH_SIZE] = "Unknown";
+
+		/* Get the negotiated link width and speed from PCI config
+		 * space
+		 */
+		pcie_capability_read_word(pf->pdev, PCI_EXP_LNKSTA,
+					  &link_status);
+
+		i40e_set_pci_config_data(hw, link_status);
+
+		switch (hw->bus.speed) {
+		case i40e_bus_speed_8000:
+			strncpy(speed, "8.0", PCI_SPEED_SIZE); break;
+		case i40e_bus_speed_5000:
+			strncpy(speed, "5.0", PCI_SPEED_SIZE); break;
+		case i40e_bus_speed_2500:
+			strncpy(speed, "2.5", PCI_SPEED_SIZE); break;
+		default:
+			break;
+		}
+		switch (hw->bus.width) {
+		case i40e_bus_width_pcie_x8:
+			strncpy(width, "8", PCI_WIDTH_SIZE); break;
+		case i40e_bus_width_pcie_x4:
+			strncpy(width, "4", PCI_WIDTH_SIZE); break;
+		case i40e_bus_width_pcie_x2:
+			strncpy(width, "2", PCI_WIDTH_SIZE); break;
+		case i40e_bus_width_pcie_x1:
+			strncpy(width, "1", PCI_WIDTH_SIZE); break;
+		default:
+			break;
+		}
+
+		dev_info(&pdev->dev, "PCI-Express: Speed %sGT/s Width x%s\n",
+			 speed, width);
+
+		if (hw->bus.width < i40e_bus_width_pcie_x8 ||
+		    hw->bus.speed < i40e_bus_speed_8000) {
+			dev_warn(&pdev->dev, "PCI-Express bandwidth available for this device may be insufficient for optimal performance.\n");
+			dev_warn(&pdev->dev, "Please move the device to a different PCI-e link with more lanes and/or higher transfer rate.\n");
+		}
 	}
 
 	/* get the requested speeds from the fw */
-- 
1.9.3

