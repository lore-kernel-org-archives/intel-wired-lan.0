From: Maciej Machnikowski <maciej.machnikowski@intel.com>
Date: Mon, 16 Aug 2021 12:27:25 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 0/4] Add support for E810-T PTP
 pins
Message-ID: <20210816102729.1266522-1-maciej.machnikowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend the driver implementation to support PTP pins on E810-T and
derivative devices.

E810-T adapters are equipped with:
- 2 external bidirectional SMA connectors
- 1 internal TX U.FL shared with SMA1
- 1 internal RX U.FL shared with SMA2

The SMA and U.FL configuration is controlled by the external
multiplexer.

E810-T Derivatives are equipped with:
- 2 1PPS outputs on SDP20 and SDP22
- 2 1PPS inputs on SDP21 and SDP23

Maciej Machnikowski (4):
  ice: Refactor ice_aqc_link_topo_addr
  ice: Implement functions for reading and setting GPIO pins
  ice: Add support for SMA control multiplexer
  ice: Implement support for SMA and U.FL on E810-T

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  87 +++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   7 +
 drivers/net/ethernet/intel/ice/ice_devids.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  15 +
 drivers/net/ethernet/intel/ice/ice_lib.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 376 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  21 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 155 ++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  22 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 12 files changed, 694 insertions(+), 14 deletions(-)

--
2.26.3

