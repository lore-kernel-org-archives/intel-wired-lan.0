From: Andre Guedes <andre.guedes@intel.com>
Date: Fri,  3 Apr 2020 11:17:39 -0700
Subject: [Intel-wired-lan] [PATCH 0/4] igc: Fixes for VLAN priority
 filtering code
Message-ID: <20200403181743.23447-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

This patch series provides some fixes and improvements to the VLAN
priority filtering code from IGC driver.

The improvements focuses on aligning the code organization to follow
the same rationale from MAC address filtering code, splitting ethtool
and core logic between igc_ethtool.c and igc_main.c. It also adds some
log messages to help debugging the code.

Best regards,

Andre

Andre Guedes (4):
  igc: Rename IGC_VLAPQF macro
  igc: Dump VLANPQF register
  igc: Return -EOPNOTSUPP when VLAN mask doesn't match
  igc: Refactor VLAN priority filtering code

 drivers/net/ethernet/intel/igc/igc.h         |  3 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 70 +++++---------------
 drivers/net/ethernet/intel/igc/igc_main.c    | 52 +++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    |  2 +-
 5 files changed, 76 insertions(+), 57 deletions(-)

-- 
2.26.0

