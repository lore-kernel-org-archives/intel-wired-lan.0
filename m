From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 29 Mar 2016 16:57:25 -0700
Subject: [Intel-wired-lan] [PATCH V4 00/11] ixgbe: Add support for x550em_a
	MAC
Message-ID: <20160329235544.68428.93935.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patches add support for a new ixgbe MAC type,
x550em_a. The interfaces supported are native SFP+, SFP+ with a
retimer, SGMII backplane and KR backplane.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
This series replaces two previous series of patches:
	ixgbe: Add initial support for a new ixgbe MAC
	ixgbe: Add KR and SFP+ interfaces to X550EM_A
with some reorganization, a couple bug fixes and incorporation of
other feedback. This series also adds the SGMII backplane support
which was not included in the previous 2 series.

Changes in V2 of this series:
- Corrected endianness of IOSF data accessed by firmware
Changes in V3 of this series:
- Moved a mac type check into ixgbe_setup_kr_x550em
Changes in V4 of this series:
- Patch 4 was replaced with different patch to implement a new PHY
  access method. The previous patch resuled in a failure on other
  MACs.
---

Mark D Rustad (11):
      ixgbe: Add definitions for x550em_a 10G MAC
      ixgbe: Use method pointer to access IOSF devices
      ixgbe: Add support for x550em_a 10G MAC type
      ixgbe: Use new methods for PHY access
      ixgbe: Read and set instance id
      ixgbe: Read and parse NW_MNG_IF_SEL register
      ixgbe: Introduce function to control MDIO speed
      ixgbe: Add support for SFPs with retimer
      ixgbe: Add support for SGMII backplane interface
      ixgbe: Add KR backplane support for x550em_a
      ixgbe: Bump version number


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |    9 
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c     |    6 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    9 
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   51 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c     |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h     |    6 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     |    6 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   88 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |  576 +++++++++++++++++++++-
 12 files changed, 714 insertions(+), 46 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
