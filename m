From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:17:41 -0700
Subject: [Intel-wired-lan] [PATCH V5 00/19] ixgbe: Add support for X550EM
	devices with SFPs
Message-ID: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patches add remaining bits of support for X550EM devices with
SFPs. The last patch adds the device ID.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

---
Changes in V2:
- Added more changes that had been missed (9 more patches!)
- Added latest CS4227 reset process
Changes in V3:
- Added a missed patch to permit SFP+ on more than just 82598 and 82599
Changes in V4:
- Added omitted NULL check for flap_tx_laser method calls
Changes in V5:
- Simplified return exit, as suggested by the build robot
- Added 6 more patches:
	- Limit SFP+ polling rate
	- I2C mux support
	- Correct error path in semaphore handling
	- Set RDRXCTL correctly for X550* devices
	- Add small packet padding support for X550
	- Update disable PCIe master for X550*

---

Mark D Rustad (19):
      ixgbe: Accept SFP not present errors on all devices
      ixgbe: Add X550EM support for SFP insertion interrupt
      ixgbe: Provide I2C combined on X550EM
      ixgbe: Provide unlocked I2C methods
      ixgbe: Set lan_id before first I2C eeprom access
      ixgbe: Enable bit-banging mode on X550
      ixgbe: Clear I2C destination location
      ixgbe: Allow reduced delays during sfp detection
      ixgbe: Add X550EM_x dual-speed SFP+ support
      ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+
      ixgbe: Add logic to reset CS4227 when needed
      ixgbe: Allow SFP+ on more than 82598 and 82599
      ixgbe: Limit SFP polling rate
      ixgbe: Add I2C bus mux support
      ixgbe: Correct error path in semaphore handling
      ixgbe: Correct setting of RDRXCTL register for X550* devices
      ixgbe: Add small packet padding support for X550
      ixgbe: Update ixgbe_disable_pcie_master flow for X550*
      ixgbe: Add new X550EM SFP+ device ID


 drivers/net/ethernet/intel/ixgbe/ixgbe.h        |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c  |  193 +--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  211 ++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    5 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |   21 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c    |  286 ++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h    |   35 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    8 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c   |  105 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |  481 +++++++++++++++++++++--
 10 files changed, 1050 insertions(+), 297 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
