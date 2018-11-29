From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 29 Nov 2018 11:15:07 -0800
Subject: [Intel-wired-lan] [net-next,
 2/2] ixgbe: use mii_bus to handle MII related ioctls
In-Reply-To: <20181129191507.12478-1-jeffrey.t.kirsher@intel.com>
References: <20181129191507.12478-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20181129191507.12478-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Steve Douthit <stephend@silicom-usa.com>

Use the mii_bus callbacks to address the entire clause 22/45 address
space.  Enables userspace to poke switch registers instead of a single
PHY address.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c2141fe35685..345ecdddc749 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8786,27 +8786,26 @@ static int
 ixgbe_mdio_read(struct net_device *netdev, int prtad, int devad, u16 addr)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	struct ixgbe_hw *hw = &adapter->hw;
-	u16 value;
-	int rc;
+	struct mii_bus *mii_bus = adapter->mii_bus;
+	int regnum = addr;
 
-	if (prtad != hw->phy.mdio.prtad)
-		return -EINVAL;
-	rc = hw->phy.ops.read_reg(hw, addr, devad, &value);
-	if (!rc)
-		rc = value;
-	return rc;
+	if (devad != MDIO_DEVAD_NONE)
+		regnum |= (devad << 16) | MII_ADDR_C45;
+
+	return mdiobus_read(mii_bus, prtad, regnum);
 }
 
 static int ixgbe_mdio_write(struct net_device *netdev, int prtad, int devad,
 			    u16 addr, u16 value)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	struct ixgbe_hw *hw = &adapter->hw;
+	struct mii_bus *mii_bus = adapter->mii_bus;
+	int regnum = addr;
 
-	if (prtad != hw->phy.mdio.prtad)
-		return -EINVAL;
-	return hw->phy.ops.write_reg(hw, addr, devad, value);
+	if (devad != MDIO_DEVAD_NONE)
+		regnum |= (devad << 16) | MII_ADDR_C45;
+
+	return mdiobus_write(mii_bus, prtad, regnum, value);
 }
 
 static int ixgbe_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
@@ -8819,7 +8818,7 @@ static int ixgbe_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
 	case SIOCGHWTSTAMP:
 		return ixgbe_ptp_get_ts_config(adapter, req);
 	case SIOCGMIIPHY:
-		if (!adapter->hw.phy.ops.read_reg)
+		if (!adapter->mii_bus)
 			return -EOPNOTSUPP;
 		/* fall through */
 	default:
@@ -10796,7 +10795,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* ixgbe_identify_phy_generic will set prtad and mmds properly */
 	hw->phy.mdio.prtad = MDIO_PRTAD_NONE;
 	hw->phy.mdio.mmds = 0;
-	hw->phy.mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_EMULATE_C22;
+	hw->phy.mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22;
 	hw->phy.mdio.dev = netdev;
 	hw->phy.mdio.mdio_read = ixgbe_mdio_read;
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
