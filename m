From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:28 -0400
Subject: [Intel-wired-lan] [next PATCH S12 00/15] i40e/i40evf updates
Message-ID: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali adds a stat to keep track of linearization count.

Carolyn fixes the extra Flow Director filter in the table after an error.

Jesse fixes an erroneous WARN_ON, and moves the interrupt enable to inline.

Matt adds a fix for multiple link up messages in i40e.

Mitch propagates an interrupt allocation failure in the vf, removes an
unused opcode in both i40e and i40evf, and adds more verbose error messages
to i40e.

Neerav adds additional checks for CEE APP priority validity, adds parsing for
CEE DCBX TLVs, and stores the CEE DCBX DesiredCfg and RemoteCfg.

Serey explicitly assign enum index for VSI type in both i40e and i40evf.

Shannon adds a switch for link polling, and saves aq writeback for future
inspection.

 drivers/net/ethernet/intel/i40e/i40e.h             |  25 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   4 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |   1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         | 271 +++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_dcb.h         |  39 +++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  41 +++-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  48 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  21 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    |   1 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c    |   4 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h    |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   5 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |  21 +-
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |   1 -
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   4 +-
 19 files changed, 421 insertions(+), 80 deletions(-)

-- 
1.9.3

