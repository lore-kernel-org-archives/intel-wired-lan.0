From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 11 Oct 2016 15:26:52 -0700
Subject: [Intel-wired-lan] [next PATCH S50 0/6] i40e/i40evf updates
Message-ID: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck adds common function for finding VSI by type & adds 
code to reorder logic for coalescing RS bits.

Maciej Sosin adds code for implementation of ERROR state for NVM 
update state machine.

Michal Kosiarz fixes code for division by zero.

Mitch Williams adds code to clear mac filter count on reset.

Filip Sadowski removed unreachable code.

 drivers/net/ethernet/intel/i40e/i40e.h             |  24 ++++-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  30 +-----
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  62 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  16 +++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 110 ++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 -
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  30 ++----
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c    |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 105 ++++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   1 -
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   1 +
 14 files changed, 195 insertions(+), 200 deletions(-)

-- 
2.4.11

