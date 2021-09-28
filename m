From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 28 Sep 2021 04:21:13 +0000
Subject: [Intel-wired-lan] [PATCH v3] ixgbe: Fix NULL pointer
 dereference in ixgbe_xdp_setup
In-Reply-To: <20210915070440.6540-1-zhoufeng.zf@bytedance.com>
References: <20210915070440.6540-1-zhoufeng.zf@bytedance.com>
Message-ID: <MW3PR11MB45543254E1F9F87512A25A6F9CA89@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Feng zhou
>Sent: Wednesday, September 15, 2021 12:35 PM
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
>ast at kernel.org; daniel at iogearbox.net; hawk at kernel.org;
>john.fastabend at gmail.com; jeffrey.t.kirsher at intel.com; Karlsson, Magnus
><magnus.karlsson@intel.com>; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>
>Cc: duanxiongchun at bytedance.com; netdev at vger.kernel.org; linux-
>kernel at vger.kernel.org; zhengqi.arch at bytedance.com;
>chenying.kernel at bytedance.com; intel-wired-lan at lists.osuosl.org;
>songmuchun at bytedance.com; zhoufeng.zf at bytedance.com;
>bpf at vger.kernel.org; wangdongdong.6 at bytedance.com;
>zhouchengming at bytedance.com
>Subject: [Intel-wired-lan] [PATCH v3] ixgbe: Fix NULL pointer dereference in
>ixgbe_xdp_setup
>
>From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
>The ixgbe driver currently generates a NULL pointer dereference with some
>machine (online cpus < 63). This is due to the fact that the maximum value of
>num_xdp_queues is nr_cpu_ids. Code is in "ixgbe_set_rss_queues"".
>
>Here's how the problem repeats itself:
>Some machine (online cpus < 63), And user set num_queues to 63 through
>ethtool. Code is in the "ixgbe_set_channels",
>	adapter->ring_feature[RING_F_FDIR].limit = count;
>
>It becomes 63.
>
>When user use xdp, "ixgbe_set_rss_queues" will set queues num.
>	adapter->num_rx_queues = rss_i;
>	adapter->num_tx_queues = rss_i;
>	adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
>
>And rss_i's value is from
>	f = &adapter->ring_feature[RING_F_FDIR];
>	rss_i = f->indices = f->limit;
>
>So "num_rx_queues" > "num_xdp_queues", when run to "ixgbe_xdp_setup",
>	for (i = 0; i < adapter->num_rx_queues; i++)
>		if (adapter->xdp_ring[i]->xsk_umem)
>
>It leads to panic.
>
>Call trace:
>[exception RIP: ixgbe_xdp+368]
>RIP: ffffffffc02a76a0  RSP: ffff9fe16202f8d0  RFLAGS: 00010297
>RAX: 0000000000000000  RBX: 0000000000000020  RCX: 0000000000000000
>RDX: 0000000000000000  RSI: 000000000000001c  RDI: ffffffffa94ead90
>RBP: ffff92f8f24c0c18   R8: 0000000000000000   R9: 0000000000000000
>R10: ffff9fe16202f830  R11: 0000000000000000  R12: ffff92f8f24c0000
>R13: ffff9fe16202fc01  R14: 000000000000000a  R15: ffffffffc02a7530
>ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> 7 [ffff9fe16202f8f0] dev_xdp_install at ffffffffa89fbbcc
> 8 [ffff9fe16202f920] dev_change_xdp_fd at ffffffffa8a08808
> 9 [ffff9fe16202f960] do_setlink at ffffffffa8a20235
>10 [ffff9fe16202fa88] rtnl_setlink at ffffffffa8a20384
>11 [ffff9fe16202fc78] rtnetlink_rcv_msg at ffffffffa8a1a8dd
>12 [ffff9fe16202fcf0] netlink_rcv_skb at ffffffffa8a717eb
>13 [ffff9fe16202fd40] netlink_unicast at ffffffffa8a70f88
>14 [ffff9fe16202fd80] netlink_sendmsg at ffffffffa8a71319
>15 [ffff9fe16202fdf0] sock_sendmsg at ffffffffa89df290
>16 [ffff9fe16202fe08] __sys_sendto at ffffffffa89e19c8
>17 [ffff9fe16202ff30] __x64_sys_sendto at ffffffffa89e1a64
>18 [ffff9fe16202ff38] do_syscall_64 at ffffffffa84042b9
>19 [ffff9fe16202ff50] entry_SYSCALL_64_after_hwframe at ffffffffa8c0008c
>
>So I fix ixgbe_max_channels so that it will not allow a setting of queues to be
>higher than the num_online_cpus(). And when run to ixgbe_xdp_setup, take
>the smaller value of num_rx_queues and num_xdp_queues.
>
>Fixes: 4a9b32f30f80 ("ixgbe: fix potential RX buffer starvation for
>AF_XDP")
>Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>---
>v1:
>- Fix "ixgbe_max_channels" callback so that it will not allow a setting of
>queues to be higher than the num_online_cpus().
>v2:
>- Modify commit message
>more details can be seen from here:
>https://patchwork.ozlabs.org/project/intel-wired-
>lan/patch/20210817075407.11961-1-zhoufeng.zf at bytedance.com/
>https://lore.kernel.org/netdev/20210903064013.9842-1-
>zhoufeng.zf at bytedance.com/
>Thanks to Maciej Fijalkowski and Paul Menzel for yours advice.
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 8 ++++++--
> 2 files changed, 7 insertions(+), 3 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
