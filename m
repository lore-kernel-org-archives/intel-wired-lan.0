From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Tue, 23 Jan 2018 08:50:54 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 00/12] Enable queue channel
 and cloud filter support on i40evf
Message-ID: <20180123165106.28900-1-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series enables the new mqprio hardware offload mechanism
creating traffic classes on VFs for XL710 devices. The parameters
needed to configure these traffic classes/queue channels are provides
by the user via the tc tool. A maximum of four traffic classes can be
created on each VF. This patch series also enables application of cloud
filters to each of these traffic classes. The cloud filters are applied
using the tc-flower classifier.

Example:
    1. tc qdisc add dev vf0 root mqprio num_tc 4 map 0 0 0 0 1 2 2 3\
        queues 2 at 0 2 at 2 1 at 4 1 at 5 hw 1 mode channel
    2. tc qdisc add dev vf0 ingress
    3. ethtool -K vf0 hw-tc-offload on
    4. ip link set eth0 vf 0 spoofchk off
    5. tc filter add dev vf0 protocol ip parent ffff: prio 1 flower dst_ip\
        192.168.3.5/32 ip_proto udp dst_port 25 skip_sw hw_tc 2

Avinash Dayanand (6):
  i40evf: Fix link up issue when queues are disabled
  i40e: Enable ADq and create queue channel/s on VF
  i40evf: Alloc queues for ADq on VF
  i40e: Delete queue channel for ADq on VF
  i40e: Service request to configure bandwidth for ADq on a VF
  i40e: Add and delete cloud filter

Harshitha Ramamurthy (6):
  virtchnl: Add virtchl structures to support queue channels
  i40evf : add ndo_setup_tc callback to i40evf
  i40evf: Add support to configure bw via tc tool
  virtchnl: Add a macro to check the size of a union
  virtchnl: Add filter data structures
  i40evf: Add support to apply cloud filters

 drivers/net/ethernet/intel/i40e/i40e.h             |    6 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   16 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1000 ++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   20 +
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   72 ++
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |    6 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  797 +++++++++++++++-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  300 +++++-
 include/linux/avf/virtchnl.h                       |  107 ++-
 10 files changed, 2232 insertions(+), 94 deletions(-)

-- 
2.9.4

