From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Apr 2020 14:07:06 -0700
Subject: [Intel-wired-lan] [PATCH 0/5] igc: Fixes for ethertype filtering
 code
Message-ID: <20200407210711.24371-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

This patch series provides some fixes and improvements to the ethertype
filtering code from IGC driver.

The improvements focuses on aligning the code organization to follow the
same rationale from the rest of the filtering code (MAC address and VLAN
priority filtering).

Best regards,

Andre

Andre Guedes (5):
  igc: Remove duplicated IGC_RXPBS macro
  igc: Remove ethertype filter in ptp code
  igc: Fix MAX_ETYPE_FILTER value
  igc: Refactor ethertype filtering code
  igc: Dump ETQF registers

 drivers/net/ethernet/intel/igc/igc.h         |  6 +-
 drivers/net/ethernet/intel/igc/igc_defines.h |  3 -
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 70 +++------------
 drivers/net/ethernet/intel/igc/igc_main.c    | 93 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 12 ---
 drivers/net/ethernet/intel/igc/igc_regs.h    |  2 -
 6 files changed, 107 insertions(+), 79 deletions(-)

-- 
2.26.0

