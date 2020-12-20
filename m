From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 20 Dec 2020 11:16:49 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Expose the gPHY firmware
 version
Message-ID: <20201220091649.2150077-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Complete to commit 6093e11d357d ("igc: Expose the NVM version")
and expose the gPHY (i225 PHY) firmware version

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  9 +++++++--
 drivers/net/ethernet/intel/igc/igc_phy.c     | 19 +++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_phy.h     |  1 +
 drivers/net/ethernet/intel/igc/igc_regs.h    |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 29be8833956a..1ce72d65d37e 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -221,7 +221,7 @@ struct igc_adapter {
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 
 	struct bpf_prog *xdp_prog;
-	char fw_version[16];
+	char fw_version[32];
 };
 
 void igc_up(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 56997de15a1e..6b89a10f1d02 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -131,16 +131,21 @@ static void igc_ethtool_get_drvinfo(struct net_device *netdev,
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct igc_hw *hw = &adapter->hw;
 	u16 nvm_version = 0;
+	u16 gphy_version = 0;
 
 	strlcpy(drvinfo->driver, igc_driver_name, sizeof(drvinfo->driver));
 
 	/* NVM image version is reported as firmware version for i225 device */
 	hw->nvm.ops.read(hw, IGC_NVM_DEV_STARTER, 1, &nvm_version);
 
+	/* gPHY firmware version is reported as PHY FW version */
+	gphy_version = igc_read_phy_fw_version(hw);
+
 	scnprintf(adapter->fw_version,
 		  sizeof(adapter->fw_version),
-		  "%x",
-		  nvm_version);
+		  "%x:%x",
+		  nvm_version,
+		  gphy_version);
 
 	strlcpy(drvinfo->fw_version, adapter->fw_version,
 		sizeof(drvinfo->fw_version));
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 8e1799508edc..346f78e8034c 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -791,3 +791,22 @@ s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
 
 	return ret_val;
 }
+
+/**
+ * igc_read_phy_fw_version - Read gPHY 211 firmware version
+ * @hw: pointer to the HW structure
+ */
+u16 igc_read_phy_fw_version(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u16 gphy_version = 0;
+	u16 ret_val = 0;
+
+	/* NVM image version is reported as firmware version for i225 device */
+	ret_val = phy->ops.read_reg(hw, IGC_GPHY_VERSION, &gphy_version);
+
+	if (ret_val)
+		hw_dbg("igc_phy: read wrong gphy version\n");
+
+	return gphy_version;
+}
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.h b/drivers/net/ethernet/intel/igc/igc_phy.h
index 25cba33de7e2..1b031372d206 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.h
+++ b/drivers/net/ethernet/intel/igc/igc_phy.h
@@ -17,5 +17,6 @@ void igc_power_up_phy_copper(struct igc_hw *hw);
 void igc_power_down_phy_copper(struct igc_hw *hw);
 s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data);
 s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data);
+u16 igc_read_phy_fw_version(struct igc_hw *hw);
 
 #endif
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index b52dd9d737e8..3e5cb7aef9da 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -13,6 +13,7 @@
 #define IGC_MDICNFG		0x00E04  /* MDC/MDIO Configuration - RW */
 #define IGC_CONNSW		0x00034  /* Copper/Fiber switch control - RW */
 #define IGC_I225_PHPM		0x00E14  /* I225 PHY Power Management */
+#define IGC_GPHY_VERSION	0x0001E  /* I225 gPHY Firmware Version */
 
 /* Internal Packet Buffer Size Registers */
 #define IGC_RXPBS		0x02404  /* Rx Packet Buffer Size - RW */
-- 
2.20.1

