From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:49 -0700
Subject: [Intel-wired-lan] [PATCH S8 00/16] Bug fixes for ice, set 1/2
Message-ID: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin (1):
  ice: Fix dead device link issue with flow control

Anirudh Venkataramanan (6):
  ice: Set carrier state and start/stop queues in rebuild
  ice: Check for reset in progress during remove
  ice: Remove duplicate addition of VLANs in replay path
  ice: Fix typo in error message
  ice: Remove node before releasing VSI
  ice: Calculate guaranteed VSIs per function and use it

Brett Creeley (3):
  ice: Fix tx_timeout in PF driver
  ice: Fix the bytecount sent to netdev_tx_sent_queue
  ice: Fix debug print in ice_tx_timeout

Dave Ertman (2):
  ice: Fix napi delete calls for remove
  ice: Avoid nested RTNL locking in ice_dis_vsi

Lev Faerman (1):
  ice: Fix NVM mask defines

Md Fahad Iqbal Polash (1):
  ice: Fix flags for port VLAN

Tony Nguyen (1):
  ice: Check for q_vector when stopping rings

Victor Raj (1):
  ice: Free VSI contexts during for unload

 drivers/net/ethernet/intel/ice/ice.h             |   5 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |   7 +-
 drivers/net/ethernet/intel/ice/ice_common.c      |  34 ++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |   7 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   5 +
 drivers/net/ethernet/intel/ice/ice_lib.c         |   7 +-
 drivers/net/ethernet/intel/ice/ice_main.c        | 119 +++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_sched.c       | 108 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_sched.h       |   2 +
 drivers/net/ethernet/intel/ice/ice_switch.c      |  12 +++
 drivers/net/ethernet/intel/ice/ice_switch.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_txrx.c        |  11 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.h        |  17 +++-
 drivers/net/ethernet/intel/ice/ice_type.h        |   4 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |   4 +-
 15 files changed, 271 insertions(+), 73 deletions(-)

-- 
2.14.3

