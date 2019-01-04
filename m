From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  3 Jan 2019 17:31:45 -0800
Subject: [Intel-wired-lan] [net v2] ixgbe: fix Kconfig when driver is not a
 module
Message-ID: <20190104013145.20287-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The new ability added to the driver to use mii_bus to handle MII related
ioctls is causing compile issues when the driver is compiled into the
kernel (i.e. not a module).

The simple solution of requiring the driver to be compiled as a module when
MDIO_BUS is a module, causes a recursion Kconfig issue due to IPSec
dependencies.

So created another Kconfig option for ixgbe, to enable mdio_bus support for
DSA devices.  This solution solves the problem when the ixgbe driver is
compiled into the kernel and MDIO_BUS is compiled as a module.  In this
case, the IXGBE_MDIO option is disabled and the code is not compiled
into the driver.

CC: Dave Jones <davej@codemonkey.org.uk>
CC: Steve Douthit <stephend@silicom-usa.com>
CC: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
v2: fixed up the Kconfig help section to include the clause 22/45
  address information and also changed the IXGBE_MDIO config option to be
  dependent upon PHYLIB versus MDIO_BUS since that appears to be the
  common usage

 drivers/net/ethernet/intel/Kconfig            | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  3 ++-
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 31fb76ee9d82..dfb6973876c0 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -159,7 +159,6 @@ config IXGBE
 	tristate "Intel(R) 10GbE PCI Express adapters support"
 	depends on PCI
 	select MDIO
-	select MDIO_DEVICE
 	imply PTP_1588_CLOCK
 	---help---
 	  This driver supports Intel(R) 10GbE PCI Express family of
@@ -210,6 +209,17 @@ config IXGBE_IPSEC
 	---help---
 	  Enable support for IPSec offload in ixgbe.ko
 
+config IXGBE_MDIO
+	bool "MDIO Support for DSA devices"
+	default n
+	depends on IXGBE && PHYLIB && !(IXGBE=y && PHYLIB=m)
+	---help---
+	  Say Y here if you want MDIO_BUS support for DSA devices in the
+	  driver.  This is useful for accessing the entire clause 22/45
+	  address space.
+
+	  If unsure, say N.
+
 config IXGBEVF
 	tristate "Intel(R) 10GbE PCI Express Virtual Function Ethernet support"
 	depends on PCI_MSI
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 08d85e336bd4..9d7496508ee0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -12,7 +12,9 @@
 #include <linux/aer.h>
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
+#ifdef CONFIG_IXGBE_MDIO
 #include <linux/phy.h>
+#endif
 
 #include <linux/timecounter.h>
 #include <linux/net_tstamp.h>
@@ -562,7 +564,9 @@ struct ixgbe_adapter {
 	struct net_device *netdev;
 	struct bpf_prog *xdp_prog;
 	struct pci_dev *pdev;
+#ifdef CONFIG_IXGBE_MDIO
 	struct mii_bus *mii_bus;
+#endif
 
 	unsigned long state;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d2ce7f0bc32d..afa0337f7ba0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -39,7 +39,9 @@
 #include "ixgbe.h"
 #include "ixgbe_common.h"
 #include "ixgbe_dcb_82599.h"
+#ifdef CONFIG_IXGBE_MDIO
 #include "ixgbe_phy.h"
+#endif
 #include "ixgbe_sriov.h"
 #include "ixgbe_model.h"
 #include "ixgbe_txrx_common.h"
@@ -8791,6 +8793,7 @@ ixgbe_mdio_read(struct net_device *netdev, int prtad, int devad, u16 addr)
 	u16 value;
 	int rc;
 
+#ifdef CONFIG_IXGBE_MDIO
 	if (adapter->mii_bus) {
 		int regnum = addr;
 
@@ -8799,7 +8802,7 @@ ixgbe_mdio_read(struct net_device *netdev, int prtad, int devad, u16 addr)
 
 		return mdiobus_read(adapter->mii_bus, prtad, regnum);
 	}
-
+#endif
 	if (prtad != hw->phy.mdio.prtad)
 		return -EINVAL;
 	rc = hw->phy.ops.read_reg(hw, addr, devad, &value);
@@ -8814,6 +8817,7 @@ static int ixgbe_mdio_write(struct net_device *netdev, int prtad, int devad,
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
 
+#ifdef CONFIG_IXGBE_MDIO
 	if (adapter->mii_bus) {
 		int regnum = addr;
 
@@ -8822,7 +8826,7 @@ static int ixgbe_mdio_write(struct net_device *netdev, int prtad, int devad,
 
 		return mdiobus_write(adapter->mii_bus, prtad, regnum, value);
 	}
-
+#endif
 	if (prtad != hw->phy.mdio.prtad)
 		return -EINVAL;
 	return hw->phy.ops.write_reg(hw, addr, devad, value);
@@ -11141,7 +11145,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			IXGBE_LINK_SPEED_10GB_FULL | IXGBE_LINK_SPEED_1GB_FULL,
 			true);
 
+#ifdef CONFIG_IXGBE_MDIO
 	ixgbe_mii_bus_init(hw);
+#endif
 
 	return 0;
 
@@ -11193,8 +11199,10 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
+#ifdef CONFIG_IXGBE_MDIO
 	if (adapter->mii_bus)
 		mdiobus_unregister(adapter->mii_bus);
+#endif
 
 #ifdef CONFIG_IXGBE_DCA
 	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index cc4907f9ff02..05da21920863 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -3,7 +3,9 @@
 
 #include <linux/pci.h>
 #include <linux/delay.h>
+#ifdef CONFIG_IXGBE_MDIO
 #include <linux/iopoll.h>
+#endif
 #include <linux/sched.h>
 
 #include "ixgbe.h"
@@ -659,6 +661,7 @@ s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 	return status;
 }
 
+#ifdef CONFIG_IXGBE_MDIO
 #define IXGBE_HW_READ_REG(addr) IXGBE_READ_REG(hw, addr)
 
 /**
@@ -956,6 +959,7 @@ s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	adapter->mii_bus = NULL;
 	return -ENODEV;
 }
+#endif
 
 /**
  *  ixgbe_setup_phy_link_generic - Set and restart autoneg
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 214b01085718..88b851178d7e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -120,8 +120,9 @@
 /* SFP+ SFF-8472 Compliance code */
 #define IXGBE_SFF_SFF_8472_UNSUP      0x00
 
+#ifdef CONFIG_IXGBE_MDIO
 s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw);
-
+#endif
 s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw);
 s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw);
 s32 ixgbe_read_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
-- 
2.20.1

