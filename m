From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 23 Dec 2020 12:36:56 -0800
Subject: [Intel-wired-lan] [PATCH v2 0/9] igc: Add support for AF_XDP
 zero-copy
Message-ID: <20201223203705.78705-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This is the second version of this series which adds AF_XDP zero-copy support
to igc driver.

The main changes from v1 are:

    - Fixed commit messages to describe changes in imperative mood, e.g. "make
      xyzzy do frotz" instead of "[This patch] makes xyzzy do frotz".
    - Added queue index to error message in igc_setup_rx_resources().
    - Improved comment about xsk frame size check in igc_xdp_enable_pool(). 
    - Fixed typos.

v1 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201217202415.77891-1-andre.guedes at intel.com/

Best,
Andre

Andre Guedes (9):
  igc: Move igc_xdp_is_enabled()
  igc: Refactor igc_xdp_run_prog()
  igc: Refactor igc_clean_rx_ring()
  igc: Refactor XDP rxq info registration
  igc: Introduce tx/rx stats helpers
  igc: Introduce igc_unmap_tx_buffer() helper
  igc: Replace IGC_TX_FLAGS_XDP flag by an enum
  igc: Enable RX via AF_XDP zero-copy
  igc: Enable TX via AF_XDP zero-copy

 drivers/net/ethernet/intel/igc/igc.h      |  33 +-
 drivers/net/ethernet/intel/igc/igc_base.h |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 651 ++++++++++++++++++----
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 107 +++-
 drivers/net/ethernet/intel/igc/igc_xdp.h  |   8 +-
 5 files changed, 673 insertions(+), 128 deletions(-)

-- 
2.29.2

