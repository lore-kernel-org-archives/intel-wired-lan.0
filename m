From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 27 Sep 2016 11:28:47 -0700
Subject: [Intel-wired-lan] [next PATCH S48 0/7] i40e/i40evf updates
Message-ID: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck drops redundant Rx descriptor processing code.

Bimmy Pujari changes version from 1.6.19 to 1.6.21.

Carolyn Wyborny adds code to fix for long link down notification time.

Filip Sadowski removes workaround for simple MAC address filter deletion.

Harshitha Ramamurthy fixes ethtool LED blinking on X722 for 1GbE.

Henry Tieman adds code to correctly restore LED status after ethtool 
identify.

Lihong Yang fixes confusing dmesg info for ethtool -L option.

 drivers/net/ethernet/intel/i40e/i40e.h          |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c   |  5 ++-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 10 ++---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 52 +++----------------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 18 +++------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 18 +++------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |  2 +-
 7 files changed, 29 insertions(+), 78 deletions(-)

-- 
2.4.11

