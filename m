From: Greenwalt, Paul <paul.greenwalt@intel.com>
Date: Fri, 19 May 2017 23:54:07 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Extend firmware version support
In-Reply-To: <1494926592-53913-1-git-send-email-paul.greenwalt@intel.com>
References: <1494926592-53913-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <9A83C569D64F2541B0B591F2CBA3CC019C819174@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

NACK

FW version EEPROM blocks definitions may change, so I'll submit a new patch once this has been resolved.

-----Original Message-----
From: Greenwalt, Paul 
Sent: Tuesday, May 16, 2017 2:23 AM
To: intel-wired-lan@lists.osuosl.org
Cc: Greenwalt, Paul <paul.greenwalt@intel.com>
Subject: [PATCH] ixgbe: Extend firmware version support

Extend FW version reporting by displaying information from the eeprom iscsi or nvm OEM block EEPROM.

This will allow us to more accurately identify the FW.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c    |  7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 93 +++++++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    | 17 +++++
 5 files changed, 112 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index dd55787..91ea773 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -712,8 +712,7 @@ struct ixgbe_adapter {
 
 	u16 bridge_mode;
 
-	u16 eeprom_verh;
-	u16 eeprom_verl;
+	char eeprom_id[NVM_VER_SIZE];
 	u16 eeprom_cap;
 
 	u32 interrupt_event;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0b75d304..22d1bda 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1013,16 +1013,13 @@ static void ixgbe_get_drvinfo(struct net_device *netdev,
 			      struct ethtool_drvinfo *drvinfo)  {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	u32 nvm_track_id;
 
 	strlcpy(drvinfo->driver, ixgbe_driver_name, sizeof(drvinfo->driver));
 	strlcpy(drvinfo->version, ixgbe_driver_version,
 		sizeof(drvinfo->version));
 
-	nvm_track_id = (adapter->eeprom_verh << 16) |
-			adapter->eeprom_verl;
-	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version), "0x%08x",
-		 nvm_track_id);
+	strlcpy(drvinfo->fw_version, adapter->eeprom_id,
+		sizeof(drvinfo->fw_version));
 
 	strlcpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 2a653ec..e320621 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -1034,11 +1034,8 @@ int ixgbe_fcoe_get_hbainfo(struct net_device *netdev,
 		 ixgbe_driver_name,
 		 ixgbe_driver_version);
 	/* Firmware Version */
-	snprintf(info->firmware_version,
-		 sizeof(info->firmware_version),
-		 "0x%08x",
-		 (adapter->eeprom_verh << 16) |
-		  adapter->eeprom_verl);
+	strlcpy(info->firmware_version, adapter->eeprom_id,
+		sizeof(info->firmware_version));
 
 	/* Model */
 	if (hw->mac.type == ixgbe_mac_82599EB) { diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ee20a2b..45e8b5b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9989,6 +9989,95 @@ bool ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,  }
 
 /**
+ * ixgbe_set_fw_version - Set FW version
+ * @adapter: the adapter private structure
+ *
+ * This function is used by probe and ethtool to determine the FW 
+version to
+ * format to display. The FW version is taken from the EEPROM/NVM.
+ *
+ **/
+static void ixgbe_set_fw_version(struct ixgbe_adapter *adapter) {
+	struct ixgbe_hw *hw = &adapter->hw;
+	u16 etk_id_h = 0, etk_id_l = 0;
+	u16 offset = 0;
+	u32 etk_id;
+
+	/* Check for OEM Product Version block format */
+	hw->eeprom.ops.read(hw, NVM_OEM_PROD_VER_PTR, &offset);
+
+	/* Make sure offset to OEM Product Version block is valid */
+	if (!(offset == 0x0) && !(offset == NVM_INVALID_PTR)) {
+		u16 mod_len = 0, cap = 0;
+
+		/* Read product version block */
+		hw->eeprom.ops.read(hw, offset, &mod_len);
+		hw->eeprom.ops.read(hw, offset + NVM_OEM_PROD_VER_CAP_OFF,
+				    &cap);
+
+		/* Only display OEM product version if valid block */
+		if (mod_len == NVM_OEM_PROD_VER_MOD_LEN &&
+		    (cap & NVM_OEM_PROD_VER_CAP_MASK) == 0x0) {
+			u16 build, major, patch, prod_ver, rel_num;
+
+			hw->eeprom.ops.read(hw, offset + NVM_OEM_PROD_VER_OFF_L,
+					    &prod_ver);
+			hw->eeprom.ops.read(hw, offset + NVM_OEM_PROD_VER_OFF_H,
+					    &rel_num);
+
+			major = prod_ver >> NVM_VER_SHIFT;
+			build = prod_ver & NVM_VER_MASK;
+			patch = rel_num;
+
+			snprintf(adapter->eeprom_id, sizeof(adapter->eeprom_id),
+				 "%x.%x.%x", major, build, patch);
+			return;
+		}
+	}
+
+	/* Save off EEPROM version number and Option Rom version which
+	 * together make a unique identify for the eeprom
+	 */
+	hw->eeprom.ops.read(hw, NVM_ETK_OFF_HI, &etk_id_h);
+	hw->eeprom.ops.read(hw, NVM_ETK_OFF_LOW, &etk_id_l);
+	etk_id = (etk_id_h << NVM_ETK_SHIFT) | etk_id_l;
+
+	/* Check for SCSI block version format */
+	hw->eeprom.ops.read(hw, NVM_ISCSI_BLCK_PTR, &offset);
+
+	/* Make sure offset to SCSI block is valid */
+	if (!(offset == 0x0) && !(offset == NVM_INVALID_PTR)) {
+		u16 nvm_cfg_blkh = 0, nvm_cfg_blkl = 0;
+
+		hw->eeprom.ops.read(hw,
+				    offset + NVM_ISCSI_IMG_VER_OFF_H,
+				    &nvm_cfg_blkh);
+		hw->eeprom.ops.read(hw,
+				    offset + NVM_ISCSI_IMG_VER_OFF_L,
+				    &nvm_cfg_blkl);
+
+		/* Only display Option Rom if exist */
+		if (nvm_cfg_blkl && nvm_cfg_blkh) {
+			u16 build, major, patch;
+
+			major = nvm_cfg_blkl >> NVM_VER_SHIFT;
+			build = (nvm_cfg_blkl << NVM_VER_SHIFT) |
+				(nvm_cfg_blkh >> NVM_VER_SHIFT);
+			patch = nvm_cfg_blkh & NVM_VER_MASK;
+
+			snprintf(adapter->eeprom_id, sizeof(adapter->eeprom_id),
+				 "0x%08x, %d.%d.%d", etk_id, major, build,
+				 patch);
+			return;
+		}
+	}
+
+	/* Set ETrack ID format */
+	snprintf(adapter->eeprom_id, sizeof(adapter->eeprom_id),
+		 "0x%08x", etk_id);
+}
+
+/**
  * ixgbe_probe - Device Initialization Routine
  * @pdev: PCI device information struct
  * @ent: entry in ixgbe_pci_tbl
@@ -10326,9 +10415,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	device_set_wakeup_enable(&adapter->pdev->dev, adapter->wol);
 
-	/* save off EEPROM version number */
-	hw->eeprom.ops.read(hw, 0x2e, &adapter->eeprom_verh);
-	hw->eeprom.ops.read(hw, 0x2d, &adapter->eeprom_verl);
+	ixgbe_set_fw_version(adapter);
 
 	/* pick up the PCI bus settings for reporting later */
 	if (ixgbe_pcie_from_parent(hw))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 9c2460c..a0a6d84 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2083,6 +2083,23 @@ enum {
 #define IXGBE_NVM_POLL_WRITE       1  /* Flag for polling for write complete */
 #define IXGBE_NVM_POLL_READ        0  /* Flag for polling for read complete */
 
+#define NVM_ISCSI_BLCK_PTR	0x17  /* iSCSI configuration block pointer */
+#define NVM_ISCSI_IMG_VER_OFF_H	0x84  /* iSCSI combo image version high */
+#define NVM_ISCSI_IMG_VER_OFF_L	0x83  /* iSCSI combo image version low */
+#define NVM_VER_MASK		0x00FF /* version mask */
+#define NVM_VER_SHIFT		8     /* version bit shift */
+#define NVM_OEM_PROD_VER_PTR	0x1B  /* OEM Product version block pointer */
+#define NVM_OEM_PROD_VER_CAP_OFF 0x1  /* OEM Product version format offset */
+#define NVM_OEM_PROD_VER_OFF_L	0x2   /* OEM Product version offset low */
+#define NVM_OEM_PROD_VER_OFF_H	0x3   /* OEM Product version offset high */
+#define NVM_OEM_PROD_VER_CAP_MASK 0xF /* OEM Product version cap mask 
+*/ #define NVM_OEM_PROD_VER_MOD_LEN 0x3  /* OEM Product version module length */
+#define NVM_ETK_OFF_LOW		0x2D  /* version low order word */
+#define NVM_ETK_OFF_HI		0x2E  /* version high order word */
+#define NVM_ETK_SHIFT		16    /* high version word shift */
+#define NVM_INVALID_PTR		0xFFFF
+#define NVM_VER_SIZE		32    /* version sting size */
+
 #define NVM_INIT_CTRL_3			0x38
 #define NVM_INIT_CTRL_3_LPLU		0x8
 #define NVM_INIT_CTRL_3_D10GMP_PORT0	0x40
--
2.7.4

