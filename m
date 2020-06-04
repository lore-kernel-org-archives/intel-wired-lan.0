From: Andre Guedes <andre.guedes@intel.com>
Date: Wed,  3 Jun 2020 17:00:59 -0700
Subject: [Intel-wired-lan] [PATCH 0/6] igc: PTP timestamping fixes
Message-ID: <20200604000105.15059-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This patch series provides some fixes and improvements to ptp timestamp
handling in IGC driver.

IGC ptp implementation was based on IGB, but there are a few differences on how
I225 handles rx timestamps that need to be considered. For example, I225 doesn't
report rx timestamps via the TS bit rx descriptor + RXSTMPL/RXSTMPH registers
mechanism. They are reported via the packet buffer only.

Apart from that, this patch series also fixes other issues like code
duplication, dummy UDP filter configuration, and missing SRRCTL register clean
up.

Regards,

Andre

Andre Guedes (6):
  igc: Clean up rx timestamping logic
  igc: Remove duplicate code in tx timestamp handling
  igc: Check __IGC_PTP_TX_IN_PROGRESS instead of ptp_tx_skb
  igc: Remove UDP filter setup in PTP code
  igc: Refactor igc_ptp_set_timestamp_mode()
  igc: Fix rx timestamp disabling

 drivers/net/ethernet/intel/igc/igc.h         |   3 -
 drivers/net/ethernet/intel/igc/igc_defines.h |   2 -
 drivers/net/ethernet/intel/igc/igc_main.c    |  12 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 256 +++++--------------
 drivers/net/ethernet/intel/igc/igc_regs.h    |   2 -
 5 files changed, 75 insertions(+), 200 deletions(-)

-- 
2.26.2

