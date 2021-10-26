From: Maciej Machnikowski <maciej.machnikowski@intel.com>
Date: Tue, 26 Oct 2021 19:31:41 +0200
Subject: [Intel-wired-lan] [RFC v5 net-next 0/5] Add RTNL interface for SyncE
Message-ID: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Synchronous Ethernet networks use a physical layer clock to syntonize
the frequency across different network elements.

Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
Equipment Clock (EEC) and have the ability to recover synchronization
from the synchronization inputs - either traffic interfaces or external
frequency sources.
The EEC can synchronize its frequency (syntonize) to any of those sources.
It is also able to select synchronization source through priority tables
and synchronization status messaging. It also provides neccessary
filtering and holdover capabilities

This patch series introduces basic interface for reading the Ethernet
Equipment Clock (EEC) state on a SyncE capable device. This state gives
information about the source of the syntonization signal (ether my port,
or any external one) and the state of EEC. This interface is required\
to implement Synchronization Status Messaging on upper layers.

v2:
- removed whitespace changes
- fix issues reported by test robot
v3:
- Changed naming from SyncE to EEC
- Clarify cover letter and commit message for patch 1
v4:
- Removed sync_source and pin_idx info
- Changed one structure to attributes
- Added EEC_SRC_PORT flag to indicate that the EEC is synchronized
  to the recovered clock of a port that returns the state
v5:
- add EEC source as an optiona attribute
- implement support for recovered clocks
- align states returned by EEC to ITU-T G.781

Maciej Machnikowski (5):
  ice: add support detecting features based on netlist
  rtnetlink: Add new RTM_GETEECSTATE message to get SyncE status
  ice: add support for reading SyncE DPLL state
  rtnetlink: Add support for SyncE recovered clock configuration
  ice: add support for SyncE recovered clocks

 drivers/net/ethernet/intel/ice/ice.h          |   7 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  94 ++++++-
 drivers/net/ethernet/intel/ice/ice_common.c   | 175 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  17 +-
 drivers/net/ethernet/intel/ice/ice_devids.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   6 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 138 ++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  34 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  94 +++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 include/linux/netdevice.h                     |  18 ++
 include/uapi/linux/if_link.h                  |  53 ++++
 include/uapi/linux/rtnetlink.h                |  10 +
 net/core/rtnetlink.c                          | 253 ++++++++++++++++++
 security/selinux/nlmsgtab.c                   |   6 +-
 16 files changed, 930 insertions(+), 4 deletions(-)

-- 
2.26.3

