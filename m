From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  3 Nov 2020 19:12:01 -0800
Subject: [Intel-wired-lan] [PATCH v4 0/9] igc: Add XDP support
Message-ID: <20201104031210.27772-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This is the fourth version of this series which adds XDP support to igc
driver.

Changes from v3 are:

    - Minor update in comment in igc_ptp_rx_pktstamp()
    - Replaced modulo op in igc_xdp_get_tx_ring()

v3 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201030210351.46482-1-andre.guedes at intel.com/

v2 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201028201943.93147-1-andre.guedes at intel.com/

v1 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201009025349.4037-1-andre.guedes at intel.com/

Cheers,
Andre


Andre Guedes (9):
  igc: Fix igc_ptp_rx_pktstamp()
  igc: Remove unused argument from igc_tx_cmd_type()
  igc: Introduce igc_rx_buffer_flip() helper
  igc: Introduce igc_get_rx_frame_truesize() helper
  igc: Refactor rx timestamp handling
  igc: Add set/clear large buffer helpers
  igc: Add initial XDP support
  igc: Add support for XDP_TX action
  igc: Add support for XDP_REDIRECT action

 drivers/net/ethernet/intel/igc/Makefile   |   2 +-
 drivers/net/ethernet/intel/igc/igc.h      |  18 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 434 +++++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  89 +++--
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  60 +++
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  13 +
 6 files changed, 515 insertions(+), 101 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.h

-- 
2.28.0

