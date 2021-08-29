From: Maciej Machnikowski <maciej.machnikowski@intel.com>
Date: Sun, 29 Aug 2021 19:39:32 +0200
Subject: [Intel-wired-lan] [RFC v3 net-next 0/2] Add RTNL interface for SyncE
Message-ID: <20210829173934.3683561-1-maciej.machnikowski@intel.com>
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
information about the source of the syntonization signal and the state
of EEC. This interface is required to implement Synchronization Status
Messaging on upper layers.

Next steps:
 - add interface to enable source clocks and get information about them

v2:
- removed whitespace changes
- fix issues reported by test robot
v3:
- Changed naming from SyncE to EEC
- Clarify cover letter and commit message for patch 1

Maciej Machnikowski (2):
  rtnetlink: Add new RTM_GETEECSTATE message to get SyncE status
  ice: add support for reading SyncE DPLL state

 drivers/net/ethernet/intel/ice/ice.h          |  5 ++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 34 +++++++++
 drivers/net/ethernet/intel/ice/ice_common.c   | 62 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  4 +
 drivers/net/ethernet/intel/ice/ice_devids.h   |  3 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 55 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 35 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 44 +++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   | 22 ++++++
 include/linux/netdevice.h                     |  6 ++
 include/uapi/linux/if_link.h                  | 43 +++++++++++
 include/uapi/linux/rtnetlink.h                |  3 +
 net/core/rtnetlink.c                          | 74 +++++++++++++++++++
 security/selinux/nlmsgtab.c                   |  3 +-
 14 files changed, 392 insertions(+), 1 deletion(-)

-- 
2.26.3

