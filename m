From: Maciej Machnikowski <maciej.machnikowski@intel.com>
Date: Sun, 29 Aug 2021 10:05:10 +0200
Subject: [Intel-wired-lan] [RFC v2 net-next 0/2] Add RTNL interface for SyncE
Message-ID: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Synchronous Ethernet networks use a physical layer clock to syntonize
the frequency across different network elements.

Multiple reference clock sources can be used. Clocks recovered from 
PHY ports on the RX side or external sources like 1PPS GPS, etc.

This patch series introduces basic interface for reading the DPLL
state on a SyncE capable device. This state gives us information
about the source of the syntonization signal and whether the DPLL
circuit is tuned to the incoming signal.

Next steps:
 - add interface to enable recovered clocks and get information
   about them

v2:
- removed whitespace changes
- fix issues reported by test robot

Maciej Machnikowski (2):
  rtnetlink: Add new RTM_GETSYNCESTATE message to get SyncE status
  ice: add support for reading SyncE DPLL state

 drivers/net/ethernet/intel/ice/ice.h          |  5 ++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 34 ++++++++
 drivers/net/ethernet/intel/ice/ice_common.c   | 62 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  4 +
 drivers/net/ethernet/intel/ice/ice_devids.h   |  3 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 55 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 35 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 44 +++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   | 22 ++++++
 include/linux/netdevice.h                     |  6 ++
 include/uapi/linux/if_link.h                  | 43 +++++++++++
 include/uapi/linux/rtnetlink.h                | 11 ++-
 net/core/rtnetlink.c                          | 77 +++++++++++++++++++
 security/selinux/nlmsgtab.c                   |  3 +-
 14 files changed, 399 insertions(+), 5 deletions(-)

-- 
2.26.3

