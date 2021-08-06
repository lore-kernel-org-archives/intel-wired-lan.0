From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Fri,  6 Aug 2021 10:48:57 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1 0/9] advanced switch rule
 management
Message-ID: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series adds support for adding/removing advanced switch filters
in ice driver. Advanced filters are building blocks for HW acceleration
of TC orchestration. Add ndo_setup_tc callback implementation for PF and
VF port representors (when device is configured in switchdev mode).

Define dummy packet headers to allow adding advanced rules in HW.
Supported headers, and thus filters, are:
- MAC + IPv4 + UDP
- MAC + VLAN + IPv4 + UDP
- MAC + IPv4 + TCP
- MAC + VLAN + IPv4 + TCP
- MAC + IPv6 + UDP
- MAC + VLAN + IPv6 + UDP
- MAC + IPv6 + TCP
- MAC + VLAN + IPv6 + TCP

Dan Nowlin (2):
  ice: manage profiles and field vectors
  ice: create advanced switch recipe

Grishma Kotecha (2):
  ice: implement low level recipes functions
  ice: allow adding advanced rules

Kiran Patil (1):
  ice: ndo_setup_tc implementation for PF

Michal Swiatkowski (2):
  ice: Allow changing lan_en and lb_en on all kinds of filters
  ice: ndo_setup_tc implementation for PR

Shivanshu Shukla (1):
  ice: allow deleting advanced rules

Victor Raj (1):
  ice: cleanup rules info

 drivers/net/ethernet/intel/ice/Makefile            |    3 +-
 drivers/net/ethernet/intel/ice/ice.h               |    4 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   57 +
 drivers/net/ethernet/intel/ice/ice_common.c        |   42 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |    3 +
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |  278 ++-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |   14 +
 drivers/net/ethernet/intel/ice/ice_flex_type.h     |   13 +
 drivers/net/ethernet/intel/ice/ice_fltr.c          |  127 +
 drivers/net/ethernet/intel/ice/ice_main.c          |   68 +
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |  169 ++
 drivers/net/ethernet/intel/ice/ice_repr.c          |   53 +
 drivers/net/ethernet/intel/ice/ice_switch.c        | 2541 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_switch.h        |  139 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  855 +++++++
 drivers/net/ethernet/intel/ice/ice_tc_lib.h        |  130 +
 drivers/net/ethernet/intel/ice/ice_type.h          |    4 +
 17 files changed, 4402 insertions(+), 98 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tc_lib.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tc_lib.h

-- 
1.8.3.1

