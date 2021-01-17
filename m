From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 17 Jan 2021 10:57:02 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Prefer strscpy over strlcpy
Message-ID: <20210117085702.4174839-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the strscpy method instead of strlcpy method.

See: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr
_i_uTL=V6A6G1oUZcprmknw at mail.gmail.com/

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 6b89a10f1d02..5ac762a9fa7c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -133,7 +133,7 @@ static void igc_ethtool_get_drvinfo(struct net_device *netdev,
 	u16 nvm_version = 0;
 	u16 gphy_version = 0;
 
-	strlcpy(drvinfo->driver, igc_driver_name, sizeof(drvinfo->driver));
+	strscpy(drvinfo->driver, igc_driver_name, sizeof(drvinfo->driver));
 
 	/* NVM image version is reported as firmware version for i225 device */
 	hw->nvm.ops.read(hw, IGC_NVM_DEV_STARTER, 1, &nvm_version);
@@ -147,10 +147,10 @@ static void igc_ethtool_get_drvinfo(struct net_device *netdev,
 		  nvm_version,
 		  gphy_version);
 
-	strlcpy(drvinfo->fw_version, adapter->fw_version,
+	strscpy(drvinfo->fw_version, adapter->fw_version,
 		sizeof(drvinfo->fw_version));
 
-	strlcpy(drvinfo->bus_info, pci_name(adapter->pdev),
+	strscpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
 
 	drvinfo->n_priv_flags = IGC_PRIV_FLAGS_STR_LEN;
-- 
2.25.1

