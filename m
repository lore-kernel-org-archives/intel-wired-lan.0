From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 30 Jul 2019 10:18:48 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Remove unneeded PCI bus defines
Message-ID: <20190730071848.7978-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

PCIe device control 2 defines does not use internally.
This patch comes to clean up those.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 11b99acf4abe..549134ecd105 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -10,10 +10,6 @@
 
 #define IGC_CTRL_EXT_DRV_LOAD	0x10000000 /* Drv loaded bit for FW */
 
-/* PCI Bus Info */
-#define PCIE_DEVICE_CONTROL2		0x28
-#define PCIE_DEVICE_CONTROL2_16ms	0x0005
-
 /* Physical Func Reset Done Indication */
 #define IGC_CTRL_EXT_LINK_MODE_MASK	0x00C00000
 
-- 
2.11.0

