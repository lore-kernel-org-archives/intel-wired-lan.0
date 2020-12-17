From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 17 Dec 2020 12:24:05 -0800
Subject: [Intel-wired-lan] [PATCH 00/10] igc: Add support for AF_XDP
 zero-copy
Message-ID: <20201217202415.77891-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

This series adds AF_XDP zero-copy feature to igc driver.

The initial patches do some code refactoring, preparing the code base to
land the AF_XDP zero-copy feature, avoiding code duplications. The last
patches of the series are the ones implementing the feature.

The last patch which indeed implements AF_XDP zero-copy support was
originally way too lengthy so, for the sake of code review, I broke it
up into two patches: one adding support for the RX functionality and the
other one adding TX support. Feel free to squash those two patches when
pushing the series to net-next if you find appropriate.

Best,
Andre

Andre Guedes (10):
  igc: Move igc_xdp_is_enabled()
  igc: Refactor igc_xdp_run_prog()
  igc: Refactor igc_clean_rx_ring()
  igc: Refactor XDP rxq info registration
  igc: Introduce igc_update_rx_stats()
  igc: Introduce igc_update_tx_stats()
  igc: Introduce igc_unmap_tx_buffer() helper
  igc: Replace IGC_TX_FLAGS_XDP flag by an enum
  igc: Enable RX via AF_XDP zero-copy
  igc: Enable TX via AF_XDP zero-copy

 drivers/net/ethernet/intel/igc/igc.h      |  33 +-
 drivers/net/ethernet/intel/igc/igc_base.h |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 650 ++++++++++++++++++----
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 107 +++-
 drivers/net/ethernet/intel/igc/igc_xdp.h  |   8 +-
 5 files changed, 672 insertions(+), 128 deletions(-)

-- 
2.29.2

