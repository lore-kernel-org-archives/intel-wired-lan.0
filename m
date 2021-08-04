From: aravindhan.gunasekaran@intel.com <aravindhan.gunasekaran@intel.com>
Date: Wed,  4 Aug 2021 19:49:09 +0530
Subject: [Intel-wired-lan] [PATCH next-queue v2 0/3] igc: Add support for
 CBS offload
Message-ID: <1628086752-20213-1-git-send-email-aravindhan.gunasekaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>

This add support for Credit-based shaper qdisc offload from
Traffic Control system. It enables traffic prioritization and
bandwidth reservation via the Credit-Based Shaper which is
implemented in hardware by i225 controller.

Patch 1/3 adds a default cycle-time for TSN mode to be configured.

Patch 2/3 helps to separate TSN mode programming on the fly and
during reset sequence. It also simplifies handling features flags
for various TSN modes supported by i225 in the driver.

Patch 3/3 adds support for IEEE802.1Qav(CBS) standard
implemented in i225 HW. Two sets of CBS HW shapers are present
in i225 and driver enables them in the two high priority queues.

Changes from v1:
 - Use num_tx_queues rather than the fixed macro IGC_MAX_TX_QUEUES

Aravindhan Gunasekaran (1):
  igc: Add support for CBS offloading

Vinicius Costa Gomes (2):
  igc: Use default cycle 'start' and 'end' values for queues
  igc: Simplify TSN flags handling

 drivers/net/ethernet/intel/igc/igc.h         |  11 ++
 drivers/net/ethernet/intel/igc/igc_defines.h |   8 ++
 drivers/net/ethernet/intel/igc/igc_main.c    | 110 ++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 174 ++++++++++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_tsn.h     |   1 +
 6 files changed, 258 insertions(+), 49 deletions(-)

-- 
2.7.4

