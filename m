From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jun 2020 12:00:45 +0200
Subject: [Intel-wired-lan] [PATCH 00/11] net: improve devres helpers
Message-ID: <20200622100056.10151-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When I first submitted the series adding devm_register_netdev() I was
told during review that it should check if the underlying struct net_device
is managed too before proceeding. I initially accepted this as the right
approach but in the back of my head something seemed wrong about this.
I started looking around and noticed how devm_mdiobus_register()
is implemented.

It turned out that struct mii_bus contains information about whether it's
managed or not and the release callback of devm_mdiobus_alloc() is responsible
for calling mdiobus_unregister(). This seems wrong to me as managed structures
shouldn't care about who manages them. It's devres' code task to correctly undo
whatever it registers/allocates.

With this series I propose to make the release callbacks of mdiobus devm
helpers only release the resources they actually allocate themselves as it the
standard in devm routines. I also propose to not check whether the structures
passed to devm_mdiobus_register() and devm_register_netdev() are already
managed as they could have been allocated over devres as part of bigger
memory chunk. I see this as an unnecessary limitation.

First two patches aim at removing the only use of devm_mdiobus_free(). It
modifies the ixgbe driver. I only compile tested it as I don't have the
relevant hw.

Next two patches relax devm_register_netdev() - we stop checking whether
struct net_device was registered using devm_etherdev_alloc().

We then document the mdio devres helper that's missing in devres.rst list
and un-inline the current implementation of devm_mdiobus_register().

Patch 8 re-implements the devres helpers for mdio conforming to common
devres patterns.

Patches 9 and 10 provide devm_of_mdiobus_register() and the last patch
adds its first user.

Bartosz Golaszewski (11):
  net: ethernet: ixgbe: check the return value of ixgbe_mii_bus_init()
  net: ethernet: ixgbe: don't call devm_mdiobus_free()
  net: devres: relax devm_register_netdev()
  net: devres: rename the release callback of devm_register_netdev()
  Documentation: devres: add missing mdio helper
  phy: un-inline devm_mdiobus_register()
  phy: mdio: add kerneldoc for __devm_mdiobus_register()
  net: phy: don't abuse devres in devm_mdiobus_register()
  of: mdio: remove the 'extern' keyword from function declarations
  of: mdio: provide devm_of_mdiobus_register()
  net: ethernet: mtk-star-emac: use devm_of_mdiobus_register()

 .../driver-api/driver-model/devres.rst        |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 14 +---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 13 +--
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 drivers/net/phy/Makefile                      |  2 +-
 drivers/net/phy/mdio_bus.c                    | 73 ----------------
 drivers/net/phy/mdio_devres.c                 | 83 +++++++++++++++++++
 drivers/of/of_mdio.c                          | 43 ++++++++++
 include/linux/of_mdio.h                       | 40 ++++-----
 include/linux/phy.h                           | 21 +----
 net/devres.c                                  | 23 +----
 12 files changed, 167 insertions(+), 156 deletions(-)
 create mode 100644 drivers/net/phy/mdio_devres.c

-- 
2.26.1

