From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:20 -0700
Subject: [Intel-wired-lan] [next PATCH S35 00/14] i40e/i40evf updates
Message-ID: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Carolyn Wyborny allows for setting RSS Hash opts using less than four parameters
and adds message for unsupported MFP mode.

Catherine Sullivan renames a version macro.

Jesse Brandeburg fixes up 32 bit timespec references, refactors tunnel
interpretation and receive routine, removes unused hardware receive
descriptor code and adds code to test memory before ethtool allocation
succeeds. 

Mitch Williams adds code to report link speed, sets netdev carrier properly,
clears mac filter count on reset, enables adaptive interrupt throttling
and allocates RX buffers properly.

Shannon Nelson adds elements to fd filter compare.

 drivers/net/ethernet/intel/i40e/i40e.h             |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  30 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 259 +++---
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  78 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 964 ++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  69 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 924 ++++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  69 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   8 +-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  78 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  54 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  64 +-
 14 files changed, 1264 insertions(+), 1353 deletions(-)

-- 
2.4.3

