From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 28 Apr 2017 10:16:50 -0700
Subject: [Intel-wired-lan] [PATCH v2 0/5] ptp cornercase cleanups
Message-ID: <20170428171655.13650-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series now includes more patches. The first patch should be
unchanged.

The following patches include extra fixes based on feedback and code
inspection.

The first new patch changes the xmit_frame() functions to properly check
for errors and cleanup if they can't DMA or similar. The next patch adds
a counter for the number of times we skipped a Tx timestamp request.
Finally, the last patch adds support for checking for Tx timestamp hangs
in the watchdog in the rare case that the hardware somehow doesn't
perform the timestamp. There's also one minor cleanup patch for i40e.

Jacob Keller (5):
  net-intel: fix race condition with PTP_TX_IN_PROGRESS bits
  net-intel: avoid permanent lock of *_PTP_TX_IN_PROGRESS
  net-intel: add statistic indicating number of skipped Tx timestamps
  i40e: use pf data structure directly in i40e_ptp_rx_hang
  net-intel: check for Tx timestamp timeouts during watchdog

 drivers/net/ethernet/intel/e1000e/e1000.h        |  1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c      |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c       | 27 ++++++++-----
 drivers/net/ethernet/intel/i40e/i40e.h           |  5 ++-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c      |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c       | 48 +++++++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c      | 28 +++++++++++---
 drivers/net/ethernet/intel/igb/igb.h             |  2 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c     |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c        | 26 ++++++++++---
 drivers/net/ethernet/intel/igb/igb_ptp.c         | 41 +++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 42 ++++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 43 +++++++++++++++++++--
 16 files changed, 228 insertions(+), 46 deletions(-)

-- 
2.13.0.rc0.317.gcc792a6cad5a

