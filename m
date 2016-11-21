From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Mon, 21 Nov 2016 15:47:53 -0800
Subject: [Intel-wired-lan] [PATCH 0/4] ixgbe: Firmware-controlled PHY
	enablement
Message-ID: <147977200790.28902.977631990204721234.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patches enable firmware-controlled PHYs. The first two
patches resolve some issues uncovered while working on the other
patches. The third adds the firmware interface for controlling PHYs.
The last patch implements everything else for the new devices.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

---

Mark D Rustad (4):
      ixgbe: Fix issues with EEPROM access
      ixgbe: Remove unused firmware version functions and method
      ixgbe: Implement firmware interface to access some PHYs
      ixgbe: Implement support for firmware-controlled PHYs


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c   |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |   97 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h  |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  138 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   42 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     |   37 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h     |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   73 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |  508 ++++++++++++++++++++--
 12 files changed, 781 insertions(+), 130 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
