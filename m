From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 18 Oct 2018 08:37:02 -0700
Subject: [Intel-wired-lan] [PATCH 0/7] ice bug fixes and minor
 implementation updates
Message-ID: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anirudh Venkataramanan (7):
  ice: Make ice_msix_clean_rings static
  ice: Change device ID define names to align with branding string
  ice: Update expected FW version
  ice: Use capability count returned by the firmware
  ice: Introduce ice_dev_onetime_setup
  ice: Allocate VF interrupts and set queue map
  ice: Poll for link status change

 drivers/net/ethernet/intel/ice/ice_common.c      |  52 ++++------
 drivers/net/ethernet/intel/ice/ice_common.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h    |   5 +-
 drivers/net/ethernet/intel/ice/ice_devids.h      |   6 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   8 ++
 drivers/net/ethernet/intel/ice/ice_lib.c         |   3 +-
 drivers/net/ethernet/intel/ice/ice_lib.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c        | 116 ++++++-----------------
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  15 ++-
 9 files changed, 77 insertions(+), 138 deletions(-)

-- 
2.14.3

