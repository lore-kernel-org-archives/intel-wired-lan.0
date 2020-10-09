From: Andre Guedes <andre.guedes@intel.com>
Date: Thu,  8 Oct 2020 19:53:40 -0700
Subject: [Intel-wired-lan] [PATCH 0/9] igc: Add XDP support
Message-ID: <20201009025349.4037-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This patch series adds XDP support for the igc driver. The approach implemented
by this series follows the same approach implemented in other Intel drivers as
much as possible for the sake of consistency.

The series is organized in two parts. In the first part, i.e. patches from 1 to
5, igc_main.c and igc_ptp.c code is refactored in preparation for landing the
XDP support, which is introduced in the second part (patches from 6 to 9).

As far as code organization is concerned, XDP-related helpers are defined in a
new file, igc_xdp.c, and are called by igc_main.c.

The features added by this series have been tested with the samples provided in
samples/bpf/: xdp1, xdp2, xdp_redirect_cpu, and xdp_redirect_map.

Upcoming series will add support of UMEM and zero-copy features from AF_XDP.

Best regards,
Andre

Andre Guedes (9):
  igc: Fix igc_ptp_rx_pktstamp()
  igc: Remove unused argument from igc_tx_cmd_type()
  igc: Introduce igc_rx_buffer_flip() helper
  igc: Introduce igc_get_rx_frame_truesize() helper
  igc: Refactor rx timestamp handling
  igc: Add Initial XDP support
  igc: Add support for XDP_TX action
  igc: Add support for XDP_REDIRECT action
  igc: Implement ndo_xdp_xmit callback

 drivers/net/ethernet/intel/igc/Makefile   |   2 +-
 drivers/net/ethernet/intel/igc/igc.h      |  18 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 280 +++++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  87 ++++---
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 202 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  27 +++
 6 files changed, 516 insertions(+), 100 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.h

-- 
2.26.2

