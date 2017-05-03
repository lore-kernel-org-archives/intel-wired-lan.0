From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:28:49 -0700
Subject: [Intel-wired-lan] [PATCH v4 00/15] ptp cornercase cleanups
Message-ID: <20170503172904.9788-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains fixes for similar corner cases in the e1000e, igb,
i40e, and ixgbe drivers reported by David Mirabito on the ptp4l mailing
list.

The first few patches fix a race condition with skb_tstamp_tx(). The
next few patches ensure that we cleanup the state bit when exiting the
_xmit_frame_ring() function with a DMA or TSO failure. After this, we
add new statistic to count how many times the Tx timestamp is skipped
due to already outstanding requests. The final few patches add some
handling in the potential case where we somehow never finish a timestamp
request, ensuring that we don't permanently lock the Tx timestamps
forever in this rare case.

Changes in v4
- Split the driver patches at request of Shannon Nelson
- Updated commit messages, but code content should be identical

I apologize in advance, the patchworks will not track this properly
because I necessarily changed the commit subjects when splitting the
patches apart by driver.

Jacob Keller (15):
  e1000e: fix race condition around skb_tstamp_tx()
  i40e: fix race condition with PTP_TX_IN_PROGRESS bits
  igb: fix race condition with PTP_TX_IN_PROGRESS bits
  ixgbe: fix race condition with PTP_TX_IN_PROGRESS bits
  i40e: avoid permanent lock of *_PTP_TX_IN_PROGRESS
  igb: avoid permanent lock of *_PTP_TX_IN_PROGRESS
  ixgbe: avoid permanent lock of *_PTP_TX_IN_PROGRESS
  e1000e: add statistic indicating number of skipped Tx timestamps
  i40e: add statistic indicating number of skipped Tx timestamps
  igb: add statistic indicating number of skipped Tx timestamps
  ixgbe: add statistic indicating number of skipped Tx timestamps
  i40e: use pf data structure directly in i40e_ptp_rx_hang
  i40e: check for Tx timestamp timeouts during watchdog
  igb: check for Tx timestamp timeouts during watchdog
  ixgbe: check for Tx timestamp timeouts during watchdog

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
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 42 +++++++++++++++++++--
 16 files changed, 227 insertions(+), 46 deletions(-)

-- 
2.13.0.rc0.317.gcc792a6cad5a

