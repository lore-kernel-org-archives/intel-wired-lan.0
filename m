From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:20 -0800
Subject: [Intel-wired-lan] [next PATCH S23 00/13] i40e/i40evf updates
Message-ID: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali fixes Rx hash reported to the stack by our driver,
adds fix for recursive RTNL lock during PROMISC change,
fixes RSS rx-flow-hash configuration through ethtool,
makes some changes in the nvm read code, and
cleans up the code with respect to restarting autoneg.

Catherine replaces X722 mac check in ethtool get_settings.

Jesse removes forever unused ID, makes tunnels generic, and
updates features with right offload.

Kiran adds mac_filter_element at the end of the list instead of HEAD.

Mitch allows channel bonding of VFs, and nulls out ring pointers on free.

Shannon defines function capabilities in only one place.

 drivers/net/ethernet/intel/i40e/i40e.h             |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 86 +++++++---------------
 drivers/net/ethernet/intel/i40e/i40e_devids.h      |  1 -
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 16 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 27 ++++---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 70 +++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 61 ++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  2 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  1 -
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |  1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 56 +++++++-------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  2 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 40 ++--------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 11 ++-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  2 +
 18 files changed, 196 insertions(+), 187 deletions(-)

-- 
2.1.0

