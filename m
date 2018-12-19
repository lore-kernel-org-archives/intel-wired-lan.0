From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Dec 2018 10:03:19 -0800
Subject: [Intel-wired-lan] [PATCH S10 00/15] Feature updates for ice
Message-ID: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset implements another round of feature updates for the
ice driver. Most notably, support for additional PHY/link speeds,
adaptive interrupt moderation and some ethtool handlers were added.

Anirudh Venkataramanan (6):
  ice: Refactor a few Tx scheduler functions
  ice: Add ethtool set_phys_id handler
  ice: Rework queue manangement code for reuse
  ice: Move aggregator list into ice_hw instance
  ice: Offload SCTP checksum
  ice: Add support for new PHY types

Brett Creeley (3):
  ice: Set physical link up/down when an interface is set up/down
  ice: Add support for adaptive interrupt moderation
  ice: Implement getting and setting ethtool coalesce

Bruce Allan (3):
  ice: Fix unused variable build warning
  ice: Implement support for normal get_eeprom[_len] ethtool ops
  ice: Add ethtool private flag to make forcing link down optional

Jacob Keller (1):
  ice: add const qualifier to mac_addr parameter

Md Fahad Iqbal Polash (1):
  ice: Configure RSS LUT and HASH KEY in rebuild path

Tony Nguyen (1):
  ice: Allow for software timestamping

 drivers/net/ethernet/intel/ice/ice.h             |  16 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |  77 ++-
 drivers/net/ethernet/intel/ice/ice_common.c      | 160 +++++-
 drivers/net/ethernet/intel/ice/ice_common.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 680 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   1 +
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c         | 264 +++++----
 drivers/net/ethernet/intel/ice/ice_lib.h         |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c        | 132 ++++-
 drivers/net/ethernet/intel/ice/ice_nvm.c         |  81 +++
 drivers/net/ethernet/intel/ice/ice_sched.c       | 156 +++---
 drivers/net/ethernet/intel/ice/ice_sched.h       |   2 +
 drivers/net/ethernet/intel/ice/ice_sriov.c       |   9 +
 drivers/net/ethernet/intel/ice/ice_txrx.c        |  71 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.h        |  32 +-
 drivers/net/ethernet/intel/ice/ice_type.h        |   4 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  24 +-
 18 files changed, 1444 insertions(+), 284 deletions(-)

-- 
2.14.5

