From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 16 May 2018 16:38:16 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 12/12] i40e: implement Tx
 zero-copy
In-Reply-To: <20180516162840.1405afaf@redhat.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
 <20180515190615.23099-13-bjorn.topel@gmail.com>
 <20180516162840.1405afaf@redhat.com>
Message-ID: <CAJ8uoz39PnGmQ63VWezG1EBEM+ODrWSjZqKNGeO5oexvGs3pXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 16, 2018 at 4:28 PM, Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
> On Tue, 15 May 2018 21:06:15 +0200
> Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
>> From: Magnus Karlsson <magnus.karlsson@intel.com>
>>
>> Here, the zero-copy ndo is implemented. As a shortcut, the existing
>> XDP Tx rings are used for zero-copy. This means that and XDP program
>> cannot redirect to an AF_XDP enabled XDP Tx ring.
>
> I've changed i40e1 to only have one queue via:
>  $ ethtool -L i40e1 combined 1
>
> And then, I'm sending on queue 1, which is/should not be avail... and then crash/BUG:
>
> $ sudo taskset -c 2 ./xdpsock --tx --interface=i40e1 --queue=1
>
> [ 3799.936877] Number of in use tx queues changed invalidating tc mappings. Priority traffic
>  classification disabled!
> [ 3799.972970] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [ 3799.980790] PGD 80000007b0992067 P4D 80000007b0992067 PUD 7b62d4067 PMD 0
> [ 3799.987654] Oops: 0002 [#1] PREEMPT SMP PTI
> [ 3799.991831] Modules linked in: nf_nat_masquerade_ipv4 tun nfnetlink bridge stp llc nf_nat
>  nf_conntrack rpcrdma ib_ipoib rdma_ucm ib_ucm ib_umad rdma_cm ib_cm iw_cm sunrpc mlx5_ib ib
> _uverbs ib_core coretemp kvm_intel kvm irqbypass intel_cstate intel_uncore intel_rapl_perf p
> cspkr i2c_i801 shpchp wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad sch_fq_codel i40e ml
> x5_core hid_generic ixgbe igb devlink mdio ptp sd_mod i2c_algo_bit i2c_core pps_core [last u
> nloaded: x_tables]
> [ 3800.033472] CPU: 2 PID: 2006 Comm: xdpsock Not tainted 4.17.0-rc3-af_xdp03_ZC_rfc+ #155
> [ 3800.041465] Hardware name: Supermicro Super Server/X10SRi-F, BIOS 2.0a 08/01/2016
> [ 3800.048943] RIP: 0010:i40e_xmit_frame_ring+0xd4/0x1490 [i40e]
> [ 3800.054683] RSP: 0018:ffffc9000407bcd0 EFLAGS: 00010293
> [ 3800.059900] RAX: 0000000000000000 RBX: ffff88084f0fd200 RCX: 0000000000000000
> [ 3800.067022] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8807b6e710c0
> [ 3800.074148] RBP: ffff8807c6397800 R08: 00000000000000c0 R09: 0000000000000001
> [ 3800.081270] R10: 0000000000000800 R11: 0000000000000010 R12: 0000000000000001
> [ 3800.088396] R13: 0000000000000000 R14: 0000000000000001 R15: 000000000000003c
> [ 3800.095520] FS:  00007f1d1e00bb80(0000) GS:ffff88087fc80000(0000) knlGS:0000000000000000
> [ 3800.103597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3800.109335] CR2: 0000000000000008 CR3: 000000087d542001 CR4: 00000000003606e0
> [ 3800.116458] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 3800.123583] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 3800.130706] Call Trace:
> [ 3800.133157]  ? validate_xmit_skb.isra.116+0x1c/0x270
> [ 3800.138118]  dev_direct_xmit+0xec/0x1d0
> [ 3800.141949]  xsk_sendmsg+0x1f4/0x380
> [ 3800.145521]  sock_sendmsg+0x30/0x40
> [ 3800.149005]  __sys_sendto+0x10e/0x140
> [ 3800.152662]  ? __do_page_fault+0x283/0x500
> [ 3800.156751]  __x64_sys_sendto+0x24/0x30
> [ 3800.160585]  do_syscall_64+0x42/0xf0
> [ 3800.164156]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 3800.169204] RIP: 0033:0x7f1d1d9db430
> [ 3800.172774] RSP: 002b:00007fffb7278610 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> [ 3800.180333] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1d1d9db430
> [ 3800.187456] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> [ 3800.194582] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 3800.201705] R10: 0000000000000040 R11: 0000000000000293 R12: 0000000000000000
> [ 3800.208830] R13: 0000000000000000 R14: 0000000000755510 R15: 00007f1d0d3fc000
> [ 3800.215953] Code: d0 0f 86 db 05 00 00 01 c8 0f b7 ca 29 c8 83 e8 01 39 c6 0f 8f ea 06 00 00 48 8b 45 28 48 8d 14 92 41 b9 01 00 00 00 4c 8d 2c d0 <49> 89 5d 08 8b 83 80 00 00 00 66 45 89 4d 14 41 89 45 10 0f b7
> [ 3800.234798] RIP: i40e_xmit_frame_ring+0xd4/0x1490 [i40e] RSP: ffffc9000407bcd0
> [ 3800.242005] CR2: 0000000000000008
> [ 3800.245320] ---[ end trace f169e36f468e0c59 ]---
> [ 3801.726719] Kernel panic - not syncing: Fatal exception in interrupt
> [ 3801.733097] Kernel Offset: disabled
> [ 3801.785836] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> [ 3801.793403] ------------[ cut here ]------------
>
> (gdb) list *(i40e_xmit_frame_ring)+0xd4
> 0x2ccd4 is in i40e_xmit_frame_ring (drivers/net/ethernet/intel/i40e/i40e_txrx.c:4048).
> warning: Source file is more recent than executable.
> 4043                    return NETDEV_TX_BUSY;
> 4044            }
> 4045
> 4046            /* record the location of the first descriptor for this packet */
> 4047            first = &tx_ring->tx_bi[tx_ring->next_to_use];
> 4048            first->skb = skb;
> 4049            first->bytecount = skb->len;
> 4050            first->gso_segs = 1;
> 4051
> 4052            /* prepare the xmit flags */
>
>
> (gdb) list *(xsk_sendmsg)+0x1f4
> 0xffffffff81800c34 is in xsk_sendmsg (net/xdp/xsk.c:251).
> warning: Source file is more recent than executable.
> 246                     skb_shinfo(skb)->destructor_arg = (void *)(long)id;
> 247                     skb->destructor = xsk_destruct_skb;
> 248
> 249                     err = dev_direct_xmit(skb, xs->queue_id);
> 250                     /* Ignore NET_XMIT_CN as packet might have been sent */
> 251                     if (err == NET_XMIT_DROP || err == NETDEV_TX_BUSY) {
> 252                             err = -EAGAIN;
> 253                             /* SKB consumed by dev_direct_xmit() */
> 254                             goto out;
> 255                     }

Thanks Jesper for reporting. I will take a look at it.

/Magnus
