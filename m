From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 15 Jun 2016 16:42:12 -0700
Subject: [Intel-wired-lan] [next PATCH S38 0/7] i40e/i40evf updates
Message-ID: <1466034139-11828-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Avinash Dayanand provides fix to show correct Advertised Link Modes when
link is down.

Catherine Sullivan removes device ID 0x37D4.

Joshua Hay adds hyperv dev ids.

Kiran Patil enables VSI broadcast promiscuous mode instead of adding broadcast
filter.

Mitch Williams removes useless initializer & refactors rx filter handling.


 drivers/net/ethernet/intel/i40e/i40e.h          |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c   |   1 -
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c  |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_devids.h   |   1 -
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  |  47 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 546 +++++++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c |   1 -
 drivers/net/ethernet/intel/i40evf/i40e_devids.h |   1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |   3 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   4 +-
 11 files changed, 310 insertions(+), 328 deletions(-)

-- 
2.4.11

