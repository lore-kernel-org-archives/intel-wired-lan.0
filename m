From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:00 -0800
Subject: [Intel-wired-lan] [PATCH S15 00/14] Bug fixes and minor clean up
 for ice
Message-ID: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin (1):
  ice: Fix issue with VF attempt to delete default MAC address

Anirudh Venkataramanan (8):
  ice: Fix for adaptive interrupt moderation
  ice: Remove unused function prototype
  ice: Remove unnecessary braces
  ice: Update function header for __ice_vsi_get_qs
  ice: Remove "2 BITS" comment
  ice: Fix typos in code comments
  ice: Fix incorrect use of abbreviations
  ice: Bump version

Brett Creeley (3):
  ice: Audit hotpath structures with pahole
  ice: Add missing case in print_link_msg for printing flow control
  ice: Update comment regarding the ITR_GRAN_S

Mitch Williams (1):
  ice: enable VF admin queue interrupts

Preethi Banala (1):
  ice: Do not bail out when filter already exists

 drivers/net/ethernet/intel/ice/ice.h             |  32 ++-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |  20 +-
 drivers/net/ethernet/intel/ice/ice_common.c      | 100 +++----
 drivers/net/ethernet/intel/ice/ice_controlq.c    |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |  20 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   2 +
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |  24 +-
 drivers/net/ethernet/intel/ice/ice_lib.c         |  33 ++-
 drivers/net/ethernet/intel/ice/ice_lib.h         |   2 -
 drivers/net/ethernet/intel/ice/ice_main.c        |  87 ++++---
 drivers/net/ethernet/intel/ice/ice_nvm.c         |   6 +-
 drivers/net/ethernet/intel/ice/ice_sched.c       | 104 ++++----
 drivers/net/ethernet/intel/ice/ice_switch.c      | 108 ++++----
 drivers/net/ethernet/intel/ice/ice_switch.h      |  10 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c        | 315 ++++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h        |  18 +-
 drivers/net/ethernet/intel/ice/ice_type.h        |  22 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  79 +++---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |   8 +-
 19 files changed, 627 insertions(+), 373 deletions(-)

-- 
2.14.5

