From: Vedang Patel <vedang.patel@intel.com>
Date: Wed, 10 Feb 2021 13:58:39 -0800
Subject: [Intel-wired-lan] [PATCH net-next v6 0/9] igc: Add XDP support
Message-ID: <20210210215848.24514-1-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This is the sixth version of this series which adds XDP support
to igc driver.

Changes from v5 are:

    - Avoid premature Rx buffer re-use in XDP_REDIRECT action by storing
      page count prior to invoking xdp_do_redirect. This is similar to
      what has been done for other Intel drivers.

v5 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210209024243.23406-1-vedang.patel at intel.com/

v4 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201104031210.27772-1-andre.guedes at intel.com/

v3 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201030210351.46482-1-andre.guedes at intel.com/

v2 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201028201943.93147-1-andre.guedes at intel.com/

v1 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201009025349.4037-1-andre.guedes at intel.com/

Thanks,
Vedang


Andre Guedes (9):
  igc: Fix igc_ptp_rx_pktstamp()
  igc: Remove unused argument from igc_tx_cmd_type()
  igc: Introduce igc_rx_buffer_flip() helper
  igc: Introduce igc_get_rx_frame_truesize() helper
  igc: Refactor Rx timestamp handling
  igc: Add set/clear large buffer helpers
  igc: Add initial XDP support
  igc: Add support for XDP_TX action
  igc: Add support for XDP_REDIRECT action

 drivers/net/ethernet/intel/igc/Makefile   |   2 +-
 drivers/net/ethernet/intel/igc/igc.h      |  18 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 458 +++++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  87 ++--
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  60 +++
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  13 +
 6 files changed, 531 insertions(+), 107 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.h

-- 
2.17.1

