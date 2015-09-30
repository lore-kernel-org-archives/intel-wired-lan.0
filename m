From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 30 Sep 2015 14:09:02 -0400
Subject: [Intel-wired-lan] [next PATCH S16 00/15 v2] i40e/i40evf updates
Message-ID: <1443636543-110106-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Catherine adds code that recognizes 1000Base_T_Optical phy type when
link is up.

Greg B. adds support for non-willing Apps.

Greg R. removed unused defines.

Jesse adds code to moderate interrupts differently.

Jingjing fixes compile issue related to const string, and resets the
invalid msg counter in vf when a valid msg is received.

Kiran adds a spinlock to synchronize access to the VSI's mac filter list.

Mitch correctly populates vlan_features, relaxs and staggers init timing
a bit, and increases AQ work limit.

Shannon generates fewer startup messages, removes read/write failed
messages from nvmupdate, adds priv flag for controlling VEB stats, and
grabs the AQ spinlocks before clearing registers.

 drivers/net/ethernet/intel/i40e/i40e.h             |  8 ++--
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      | 45 ++++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  7 ++++
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 49 ++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 34 +++++++++------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        | 10 +++++
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  2 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  2 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  5 +--
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c    | 45 ++++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  4 +-
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h |  4 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      | 10 +++++
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 11 +++--
 19 files changed, 166 insertions(+), 86 deletions(-)

-- 
1.9.3

