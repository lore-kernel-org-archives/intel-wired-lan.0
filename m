From: Jithu Joseph <jithu.joseph@intel.com>
Date: Tue,  9 Mar 2021 23:13:14 -0800
Subject: [Intel-wired-lan] [PATCH v7 0/8] igc: Add XDP support
Message-ID: <20210310071322.15425-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This is the seventh version of this series which adds XDP support
to igc driver.

This series has to be applied after the patch below:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20210310064256.15299-1-jithu.joseph at intel.com/

Changes in v7
  - First patch from the v6 series "igc: Fix igc_ptp_rx_pktstamp()"
    was separated from this v7 series as the maintainer wants that one patch
    to take a different upstream path
  - Minor reabasing change in igc_ptp_rx_pktstamp() touched by the patch
    "igc: Refactor Rx timestamp handling", due to a sparse warning
    fix in the separated patch
  - Added Tested-by: Dvora Fuxbrumer

v6 is here
   https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210210215848.24514-1-vedang.patel at intel.com/

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
Jithu

Andre Guedes (8):
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
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  25 +-
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  60 +++
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  13 +
 6 files changed, 496 insertions(+), 80 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.h

-- 
2.17.1

