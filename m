From: Steve Douthit <stephend@silicom-usa.com>
Date: Thu, 6 Dec 2018 15:50:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 1/2] ixgbe: register a mdiobus
In-Reply-To: <20181206154955.334-1-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181206154955.334-1-stephend@silicom-usa.com>
Message-ID: <20181206154955.334-2-stephend@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Most dsa devices expect a 'struct mii_bus' pointer to talk to switches
via the MII interface.

While this works for dsa devices, it will not work safely with Linux
PHYs in all configurations since the firmware of the ixgbe device may
be polling some PHY addresses in the background.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 299 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +
 5 files changed, 309 insertions(+)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 59e1bc0f609e..096cf3bc76a0 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -159,6 +159,7 @@ config IXGBE
 	tristate "Intel(R) 10GbE PCI Express adapters support"
 	depends on PCI
 	select MDIO
+	select MDIO_DEVICE
 	imply PTP_1588_CLOCK
 	---help---
 	  This driver supports Intel(R) 10GbE PCI Express family of
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
index b57fa0cfb222..b7907674c565 100644
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
@@ -11120,6 +11121,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			IXGBE_LINK_SPEED_10GB_FULL | IXGBE_LINK_SPEED_1GB_FULL,
 			true);
 
+	ixgbe_mii_bus_init(hw);
+
 	return 0;
 
 err_register:
@@ -11170,6 +11173,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
+	if (adapter->mii_bus)
+		mdiobus_unregister(adapter->mii_bus);
 
 #ifdef CONFIG_IXGBE_DCA
 	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 919a7af84b42..cc4907f9ff02 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -3,6 +3,7 @@
 
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/sched.h>
 
 #include "ixgbe.h"
@@ -658,6 +659,304 @@ s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 	return status;
 }
 
+#define IXGBE_HW_READ_REG(addr) IXGBE_READ_REG(hw, addr)
+
+/**
+ *  ixgbe_msca_cmd - Write the command register and poll for completion/timeout
+ *  @hw: pointer to hardware structure
+ *  @cmd: command register value to write
+ **/
+static s32 ixgbe_msca_cmd(struct ixgbe_hw *hw, u32 cmd)
+{
+	IXGBE_WRITE_REG(hw, IXGBE_MSCA, cmd);
+
+	return readx_poll_timeout(IXGBE_HW_READ_REG, IXGBE_MSCA, cmd,
+				  !(cmd & IXGBE_MSCA_MDI_COMMAND), 10,
+				  10 * IXGBE_MDIO_COMMAND_TIMEOUT);
+}
+
+/**
+ *  ixgbe_mii_bus_read_generic - Read a clause 22/45 register with gssr flags
+ *  @hw: pointer to hardware structure
+ *  @addr: address
+ *  @regnum: register number
+ *  @gssr: semaphore flags to acquire
+ **/
+static s32 ixgbe_mii_bus_read_generic(struct ixgbe_hw *hw, int addr,
+				      int regnum, u32 gssr)
+{
+	u32 hwaddr, cmd;
+	s32 data;
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
+ *  ixgbe_mii_bus_write_generic - Write a clause 22/45 register with gssr flags
+ *  @hw: pointer to hardware structure
+ *  @addr: address
+ *  @regnum: register number
+ *  @val: value to write
+ *  @gssr: semaphore flags to acquire
+ **/
+static s32 ixgbe_mii_bus_write_generic(struct ixgbe_hw *hw, int addr,
+				       int regnum, u16 val, u32 gssr)
+{
+	u32 hwaddr, cmd;
+	s32 err;
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
+ *  ixgbe_mii_bus_read - Read a clause 22/45 register
+ *  @hw: pointer to hardware structure
+ *  @addr: address
+ *  @regnum: register number
+ **/
+static s32 ixgbe_mii_bus_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct ixgbe_adapter *adapter = bus->priv;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 gssr = hw->phy.phy_semaphore_mask;
+
+	return ixgbe_mii_bus_read_generic(hw, addr, regnum, gssr);
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
+	struct ixgbe_adapter *adapter = bus->priv;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 gssr = hw->phy.phy_semaphore_mask;
+
+	return ixgbe_mii_bus_write_generic(hw, addr, regnum, val, gssr);
+}
+
+/**
+ *  ixgbe_x550em_a_mii_bus_read - Read a clause 22/45 register on x550em_a
+ *  @hw: pointer to hardware structure
+ *  @addr: address
+ *  @regnum: register number
+ **/
+static s32 ixgbe_x550em_a_mii_bus_read(struct mii_bus *bus, int addr,
+				       int regnum)
+{
+	struct ixgbe_adapter *adapter = bus->priv;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 gssr = hw->phy.phy_semaphore_mask;
+
+	gssr |= IXGBE_GSSR_TOKEN_SM | IXGBE_GSSR_PHY0_SM;
+	return ixgbe_mii_bus_read_generic(hw, addr, regnum, gssr);
+}
+
+/**
+ *  ixgbe_x550em_a_mii_bus_write - Write a clause 22/45 register on x550em_a
+ *  @hw: pointer to hardware structure
+ *  @addr: address
+ *  @regnum: register number
+ *  @val: value to write
+ **/
+static s32 ixgbe_x550em_a_mii_bus_write(struct mii_bus *bus, int addr,
+					int regnum, u16 val)
+{
+	struct ixgbe_adapter *adapter = bus->priv;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 gssr = hw->phy.phy_semaphore_mask;
+
+	gssr |= IXGBE_GSSR_TOKEN_SM | IXGBE_GSSR_PHY0_SM;
+	return ixgbe_mii_bus_write_generic(hw, addr, regnum, val, gssr);
+}
+
+/**
+ * ixgbe_get_first_secondary_devfn - get first device downstream of root port
+ * @devfn: PCI_DEVFN of root port on domain 0, bus 0
+ *
+ * Returns pci_dev pointer to PCI_DEVFN(0, 0) on subordinate side of root
+ * on domain 0, bus 0, devfn = 'devfn'
+ **/
+static struct pci_dev *ixgbe_get_first_secondary_devfn(unsigned int devfn)
+{
+	struct pci_dev *rp_pdev;
+	int bus;
+
+	rp_pdev = pci_get_domain_bus_and_slot(0, 0, devfn);
+	if (rp_pdev && rp_pdev->subordinate) {
+		bus = rp_pdev->subordinate->number;
+		return pci_get_domain_bus_and_slot(0, bus, 0);
+	}
+
+	return NULL;
+}
+
+/**
+ * ixgbe_x550em_a_has_mii - is this the first ixgbe x550em_a PCI function?
+ * @hw: pointer to hardware structure
+ *
+ * Returns true if hw points to lowest numbered PCI B:D.F x550_em_a device in
+ * the SoC.  There are up to 4 MACs sharing a single MDIO bus on the x550em_a,
+ * but we only want to register one MDIO bus.
+ **/
+static bool ixgbe_x550em_a_has_mii(struct ixgbe_hw *hw)
+{
+	struct ixgbe_adapter *adapter = hw->back;
+	struct pci_dev *pdev = adapter->pdev;
+	struct pci_dev *func0_pdev;
+
+	/* For the C3000 family of SoCs (x550em_a) the internal ixgbe devices
+	 * are always downstream of root ports @ 0000:00:16.0 & 0000:00:17.0
+	 * It's not valid for function 0 to be disabled and function 1 is up,
+	 * so the lowest numbered ixgbe dev will be device 0 function 0 on one
+	 * of those two root ports
+	 */
+	func0_pdev = ixgbe_get_first_secondary_devfn(PCI_DEVFN(0x16, 0));
+	if (func0_pdev) {
+		if (func0_pdev == pdev)
+			return true;
+		else
+			return false;
+	}
+	func0_pdev = ixgbe_get_first_secondary_devfn(PCI_DEVFN(0x17, 0));
+	if (func0_pdev == pdev)
+		return true;
+
+	return false;
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
+	struct device *dev = &adapter->netdev->dev;
+	struct mii_bus *bus;
+
+	adapter->mii_bus = devm_mdiobus_alloc(dev);
+	if (!adapter->mii_bus)
+		return -ENOMEM;
+
+	bus = adapter->mii_bus;
+
+	switch (hw->device_id) {
+	/* C3000 SoCs */
+	case IXGBE_DEV_ID_X550EM_A_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR_L:
+	case IXGBE_DEV_ID_X550EM_A_SFP_N:
+	case IXGBE_DEV_ID_X550EM_A_SGMII:
+	case IXGBE_DEV_ID_X550EM_A_SGMII_L:
+	case IXGBE_DEV_ID_X550EM_A_10G_T:
+	case IXGBE_DEV_ID_X550EM_A_SFP:
+	case IXGBE_DEV_ID_X550EM_A_1G_T:
+	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
+		if (!ixgbe_x550em_a_has_mii(hw))
+			goto ixgbe_no_mii_bus;
+		bus->read = &ixgbe_x550em_a_mii_bus_read;
+		bus->write = &ixgbe_x550em_a_mii_bus_write;
+		break;
+	default:
+		bus->read = &ixgbe_mii_bus_read;
+		bus->write = &ixgbe_mii_bus_write;
+		break;
+	}
+
+	/* Use the position of the device in the PCI hierarchy as the id */
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%s", ixgbe_driver_name,
+		 pci_name(pdev));
+
+	bus->name = "ixgbe-mdio";
+	bus->priv = adapter;
+	bus->parent = dev;
+	bus->phy_mask = GENMASK(31, 0);
+
+	/* Support clause 22/45 natively.  ixgbe_probe() sets MDIO_EMULATE_C22
+	 * unfortunately that causes some clause 22 frames to be sent with
+	 * clause 45 addressing.  We don't want that.
+	 */
+	hw->phy.mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22;
+
+	return mdiobus_register(bus);
+
+ixgbe_no_mii_bus:
+	devm_mdiobus_free(dev, bus);
+	adapter->mii_bus = NULL;
+	return -ENODEV;
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
-- 
2.17.2

