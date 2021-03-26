From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:23 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 00/11] warning cleanups
Message-ID: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In this series I address the C=2 (sparse) warnings. The goal is to be
completely sparse clean in the drivers/net/ethernet/intel directory.
This can help us run this tool for every patch, and helps the kernel
code by reducing technical debt.

NOTE: there is one warning left in ixgbe XDP code using
rcu_assign_pointer().

Jesse Brandeburg (11):
  e100: handle eeprom as little endian
  intel: remove checker warning
  fm10k: move error check
  igb/igc: use strongly typed pointer
  igb: handle vlan types with checker enabled
  igb: fix assignment on big endian machines
  igb: override two checker warnings
  intel: call csum functions with well formatted arguments
  igbvf: convert to strongly typed descriptors
  ixgbe: use checker safe conversions
  ixgbe: reduce checker warnings

 drivers/net/ethernet/intel/e100.c             | 12 +++---
 .../net/ethernet/intel/e1000/e1000_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 10 ++---
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 11 ++---
 drivers/net/ethernet/intel/igb/igb_ptp.c      |  4 +-
 drivers/net/ethernet/intel/igbvf/netdev.c     |  6 +--
 drivers/net/ethernet/intel/igbvf/vf.h         | 42 +++++++++----------
 drivers/net/ethernet/intel/igc/igc_dump.c     |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  9 ++--
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  8 ++--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
 13 files changed, 56 insertions(+), 56 deletions(-)


base-commit: 4390eafe5ee738a90ab2ae0e3eb2c81330107d05
-- 
2.30.2

