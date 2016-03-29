From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 29 Mar 2016 16:57:51 -0700
Subject: [Intel-wired-lan] [PATCH V4 05/11] ixgbe: Read and set instance id
In-Reply-To: <20160329235544.68428.93935.stgit@mdrustad-wks.jf.intel.com>
References: <20160329235544.68428.93935.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160329235751.68428.36314.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Read the instance number from EEPROM and save it for later use.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    8 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 76080310fc6b..833567cacda4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -681,6 +681,7 @@ s32 ixgbe_get_bus_info_generic(struct ixgbe_hw *hw)
 void ixgbe_set_lan_id_multi_port_pcie(struct ixgbe_hw *hw)
 {
 	struct ixgbe_bus_info *bus = &hw->bus;
+	u16 ee_ctrl_4;
 	u32 reg;
 
 	reg = IXGBE_READ_REG(hw, IXGBE_STATUS);
@@ -691,6 +692,13 @@ void ixgbe_set_lan_id_multi_port_pcie(struct ixgbe_hw *hw)
 	reg = IXGBE_READ_REG(hw, IXGBE_FACTPS(hw));
 	if (reg & IXGBE_FACTPS_LFS)
 		bus->func ^= 0x1;
+
+	/* Get MAC instance from EEPROM for configuring CS4227 */
+	if (hw->device_id == IXGBE_DEV_ID_X550EM_A_SFP) {
+		hw->eeprom.ops.read(hw, IXGBE_EEPROM_CTRL_4, &ee_ctrl_4);
+		bus->instance_id = (ee_ctrl_4 & IXGBE_EE_CTRL_4_INST_ID) >>
+				   IXGBE_EE_CTRL_4_INST_ID_SHIFT;
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index f6d02c254b6e..3fc447a7c15d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -81,6 +81,7 @@
 #define IXGBE_DEV_ID_X550EM_X_10G_T	0x15AD
 #define IXGBE_DEV_ID_X550EM_X_1G_T	0x15AE
 #define IXGBE_DEV_ID_X550EM_A_SFP_N	0x15C4
+#define IXGBE_DEV_ID_X550EM_A_SFP	0x15CE
 
 /* VF Device IDs */
 #define IXGBE_DEV_ID_X550_VF_HV	0x1564
@@ -1999,6 +2000,9 @@ enum {
 #define IXGBE_PBANUM_PTR_GUARD		0xFAFA
 #define IXGBE_EEPROM_CHECKSUM		0x3F
 #define IXGBE_EEPROM_SUM		0xBABA
+#define IXGBE_EEPROM_CTRL_4		0x45
+#define IXGBE_EE_CTRL_4_INST_ID		0x10
+#define IXGBE_EE_CTRL_4_INST_ID_SHIFT	4
 #define IXGBE_PCIE_ANALOG_PTR		0x03
 #define IXGBE_ATLAS0_CONFIG_PTR		0x04
 #define IXGBE_PHY_PTR			0x04
@@ -3174,6 +3178,7 @@ struct ixgbe_bus_info {
 
 	u8 func;
 	u8 lan_id;
+	u8 instance_id;
 };
 
 /* Flow control parameters */

