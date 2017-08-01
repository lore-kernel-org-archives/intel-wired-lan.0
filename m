From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Mon, 31 Jul 2017 17:36:20 -0700
Subject: [Intel-wired-lan] [PATCH net-next RFC 0/6] Configure cloud filters
 in i40e via tc/flower classifier
Message-ID: <150154569340.4135.11548126443780491627.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series enables configuring cloud filters in i40e
using the tc/flower classifier. The only tc-filter action
supported is to redirect packets to a traffic class on the
same device. The tc/mirred:redirect action is extended to
accept a traffic class to achieve this.

The cloud filters are added for a VSI and are cleaned up when
the VSI is deleted. The filters that match on L4 ports needs
enhanced admin queue functions with big buffer support for
extended general fields in Add/Remove Cloud filters command.

Example:
# tc qdisc add dev eth0 ingress

# ethtool -K eth0 hw-tc-offload on

# tc filter add dev eth0 protocol ip parent ffff: prio 1 flower\
  dst_ip 192.168.1.1/32 ip_proto udp dst_port 22\
  skip_sw indev eth0 action mirred ingress redirect dev eth0 tc 1

# tc filter show dev eth0 parent ffff:
filter protocol ip pref 1 flower
filter protocol ip pref 1 flower handle 0x1
  indev eth0
  eth_type ipv4
  ip_proto udp
  dst_ip 192.168.1.1
  dst_port 22
  skip_sw
  in_hw
        action order 1: mirred (Ingress Redirect to device eth0) stolen tc 1
        index 1 ref 1 bind 1
---

Amritha Nambiar (6):
      [net-next]net: sched: act_mirred: Extend redirect action to accept a traffic class
      [net-next]net: i40e: Maintain a mapping of TCs with the VSI seids
      [net-next]net: i40e: Extend set switch config command to accept cloud filter mode
      [net-next]net: i40e: Admin queue definitions for cloud filters
      [net-next]net: i40e: Clean up of cloud filters
      [net-next]net: i40e: Enable cloud filters in i40e via tc/flower classifier


 drivers/net/ethernet/intel/i40e/i40e.h            |   58 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h |  132 +++
 drivers/net/ethernet/intel/i40e/i40e_common.c     |  184 ++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c    |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  983 +++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h  |   19 
 drivers/net/ethernet/intel/i40e/i40e_type.h       |    9 
 include/net/tc_act/tc_mirred.h                    |    7 
 include/uapi/linux/tc_act/tc_mirred.h             |    5 
 net/sched/act_mirred.c                            |   17 
 10 files changed, 1408 insertions(+), 8 deletions(-)

--
