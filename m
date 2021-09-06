From: Feng Zhou <zhoufeng.zf@bytedance.com>
Date: Mon, 6 Sep 2021 15:49:22 +0800
Subject: [Intel-wired-lan] [External] Re: [PATCH v2] ixgbe: Fix NULL
 pointer dereference in ixgbe_xdp_setup
In-Reply-To: <2ee172ab-836c-d464-be59-935030d01f4b@molgen.mpg.de>
References: <20210903064013.9842-1-zhoufeng.zf@bytedance.com>
 <2ee172ab-836c-d464-be59-935030d01f4b@molgen.mpg.de>
Message-ID: <8ce8de1c-14bf-20ad-00c0-9e0d8ff34b91@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


? 2021/9/6 ??2:37, Paul Menzel ??:
> Dear Feng,
>
>
> Am 03.09.21 um 08:40 schrieb Feng zhou:
>
> (If you care, in your email client, your last name does not start with 
> a capital letter.)
>
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> The ixgbe driver currently generates a NULL pointer dereference with
>> some machine (online cpus < 63). This is due to the fact that the
>> maximum value of num_xdp_queues is nr_cpu_ids. Code is in
>> "ixgbe_set_rss_queues"".
>>
>> Here's how the problem repeats itself:
>> Some machine (online cpus < 63), And user set num_queues to 63 through
>> ethtool. Code is in the "ixgbe_set_channels",
>> adapter->ring_feature[RING_F_FDIR].limit = count;
>
> For better legibility, you might want to indent code (blocks) by four 
> spaces and add blank lines around it (also below).
>
>> It becames 63.
>
> becomes
>
>> When user use xdp, "ixgbe_set_rss_queues" will set queues num.
>> adapter->num_rx_queues = rss_i;
>> adapter->num_tx_queues = rss_i;
>> adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
>> And rss_i's value is from
>> f = &adapter->ring_feature[RING_F_FDIR];
>> rss_i = f->indices = f->limit;
>> So "num_rx_queues" > "num_xdp_queues", when run to "ixgbe_xdp_setup",
>> for (i = 0; i < adapter->num_rx_queues; i++)
>> ????if (adapter->xdp_ring[i]->xsk_umem)
>> lead to panic.
>
> lead*s*?
>
>> Call trace:
>> [exception RIP: ixgbe_xdp+368]
>> RIP: ffffffffc02a76a0? RSP: ffff9fe16202f8d0? RFLAGS: 00010297
>> RAX: 0000000000000000? RBX: 0000000000000020? RCX: 0000000000000000
>> RDX: 0000000000000000? RSI: 000000000000001c? RDI: ffffffffa94ead90
>> RBP: ffff92f8f24c0c18?? R8: 0000000000000000?? R9: 0000000000000000
>> R10: ffff9fe16202f830? R11: 0000000000000000? R12: ffff92f8f24c0000
>> R13: ffff9fe16202fc01? R14: 000000000000000a? R15: ffffffffc02a7530
>> ORIG_RAX: ffffffffffffffff? CS: 0010? SS: 0018
>> ? 7 [ffff9fe16202f8f0] dev_xdp_install at ffffffffa89fbbcc
>> ? 8 [ffff9fe16202f920] dev_change_xdp_fd at ffffffffa8a08808
>> ? 9 [ffff9fe16202f960] do_setlink at ffffffffa8a20235
>> 10 [ffff9fe16202fa88] rtnl_setlink at ffffffffa8a20384
>> 11 [ffff9fe16202fc78] rtnetlink_rcv_msg at ffffffffa8a1a8dd
>> 12 [ffff9fe16202fcf0] netlink_rcv_skb at ffffffffa8a717eb
>> 13 [ffff9fe16202fd40] netlink_unicast at ffffffffa8a70f88
>> 14 [ffff9fe16202fd80] netlink_sendmsg at ffffffffa8a71319
>> 15 [ffff9fe16202fdf0] sock_sendmsg at ffffffffa89df290
>> 16 [ffff9fe16202fe08] __sys_sendto at ffffffffa89e19c8
>> 17 [ffff9fe16202ff30] __x64_sys_sendto at ffffffffa89e1a64
>> 18 [ffff9fe16202ff38] do_syscall_64 at ffffffffa84042b9
>> 19 [ffff9fe16202ff50] entry_SYSCALL_64_after_hwframe at ffffffffa8c0008c
>
> Please describe the fix in the commit message.
>
>> Fixes: 4a9b32f30f80 ("ixgbe: fix potential RX buffer starvation for
>> AF_XDP")
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>> Updates since v1:
>> - Fix "ixgbe_max_channels" callback so that it will not allow a 
>> setting of
>> queues to be higher than the num_online_cpus().
>> more details can be seen from here:
>> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20210817075407.11961-1-zhoufeng.zf at bytedance.com/ 
>>
>> Thanks to Maciej Fijalkowski for your advice.
>>
>> ? drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
>> ? drivers/net/ethernet/intel/ixgbe/ixgbe_main.c??? | 8 ++++++--
>> ? 2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c 
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> index 4ceaca0f6ce3..21321d164708 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> @@ -3204,7 +3204,7 @@ static unsigned int ixgbe_max_channels(struct 
>> ixgbe_adapter *adapter)
>> ????????? max_combined = ixgbe_max_rss_indices(adapter);
>> ????? }
>> ? -??? return max_combined;
>> +??? return min_t(int, max_combined, num_online_cpus());
>> ? }
>> ? ? static void ixgbe_get_channels(struct net_device *dev,
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c 
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 14aea40da50f..5db496cc5070 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -10112,6 +10112,7 @@ static int ixgbe_xdp_setup(struct net_device 
>> *dev, struct bpf_prog *prog)
>> ????? struct ixgbe_adapter *adapter = netdev_priv(dev);
>> ????? struct bpf_prog *old_prog;
>> ????? bool need_reset;
>> +??? int num_queues;
>> ? ????? if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
>> ????????? return -EINVAL;
>> @@ -10161,11 +10162,14 @@ static int ixgbe_xdp_setup(struct 
>> net_device *dev, struct bpf_prog *prog)
>> ????? /* Kick start the NAPI context if there is an AF_XDP socket open
>> ?????? * on that queue id. This so that receiving will start.
>> ?????? */
>> -??? if (need_reset && prog)
>> -??????? for (i = 0; i < adapter->num_rx_queues; i++)
>> +??? if (need_reset && prog) {
>> +??????? num_queues = min_t(int, adapter->num_rx_queues,
>> +??????????? adapter->num_xdp_queues);
>> +??????? for (i = 0; i < num_queues; i++)
>> ????????????? if (adapter->xdp_ring[i]->xsk_pool)
>> ????????????????? (void)ixgbe_xsk_wakeup(adapter->netdev, i,
>> ???????????????????????????????? XDP_WAKEUP_RX);
>> +??? }
>> ? ????? return 0;
>> ? }
>>
Thanks for your advice. I will modify the commit message in v3

