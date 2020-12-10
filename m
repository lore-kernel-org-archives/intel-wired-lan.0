From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 10 Dec 2020 08:42:09 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Expose the NVM version
Message-ID: <20201210064209.1030243-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Expose the NVM map version via drvinfo in ethtool
NVM image version is reported as firmware version for i225 device
Minor typo fix - remove space

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 16 ++++++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index cbf85dea8b2e..29be8833956a 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -221,6 +221,7 @@ struct igc_adapter {
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 
 	struct bpf_prog *xdp_prog;
+	char fw_version[16];
 };
 
 void igc_up(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index efddb9012439..882e1e272953 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -160,6 +160,7 @@
 #define IGC_NVM_RW_REG_START	1    /* Start operation */
 #define IGC_NVM_RW_ADDR_SHIFT	2    /* Shift to the address bits */
 #define IGC_NVM_POLL_READ	0    /* Flag for polling for read complete */
+#define IGC_NVM_DEV_STARTER	5    /* Dev_starter Version */
 
 /* NVM Word Offsets */
 #define NVM_CHECKSUM_REG		0x003F
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 29da2710b500..56997de15a1e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -129,10 +129,22 @@ static void igc_ethtool_get_drvinfo(struct net_device *netdev,
 				    struct ethtool_drvinfo *drvinfo)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+	u16 nvm_version = 0;
+
+	strlcpy(drvinfo->driver, igc_driver_name, sizeof(drvinfo->driver));
+
+	/* NVM image version is reported as firmware version for i225 device */
+	hw->nvm.ops.read(hw, IGC_NVM_DEV_STARTER, 1, &nvm_version);
+
+	scnprintf(adapter->fw_version,
+		  sizeof(adapter->fw_version),
+		  "%x",
+		  nvm_version);
 
-	strlcpy(drvinfo->driver,  igc_driver_name, sizeof(drvinfo->driver));
+	strlcpy(drvinfo->fw_version, adapter->fw_version,
+		sizeof(drvinfo->fw_version));
 
-	/* add fw_version here */
 	strlcpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
 
-- 
2.25.1

