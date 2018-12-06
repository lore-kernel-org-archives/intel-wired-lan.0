From: Steve Douthit <stephend@silicom-usa.com>
Date: Thu, 6 Dec 2018 15:50:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 0/2] Add mii_bus to ixgbe
 driver for dsa devs
In-Reply-To: <20181203163227.5107-1-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
Message-ID: <20181206154955.334-1-stephend@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changes from v4 -> v5
* select MDIO_DEVICE instead of MII in Kconfig
* Collect Tested-by: tags

Changes from v3 -> v4
* Remove unecessary pointer casts
* Fix copy/paste issues in comments
* Simplify setting of swfw semaphore flags
* Collect Reviewed-by: tags

Changes from v2 -> v3
* Added warnings about interactions between this code and PHY polling
  unit to the commit messages.

Changes from v1 -> v2
[PATCH 1/2] ixgbe: register a mdiobus
* Add intel-wired-lan at lists.osuosl.org to CC list, see
* select MII in Kconfig (thanks to the kbuild bot)
* Only call mdiobus_regsiter for single x500em_a device
* Use readx_poll_timeout() in ixgbe_msca_cmd()
* Register different bus->read/write callbacks in ixgbe_mii_bus_init()
  so there's device id check on every access
* Use device pci_name() in bus->id instead of parent bridge's name

[PATCH 2/2] ixgbe: use mii_bus to handle MII related ioctls
* Only use mdiobus_read/write for adapters that registered a mdiobus

Stephen Douthit (2):
  ixgbe: register a mdiobus
  ixgbe: use mii_bus to handle MII related ioctls

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  23 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 307 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +
 5 files changed, 335 insertions(+)

-- 
2.17.2

