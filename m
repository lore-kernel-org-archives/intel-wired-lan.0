From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:47 -0800
Subject: [Intel-wired-lan] [PATCH S12 00/14] Bug fixes and minor feature
 updates for ice
Message-ID: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin (5):
  ice: Fix issue with VF reset and multiple VFs support on PFs
  ice: Implement flow to reset VFs with PFR and other resets
  ice: Reset all VFs with VFLR during SR-IOV init flow
  ice: Enable MAC anti-spoof by default
  ice: Fix issue reclaiming resources back to the pool after reset

Brett Creeley (5):
  ice: remove redundant variable and if condition
  ice: use ice_for_each_vsi macro when possible
  ice: configure GLINT_ITR to always have an ITR gran of 2
  ice: Get resources per function
  ice: Determine descriptor count and ring size based on PAGE_SIZE

Bruce Allan (1):
  ice: avoid multiple unnecessary de-references in probe

Chinh T Cao (1):
  ice : Ensure only valid bits are set in ice_aq_set_phy_cfg

Henry Tieman (1):
  ice: implement ethtool set channels

Michal Swiatkowski (1):
  ice: Fix broadcast traffic in port VLAN mode

 drivers/net/ethernet/intel/ice/ice.h             |  19 ++-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.c      |  24 +++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |  88 ++++++++++++-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |  10 ++
 drivers/net/ethernet/intel/ice/ice_lib.c         | 157 +++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.h         |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c        | 125 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c        |  10 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 100 +++++++++------
 12 files changed, 411 insertions(+), 131 deletions(-)

-- 
2.14.5

