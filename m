From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 10 Apr 2020 17:28:30 -0700
Subject: [Intel-wired-lan] [PATCH 0/4] igc: Enable NFC rules based on source
 MAC address
Message-ID: <20200411002834.13916-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This patch series adds extends the IGC driver to support for Network
Flow Classification (NFC) rules based on source MAC address.

Quick summary of this series: Patches 1 and 2 clean up and prepare
the code for the new feature, patch 3 adds the support for source
address filters in the core layer, and patch 4 enables NFC rules
based on source address on the ethtool layer.

Regards,

Andre

Andre Guedes (4):
  igc: Remove IGC_MAC_STATE_SRC_ADDR flag
  igc: Remove mac_table from igc_adapter
  igc: Add support for source address filters in core
  igc: Enable NFC rules based source MAC address

 drivers/net/ethernet/intel/igc/igc.h         |  26 ++---
 drivers/net/ethernet/intel/igc/igc_defines.h |   3 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  41 +++----
 drivers/net/ethernet/intel/igc/igc_main.c    | 111 +++++++++----------
 4 files changed, 84 insertions(+), 97 deletions(-)

-- 
2.26.0

