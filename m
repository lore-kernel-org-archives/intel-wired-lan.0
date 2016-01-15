From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:07 -0800
Subject: [Intel-wired-lan] [next PATCH S28 00/15] i40e/i40evf updates
Message-ID: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain adds a SW workaround for lost Interrupts, fixes 
PROMISC mode for Multi-function per port (MFP) devices, does not 
disable queues in the Legacy/MSI Interrupt handler,  applies 
promisc mode to Tx Traffic when in promisc mode as well.

Jesse Brandeburg drops unused debugfs file "dump", cleans up use 
of pf->hw.

Kiran Patil removes code which relies on BASE VEB SEID.

Mitch Williams gets rid of magic number, supports packet split
receive, avoids atomics, expands comment, sets adapter state on
reset failure.

Shannon Nelson adds better error reporting for nvmupdate, cleans 
event descriptor before use.

 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |  20 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 266 +--------------------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  40 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  69 +++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  44 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   8 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c    |   5 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |   3 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  31 ++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   3 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   6 +-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  67 +++++-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  67 +++---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   4 +
 18 files changed, 253 insertions(+), 399 deletions(-)

-- 
2.1.0

