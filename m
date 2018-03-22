From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Mar 2018 17:33:44 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 0/9] igb: offloading of
 receive filters
Message-ID: <20180322003353.29970-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Changes from v4:
 - Added a new bit to the MAC address filters internal representation
 to mean that some MAC address filters are steering filters (i.e. they
 direct traffic to queues);
 - And, this is only supported in i210;
 - Added a "Known Issue" section;

Changes from v3:
 - Addressed review comments from Aaron F. Brown and
   Jakub Kicinski;

Changes from v2:
 - Addressed review comments from Jakub Kicinski, mostly about coding
   style adjustments and more consistent error reporting;

Changes from v1:
 - Addressed review comments from Alexander Duyck and Florian
   Fainelli;
 - Adding and removing cls_flower filters are now proposed in the same
   patch;
 - cls_flower filters are kept in a separated list from "ethtool"
   filters (so that section of the original cover letter is no longer
   valid);
 - The patch adding support for ethtool filters is now independent from
   the rest of the series;

Known issue:
 - It seems that the the QSEL bits in the RAH registers do not have
 any effect for source address (i.e. steering doesn't work for source
 address filters), everything is pointing to a hardware (or
 documentation) issue;

Original cover letter:

This series enables some ethtool and tc-flower filters to be offloaded
to igb-based network controllers. This is useful when the system
configurator want to steer kinds of traffic to a specific hardware
queue.

The first two commits are bug fixes.

The basis of this series is to export the internal API used to
configure address filters, so they can be used by ethtool, and
extending the functionality so an source address can be handled.

Then, we enable the tc-flower offloading implementation to re-use the
same infrastructure as ethtool, and storing them in the per-adapter
"nfc" (Network Filter Config?) list. But for consistency, for
destructive access they are separated, i.e. an filter added by
tc-flower can only be removed by tc-flower, but ethtool can read them
all.

Only support for VLAN Prio, Source and Destination MAC Address, and
Ethertype is enabled for now.

Open question:
  - igb is initialized with the number of traffic classes as 1, if we
  want to use multiple traffic classes we need to increase this value,
  the only way I could find is to use mqprio (for example). Should igb
  be initialized with, say, the number of queues as its "num_tc"?

Vinicius Costa Gomes (9):
  igb: Fix not adding filter elements to the list
  igb: Fix queue selection on MAC filters on i210
  igb: Enable the hardware traffic class feature bit for igb models
  igb: Add support for MAC address filters specifying source addresses
  igb: Add support for enabling queue steering in filters
  igb: Enable nfc filters to specify MAC addresses
  igb: Add MAC address support for ethtool nftuple filters
  igb: Add the skeletons for tc-flower offloading
  igb: Add support for adding offloaded clsflower filters

 drivers/net/ethernet/intel/igb/e1000_defines.h |   2 +
 drivers/net/ethernet/intel/igb/igb.h           |  13 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c   |  65 ++++-
 drivers/net/ethernet/intel/igb/igb_main.c      | 332 ++++++++++++++++++++++++-
 4 files changed, 398 insertions(+), 14 deletions(-)

--
2.16.2
