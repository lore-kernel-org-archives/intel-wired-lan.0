From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 03 Oct 2018 08:04:48 -0700
Subject: [Intel-wired-lan] i40e Q
In-Reply-To: <f3c0595d07643496e1d3f411bfaab2deec93d750.camel@coverfire.com>
References: <f3c0595d07643496e1d3f411bfaab2deec93d750.camel@coverfire.com>
Message-ID: <09ad93bed0f6d9e0abe79e79953b83050e3e7a8a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2018-10-02 at 22:24 -0400, Dan Siemon wrote:
> Sorry for the direct email but I see on Netdev that you do some work
> on
> the i40e driver so I'm hoping you can point me in the right direction
> or to the right forum/person.
> 
> We have a product based on the X710 and Linux. We occasionally see
> kernel error messages like the one pasted below. Our product creates
> a
> large number of qdiscs, this may be related to tearing down the qdisc
> hierarchy.
> 
> I'd appreciate any help you can give.

Adding the intel-wired-lan mailing list, as well as the current i40e
maintainer...

What kernel are you running?
Also can you provide the output of lspci -vvv for the network
interface?

You say you are running with a large number of qdiscs, can you provide
the setup/configuration that you are running?  It would be helpful in
trying to reproduce the issue in-house and so we can debug the issue.

> 
> [21932.043936] NETDEV WATCHDOG: ens15f1 (i40e): transmit queue 16
> timed
> out
> [21932.043962] WARNING: CPU: 10 PID: 0 at net/sched/sch_generic.c:461
> dev_watchdog+0x1f3/0x200
> [21932.043963] Modules linked in: sch_htb binfmt_misc cls_bpf
> sch_ingress ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack
> ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc
> ip6table_nat
> nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
> iptable_raw iptable_security ebtable_filter ebtables ip6table_filter
> ip6_tables sunrpc intel_rapl sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore
> intel_rapl_perf iTCO_wdt iTCO_vendor_support mxm_wmi ppdev lpc_ich
> parport_pc parport wmi pcc_cpufreq xfs libcrc32c i40e crc32c_intel
> igb
> i2c_algo_bit dca bpwd_drv(OE)
> [21932.044014] CPU: 10 PID: 0 Comm: swapper/10 Tainted:
> G        W  OE     4.18.10-200.fc28.x86_64 #1
> [21932.044015] Hardware name: Default string Default string/Default
> string, BIOS 5.11 08/16/2016
> [21932.044018] RIP: 0010:dev_watchdog+0x1f3/0x200
> [21932.044018] Code: 00 48 63 4d e8 eb 93 4c 89 e7 c6 05 a5 36 b5 00
> 01
> e8 e1 e5 fc ff 89 d9 4c 89 e6 48 c7 c7 d8 d9 17 bb 48 89 c2 e8 b7 64
> 8c
> ff <0f> 0b eb c0 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41
> 56 
> [21932.044055] RSP: 0018:ffff9ff15f083e98 EFLAGS: 00010282
> [21932.044057] RAX: 0000000000000000 RBX: 0000000000000010 RCX:
> 0000000000000006
> [21932.044058] RDX: 0000000000000007 RSI: 0000000000000092 RDI:
> ffff9ff15f096930
> [21932.044059] RBP: ffff9ff14f98d478 R08: 000000000000004c R09:
> 0000000000000004
> [21932.044060] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff9ff14f98d000
> [21932.044062] R13: 000000000000000a R14: ffff9ff15f083ee8 R15:
> 0000000000000000
> [21932.044064] FS:  0000000000000000(0000) GS:ffff9ff15f080000(0000)
> knlGS:0000000000000000
> [21932.044065] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [21932.044066] CR2: 0000559ddb807900 CR3: 00000001fd20a005 CR4:
> 00000000003606e0
> [21932.044068] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [21932.044069] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [21932.044070] Call Trace:
> [21932.044073]  <IRQ>
> [21932.044078]  ? pfifo_fast_dequeue+0x160/0x160
> [21932.044082]  call_timer_fn+0x2b/0x120
> [21932.044084]  run_timer_softirq+0x3ad/0x3e0
> [21932.044087]  ? enqueue_hrtimer+0x38/0x90
> [21932.044090]  ? native_sched_clock+0x37/0x90
> [21932.044095]  __do_softirq+0xe4/0x2d9
> [21932.044100]  irq_exit+0xf7/0x100
> [21932.044103]  smp_apic_timer_interrupt+0x74/0x130
> [21932.044106]  apic_timer_interrupt+0xf/0x20
> [21932.044107]  </IRQ>
> [21932.044110] RIP: 0010:poll_idle+0x61/0x95
> [21932.044110] Code: 04 25 00 5c 01 00 f0 80 60 02 df f0 83 44 24 fc
> 00
> 48 8b 00 a8 08 74 0b 65 81 25 56 45 70 45 ff ff ff 7f 89 e8 5b 5d c3
> f3
> 90 <83> e8 01 75 1c 65 8b 3d e3 da 6f 45 e8 7e e2 7c ff 48 29 d8 48
> 3d 
> [21932.044146] RSP: 0018:ffffaaeb0323fe80 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffff13
> [21932.044148] RAX: 0000000000000028 RBX: 000013f273af9f9a RCX:
> 000000000000001f
> [21932.044149] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffffaaeb0323fe38
> [21932.044151] RBP: 0000000000000000 R08: 001f881cc601f158 R09:
> 0000000000000040
> [21932.044152] R10: 00000000ffffffff R11: ffff9ff15f09fce8 R12:
> ffff9ff15f0ab950
> [21932.044153] R13: ffffffffbb2d4198 R14: 000013f273af9f6a R15:
> 0000000000000000
> [21932.044159]  cpuidle_enter_state+0x70/0x2a0
> [21932.044164]  do_idle+0x226/0x260
> [21932.044167]  cpu_startup_entry+0x6f/0x80
> [21932.044170]  start_secondary+0x1a7/0x200
> [21932.044175]  secondary_startup_64+0xa5/0xb0
> [21932.044177] ---[ end trace 4f581e475cf4be18 ]---
> [21932.044186] i40e 0000:04:00.1 ens15f1: tx_timeout: VSI_seid: 396,
> Q
> 16, NTC: 0x150, HWB: 0x18b, NTU: 0x18b, TAIL: 0x18b, INT: 0x0
> [21932.044188] i40e 0000:04:00.1 ens15f1: tx_timeout recovery level
> 1,
> hung_queue 16
> [21943.476673] i40e 0000:04:00.0 ens15f0: NIC Link is Down
> [21944.097775] watchdog: BUG: soft lockup - CPU#8 stuck for 23s!
> [preseem-netdev-:27734]
> [21944.105596] Modules linked in: sch_htb binfmt_misc cls_bpf
> sch_ingress ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack
> ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc
> ip6table_nat
> nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
> iptable_raw iptable_security ebtable_filter ebtables ip6table_filter
> ip6_tables sunrpc intel_rapl sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore
> intel_rapl_perf iTCO_wdt iTCO_vendor_support mxm_wmi ppdev lpc_ich
> parport_pc parport wmi pcc_cpufreq xfs libcrc32c i40e crc32c_intel
> igb
> i2c_algo_bit dca bpwd_drv(OE)
> [21944.105647] CPU: 8 PID: 27734 Comm: preseem-netdev- Tainted:
> G        W  OE     4.18.10-200.fc28.x86_64 #1
> [21944.105647] Hardware name: Default string Default string/Default
> string, BIOS 5.11 08/16/2016
> [21944.105654] RIP: 0010:fq_codel_reset+0x64/0xd0
> [21944.105654] Code: 00 00 85 c0 0f 84 84 00 00 00 31 ed 48 63 dd 83
> c5
> 01 48 c1 e3 06 49 03 9c 24 50 01 00 00 48 8b 73 08 48 8b 3b e8 4c f0
> fc
> ff <48> 8d 43 10 48 c7 03 00 00 00 00 48 8d 7b 28 48 89 43 10 48 89
> 43 
> [21944.105692] RSP: 0018:ffffaaeb03e97a30 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffff13
> [21944.105694] RAX: ffff9fef5be4e910 RBX: ffff9fef5be4e940 RCX:
> 0000000000000000
> [21944.105696] RDX: 0000000000001000 RSI: ffff9fefdf1af800 RDI:
> 0000000000000000
> [21944.105697] RBP: 00000000000003a6 R08: 0000000000240000 R09:
> ffff9fef5bd58000
> [21944.105698] R10: 00000000c1525000 R11: 0000000000000000 R12:
> ffff9fef5c1da200
> [21944.105699] R13: 000000000000072f R14: 0000000200000000 R15:
> ffff9ff15e856000
> [21944.105701] FS:  00007f8032ffd700(0000) GS:ffff9ff15f000000(0000)
> knlGS:0000000000000000
> [21944.105703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [21944.105704] CR2: 000000c42022b000 CR3: 00000007d6f52004 CR4:
> 00000000003606e0
> [21944.105706] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [21944.105707] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [21944.105708] Call Trace:
> [21944.105716]  qdisc_reset+0x1e/0xe0
> [21944.105721]  htb_reset+0xab/0x220 [sch_htb]
> [21944.105723]  qdisc_reset+0x1e/0xe0
> [21944.105726]  dev_deactivate_queue.constprop.46+0x51/0x90
> [21944.105729]  ? dev_deactivate_many+0x132/0x280
> [21944.105731]  dev_deactivate_many+0x4f/0x280
> [21944.105734]  dev_deactivate+0x5f/0xa0
> [21944.105737]  qdisc_graft+0x290/0x450
> [21944.105740]  tc_get_qdisc+0x1c8/0x2e0
> [21944.105745]  rtnetlink_rcv_msg+0x200/0x2f0
> [21944.105749]  ? rtnl_calcit.isra.31+0x100/0x100
> [21944.105752]  netlink_rcv_skb+0x4c/0x120
> [21944.105755]  netlink_unicast+0x19e/0x260
> [21944.105758]  netlink_sendmsg+0x1ff/0x3c0
> [21944.105761]  sock_sendmsg+0x36/0x40
> [21944.105764]  __sys_sendto+0xee/0x160
> [21944.105767]  ? __sys_bind+0x79/0xf0
> [21944.105769]  ? sock_alloc_file+0xa4/0x150
> [21944.105771]  ? __alloc_fd+0x3d/0x140
> [21944.105774]  ? __sys_socket+0x93/0xe0
> [21944.105776]  __x64_sys_sendto+0x24/0x30
> [21944.105780]  do_syscall_64+0x5b/0x160
> [21944.105785]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [21944.105787] RIP: 0033:0x47ddfa
> [21944.105787] Code: e8 3b 72 fb ff 48 8b 7c 24 10 48 8b 74 24 18 48
> 8b
> 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08
> 0f
> 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24
> 48 
> [21944.105824] RSP: 002b:000000c4201bacc8 EFLAGS: 00000216 ORIG_RAX:
> 000000000000002c
> [21944.105826] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 000000000047ddfa
> [21944.105827] RDX: 0000000000000024 RSI: 000000c42022b4a0 RDI:
> 0000000000000007
> [21944.105828] RBP: 000000c4201bad38 R08: 000000c42022b480 R09:
> 000000000000000c
> [21944.105829] R10: 0000000000000000 R11: 0000000000000216 R12:
> 0000000000000014
> [21944.105830] R13: 0000000000000000 R14: 000000000000006e R15:
> 00000000000000aa
> [21968.133822] watchdog: BUG: soft lockup - CPU#23 stuck for 22s!
> [preseem-netdev-:27734]
> [21968.141736] Modules linked in: sch_htb binfmt_misc cls_bpf
> sch_ingress ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack
> ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc
> ip6table_nat
> nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
> iptable_raw iptable_security ebtable_filter ebtables ip6table_filter
> ip6_tables sunrpc intel_rapl sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore
> intel_rapl_perf iTCO_wdt iTCO_vendor_support mxm_wmi ppdev lpc_ich
> parport_pc parport wmi pcc_cpufreq xfs libcrc32c i40e crc32c_intel
> igb
> i2c_algo_bit dca bpwd_drv(OE)
> [21968.141787] CPU: 23 PID: 27734 Comm: preseem-netdev- Tainted:
> G        W  OEL    4.18.10-200.fc28.x86_64 #1
> [21968.141788] Hardware name: Default string Default string/Default
> string, BIOS 5.11 08/16/2016
> [21968.141793] RIP: 0010:fq_codel_reset+0x64/0xd0
> [21968.141794] Code: 00 00 85 c0 0f 84 84 00 00 00 31 ed 48 63 dd 83
> c5
> 01 48 c1 e3 06 49 03 9c 24 50 01 00 00 48 8b 73 08 48 8b 3b e8 4c f0
> fc
> ff <48> 8d 43 10 48 c7 03 00 00 00 00 48 8d 7b 28 48 89 43 10 48 89
> 43 
> [21968.141832] RSP: 0018:ffffaaeb03e97a58 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffff13
> [21968.141834] RAX: ffff9feff1415310 RBX: ffff9feff1415340 RCX:
> 0000000000000000
> [21968.141836] RDX: 0000000000001000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [21968.141837] RBP: 000000000000054e R08: ffffffffbb25f048 R09:
> ffff9fefddeb0000
> [21968.141838] R10: 0000000000000000 R11: ffff9ff15f3dfce8 R12:
> ffff9ff0d6b36c00
> [21968.141840] R13: 00000000000019dd R14: 0000000200000000 R15:
> 0000000000000040
> [21968.141842] FS:  00007f8032ffd700(0000) GS:ffff9ff15f3c0000(0000)
> knlGS:0000000000000000
> [21968.141843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [21968.141844] CR2: 000000c42017b000 CR3: 00000007d6f52004 CR4:
> 00000000003606e0
> [21968.141846] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [21968.141847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [21968.141848] Call Trace:
> [21968.141856]  qdisc_reset+0x1e/0xe0
> [21968.141860]  htb_reset+0xab/0x220 [sch_htb]
> [21968.141863]  qdisc_reset+0x1e/0xe0
> [21968.141866]  dev_deactivate_many+0x229/0x280
> [21968.141869]  dev_deactivate+0x5f/0xa0
> [21968.141872]  qdisc_graft+0x290/0x450
> [21968.141875]  tc_get_qdisc+0x1c8/0x2e0
> [21968.141880]  rtnetlink_rcv_msg+0x200/0x2f0
> [21968.141883]  ? rtnl_calcit.isra.31+0x100/0x100
> [21968.141886]  netlink_rcv_skb+0x4c/0x120
> [21968.141889]  netlink_unicast+0x19e/0x260
> [21968.141892]  netlink_sendmsg+0x1ff/0x3c0
> [21968.141896]  sock_sendmsg+0x36/0x40
> [21968.141898]  __sys_sendto+0xee/0x160
> [21968.141901]  ? __sys_bind+0x79/0xf0
> [21968.141903]  ? sock_alloc_file+0xa4/0x150
> [21968.141906]  ? __alloc_fd+0x3d/0x140
> [21968.141908]  ? __sys_socket+0x93/0xe0
> [21968.141910]  __x64_sys_sendto+0x24/0x30
> [21968.141914]  do_syscall_64+0x5b/0x160
> [21968.141918]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [21968.141921] RIP: 0033:0x47ddfa
> [21968.141921] Code: e8 3b 72 fb ff 48 8b 7c 24 10 48 8b 74 24 18 48
> 8b
> 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08
> 0f
> 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24
> 48 
> [21968.141958] RSP: 002b:000000c4201bacc8 EFLAGS: 00000216 ORIG_RAX:
> 000000000000002c
> [21968.141960] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 000000000047ddfa
> [21968.141961] RDX: 0000000000000024 RSI: 000000c42022b4a0 RDI:
> 0000000000000007
> [21968.141962] RBP: 000000c4201bad38 R08: 000000c42022b480 R09:
> 000000000000000c
> [21968.141964] R10: 0000000000000000 R11: 0000000000000216 R12:
> 0000000000000014
> [21968.141965] R13: 0000000000000000 R14: 000000000000006e R15:
> 00000000000000aa
> [21992.077869] watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> [kworker/3:0:27676]
> [21992.085343] Modules linked in: sch_htb binfmt_misc cls_bpf
> sch_ingress ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack
> ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc
> ip6table_nat
> nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
> iptable_raw iptable_security ebtable_filter ebtables ip6table_filter
> ip6_tables sunrpc intel_rapl sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore
> intel_rapl_perf iTCO_wdt iTCO_vendor_support mxm_wmi ppdev lpc_ich
> parport_pc parport wmi pcc_cpufreq xfs libcrc32c i40e crc32c_intel
> igb
> i2c_algo_bit dca bpwd_drv(OE)
> [21992.085394] CPU: 3 PID: 27676 Comm: kworker/3:0 Tainted:
> G        W  OEL    4.18.10-200.fc28.x86_64 #1
> [21992.085395] Hardware name: Default string Default string/Default
> string, BIOS 5.11 08/16/2016
> [21992.085403] Workqueue: events linkwatch_event
> [21992.085407] RIP: 0010:fq_codel_reset+0x58/0xd0
> [21992.085408] Code: 00 48 89 87 c0 01 00 00 8b 87 60 01 00 00 85 c0
> 0f
> 84 84 00 00 00 31 ed 48 63 dd 83 c5 01 48 c1 e3 06 49 03 9c 24 50 01
> 00
> 00 <48> 8b 73 08 48 8b 3b e8 4c f0 fc ff 48 8d 43 10 48 c7 03 00 00
> 00 
> [21992.085445] RSP: 0018:ffffaaeb04697d40 EFLAGS: 00000282 ORIG_RAX:
> ffffffffffffff13
> [21992.085447] RAX: ffff9fefbe779150 RBX: ffff9fefbe779180 RCX:
> 0000000000000000
> [21992.085449] RDX: 0000000000001000 RSI: 0000000000000000 RDI:
> ffff9fefbe779168
> [21992.085450] RBP: 0000000000000e47 R08: ffffffffbb25f060 R09:
> ffff9fefbe5a8000
> [21992.085451] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff9fefbe588000
> [21992.085452] R13: 0000000000001a47 R14: 0000000200000000 R15:
> 0000000000000040
> [21992.085454] FS:  0000000000000000(0000) GS:ffff9ff15eec0000(0000)
> knlGS:0000000000000000
> [21992.085456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [21992.085457] CR2: 00007f322fc430c0 CR3: 00000001fd20a004 CR4:
> 00000000003606e0
> [21992.085458] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [21992.085460] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [21992.085460] Call Trace:
> [21992.085468]  qdisc_reset+0x1e/0xe0
> [21992.085473]  htb_reset+0xab/0x220 [sch_htb]
> [21992.085476]  qdisc_reset+0x1e/0xe0
> [21992.085478]  dev_deactivate_many+0x229/0x280
> [21992.085481]  dev_deactivate+0x5f/0xa0
> [21992.085483]  linkwatch_do_dev+0x2c/0x50
> [21992.085485]  __linkwatch_run_queue+0x106/0x1b0
> [21992.085488]  linkwatch_event+0x21/0x30
> [21992.085492]  process_one_work+0x1a1/0x350
> [21992.085495]  worker_thread+0x30/0x380
> [21992.085498]  ? pwq_unbound_release_workfn+0xd0/0xd0
> [21992.085501]  kthread+0x112/0x130
> [21992.085503]  ? kthread_create_worker_on_cpu+0x70/0x70
> [21992.085508]  ret_from_fork+0x35/0x40
> [21995.540072] br1: port 1(ens15f0) entered disabled state
> 
> 
> 
> 
> 
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181003/cc28a38b/attachment-0001.asc>
