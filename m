From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 Aug 2017 09:14:46 -0700
Subject: [Intel-wired-lan] [RFC PATCH v2 0/6] Configure cloud filters in
 i40e via tc-flower classifier
In-Reply-To: <150296538797.16910.13738130623106637990.stgit@anamdev.jf.intel.com>
References: <150296538797.16910.13738130623106637990.stgit@anamdev.jf.intel.com>
Message-ID: <dae1822d-cd6c-5ae6-a2e6-d290e3499f1a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks, this RFC patchset addresses my previous comments.
sln

On 8/17/2017 3:26 AM, Amritha Nambiar wrote:
> This patch series enables configuring cloud filters in i40e
> using the tc-flower classifier. The only tc-filter action
> supported is to redirect packets to a traffic class on the
> same device. The tc/mirred:redirect action is extended to
> accept a traffic class to achieve this.
> 
> The cloud filters are added for a VSI and are cleaned up when
> the VSI is deleted. The filters that match on L4 ports needs
> enhanced admin queue functions with big buffer support for
> extended general fields in Add/Remove Cloud filters command.
> 
> Example:
> # tc qdisc add dev eth0 ingress
> 
> # ethtool -K eth0 hw-tc-offload on
> 
> # tc filter add dev eth0 protocol ip parent ffff: prio 1 flower\
>    dst_ip 192.168.1.1/32 ip_proto udp dst_port 22\
>    skip_sw action mirred ingress redirect dev eth0 tclass 1
> 
> # tc filter show dev eth0 parent ffff:
> filter protocol ip pref 1 flower chain 0
> filter protocol ip pref 1 flower chain 0 handle 0x1
>    eth_type ipv4
>    ip_proto udp
>    dst_ip 192.168.1.1
>    dst_port 22
>    skip_sw
>    in_hw
>          action order 1: mirred (Ingress Redirect to device eth0) stolen tclass 1
>          index 7 ref 1 bind 1
> ---
> 
> Amritha Nambiar (6):
>        [net-next]net: sched: act_mirred: Extend redirect action to accept a traffic class
>        [net-next]net: i40e: Maintain a mapping of TCs with the VSI seids
>        [net-next]net: i40e: Extend set switch config command to accept cloud filter mode
>        [net-next]net: i40e: Admin queue definitions for cloud filters
>        [net-next]net: i40e: Clean up of cloud filters
>        [net-next]net: i40e: Enable cloud filters in i40e via tc flower classifier
> 
> 
>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c  |    2
>   drivers/net/ethernet/intel/i40e/i40e.h             |   56 +
>   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  139 +++
>   drivers/net/ethernet/intel/i40e/i40e_common.c      |  194 ++++
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2
>   drivers/net/ethernet/intel/i40e/i40e_main.c        | 1003 +++++++++++++++++++-
>   drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   19
>   drivers/net/ethernet/intel/i40e/i40e_type.h        |   10
>   .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  108 ++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    2
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |    2
>   drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    3
>   .../net/ethernet/mellanox/mlxsw/spectrum_flower.c  |    3
>   drivers/net/ethernet/netronome/nfp/bpf/offload.c   |    1
>   drivers/net/ethernet/netronome/nfp/flower/action.c |    4
>   include/net/tc_act/tc_mirred.h                     |   16
>   include/uapi/linux/tc_act/tc_mirred.h              |    3
>   net/dsa/slave.c                                    |    3
>   net/sched/act_mirred.c                             |   15
>   19 files changed, 1543 insertions(+), 42 deletions(-)
> 
> --
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
