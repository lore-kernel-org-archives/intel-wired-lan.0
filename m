From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 18 Apr 2016 11:33:40 -0700
Subject: [Intel-wired-lan] [PATCH next S35 v3 0/9] i40e/i40evf refactor
	receive
Message-ID: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesse Brandeburg refactors tunnel code, drops the packet split receive
routine for both i40e and i40evf, removes reference to ring->dtype, refactors
the receive routine(s), removes unused hardware receive descriptor code and
tests memory before ethtool alloc succeeds.

Mitch Williams ensured RX buffers are properly allocated.

Jesse Brandeburg (8):
  i40e/i40evf: Refactor tunnel interpretation
  i40e: Drop packet split receive routine
  i40e/i40evf: Remove reference to ring->dtype
  i40e: Refactor receive routine
  i40evf: Drop packet split receive routine
  i40evf: refactor receive routine
  i40e/i40evf: Remove unused hardware receive descriptor code
  i40e: Test memory before ethtool alloc succeeds

Mitch Williams (1):
  i40evf: Allocate rx buffers properly

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
1.8.3.1

