From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:29 -0400
Subject: [Intel-wired-lan] [next PATCH S9 00/15] i40e/i40evf updates
Message-ID: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali strips VEB stats if they are disabled in HW.

Greg fixes a port VLAN configuration bug and removes a useless message.

Jesse fixes a tx hang workaround, adds a counter for drops in the netstat
interface, refactors the interrupt enable, adds a warning on a double free,
and tightens up reset polling.

Mitch modifies code to use the qos field consistently

Shannon fixes up a type clash in i40e_aq_rc_to_posix conversion, fixes up
a padding issue in get_cee_dcb_cfg_v1_resp, renames a variable to prevent
misunderstandings, limits debugfs io ops, and adds a new device id.

 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  13 ++-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  12 +--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  42 ++++----
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 114 ++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  13 +--
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   9 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h    |   9 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   3 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   6 +-
 16 files changed, 137 insertions(+), 111 deletions(-)

-- 
1.9.3

