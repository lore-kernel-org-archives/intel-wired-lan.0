From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:47 -0400
Subject: [Intel-wired-lan] [next PATCH S15 00/15] i40e/i40evf updates
Message-ID: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali adds WB_ON_ITR offload support to i40evf and fixes the PCI
bus info for X722.

Catherine removes 100M settings from get_settings that are no longer
supported.

Jesse adds a missing parameter comment to ndo_bridge_setlink and uses
priv flags to control flow director.

Kevin stores off PHY capabilities.

Kiran adds a spin lock for VSI's MAC filter list.

Mitch removes an obsolete version check and speeds up i40evf's init.

Neerav change some messages from info to debug only.

Shannon allows FD SB if MFP mode only has 1 partition, removes FD atr
control from debugfs, removes redundant declarations of a variable and a
function and removes unnecessary string copy operations.

 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   3 +
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  24 --
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  59 ++-
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 451 ++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  30 +-
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |   1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  13 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   3 +-
 12 files changed, 443 insertions(+), 157 deletions(-)

-- 
1.9.3

