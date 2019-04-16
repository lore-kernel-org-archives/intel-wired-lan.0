From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:37 -0700
Subject: [Intel-wired-lan] [PATCH S20 00/15] Fixes and feature updates for
 ice
Message-ID: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anirudh Venkataramanan (3):
  ice: Remove direct write for GLLAN_RCTL_0
  ice: Add handler for ethtool selftest
  ice: Minor cleanup in ice_switch.h

Brett Creeley (5):
  ice: Set minimum default Rx descriptor count to 512
  ice: Don't call ice_cfg_itr() for SR-IOV
  ice: Refactor interrupt tracking
  ice: Add a helper to trigger software interrupt
  ice: Use GLINT_DYN_CTL to disable VF's interrupts

Bruce Allan (1):
  ice: Resolve static analysis warning

Dan Nowlin (1):
  ice: Add ice_get_fw_log_cfg to init FW logging

Dave Ertman (1):
  ice: Remove redundant and premature event config

Md Fahad Iqbal Polash (1):
  ice: Configure RSS LUT key only if RSS is enabled

Mitch Williams (2):
  ice: Check all VFs for MDD activity, don't disable
  ice: Change message level

Tony Nguyen (1):
  ice: Implement toggling ethtool rx-vlan-filter

 drivers/net/ethernet/intel/ice/ice.h          |  48 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  24 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  74 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   5 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 601 +++++++++++++++++-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 245 ++++---
 drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 159 +++--
 drivers/net/ethernet/intel/ice/ice_nvm.c      |  31 +
 drivers/net/ethernet/intel/ice/ice_status.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   7 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   8 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 227 +++++--
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   8 +
 16 files changed, 1142 insertions(+), 303 deletions(-)

-- 
2.20.1

