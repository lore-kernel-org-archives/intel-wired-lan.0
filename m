From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 28 Jun 2021 21:43:27 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v2 0/5] igc: Add support for RX
 Flex Filters
Message-ID: <20210629044332.3491232-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Changes from v1:
 - Fixed warnings related to invalid endianness conversions (Tony Nguyen);
 - Added some examples for using the exposed LEDs (Paul Menzel);

Add support for steering traffic to specific RX queues using Flex Filters.

As the name implies, Flex Filters are more flexible than using
Layer-2, VLAN or MAC address filters, one of the reasons is that they
allow "AND" operations more easily, e.g. when the user wants to steer
some traffic based on the source MAC address and the packet ethertype.

Future work include adding support for offloading tc-u32 filters to
the hardware.

The series is divided as follows:

Patch 1/5, add the low level primitives for configuring Flex filters.

Patch 2/5 and 3/5, allow ethtool to manage Flex filters.

Patch 4/5, when specifying filters that have multiple predicates, use Flex filters.

Patch 5/5, Adds support for exposing the i225 LEDs using the LED subsystem.

Cheers,


Kurt Kanzenbach (4):
  igc: Add possibility to add flex filter
  igc: Integrate flex filter into ethtool ops
  igc: Make flex filter more flexible
  igc: Export LEDs

Vinicius Costa Gomes (1):
  igc: Allow for Flex Filters to be installed

 drivers/net/ethernet/intel/Kconfig           |   1 +
 drivers/net/ethernet/intel/igc/igc.h         |  48 +-
 drivers/net/ethernet/intel/igc/igc_defines.h |  62 ++-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  41 +-
 drivers/net/ethernet/intel/igc/igc_main.c    | 448 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_regs.h    |  19 +
 6 files changed, 595 insertions(+), 24 deletions(-)

-- 
2.32.0

