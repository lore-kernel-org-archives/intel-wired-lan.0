From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 16 Mar 2018 15:34:01 -0700
Subject: [Intel-wired-lan] [PATCH 0/5] Enable XDP for ixgbevf
Message-ID: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series implements support for XDP on ixgbevf;
it is mainly based on the ixgbe implementation and supports
the following actions: XDP_PASS, XDP_DROP, and XDP_TX.

Tony Nguyen (5):
  ixgbevf: Add XDP support for pass and drop actions
  ixgbevf: Add support for XDP_TX action
  ixgbevf: Delay tail write for XDP packets
  ixgbevf: Add support for meta data
  ixgbevf: Add XDP queue stats reporting

 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  68 ++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  30 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 489 +++++++++++++++++++---
 3 files changed, 518 insertions(+), 69 deletions(-)

-- 
2.13.6

