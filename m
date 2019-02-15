From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Feb 2019 04:03:20 +0000
Subject: [Intel-wired-lan] [PATCH v3] i40e: Add macvlan support on i40e
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3660A8@ORSMSX104.amr.corp.intel.com>
References: <20190116235414.4946-1-harshitha.ramamurthy@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3660A8@ORSMSX104.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96641572@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Wednesday, February 13, 2019 2:21 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v3] i40e: Add macvlan support on i40e
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Harshitha Ramamurthy
> > Sent: Wednesday, January 16, 2019 3:54 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Duyck, Alexander H <alexander.h.duyck@intel.com>
> > Subject: [Intel-wired-lan] [PATCH v3] i40e: Add macvlan support on i40e
> >
> > This patch enables macvlan offloads for i40e. The idea is to use channels as
> > macvlan interfaces. The channels are VSIs of type VMDQ. When the first
> > macvlan is created, the maximum number of channels possible are created.
> > From then on, as a macvlan interface is created, a mac filter is added to
> these
> > already created channels (VSIs).
> >
> > This patch builds on top of the recent changes which move away from the
> > select_queue implementation of picking the tx queue.
> >
> > Steps to configure macvlan offloads:
> > 1. sudo ethtool -K ens261f1 l2-fwd-offload on 2. ip link add link ens261f1
> > name macvlan1 type macvlan 3. sudo ip link add link ens261f1 name
> macvlan1
> > type macvlan 4. sudo ip link set macvlan1 up
> >
> > Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> > ---
> > v3: Renamed i40e_remove_macvlan_channels() to
> > i40e_free_macvlan_channels()
> >     Fixed an indentation issue and added some comments
> >     Removed a code name from the commit message
> >     Addressed some more of Shannon's comments
> >
> > v2: Addressed Shannon's comments
> >     Added a new function to remove all macvlan VSIs
> >
> >  drivers/net/ethernet/intel/i40e/i40e.h      |  26 ++
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 481
> +++++++++++++++++++-
> >  2 files changed, 505 insertions(+), 2 deletions(-)
> 
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

This may be premature.  Andrew reported a call trace when disabling rx vlan offloads (ethtool -K ethX rxvlan off) while working on patches later in the queue.  And on another system I am getting a consistent system freeze if I try to disable rx vlan offloads.  While my system is freezing to quickly to get a trace the trigger is identical so I suspect they are the same basic issue.  I bisected my system and found the freezes on rx vlan disable started with the introduction of this patch. 

A snippet of the call trace Andrew reported with the other system is as follows:
[  118.981539] CPU: 41 PID: 4097 Comm: ethtool Not tainted 5.0.0-rc5WW07.3-ABNxQ-Reverted+ #14
[  118.981542] Hardware name: Intel Corporation S2600STB/S2600STB, BIOS SE5C620.86B.00.01.0015.110720180833 11/07/2018
[  118.981567] RIP: 0010:i40e_set_features+0xfb/0x2c0 [i40e]
[  118.981572] Code: 00 00 be 00 20 00 00 4c 89 ef e8 10 e3 ff ff eb b1 48 8b 85 40 0f 00 00 48 8b 9d a0 0f 00 00 4c 8d 70 08 48 8d 85 a0 0f 00 00 <4c> 8b 3b 48 39 d8 48 89 04 24 75 18 e9 78 ff ff ff 4c 89 f8 48 3b
[  118.981576] RSP: 0018:ffffc1180b947b88 EFLAGS: 00010282
[  118.981580] RAX: ffff9e768557ffa0 RBX: 0000000000000000 RCX: 0000000000000000
[  118.981583] RDX: 0000000001300002 RSI: 0000000006000000 RDI: ffff9e7680ec4350
[  118.981586] RBP: ffff9e768557f000 R08: 0000000000000080 R09: ffff9e76809eaa60
[  118.981589] R10: 0000000000000000 R11: 0000000000000046 R12: 000900e81fd54ab3
[  118.981592] R13: ffff9e7680ec4000 R14: ffff9e7680ec4008 R15: 0000000000000000
[  118.981597] FS:  00007f948d325740(0000) GS:ffff9e768f140000(0000) knlGS:0000000000000000
[  118.981600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  118.981603] CR2: 0000000000000000 CR3: 00000017223b0001 CR4: 00000000007606e0
[  118.981607] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  118.981610] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  118.981612] PKRU: 55555554
[  118.981614] Call Trace:
[  118.981631]  __netdev_update_features+0x234/0x980
[  118.981639]  dev_ethtool+0x1076/0x26f0
[  118.981647]  ? netdev_run_todo+0x61/0x290
[  118.981654]  dev_ioctl+0x1d7/0x3a0
[  118.981662]  sock_do_ioctl+0xa0/0x140
[  118.981671]  ? __handle_mm_fault+0xac1/0x1360
[  118.981676]  sock_ioctl+0x19e/0x320
[  118.981685]  ? selinux_file_ioctl+0x161/0x200
[  118.981692]  do_vfs_ioctl+0xa5/0x620
[  118.981699]  ksys_ioctl+0x60/0x90
[  118.981705]  __x64_sys_ioctl+0x16/0x20
[  118.981715]  do_syscall_64+0x5b/0x160
[  118.981725]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  118.981730] RIP: 0033:0x7f948d41c09b
[  118.981734] Code: 0f 1e fa 48 8b 05 ed bd 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd bd 0c 00 f7 d8 64 89 01 48
[  118.981738] RSP: 002b:00007ffe031fc988 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  118.981742] RAX: ffffffffffffffda RBX: 00007ffe031fca10 RCX: 00007f948d41c09b
[  118.981745] RDX: 00007ffe031fca20 RSI: 0000000000008946 RDI: 0000000000000003
[  118.981748] RBP: 000055786a29d260 R08: 0000000000000001 R09: 0000000010000000
[  118.981751] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
[  118.981754] R13: 000055786a29d980 R14: 0000557869cf0cc8 R15: 000055786a29d280
[  118.981757] Modules linked in: xt_CHECKSUM ipt_MASQUERADE tun bridge stp llc ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 devlink nf_defrag_ipv4 libcrc32c ip_set nfnetlink ebtable_filter ebtables ib_isert ip6table_filter iscsi_target_mod ip6_tables ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rpcrdma ib_umad sunrpc vfat fat rdma_ucm ib_uverbs intel_rapl skx_edac nfit ib_iser x86_pkg_temp_thermal intel_powerclamp coretemp rdma_cm iw_cm kvm_intel ib_cm libiscsi scsi_transport_iscsi kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate i40iw intel_uncore ib_core intel_rapl_perf ipmi_ssif mei_me iTCO_wdt joydev iTCO_vendor_support ipmi_si mei pcspkr ioatdma i2c_i801 ipmi_devintf lpc_ich ipmi_msghandler dca acpi_power_meter acpi_pad pcc_cpufreq ast i2c_algo_bit
[  118.981834]  drm_kms_helper ttm drm i40e crc32c_intel wmi
[  118.981846] CR2: 0000000000000000
[  118.981851] ---[ end trace dccc97c7b510ec6f ]---
[  119.028612] RIP: 0010:i40e_set_features+0xfb/0x2c0 [i40e]
[  119.028618] Code: 00 00 be 00 20 00 00 4c 89 ef e8 10 e3 ff ff eb b1 48 8b 85 40 0f 00 00 48 8b 9d a0 0f 00 00 4c 8d 70 08 48 8d 85 a0 0f 00 00 <4c> 8b 3b 48 39 d8 48 89 04 24 75 18 e9 78 ff ff ff 4c 89 f8 48 3b
[  119.028620] RSP: 0018:ffffc1180b947b88 EFLAGS: 00010282
[  119.028623] RAX: ffff9e768557ffa0 RBX: 0000000000000000 RCX: 0000000000000000
[  119.028624] RDX: 0000000001300002 RSI: 0000000006000000 RDI: ffff9e7680ec4350
[  119.028625] RBP: ffff9e768557f000 R08: 0000000000000080 R09: ffff9e76809eaa60
[  119.028626] R10: 0000000000000000 R11: 0000000000000046 R12: 000900e81fd54ab3
[  119.028628] R13: ffff9e7680ec4000 R14: ffff9e7680ec4008 R15: 0000000000000000
[  119.028629] FS:  00007f948d325740(0000) GS:ffff9e768f140000(0000) knlGS:0000000000000000
[  119.028630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  119.028631] CR2: 0000000000000000 CR3: 00000017223b0001 CR4: 00000000007606e0
[  119.028633] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  119.028634] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  119.028635] PKRU: 55555554


