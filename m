From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:25:58 -0800
Subject: [Intel-wired-lan] [next PATCH S21 00/14] i40e/i40evf updates
Message-ID: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesse Brandeburg uses priv flags to control packet split, and removes 
CONFIG_I40E_VXLAN.

Kiran Patil moves detection and recovery of TX queue hung logic
to service_task from tx_timeout, and fixes memory leaks and 
sideband filter programming.

Mitch Williams increases max number of queues, sets real number
of queues, removes duplicate string, removes atomic allocation,
fixes up error propagation and handling, changes uint32_t to
u32, fixes whitespaces, and corrects bitwise operator to logical.

Neerav Parikh removes separate functions gathering XOFF Rx stats.

 drivers/net/ethernet/intel/Kconfig                 |  11 -
 drivers/net/ethernet/intel/i40e/i40e.h             |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  27 +++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 236 ++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  23 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  18 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  33 +--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  15 ++
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   3 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  11 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  12 +-
 11 files changed, 217 insertions(+), 180 deletions(-)

-- 
2.1.0

