From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 23 Feb 2018 17:20:28 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 0/8] igb: offloading of receive
 filters
Message-ID: <20180224012036.5834-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

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
Ethertype are supported for now.

Open question:
  - igb is initialized with the number of traffic classes as 1, if we
  want to use multiple traffic classes we need to increase this value,
  the only way I could find is to use mqprio (for example). Should igb
  be initialized with, say, the number of queues as its "num_tc"?


Vinicius Costa Gomes (8):
  igb: Fix not adding filter elements to the list
  igb: Fix queue selection on MAC filters on i210 and i211
  igb: Enable the hardware traffic class feature bit for igb models
  igb: Add support for MAC address filters specifying source addresses
  igb: Add support for ethtool MAC address filters
  igb: Add the skeletons for tc-flower offloading
  igb: Add support for adding offloaded clsflower filters
  igb: Add support for removing offloaded tc-flower filters

 drivers/net/ethernet/intel/igb/e1000_defines.h |   2 +
 drivers/net/ethernet/intel/igb/igb.h           |  15 ++
 drivers/net/ethernet/intel/igb/igb_ethtool.c   | 125 ++++++++++-
 drivers/net/ethernet/intel/igb/igb_main.c      | 294 +++++++++++++++++++++++--
 4 files changed, 409 insertions(+), 27 deletions(-)

--
2.16.2
