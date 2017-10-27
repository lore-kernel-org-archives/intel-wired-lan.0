From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Fri, 27 Oct 2017 02:35:29 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 0/6] tc-flower
 based cloud filters in i40e
Message-ID: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series enables configuring cloud filters in i40e
using the tc-flower classifier. The classification function
of the filter is to match a packet to a traffic class. cls_flower is
extended to offload classid to hardware. Hardware traffic classes
are identified using classid values reserved in the range :ffe0 - :ffef.

The cloud filters are added for a VSI and are cleaned up when
the VSI is deleted. The filters that match on L4 ports needs
enhanced admin queue functions with big buffer support for
extended fields in cloud filter commands.

Example:
# tc qdisc add dev eth0 ingress
# ethtool -K eth0 hw-tc-offload on

Match Dst IPv4,Dst Port and route to TC1:
# tc filter add dev eth0 protocol ip parent ffff: prio 1 flower\
  dst_ip 192.168.1.1/32 ip_proto udp dst_port 12000\
  skip_sw hw_tc 1

# tc filter show dev eth0 parent ffff:
filter pref 1 flower chain 0
filter pref 1 flower chain 0 handle 0x1 hw_tc 1
  eth_type ipv4
  ip_proto udp
  dst_ip 192.168.1.1
  dst_port 12000
  skip_sw
  in_hw

v5: Hardware traffic class based on reserved classid values.
Changes to align with Jiri's filter-block series. i40e code
cleanup based on Shannon's comments.

Authors:
Amritha Nambiar <amritha.nambiar@intel.com>
Kiran Patil <kiran.patil@intel.com>
Anjali Singhai Jain <anjali.singhai@intel.com>
Jingjing Wu <jingjing.wu@intel.com>

---

Amritha Nambiar (6):
      net: sched: Identify hardware traffic classes using classid
      i40e: Map TCs with the VSI seids
      i40e: Cloud filter mode for set_switch_config command
      i40e: Admin queue definitions for cloud filters
      i40e: Clean up of cloud filters
      i40e: Enable cloud filters via tc-flower


 drivers/net/ethernet/intel/i40e/i40e.h             |   62 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  140 +++
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  193 ++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  985 +++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   18 
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   10 
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  110 ++
 include/net/pkt_cls.h                              |    1 
 include/net/sch_generic.h                          |    7 
 net/sched/cls_flower.c                             |    2 
 11 files changed, 1491 insertions(+), 39 deletions(-)

--
