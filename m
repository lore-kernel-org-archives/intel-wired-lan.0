From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 29 Nov 2018 11:15:06 -0800
Subject: [Intel-wired-lan] [net-next,1/2] ixgbe: register a mdiobus
Message-ID: <20181129191507.12478-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Steve Douthit <stephend@silicom-usa.com>

Most dsa devices expect a 'struct mii_bus' pointer to talk to switches
via the MII interface.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   6 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 192 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +
 4 files changed, 202 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 143bdd5ee2a0..08d85e336bd4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -12,6 +12,7 @@
 #include <linux/aer.h>
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
+#include <linux/phy.h>
 
 #include <linux/timecounter.h>
 #include <linux/net_tstamp.h>
@@ -561,6 +562,7 @@ struct ixgbe_adapter {
 	struct net_device *netdev;
 	struct bpf_prog *xdp_prog;
 	struct pci_dev *pdev;
+	struct mii_bus *mii_bus;
 
 	unsigned long state;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 49a4ea38eb07..c2141fe35685 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -39,6 +39,7 @@
 #include "ixgbe.h"
 #include "ixgbe_common.h"
 #include "ixgbe_dcb_82599.h"
+#include "ixgbe_phy.h"
 #include "ixgbe_sriov.h"
 #include "ixgbe_model.h"
 #include "ixgbe_txrx_common.h"
@@ -11120,6 +11121,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			IXGBE_LINK_SPEED_10GB_FULL | IXGBE_LINK_SPEED_1GB_FULL,
 			true);
 
+	if (ixgbe_mii_bus_init(hw))
+		e_err(probe, "failed to create mii_bus\n");
+
 	return 0;
 
 err_register:
@@ -11170,6 +11174,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
+	if (adapter->mii_bus)
+		mdiobus_unregister(adapter->mii_bus);
 
 #ifdef CONFIG_IXGBE_DCA
 	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 919a7af84b42..75db340963ad 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -658,6 +658,198 @@ s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 	return status;
 }
 
+/**
+ *  ixgbe_msca - Write the command register and poll for completion/timeout
+ *  @hw: pointer to hardware structure
+ *  @cmd: command register value to write
+ **/
+static s32 ixgbe_msca_cmd(struct ixgbe_hw *hw, u32 cmd)
+{
+	u32 i;
+
+	IXGBE_WRITE_REG(hw, IXGBE_MSCA, cmd);
+
+	for (i = 0; i < IXGBE_MDIO_COMMAND_TIMEOUT; i++) {
+		udelay(10);
+		cmd = IXGBE_READ_REG(hw, IXGBE_MSCA);
+		if (!(cmd & IXGBE_MSCA_MDI_COMMAND))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+/**
+ *  ixgbe_msca - Use device_id to figure out if MDIO bus is shared between MACs.
+ *  The embedded x550(s) in the C3000 line of SoCs only have a single mii_bus
+ *  shared between all MACs, and that introduces some new mask flags that need
+ *  to be passed to the *_swfw_sync callbacks.
+ *  @hw: pointer to hardware structure
+ **/
+static bool ixgbe_is_shared_mii(struct ixgbe_hw *hw)
+{
+	switch (hw->device_id) {
+	case IXGBE_DEV_ID_X550EM_A_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR_L:
+	case IXGBE_DEV_ID_X550EM_A_SFP_N:
+	case IXGBE_DEV_ID_X550EM_A_SGMII:
+	case IXGBE_DEV_ID_X550EM_A_SGMII_L:
+	case IXGBE_DEV_ID_X550EM_A_10G_T:
+	case IXGBE_DEV_ID_X550EM_A_SFP:
+	case IXGBE_DEV_ID_X550EM_A_1G_T:
+	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ *  ixgbe_mii_bus_read - Read a clause 22/45 register
+ *  @hw: pointer to hardware structure
+ *  @addr: address
+ *  @regnum: register number
+ **/
+static s32 ixgbe_mii_bus_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct ixgbe_adapter *adapter = (struct ixgbe_adapter *)bus->priv;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 hwaddr, cmd, gssr = hw->phy.phy_semaphore_mask;
+	s32 data;
+
+	if (ixgbe_is_shared_mii(hw)) {
+		gssr |= IXGBE_GSSR_TOKEN_SM;
+		if (hw->bus.lan_id)
+			gssr |= IXGBE_GSSR_PHY1_SM;
+		else
+			gssr |= IXGBE_GSSR_PHY0_SM;
+	}
+
+	if (hw->mac.ops.acquire_swfw_sync(hw, gssr))
+		return -EBUSY;
+
+	hwaddr = addr << IXGBE_MSCA_PHY_ADDR_SHIFT;
+	if (regnum & MII_ADDR_C45) {
+		hwaddr |= regnum & GENMASK(21, 0);
+		cmd = hwaddr | IXGBE_MSCA_ADDR_CYCLE | IXGBE_MSCA_MDI_COMMAND;
+	} else {
+		hwaddr |= (regnum & GENMASK(5, 0)) << IXGBE_MSCA_DEV_TYPE_SHIFT;
+		cmd = hwaddr | IXGBE_MSCA_OLD_PROTOCOL |
+			IXGBE_MSCA_READ_AUTOINC | IXGBE_MSCA_MDI_COMMAND;
+	}
+
+	data = ixgbe_msca_cmd(hw, cmd);
+	if (data < 0)
+		goto mii_bus_read_done;
+
+	/* For a clause 45 access the address cycle just completed, we still
+	 * need to do the read command, otherwise just get the data
+	 */
+	if (!(regnum & MII_ADDR_C45))
+		goto do_mii_bus_read;
+
+	cmd = hwaddr | IXGBE_MSCA_READ | IXGBE_MSCA_MDI_COMMAND;
+	data = ixgbe_msca_cmd(hw, cmd);
+	if (data < 0)
+		goto mii_bus_read_done;
+
+do_mii_bus_read:
+	data = IXGBE_READ_REG(hw, IXGBE_MSRWD);
+	data = (data >> IXGBE_MSRWD_READ_DATA_SHIFT) & GENMASK(16, 0);
+
+mii_bus_read_done:
+	hw->mac.ops.release_swfw_sync(hw, gssr);
+	return data;
+}
+
+/**
+ *  ixgbe_mii_bus_write - Write a clause 22/45 register
+ *  @hw: pointer to hardware structure
+ *  @addr: address
+ *  @regnum: register number
+ *  @val: value to write
+ **/
+static s32 ixgbe_mii_bus_write(struct mii_bus *bus, int addr, int regnum,
+			       u16 val)
+{
+	struct ixgbe_adapter *adapter = (struct ixgbe_adapter *)bus->priv;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 hwaddr, cmd, gssr = hw->phy.phy_semaphore_mask;
+	s32 err;
+
+	if (ixgbe_is_shared_mii(hw)) {
+		gssr |= IXGBE_GSSR_TOKEN_SM;
+		if (hw->bus.lan_id)
+			gssr |= IXGBE_GSSR_PHY1_SM;
+		else
+			gssr |= IXGBE_GSSR_PHY0_SM;
+	}
+
+	if (hw->mac.ops.acquire_swfw_sync(hw, gssr))
+		return -EBUSY;
+
+	IXGBE_WRITE_REG(hw, IXGBE_MSRWD, (u32)val);
+
+	hwaddr = addr << IXGBE_MSCA_PHY_ADDR_SHIFT;
+	if (regnum & MII_ADDR_C45) {
+		hwaddr |= regnum & GENMASK(21, 0);
+		cmd = hwaddr | IXGBE_MSCA_ADDR_CYCLE | IXGBE_MSCA_MDI_COMMAND;
+	} else {
+		hwaddr |= (regnum & GENMASK(5, 0)) << IXGBE_MSCA_DEV_TYPE_SHIFT;
+		cmd = hwaddr | IXGBE_MSCA_OLD_PROTOCOL | IXGBE_MSCA_WRITE |
+			IXGBE_MSCA_MDI_COMMAND;
+	}
+
+	/* For clause 45 this is an address cycle, for clause 22 this is the
+	 * entire transaction
+	 */
+	err = ixgbe_msca_cmd(hw, cmd);
+	if (err < 0 || !(regnum & MII_ADDR_C45))
+		goto mii_bus_write_done;
+
+	cmd = hwaddr | IXGBE_MSCA_WRITE | IXGBE_MSCA_MDI_COMMAND;
+	err = ixgbe_msca_cmd(hw, cmd);
+
+mii_bus_write_done:
+	hw->mac.ops.release_swfw_sync(hw, gssr);
+	return err;
+}
+
+/**
+ * ixgbe_mii_bus_init - mii_bus structure setup
+ * @hw: pointer to hardware structure
+ *
+ * Returns 0 on success, negative on failure
+ *
+ * ixgbe_mii_bus_init initializes a mii_bus structure in adapter
+ **/
+s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw)
+{
+	struct ixgbe_adapter *adapter = hw->back;
+	struct pci_dev *pdev = adapter->pdev;
+	struct mii_bus *bus = adapter->mii_bus;
+	struct device *dev = &adapter->netdev->dev;
+
+	adapter->mii_bus = devm_mdiobus_alloc(dev);
+	if (!adapter->mii_bus)
+		return -ENOMEM;
+
+	bus = adapter->mii_bus;
+
+	/* Use the position of the device in the PCI hierarchy as the id */
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%s", ixgbe_driver_name,
+		 pci_name(pdev->bus->self));
+
+	bus->name = "ixgbe-mdio";
+	bus->read = &ixgbe_mii_bus_read;
+	bus->write = &ixgbe_mii_bus_write;
+	bus->priv = adapter;
+	bus->parent = dev;
+	bus->phy_mask = 0xffffffff;
+
+	return mdiobus_register(bus);
+}
+
 /**
  *  ixgbe_setup_phy_link_generic - Set and restart autoneg
  *  @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 64e44e01c973..214b01085718 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -120,6 +120,8 @@
 /* SFP+ SFF-8472 Compliance code */
 #define IXGBE_SFF_SFF_8472_UNSUP      0x00
 
+s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw);
+
 s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw);
 s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw);
 s32 ixgbe_read_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
