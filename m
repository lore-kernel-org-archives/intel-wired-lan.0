From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:24:21 -0800
Subject: [Intel-wired-lan] [PATCH S16 00/11] Add support for Data Center
 Bridging (DCB)
Message-ID: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anirudh Venkataramanan (11):
  ice: Add code for DCB initialization part 1/4
  ice: Add code for DCB initialization part 2/4
  ice: Add code for DCB initialization part 3/4
  ice: Add code for DCB initialization part 4/4
  ice: Add code to process LLDP MIB change events
  ice: Update rings based on TC information
  ice: Add priority information into VLAN header
  ice: Add code to get DCB related statistics
  ice: Add code for DCB rebuild
  ice: Add code to control FW LLDP and DCBX
  ice: Bump driver version

 drivers/net/ethernet/intel/ice/Makefile         |    1 +
 drivers/net/ethernet/intel/ice/ice.h            |   18 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  164 +++
 drivers/net/ethernet/intel/ice/ice_common.c     |   25 +
 drivers/net/ethernet/intel/ice/ice_common.h     |    3 +
 drivers/net/ethernet/intel/ice/ice_dcb.c        | 1392 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dcb.h        |  179 +++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c    |  551 +++++++++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h    |   61 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c    |  132 ++-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |    8 +
 drivers/net/ethernet/intel/ice/ice_lib.c        |  137 +++
 drivers/net/ethernet/intel/ice/ice_lib.h        |    8 +
 drivers/net/ethernet/intel/ice/ice_main.c       |  138 ++-
 drivers/net/ethernet/intel/ice/ice_sched.c      |   27 +-
 drivers/net/ethernet/intel/ice/ice_sched.h      |    4 +
 drivers/net/ethernet/intel/ice/ice_status.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c       |    6 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h       |    5 +
 drivers/net/ethernet/intel/ice/ice_type.h       |   69 ++
 20 files changed, 2841 insertions(+), 88 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb_lib.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb_lib.h

-- 
2.14.5

