From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:24:24 -0700
Subject: [Intel-wired-lan] [PATCH S19 00/15] Fixes and feature updates for
 ice
Message-ID: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anirudh Venkataramanan (3):
  ice: Implement LLDP persistence
  ice: Remove braces for single statement blocks
  ice: Call out dev/func caps when printing

Brett Creeley (2):
  ice: Gracefully handle reset failure in ice_alloc_vfs()
  ice: Fix couple of issues in ice_vsi_release

Bruce Allan (3):
  ice: Cleanup an unnecessary variable initialization
  ice: Silence semantic parser warnings
  ice: Fix LINE_SPACING style issue

Dave Ertman (1):
  ice: Fix hang when ethtool disables FW LLDP

Jesse Brandeburg (3):
  ice: Reorganize tx_buf and ring structs
  ice: Use bitfields when possible
  ice: Reorganize ice_vf struct

Richard Rodriguez (1):
  ice: Format ethtool reported stats

Tony Nguyen (1):
  ice: Advertise supported link modes if none requested

Usha Ketineni (1):
  ice: Refactor the LLDP MIB change event handling

 drivers/net/ethernet/intel/ice/ice.h          |  13 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  57 ++---
 drivers/net/ethernet/intel/ice/ice_dcb.c      |  21 +-
 drivers/net/ethernet/intel/ice/ice_dcb.h      |  12 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 212 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 197 +++++++++-------
 drivers/net/ethernet/intel/ice/ice_lib.c      |  24 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  35 +--
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  20 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  25 ++-
 14 files changed, 399 insertions(+), 234 deletions(-)

-- 
2.20.1

