From: Steve Douthit <stephend@silicom-usa.com>
Date: Mon, 3 Dec 2018 18:55:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] ixgbe: use mii_bus to
 handle MII related ioctls
In-Reply-To: <20181203185454.6357-1-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203185454.6357-1-stephend@silicom-usa.com>
Message-ID: <20181203185454.6357-3-stephend@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the mii_bus callbacks to address the entire clause 22/45 address
space.  Enables userspace to poke switch registers instead of a single
PHY address.

The ixgbe firmware may be polling PHYs in a way that is not protected by
the mii_bus lock.  This isn't new behavior, but as Andrew Lunn pointed
out there are more addresses available for conflicts.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 82af3b24d222..fb066c491abe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8790,6 +8790,15 @@ ixgbe_mdio_read(struct net_device *netdev, int prtad, int devad, u16 addr)
 	u16 value;
 	int rc;
 
+	if (adapter->mii_bus) {
+		int regnum = addr;
+
+		if (devad != MDIO_DEVAD_NONE)
+			regnum |= (devad << 16) | MII_ADDR_C45;
+
+		return mdiobus_read(adapter->mii_bus, prtad, regnum);
+	}
+
 	if (prtad != hw->phy.mdio.prtad)
 		return -EINVAL;
 	rc = hw->phy.ops.read_reg(hw, addr, devad, &value);
@@ -8804,6 +8813,15 @@ static int ixgbe_mdio_write(struct net_device *netdev, int prtad, int devad,
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
 
+	if (adapter->mii_bus) {
+		int regnum = addr;
+
+		if (devad != MDIO_DEVAD_NONE)
+			regnum |= (devad << 16) | MII_ADDR_C45;
+
+		return mdiobus_write(adapter->mii_bus, prtad, regnum, value);
+	}
+
 	if (prtad != hw->phy.mdio.prtad)
 		return -EINVAL;
 	return hw->phy.ops.write_reg(hw, addr, devad, value);
-- 
2.17.2

