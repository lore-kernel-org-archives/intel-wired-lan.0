From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 Oct 2021 15:01:20 -0700
Subject: [Intel-wired-lan] [PATCH net-next 0/7] Remove enum ice_status
Message-ID: <20211007220127.70514-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the use of ice_status from the driver. This begins with
refactoring of DDP package download. Package download relies on a
variety of variables to determine its state, including ice_status.
Rework DDP download functions to determine and communicate this state.
These states are DDP specific and only to be used by the package
download functions.

Patches 2-4 are mainly scripted removals and conversions of ice_status
values and helper functions which are followed up by code cleanups as a
result of these changes.

Tony Nguyen (6):
  ice: Remove string printing for ice_status
  ice: Use int for ice_status
  ice: Remove enum ice_status
  ice: Cleanup after ice_status removal
  ice: Remove excess error variables
  ice: Propagate error codes

Wojciech Drewek (1):
  ice: Refactor status flow for DDP load

 drivers/net/ethernet/intel/ice/ice.h          |   1 -
 drivers/net/ethernet/intel/ice/ice_base.c     |  22 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 408 ++++++------
 drivers/net/ethernet/intel/ice/ice_common.h   | 102 +--
 drivers/net/ethernet/intel/ice/ice_controlq.c | 118 ++--
 drivers/net/ethernet/intel/ice/ice_dcb.c      |  91 ++-
 drivers/net/ethernet/intel/ice/ice_dcb.h      |  26 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  68 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 143 ++--
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  44 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  18 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  10 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 617 ++++++++++--------
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |  78 ++-
 drivers/net/ethernet/intel/ice/ice_flow.c     | 158 +++--
 drivers/net/ethernet/intel/ice/ice_flow.h     |  20 +-
 drivers/net/ethernet/intel/ice/ice_fltr.c     |  89 ++-
 drivers/net/ethernet/intel/ice/ice_fltr.h     |  34 +-
 .../net/ethernet/intel/ice/ice_fw_update.c    |  56 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  30 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 229 +++----
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 532 ++++++---------
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 136 ++--
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  32 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  10 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  13 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_sched.c    | 394 +++++------
 drivers/net/ethernet/intel/ice/ice_sched.h    |  36 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  40 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  12 +-
 drivers/net/ethernet/intel/ice/ice_status.h   |  44 --
 drivers/net/ethernet/intel/ice/ice_switch.c   | 448 +++++++------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  56 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  12 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   3 -
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  24 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 126 ++--
 40 files changed, 2034 insertions(+), 2256 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_status.h

-- 
2.20.1

