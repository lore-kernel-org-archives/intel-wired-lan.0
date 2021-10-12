From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 12 Oct 2021 11:31:02 -0700
Subject: [Intel-wired-lan] [next-queue v2 0/4] support for tunnel in ice
 eswitch
Message-ID: <20211012183106.2315477-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series adds the support for ice VXLAN, Geneve and GRE offload.

Support adding drop and redirect filter from and to this tunnel devices.
From means from uplink to VF and to means from VF to uplink. There is no
support for decapsulation and encapsulation offload.

example:
- VXLAN from uplink to VF:
tc filter add dev $VXLAN_DEV protocol ip parent ffff: flower enc_dst_ip  \
$VF1_IP enc_key_id $VXLAN_VNI action mirred egress redirect dev $VF1_PR
- VXLAN from VF to uplink:
tc filter add dev $VF1_PR protocol ip parent ffff: flower enc_dst_ip \
$LP_IP enc_key_id $VXLAN_VNI action mirred egress redirect dev
$VXLAN_DEV
---
v2:
- Fix sparse error and kdoc issues
- Fix abbreviations

Michal Swiatkowski (4):
  ice: support for indirect notification
  ice: VXLAN and Geneve TC support
  ice: low level support for tunnels
  ice: support for GRE in eswitch

 drivers/net/ethernet/intel/ice/ice.h          |   8 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  30 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 196 ++++++++-
 .../ethernet/intel/ice/ice_protocol_type.h    |  35 ++
 drivers/net/ethernet/intel/ice/ice_switch.c   | 375 ++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_switch.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 392 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |  10 +
 9 files changed, 1004 insertions(+), 49 deletions(-)

-- 
2.31.1

