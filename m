From: Steve Douthit <stephend@silicom-usa.com>
Date: Mon, 3 Dec 2018 16:32:47 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 0/2] Add mii_bus to ixgbe
 driver for dsa devs
Message-ID: <20181203163227.5107-1-stephend@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Address review comments from v1.  I missed the intel-wired-lan list on
the first submission, so check out the netdev list archive for the first
rev of the patch.

I think it's still up in the air on how best to register a single bus
that's shared among up to four MACs.  This code works for me, but there
might be a better way to do this.

Same caveats about testing still apply.  My test setup is a Marvell
Peridot switch hanging off of a Intel C3000 SoC.  Clause 45 devices and
other ixgbe devices have not been tested.

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

