From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 14:31:11 -0700
Subject: [Intel-wired-lan] [PATCH v1 00/13] Fix several GCC6 warnings
Message-ID: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series fixes several warnings on Intel(R) drivers, including
for igb, igbvf, e1000e, ixgbe, ixgbevf, i40e, i40evf and fm10k.

The primary change is to use BIT() macro where appropriate, and use the
unsigned postfix for various other bitshifts. While much of this change
doesn't prevent any current warnings, it helps ensure that future
additions make use of BIT() macro or the unsigned postfix and prevent
signed bitshift errors in the future. A few places (especially in ixgbe)
don't use BIT even though it's technically equivalent for style and
understanding the real intent of the code.

The series also fixes some other warnings, and makes use of GENMASK in a
few locations.

Jacob Keller (13):
  ixgbe: use BIT() macro
  ixgbe: resolve shift of negative value warning
  ixgbevf: make use of BIT() macro to avoid shift of signed values
  i40e/i40evf: fix I40E_MASK signed shift overflow warnings
  i40e: make use of BIT() macro to prevent left shift of signed values
  i40evf: make use of BIT() macro to avoid signed left shift
  igb: use BIT() macro or unsigned prefix
  igb: make igb_update_pf_vlvf static
  igbvf: remove unused variable and dead code
  igbvf: use BIT() macro instead of shifts
  e1000e: use BIT() macro for bit defines
  e1000e: mark shifted values as unsigned
  e1000e: remove unused variable

 drivers/net/ethernet/intel/e1000e/80003es2lan.c    |  12 +-
 drivers/net/ethernet/intel/e1000e/82571.c          |  30 ++--
 drivers/net/ethernet/intel/e1000e/e1000.h          | 100 ++++++-------
 drivers/net/ethernet/intel/e1000e/ethtool.c        |  40 ++---
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  44 +++---
 drivers/net/ethernet/intel/e1000e/ich8lan.h        |   8 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  29 ++--
 drivers/net/ethernet/intel/e1000e/nvm.c            |   2 +-
 drivers/net/ethernet/intel/e1000e/phy.c            |   4 +-
 drivers/net/ethernet/intel/e1000e/phy.h            |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  53 ++++---
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   2 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  44 +++---
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   2 +-
 drivers/net/ethernet/intel/igb/e1000_82575.c       |   8 +-
 drivers/net/ethernet/intel/igb/e1000_82575.h       |  30 ++--
 drivers/net/ethernet/intel/igb/e1000_defines.h     | 108 +++++++-------
 drivers/net/ethernet/intel/igb/e1000_mac.c         |  10 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.c         |   4 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c         |   2 +-
 drivers/net/ethernet/intel/igb/e1000_phy.h         |   6 +-
 drivers/net/ethernet/intel/igb/igb.h               |  32 ++--
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  18 +--
 drivers/net/ethernet/intel/igb/igb_main.c          |  50 +++----
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   6 +-
 drivers/net/ethernet/intel/igbvf/defines.h         |   2 +-
 drivers/net/ethernet/intel/igbvf/ethtool.c         |   2 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |  14 +-
 drivers/net/ethernet/intel/igbvf/vf.c              |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |  68 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |   6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  30 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c       |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c    |   6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  14 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  36 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  22 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      | 164 ++++++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   8 +-
 drivers/net/ethernet/intel/ixgbevf/defines.h       |  22 +--
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |   8 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  18 +--
 52 files changed, 558 insertions(+), 564 deletions(-)

-- 
2.8.1.102.ga49ec4a

