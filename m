From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jun 2020 12:00:47 +0200
Subject: [Intel-wired-lan] [PATCH 02/11] net: ethernet: ixgbe: don't call
 devm_mdiobus_free()
In-Reply-To: <20200622100056.10151-1-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
Message-ID: <20200622100056.10151-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The idea behind devres is that the release callbacks are called if
probe fails. As we now check the return value of ixgbe_mii_bus_init(),
we can drop the call devm_mdiobus_free() in error path as the release
callback will be called automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 2fb97967961c..7980d7265e10 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -905,7 +905,6 @@ s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	struct pci_dev *pdev = adapter->pdev;
 	struct device *dev = &adapter->netdev->dev;
 	struct mii_bus *bus;
-	int err = -ENODEV;
 
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus)
@@ -923,7 +922,7 @@ s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	case IXGBE_DEV_ID_X550EM_A_1G_T:
 	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
 		if (!ixgbe_x550em_a_has_mii(hw))
-			goto ixgbe_no_mii_bus;
+			return -ENODEV;
 		bus->read = &ixgbe_x550em_a_mii_bus_read;
 		bus->write = &ixgbe_x550em_a_mii_bus_write;
 		break;
@@ -948,15 +947,8 @@ s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	 */
 	hw->phy.mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22;
 
-	err = mdiobus_register(bus);
-	if (!err) {
-		adapter->mii_bus = bus;
-		return 0;
-	}
-
-ixgbe_no_mii_bus:
-	devm_mdiobus_free(dev, bus);
-	return err;
+	adapter->mii_bus = bus;
+	return mdiobus_register(bus);
 }
 
 /**
-- 
2.26.1

