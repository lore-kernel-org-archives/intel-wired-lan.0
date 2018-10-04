From: Alice Michael <alice.michael@intel.com>
Date: Thu,  4 Oct 2018 15:18:26 -0700
Subject: [Intel-wired-lan] [next PATCH S97 3/7] i40e: Replace strncpy with
 strlcpy to ensure null termination
In-Reply-To: <20181004221830.16212-1-alice.michael@intel.com>
References: <20181004221830.16212-1-alice.michael@intel.com>
Message-ID: <20181004221830.16212-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

Using strncpy allows destination buffer to be not null terminated
after the copying takes place. strlcpy ensures that's not the
case by explicitly setting last element in the buffer as '\0'.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++-------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f98e0bd..de82129 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14525,23 +14525,23 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		switch (hw->bus.speed) {
 		case i40e_bus_speed_8000:
-			strncpy(speed, "8.0", PCI_SPEED_SIZE); break;
+			strlcpy(speed, "8.0", PCI_SPEED_SIZE); break;
 		case i40e_bus_speed_5000:
-			strncpy(speed, "5.0", PCI_SPEED_SIZE); break;
+			strlcpy(speed, "5.0", PCI_SPEED_SIZE); break;
 		case i40e_bus_speed_2500:
-			strncpy(speed, "2.5", PCI_SPEED_SIZE); break;
+			strlcpy(speed, "2.5", PCI_SPEED_SIZE); break;
 		default:
 			break;
 		}
 		switch (hw->bus.width) {
 		case i40e_bus_width_pcie_x8:
-			strncpy(width, "8", PCI_WIDTH_SIZE); break;
+			strlcpy(width, "8", PCI_WIDTH_SIZE); break;
 		case i40e_bus_width_pcie_x4:
-			strncpy(width, "4", PCI_WIDTH_SIZE); break;
+			strlcpy(width, "4", PCI_WIDTH_SIZE); break;
 		case i40e_bus_width_pcie_x2:
-			strncpy(width, "2", PCI_WIDTH_SIZE); break;
+			strlcpy(width, "2", PCI_WIDTH_SIZE); break;
 		case i40e_bus_width_pcie_x1:
-			strncpy(width, "1", PCI_WIDTH_SIZE); break;
+			strlcpy(width, "1", PCI_WIDTH_SIZE); break;
 		default:
 			break;
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 1199f05..e6fc0af 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -694,7 +694,7 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
 	if (!IS_ERR_OR_NULL(pf->ptp_clock))
 		return 0;
 
-	strncpy(pf->ptp_caps.name, i40e_driver_name,
+	strlcpy(pf->ptp_caps.name, i40e_driver_name,
 		sizeof(pf->ptp_caps.name) - 1);
 	pf->ptp_caps.owner = THIS_MODULE;
 	pf->ptp_caps.max_adj = 999999999;
-- 
2.9.5

