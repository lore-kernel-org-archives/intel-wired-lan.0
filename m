From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:42:52 -0700
Subject: [Intel-wired-lan] [PATCH v2 00/16] Add SR-IOV support,
 feature updates
Message-ID: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset adds SR-IOV support and miscellaneous implementation
updates (ITR, filtering, bug fixes) for the ice driver.

Anirudh Venkataramanan (10):
  ice: Add support to detect SR-IOV capability and mailbox queues
  ice: Add handler to configure SR-IOV
  ice: Update VSI and queue management code to handle VF VSI
  ice: Add support for VF reset events
  ice: Add handlers for VF netdevice operations
  ice: Implement virtchnl commands for AVF support
  ice: Notify VF of link status change
  ice: Extend malicious operations detection logic
  ice: Fix forward to queue group logic
  ice: Update version string

Brett Creeley (2):
  ice: Add code to go from ICE_FWD_TO_VSI_LIST to ICE_FWD_TO_VSI
  ice: Add more flexibility on how we assign an ITR index

Dave Ertman (3):
  ice: Fix potential null pointer issues
  ice: Use the right function to enable/disable VSI
  ice: Fix error on driver remove

Yashaswini Raghuram Prathivadi Bhayankaram (1):
  virtchnl: Added support to exchange additional speed values

 drivers/net/ethernet/intel/ice/Makefile          |    1 +
 drivers/net/ethernet/intel/ice/ice.h             |   34 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |   20 +
 drivers/net/ethernet/intel/ice/ice_common.c      |   78 +-
 drivers/net/ethernet/intel/ice/ice_common.h      |    4 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c    |   46 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h    |    2 +
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   69 +
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |   13 +
 drivers/net/ethernet/intel/ice/ice_lib.c         |  283 ++-
 drivers/net/ethernet/intel/ice/ice_lib.h         |    3 +-
 drivers/net/ethernet/intel/ice/ice_main.c        |  156 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c       |  127 +
 drivers/net/ethernet/intel/ice/ice_sriov.h       |   34 +
 drivers/net/ethernet/intel/ice/ice_status.h      |    3 +
 drivers/net/ethernet/intel/ice/ice_switch.c      |   66 +-
 drivers/net/ethernet/intel/ice/ice_switch.h      |    1 +
 drivers/net/ethernet/intel/ice/ice_txrx.h        |   13 +-
 drivers/net/ethernet/intel/ice/ice_type.h        |   20 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2668 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  173 ++
 include/linux/avf/virtchnl.h                     |   15 +
 22 files changed, 3720 insertions(+), 109 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sriov.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sriov.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h

-- 
2.14.3

