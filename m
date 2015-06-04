From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  4 Jun 2015 16:23:54 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 0/8] i40e/i40evf
	updates
Message-ID: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesse converts i40e and i40evf to use BIT and BIT_ULL macros.

Mitch adds VF capabilities to virtual channel interface and updates
the virtual channel to API version 1.1. He also fixes up i40evf's ability to
handle big resets.

Shannon cleans up error status messages.

 drivers/net/ethernet/intel/i40e/i40e.h             |  56 +--
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 210 ++++++++-
 drivers/net/ethernet/intel/i40e/i40e_dcb.h         |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.c        |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  84 ++--
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_fcoe.h        |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h         |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 467 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   2 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  39 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  44 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  23 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  46 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   5 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c    | 206 +++++++++
 drivers/net/ethernet/intel/i40evf/i40e_hmc.h       |   6 +-
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   2 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  37 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  42 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |  23 +-
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |  16 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  51 ++-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  44 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 123 +++---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  51 ++-
 32 files changed, 1130 insertions(+), 545 deletions(-)

-- 
1.9.3

