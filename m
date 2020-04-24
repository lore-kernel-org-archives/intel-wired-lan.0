From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:04 -0700
Subject: [Intel-wired-lan] [PATCH 00/19] igc: Fixes to NFC support code
Message-ID: <20200424201623.10971-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

Previous patch series [1-4] addressed issues with IGC filtering support
individually (MAC address, VLAN priority, and ethertype filtering). This
patch series fixes issues with the Network Flow Classification (NFC)
support, which is built on top of those individual filters.

This series is organized as follows:

    * Initial patches (1 to 4) do trivial code cleanup like remove unused
      code, useless wrappers, simplify logic, etc.

    * Midsection patches (5 to 8) refactor the NFC support code to improve
      code reuse and organization. It also makes some upcoming bug fixes
      simpler.

    * The rest of the series (9 to 19) fixes multiple bugs related to rules
      insertion, overwrite, and restoration as well as other issues like
      memory leak and locking.

Best regards,

Andre

[1] https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20200318230102.36952-1-andre.guedes at intel.com/
[2] https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20200403181743.23447-1-andre.guedes at intel.com/
[3] https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20200407210711.24371-1-andre.guedes at intel.com/
[4] https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20200411002834.13916-1-andre.guedes at intel.com/

Andre Guedes (19):
  igc: Remove unused field from igc_nfc_filter
  igc: Get rid of igc_max_channels()
  igc: Cleanup _get|set_rxnfc ethtool ops
  igc: Early return in igc_get_ethtool_nfc_entry()
  igc: Add 'igc_ethtool_' prefix to functions in igc_ethtool.c
  igc: Align terms used in NFC support code
  igc: Change byte order in struct igc_nfc_filter
  igc: Refactor igc_ethtool_add_nfc_rule()
  igc: Fix 'sw_idx' type in struct igc_nfc_rule
  igc: Fix locking issue when retrieving NFC rules
  igc: Fix NFC rule overwrite cases
  igc: Fix NFC rules with multicast addresses
  igc: Fix NFC rules restoration
  igc: Refactor igc_ethtool_update_nfc_rule()
  igc: Fix NFC rules leak when driver is unloaded
  igc: Fix NFC rule validation
  igc: Change return type from igc_disable_nfc_rule()
  igc: Change adapter->nfc_rule_lock to mutex
  igc: Remove igc_nfc_rule_exit()

 drivers/net/ethernet/intel/igc/igc.h         |  57 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 608 ++++++++-----------
 drivers/net/ethernet/intel/igc/igc_main.c    | 257 +++++---
 3 files changed, 469 insertions(+), 453 deletions(-)

-- 
2.26.0

