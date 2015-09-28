From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:49 -0400
Subject: [Intel-wired-lan] [next PATCH S17 00/12] i40e/i40evf updates
Message-ID: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali fixes an accidental error with BIT_ULL replacement.

Carolyn fixes the tools loopback test failing after driver load, and fixes
a PHY NVM interaction problem.

Catherine fixes the  order of checks when enabling/disabling autoneg in
ethtool and moves an error message to debug level.

Jesse refactors irq enable function, fixes bug in throttle rate math,
changes dynamic interrupt thresholds, and adjusts interrupt throttle
less frequently.

Mitch stops the VF from giving up if it can't communicate with the PF.

 drivers/net/ethernet/intel/i40e/i40e.h          |   2 +
 drivers/net/ethernet/intel/i40e/i40e_common.c   |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  |  35 ++---
 drivers/net/ethernet/intel/i40e/i40e_main.c     |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 181 +++++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h     |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h     |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 178 ++++++++++++++---------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h   |   8 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h   |   4 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h      |   2 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |  11 +-
 12 files changed, 294 insertions(+), 162 deletions(-)

-- 
1.9.3

