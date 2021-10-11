From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Mon, 11 Oct 2021 11:48:17 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/4] support for tunnel in ice
 eswitch
Message-ID: <20211011094821.5286-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series adds the support for ice vxlan, geneve and gre offload.

Support adding drop and redirect filter from and to this tunnel deivces.
From means from uplink to VF and to means from VF to uplink. There is no
support for decapsulation and encapsulation offload.

example:
- vxlan from uplink to VF:
tc filter add dev $VXLAN_DEV protocol ip parent ffff: flower enc_dst_ip  \
$VF1_IP enc_key_id $VXLAN_VNI action mirred egress redirect dev $VF1_PR
- vxlan from VF to uplink:
tc filter add dev $VF1_PR protocol ip parent ffff: flower enc_dst_ip \
$LP_IP enc_key_id $VXLAN_VNI action mirred egress redirect dev $VXLAN_DEV

Michal Swiatkowski (4):
  ice: support for indirect notification
  ice: vxlan and geneve tc support
  ice: low level support for tunnels
  ice: support for gre in eswitch

 drivers/net/ethernet/intel/ice/ice.h          |   8 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  26 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 196 ++++++++-
 .../ethernet/intel/ice/ice_protocol_type.h    |  35 ++
 drivers/net/ethernet/intel/ice/ice_switch.c   | 374 ++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_switch.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 393 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |  10 +
 9 files changed, 1000 insertions(+), 49 deletions(-)

-- 
2.31.1

