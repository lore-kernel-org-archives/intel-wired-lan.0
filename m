From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 14 Dec 2016 11:01:55 -0800
Subject: [Intel-wired-lan] [PATCH V9 0/4] ixgbe: Firmware-controlled PHY
	enablement
Message-ID: <148174202018.48405.9935418150415224529.stgit@mdrustad-wks.jf.intel.com>
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
Changes in V2:
- Fixed some oversights related to the 10M link speed
Changes in V3:
- Use correct ops for LED control
Changes in V4:
- Actually get the V3 changes into the patch. Sorry for the error.
Changes in V5:
- Properly indicate FC autoneg support
Changes in V6:
- Add missing thermal interrupt support
Changes in V7:
- Rebase and resolve conflict
Changes in V8:
- Correct flow error in overtemp code
Changes in V9:
- Correct subtlety in overtemp flow that resulted in double messages

---

Mark D Rustad (4):
      ixgbe: Fix issues with EEPROM access
      ixgbe: Remove unused firmware version functions and method
      ixgbe: Implement firmware interface to access some PHYs
      ixgbe: Implement support for firmware-controlled PHYs


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c   |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |  106 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h  |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  153 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   64 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     |   37 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h     |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   74 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |  529 ++++++++++++++++++++--
 12 files changed, 846 insertions(+), 133 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
