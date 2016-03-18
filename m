From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 11:32:45 -0700
Subject: [Intel-wired-lan] [PATCH V2 0/7] ixgbe: Add initial support for a
	new ixgbe MAC
Message-ID: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patches add initial support for a new ixgbe MAC type.
The initial interface supported is a native SFP+ interface.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changes in V2:
- Added a missing check to set SFP detection interrupt mask

---

Mark D Rustad (7):
      ixgbe: Add definitions for new 10G MAC
      ixgbe: Add support for phy token firmware command
      ixgbe: Add new semaphore method for a new MAC
      ixgbe: Use method pointer to access IOSF devices
      ixgbe: Provide for use of firmware to access IOSF registers
      ixgbe: Add support for new 10G MAC type
      ixgbe: Add some new device IDs for new 10G MAC


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c     |    6 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    9 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   43 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c     |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     |    6 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   62 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |  245 ++++++++++++++++++++--
 11 files changed, 353 insertions(+), 28 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
