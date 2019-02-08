From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:27 -0800
Subject: [Intel-wired-lan] [PATCH S11 00/16] Bug fixes for ice
Message-ID: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Brett Creeley (2):
  ice: fix issue where host reboots on unload when iommu=on
  ice: only use the VF for ICE_VSI_VF in ice_vsi_release

Bruce Allan (4):
  ice: Mark extack argument as __always_unused
  ice: sizeof(<type>) should be avoided
  ice: fix stack hogs from struct ice_vsi_ctx structures
  ice: fix numeric overflow warning

Jacob Keller (1):
  ice: fix ice_remove_rule_internal vsi_list handling

Jesse Brandeburg (1):
  ice: fix overlong string, update stats output

Lukasz Czapnik (1):
  ice: Fix for FC get rx/tx pause params

Maciej Fijalkowski (1):
  ice: Fix the calculation of ICE_MAX_MTU

Mitch Williams (3):
  ice: don't spam VFs with link messages
  ice: clear VF ARQLEN register on reset
  ice: use absolute vector ID for VFs

Victor Raj (3):
  ice: Fix added in VSI supported nodes calc
  ice: flush tx pipe on disable queue timeout
  ice: check for a leaf node presence

 drivers/net/ethernet/intel/ice/ice.h             |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.c      |  21 +++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 132 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c         | 112 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c        | 133 +++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_nvm.c         |   7 +-
 drivers/net/ethernet/intel/ice/ice_sched.c       |  41 +++++--
 drivers/net/ethernet/intel/ice/ice_status.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_switch.c      |  17 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c        |  26 ++---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  70 ++++++++----
 12 files changed, 364 insertions(+), 199 deletions(-)

-- 
2.14.5

