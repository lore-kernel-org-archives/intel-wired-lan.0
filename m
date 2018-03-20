From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 20 Mar 2018 07:58:04 -0700
Subject: [Intel-wired-lan] [PATCH v4 00/15] Add ice driver
Message-ID: <20180320145819.19133-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series adds the ice driver, which will support the Intel(R)
E800 Series of network devices.

This is the first phase in the release of this driver where we implement
basic transmit and receive. The idea behind the multi-phase release is to
aid in code review as well as testing. Subsequent phases will implement
advanced features (like SR-IOV, tunnelling, flow director, QoS, etc.) that
build upon the previous phase(s). Each phase will be submitted as a patch
series.

v4: Use ARRAY_SIZE instead of sizeof in patch #12

Anirudh Venkataramanan (15):
  ice: Add basic driver framework for Intel(R) E800 Series
  ice: Add support for control queues
  ice: Start hardware initialization
  ice: Get switch config, scheduler config and device capabilities
  ice: Get MAC/PHY/link info and scheduler topology
  ice: Initialize PF and setup miscellaneous interrupt
  ice: Add support for VSI allocation and deallocation
  ice: Add support for switch filter programming
  ice: Configure VSIs for Tx/Rx
  ice: Implement transmit and NAPI support
  ice: Add support for VLANs and offloads
  ice: Add stats and ethtool support
  ice: Update Tx scheduler tree for VSI multi-Tx queue support
  ice: Support link events, reset and rebuild
  ice: Implement filter sync, NDO operations and bump version

 Documentation/networking/ice.txt                |   39 +
 MAINTAINERS                                     |    1 +
 drivers/net/ethernet/intel/Kconfig              |   14 +
 drivers/net/ethernet/intel/Makefile             |    1 +
 drivers/net/ethernet/intel/ice/Makefile         |   34 +
 drivers/net/ethernet/intel/ice/ice.h            |  326 ++
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1366 ++++++
 drivers/net/ethernet/intel/ice/ice_common.c     | 2247 +++++++++
 drivers/net/ethernet/intel/ice/ice_common.h     |  100 +
 drivers/net/ethernet/intel/ice/ice_controlq.c   | 1080 +++++
 drivers/net/ethernet/intel/ice/ice_controlq.h   |  108 +
 drivers/net/ethernet/intel/ice/ice_devids.h     |   33 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c    |  954 ++++
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  280 ++
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  487 ++
 drivers/net/ethernet/intel/ice/ice_main.c       | 5509 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.c        |  250 +
 drivers/net/ethernet/intel/ice/ice_osdep.h      |   87 +
 drivers/net/ethernet/intel/ice/ice_sched.c      | 1673 +++++++
 drivers/net/ethernet/intel/ice/ice_sched.h      |   57 +
 drivers/net/ethernet/intel/ice/ice_status.h     |   46 +
 drivers/net/ethernet/intel/ice/ice_switch.c     | 1897 ++++++++
 drivers/net/ethernet/intel/ice/ice_switch.h     |  175 +
 drivers/net/ethernet/intel/ice/ice_txrx.c       | 1796 ++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.h       |  206 +
 drivers/net/ethernet/intel/ice/ice_type.h       |  408 ++
 26 files changed, 19174 insertions(+)
 create mode 100644 Documentation/networking/ice.txt
 create mode 100644 drivers/net/ethernet/intel/ice/Makefile
 create mode 100644 drivers/net/ethernet/intel/ice/ice.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_common.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_common.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_devids.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hw_autogen.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_main.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_nvm.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_osdep.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sched.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sched.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_status.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_type.h

-- 
2.14.3

