From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:34:49 -0700
Subject: [Intel-wired-lan] [PATCH S21 00/14] Fixes and feature updates for
 ice
Message-ID: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin (1):
  ice: Use right type for ice_cfg_vsi_lan return

Anirudh Venkataramanan (7):
  ice: Add support for virtchnl_vector_map.[rxq|txq]_map
  ice: Use continue instead of an else block
  ice: Align to updated AQ command formats
  ice: Move define for ICE_AQC_DRIVER_UNLOADING
  ice: Update function header
  ice: Recognize higher speeds
  ice: Trivial cosmetic changes

Bruce Allan (1):
  ice: Cleanup ice_update_link_info

Dave Ertman (1):
  ice: Add switch rules to handle LLDP packets

Jacob Keller (1):
  ice: Use a different ICE_DBG bit for firmware log messages

Paul Greenwalt (1):
  ice: Add support for Forward Error Correction (FEC)

Preethi Banala (1):
  ice: Change minimum descriptor count value for Tx/Rx rings

Tony Nguyen (1):
  ice: Introduce ice_init_mac_fltr and move ice_napi_del

 drivers/net/ethernet/intel/ice/ice.h          |   2 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  25 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 127 ++++++++--
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c      |  14 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  24 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 229 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 213 ++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.h      |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 199 ++++++++++-----
 drivers/net/ethernet/intel/ice/ice_switch.c   |   7 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   8 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  12 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  54 +++--
 16 files changed, 742 insertions(+), 194 deletions(-)

-- 
2.20.1

