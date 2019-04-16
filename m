From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:13 -0700
Subject: [Intel-wired-lan] [PATCH S18 00/15] Fixes and feature updates for
 ice
Message-ID: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin (2):
  ice: Don't remove VLAN filters that were never programmed
  ice: Add function to program ethertype based filter rule on VSIs

Anirudh Venkataramanan (1):
  ice: Fix double spacing

Brett Creeley (2):
  ice: Always free/allocate q_vectors
  ice: Refactor getting/setting coalesce

Bruce Allan (2):
  ice: Do not unnecessarily initialize local variable
  ice: Suppress false-positive style issues reported by static analyzer

Jesse Brandeburg (2):
  ice: Use bitfields where possible
  ice: Use more efficient structures

Michal Swiatkowski (3):
  ice: Fix for allowing too many MDD events on VF
  ice: Add more validation in ice_vc_cfg_irq_map_msg
  ice: Disable sniffing VF traffic on PF

Tony Nguyen (3):
  ice: Preserve VLAN Rx stripping settings
  ice: Remove __always_unused attribute
  ice: Separate if conditions for ice_set_features()

 drivers/net/ethernet/intel/ice/ice.h          |   4 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 154 +++++++++++-------
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 131 +++++++++++----
 drivers/net/ethernet/intel/ice/ice_main.c     |  49 ++----
 drivers/net/ethernet/intel/ice/ice_switch.c   |  59 +++++++
 drivers/net/ethernet/intel/ice/ice_switch.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  10 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  38 +++--
 12 files changed, 310 insertions(+), 150 deletions(-)

-- 
2.20.1

