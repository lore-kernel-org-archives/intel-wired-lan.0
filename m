From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 14 Sep 2018 17:37:43 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 00/14] rename and shrink i40evf
Message-ID: <20180915003757.169108-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains changes to i40evf so that it becomes a more
generic virtual function driver for current and future silicon.

While doing the rename of i40evf to a more generic name of iavf,
we also put the driver on a severe diet due to how much of the
code was unneeded or was unused.  The outcome is a lean and mean
virtual function driver that continues to work on existing 40GbE
(i40e) virtual devices and prepped for future supported devices,
like the 100GbE (ice) virtual devices.

This solves 2 issues we saw coming or were already present, the
first was constant code duplication happening with i40e/i40evf,
when much of the duplicate code in the i40evf was not used or was
not needed.  The second was to remove the future confusion of why
future VF devices that were not considered "40GbE" only devices
were supported by i40evf.

The thought is that iavf will be the virtual function driver for
all future devices, so it should have a "generic" name to properly
represent that it is the VF driver for multiple generations of
devices.

The last patch in this series is unreleated to the iavf conversion
and just has to do with a MODULE_LICENSE correction.

Known Caveats:
Existing user space configurations may have to change, but the module
alias in patch 1 helps a bit here.

---
NOTE: This series is compile tested, but needs more testing before
      commit.  I expect it will go through Jeff's regular
      intel-wired-lan process.

v2: first non-RFC version, updated Kconfig migration in patch 1
v1: initial RFC


Jesse Brandeburg (14):
  intel-ethernet: rename i40evf to iavf
  iavf: diet and reformat
  iavf: rename functions and structs to new name
  iavf: rename i40e_status to iavf_status
  iavf: move i40evf files to new name
  iavf: remove references to old names
  iavf: rename device ID defines
  iavf: rename I40E_ADMINQ_DESC
  iavf: rename i40e_hw to iavf_hw
  iavf: replace i40e_debug with iavf version
  iavf: tracing infrastructure rename
  iavf: rename most of i40e strings
  iavf: finish renaming files to iavf
  intel-ethernet: use correct module license

 Documentation/networking/00-INDEX                  |    4 +-
 Documentation/networking/{i40evf.txt => iavf.txt}  |   16 +-
 MAINTAINERS                                        |    2 +-
 drivers/net/ethernet/intel/Kconfig                 |   15 +-
 drivers/net/ethernet/intel/Makefile                |    2 +-
 drivers/net/ethernet/intel/e100.c                  |    2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |    2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c      |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    2 +-
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |   34 -
 drivers/net/ethernet/intel/i40evf/i40e_hmc.h       |  215 --
 drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h   |  158 --
 drivers/net/ethernet/intel/i40evf/i40e_register.h  |  313 ---
 .../net/ethernet/intel/{i40evf => iavf}/Makefile   |   11 +-
 .../ethernet/intel/{i40evf => iavf}/i40e_adminq.c  |  309 ++-
 .../ethernet/intel/{i40evf => iavf}/i40e_adminq.h  |   35 +-
 .../intel/{i40evf => iavf}/i40e_adminq_cmd.h       | 2281 +-------------------
 .../intel/{i40evf/i40evf.h => iavf/iavf.h}         |  407 ++--
 .../{i40evf/i40e_alloc.h => iavf/iavf_alloc.h}     |   47 +-
 .../{i40evf/i40evf_client.c => iavf/iavf_client.c} |  200 +-
 .../{i40evf/i40evf_client.h => iavf/iavf_client.h} |   30 +-
 .../{i40evf/i40e_common.c => iavf/iavf_common.c}   | 1105 ++++------
 drivers/net/ethernet/intel/iavf/iavf_devids.h      |   12 +
 .../i40evf_ethtool.c => iavf/iavf_ethtool.c}       |  510 +++--
 .../{i40evf/i40evf_main.c => iavf/iavf_main.c}     | 1688 ++++++++-------
 .../{i40evf/i40e_osdep.h => iavf/iavf_osdep.h}     |   28 +-
 .../i40e_prototype.h => iavf/iavf_prototype.h}     |  147 +-
 drivers/net/ethernet/intel/iavf/iavf_register.h    |   68 +
 .../{i40evf/i40e_status.h => iavf/iavf_status.h}   |    8 +-
 .../{i40evf/i40e_trace.h => iavf/iavf_trace.h}     |   86 +-
 .../intel/{i40evf/i40e_txrx.c => iavf/iavf_txrx.c} |  804 +++----
 .../intel/{i40evf/i40e_txrx.h => iavf/iavf_txrx.h} |  359 ++-
 .../intel/{i40evf/i40e_type.h => iavf/iavf_type.h} | 1604 ++++----------
 .../i40evf_virtchnl.c => iavf/iavf_virtchnl.c}     |  501 +++--
 drivers/net/ethernet/intel/ice/ice_main.c          |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |    2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |    2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c        |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |    2 +-
 41 files changed, 3440 insertions(+), 7581 deletions(-)
 rename Documentation/networking/{i40evf.txt => iavf.txt} (72%)
 delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_devids.h
 delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_hmc.h
 delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h
 delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_register.h
 rename drivers/net/ethernet/intel/{i40evf => iavf}/Makefile (38%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_adminq.c (74%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_adminq.h (82%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_adminq_cmd.h (22%)
 rename drivers/net/ethernet/intel/{i40evf/i40evf.h => iavf/iavf.h} (37%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_alloc.h => iavf/iavf_alloc.h} (16%)
 rename drivers/net/ethernet/intel/{i40evf/i40evf_client.c => iavf/iavf_client.c} (66%)
 rename drivers/net/ethernet/intel/{i40evf/i40evf_client.h => iavf/iavf_client.h} (87%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_common.c => iavf/iavf_common.c} (37%)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_devids.h
 rename drivers/net/ethernet/intel/{i40evf/i40evf_ethtool.c => iavf/iavf_ethtool.c} (59%)
 rename drivers/net/ethernet/intel/{i40evf/i40evf_main.c => iavf/iavf_main.c} (63%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_osdep.h => iavf/iavf_osdep.h} (56%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_prototype.h => iavf/iavf_prototype.h} (10%)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_register.h
 rename drivers/net/ethernet/intel/{i40evf/i40e_status.h => iavf/iavf_status.h} (95%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_trace.h => iavf/iavf_trace.h} (66%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_txrx.c => iavf/iavf_txrx.c} (72%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_txrx.h => iavf/iavf_txrx.h} (52%)
 rename drivers/net/ethernet/intel/{i40evf/i40e_type.h => iavf/iavf_type.h} (12%)
 rename drivers/net/ethernet/intel/{i40evf/i40evf_virtchnl.c => iavf/iavf_virtchnl.c} (73%)

-- 
2.14.4

