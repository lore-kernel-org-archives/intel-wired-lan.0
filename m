From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:07 -0400
Subject: [Intel-wired-lan]  [net-next S5 00/15] i40e/i40evf updates
Message-ID: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali refines an error message in i40e.

Carolyn removes inccorect #ifdefs and fixes the compile errors that show
up as a result. She also refactors the dynamic ITR code for i40e and i40evf.

Faisal adds support for pre-allocated pages for PD in i40e.

Greg updates the admin queue command header for i40e and i40evf.

Jesse improves i40e/i40evf tx and rx performance with a couple
small tweaks.

Mitch modifies i40evf to allow for an abundance of vectors, moves adding
MAC address filters from init to open, and  to stop deleting all filters
every time set_rx_mode was called. He also modified i40e to ignore duplicate
port VLAN requests, to correctly program filters for VFs, to do a proper reset
when disabling a VF, and to un-disable the VF after a reset.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  24 ++--
 drivers/net/ethernet/intel/i40e/i40e_hmc.c         |  30 +++--
 drivers/net/ethernet/intel/i40e/i40e_hmc.h         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 150 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  23 ++--
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  18 +--
 drivers/net/ethernet/intel/i40evf/i40e_hmc.h       |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 117 ++++++++++------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  20 +--
 11 files changed, 236 insertions(+), 164 deletions(-)

-- 
1.9.3

