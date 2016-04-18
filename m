From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Mon, 18 Apr 2016 01:31:50 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S35 0/9] i40e/i40evf updates
Message-ID: <1460968319-18950-1-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesse Brandeburg refactors tunnel interpretation, drops the packet split receive
routine for both i40e and i40evf, removes reference to ring->dtype, refactors
the receive routine, removes unused hardware receive descriptor code and tests
memory before ethtool alloc succeeds.

Mitch Williams ensured RX buffers are properly allocated.

 drivers/net/ethernet/intel/i40e/i40e.h             |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  31 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  54 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  73 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 970 ++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  69 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 930 ++++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  69 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   7 -
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  65 --
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  34 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   4 -
 13 files changed, 1059 insertions(+), 1260 deletions(-)

-- 
2.4.3

