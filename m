From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:00:50 -0700
Subject: [Intel-wired-lan] [PATCH 00/12] igc: Refactor MAC address filtering
 code
Message-ID: <20200318230102.36952-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

The MAC address filtering support from IGC driver has some duplicate code and
convoluted logic, making it harder to read, debug, and maintain.

As a follow-up to the bug fixes already applied to dev-queue, this patchset
refactors the MAC address filtering code to address those issues. It also takes
the opportunity to improve documentation from some key functions and clean up
comments that are not applicable to IGC, and fix minor issues along the way.

In summary, the new MAC address filtering code is organized as follows:

	* Filters are added and deleted only via igc_add_mac_filter() and
	  igc_del_mac_filter() APIs. These APIs manage the adapter->mac_table.
	  They are defined in igc_main.c and used in both igc_main.c and
	  igc_ethtool.c.

	* Filter configuration in hardware is handled by igc_set_mac_filter_
	  hw() and igc_clear_mac_filter_hw() local helpers in igc_main.c.

	* IGC_MAC_STATE_QUEUE_STEERING flag as well as igc_*_mac_steering_
	  filter() are gone.

Best regards,

Andre

Andre Guedes (12):
  igc: Remove duplicate code in MAC filtering logic
  igc: Check unsupported flag in igc_add_mac_filter()
  igc: Change igc_add_mac_filter() returning value
  igc: Fix igc_uc_unsync()
  igc: Refactor igc_rar_set_index()
  igc: Improve address check in igc_del_mac_filter()
  igc: Remove 'queue' check in igc_del_mac_filter()
  igc: Remove IGC_MAC_STATE_QUEUE_STEERING
  igc: Remove igc_*_mac_steering_filter() wrappers
  igc: Refactor igc_mac_entry_can_be_used()
  igc: Refactor igc_del_mac_filter()
  igc: Add debug messages to MAC filter code

 drivers/net/ethernet/intel/igc/igc.h         |  11 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  22 +-
 drivers/net/ethernet/intel/igc/igc_main.c    | 372 ++++++++-----------
 3 files changed, 169 insertions(+), 236 deletions(-)

-- 
2.25.0

