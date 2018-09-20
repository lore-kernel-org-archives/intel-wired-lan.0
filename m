From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:03 -0700
Subject: [Intel-wired-lan] [PATCH 00/16] Implementation updates for ice
Message-ID: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The first part of this patchset moves code from one file to
another. This code reorganization is required for the very
next patchset which will add SR-IOV support.

The remainder of this patchset contains implementation updates
mostly around VSI management.

Anirudh Venkataramanan (10):
  ice: Move common functions out of ice_main.c part 1/7
  ice: Move common functions out of ice_main.c part 2/7
  ice: Move common functions out of ice_main.c part 3/7
  ice: Move common functions out of ice_main.c part 4/7
  ice: Move common functions out of ice_main.c part 5/7
  ice: Move common functions out of ice_main.c part 6/7
  ice: Move common functions out of ice_main.c part 7/7
  ice: Expand use of VSI handles part 1/2
  ice: Expand use of VSI handles part 2/2
  ice: Implement VSI replay framework

Brett Creeley (2):
  ice: Align ice_reset_req enum values to hardware reset values
  ice: Add support for dynamic interrupt moderation

Dave Ertman (2):
  ice: Change pf state behavior to protect reset path
  ice: Check for actual link state of port after reset

Md Fahad Iqbal Polash (1):
  ice: Implement ethtool hook for RSS switch

Preethi Banala (1):
  ice: Split irq_tracker into sw_irq_tracker and hw_irq_tracker

 drivers/net/ethernet/intel/ice/Makefile         |    1 +
 drivers/net/ethernet/intel/ice/ice.h            |   27 +-
 drivers/net/ethernet/intel/ice/ice_common.c     |  241 +-
 drivers/net/ethernet/intel/ice/ice_common.h     |   20 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |    5 +
 drivers/net/ethernet/intel/ice/ice_lib.c        | 2461 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h        |   76 +
 drivers/net/ethernet/intel/ice/ice_main.c       | 2784 ++---------------------
 drivers/net/ethernet/intel/ice/ice_sched.c      |  151 +-
 drivers/net/ethernet/intel/ice/ice_sched.h      |    5 +-
 drivers/net/ethernet/intel/ice/ice_switch.c     |  573 +++--
 drivers/net/ethernet/intel/ice/ice_switch.h     |   45 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h       |   17 +-
 drivers/net/ethernet/intel/ice/ice_type.h       |   49 +-
 14 files changed, 3509 insertions(+), 2946 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_lib.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_lib.h

-- 
2.14.3

