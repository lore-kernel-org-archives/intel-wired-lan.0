From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 14 Apr 2016 14:48:42 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time
	reset	on	network interruption
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81EEC4DE@ORSMSX101.amr.corp.intel.com>
References: <1455662685-7231-1-git-send-email-brian@walsh.ws>
 <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
 <309B89C4C689E141A5FF6A0C5FB2118B81EEC4DE@ORSMSX101.amr.corp.intel.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65ABF86AE@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

NAK - This completely breaks my system: delays boot & shutdown by quite a lot, can't rmmod e1000e, and no longer sees my 82574L.

Sorry for the top post.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Brown, Aaron F
Sent: Wednesday, April 13, 2016 8:12 PM
To: Brian Walsh <brian@walsh.ws>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time reset on network interruption

> From: Intel-wired-lan 
> [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Brian 
> Walsh
> Sent: Tuesday, April 12, 2016 8:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time reset 
> on network interruption
> 
> Time is resetting on any interruption of network connectivity. This 
> causes the clock to jump around by the leapsecond offset. It should 
> only reset when the device is initialized.
> 
> Signed-off-by: Brian Walsh <brian@walsh.ws>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 22 
> +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

This patch introduces a Call Trace and panic for me on a handful of regression systems.  I am usually seeing this on the e1000e driver load, but on one system when just under traffic stress.  It seems to show up mostly on older hardware, the trace has been spotted on a system with a 82573 LOM, another system with a pair of 80003ES2LAN controller's and an add in 82572.  The following trace is taken via a serial console from a system with an 82574L and 82579L LOM on the board after the system had been running randomish netperf traffic for an hour or so.  The trace on driver load is similar to the first call trace of this series, but generally did not recover enough to get the follow along messages:

divide error: 0000 [#1] SMP
Modules linked in: e1000e 8021q igb ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge stp llc nfsd lockd grace nfs_acl auth_rpcgss autofs4 sunrpc cpufreq_ondemand ipv6 dm_mirror dm_region_hash dm_log dm_mod vhost_net macvtap macvlan vhost tun kvm_intel kvm irqbypass uinput video iTCO_wdt iTCO_vendor_support sg serio_raw i2c_i801 lpc_ich mfd_core dca i2c_algo_bit i2c_core ptp pps_core acpi_cpufreq ext4(E) mbcache(E) jbd2(E) sd_mod(E) usb_storage(E) ahci(E) libahci(E) [last unloaded: igb]
CPU: 1 PID: 119 Comm: kworker/1:2 Tainted: G            E   4.6.0-rc2_next-queue_dev-queue_2146170 #12
Hardware name: Supermicro X9SCL/X9SCM/X9SCL/X9SCM, BIOS 2.0b 09/17/2012
Workqueue: events e1000e_systim_overflow_work [e1000e]
task: ffff8802254a2a00 ti: ffff8802254a4000 task.ti: ffff8802254a4000
RIP: 0010:[<ffffffffa05a0ba4>]  [<ffffffffa05a0ba4>] e1000e_cyclecounter_read+0xd4/0xf0 [e1000e]
RSP: 0018:ffff8802254a7bf8  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88021f8477a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8802254a7bf8 R08: ffff88021f844840 R09: 0000000000000000
R10: 00000007ffffffff R11: 0000000000000001 R12: ffff88021f847780
R13: ffff88021f844840 R14: 0000000000000292 R15: ffff88022fc5ff05
FS:  0000000000000000(0000) GS:ffff88022fc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb97c476000 CR3: 00000000c87eb000 CR4: 00000000000406e0
Stack:
 ffff8802254a7c18 ffffffff810d8459 ffff8802238100c0 ffff8802254a7c68
 ffff8802254a7c58 ffffffffa05acc45 ffff8800c8ec9720 ffff88022501e380
 ffff88021f844840 ffff88021f8476d0 ffff88022fc5ff00 0000000000000000 Call Trace:
 [<ffffffff810d8459>] timecounter_read+0x19/0x60  [<ffffffffa05acc45>] e1000e_phc_gettime+0x45/0x80 [e1000e]  [<ffffffffa05ac960>] e1000e_systim_overflow_work+0x30/0x90 [e1000e]  [<ffffffff8107e3a6>] process_one_work+0x186/0x4e0  [<ffffffff810cd1e8>] ? mod_timer+0x108/0x1e0  [<ffffffff815fc6e0>] ? schedule+0x40/0xb0  [<ffffffff8107f35d>] worker_thread+0x16d/0x520  [<ffffffff8108f6b4>] ? try_to_wake_up+0x54/0x2b0  [<ffffffff8108f922>] ? default_wake_function+0x12/0x20  [<ffffffff810a35b6>] ? __wake_up_common+0x56/0x90  [<ffffffff8107f1f0>] ? maybe_create_worker+0x110/0x110  [<ffffffff815fc6e0>] ? schedule+0x40/0xb0  [<ffffffff8107f1f0>] ? maybe_create_worker+0x110/0x110  [<ffffffff81083ecc>] kthread+0xcc/0xf0  [<ffffffff8108eb9e>] ? schedule_tail+0x1e/0xc0  [<ffffffff815ffed2>] ret_from_fork+0x22/0x40  [<ffffffff81083e00>] ? kthread_freezable_should_stop+0x70/0x70
Code: 40 05 00 00 8b 92 00 b6 00 00 89 d2 49 8b 88 40 05 00 00 8b 89 04 b6 00 00 48 c1 e1 20 48 09 d1 31 d2 48 89 ce 48 29 c6 48 89 f0 <49> f7 f1 48 85 d2 75 bf 4c 39 d6 77 ba 48 89 c8 c9 c3 66 2e 0f RIP  [<ffffffffa05a0ba4>] e1000e_cyclecounter_read+0xd4/0xf0 [e1000e]  RSP <ffff8802254a7bf8> ---[ end trace b2d401f389a3cf87 ]---
BUG: unable to handle kernel paging request at ffffffffffffffd8
IP: [<ffffffff81083a70>] kthread_data+0x10/0x20 PGD 1c07067 PUD 1c09067 PMD 0
Oops: 0000 [#2] SMP
Modules linked in: e1000e 8021q igb ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge stp llc nfsd lockd grace nfs_acl auth_rpcgss autofs4 sunrpc cpufreq_ondemand ipv6 dm_mirror dm_region_hash dm_log dm_mod vhost_net macvtap macvlan vhost tun kvm_intel kvm irqbypass uinput video iTCO_wdt iTCO_vendor_support sg serio_raw i2c_i801 lpc_ich mfd_core dca i2c_algo_bit i2c_core ptp pps_core acpi_cpufreq ext4(E) mbcache(E) jbd2(E) sd_mod(E) usb_storage(E) ahci(E) libahci(E) [last unloaded: igb]
CPU: 1 PID: 119 Comm: kworker/1:2 Tainted: G      D     E   4.6.0-rc2_next-queue_dev-queue_2146170 #12
Hardware name: Supermicro X9SCL/X9SCM/X9SCL/X9SCM, BIOS 2.0b 09/17/2012
task: ffff8802254a2a00 ti: ffff8802254a4000 task.ti: ffff8802254a4000
RIP: 0010:[<ffffffff81083a70>]  [<ffffffff81083a70>] kthread_data+0x10/0x20
RSP: 0018:ffff8802254a7728  EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88022fc55580 RCX: 0000000000000001
RDX: ffff8802254a2a00 RSI: ffff8802254a2a00 RDI: ffff8802254a2a00
RBP: ffff8802254a7728 R08: ffff8802254a2aa8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8802254a33a0 R14: 0000000000000001 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff88022fc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 00000000c87eb000 CR4: 00000000000406e0
Stack:
 ffff8802254a7758 ffffffff8107b742 ffff880200000000 ffff88022fc55580
 0000000000000000 ffff8802254a33a0 ffff8802254a7878 ffffffff815fc1e0
 0000000000000000 ffff8802255b3000 ffff8800c8ec9728 ffff8802254a2a00 Call Trace:
 [<ffffffff8107b742>] wq_worker_sleeping+0x12/0xa0  [<ffffffff815fc1e0>] __schedule+0x510/0x8b0  [<ffffffff812ce7d5>] ? cfq_put_queue+0xe5/0x280  [<ffffffff810c7517>] ? call_rcu_sched+0x17/0x20  [<ffffffff81068023>] ? release_task+0xf3/0x160  [<ffffffff812ad871>] ? put_io_context+0x81/0xc0  [<ffffffff812cef55>] ? cfq_exit_cfqq+0x35/0x60  [<ffffffff815fc6e0>] schedule+0x40/0xb0  [<ffffffff812addbf>] ? exit_io_context+0x3f/0x50  [<ffffffff81068c7e>] do_exit+0x2ae/0x4d0  [<ffffffff810b719b>] ? kmsg_dump+0x9b/0xc0  [<ffffffff81022dff>] oops_end+0x9f/0xe0  [<ffffffff81022f3b>] die+0x5b/0x90  [<ffffffff81020171>] do_trap+0x161/0x170  [<ffffffff810204f8>] do_error_trap+0xb8/0xf0  [<ffffffffa05a0ba4>] ? e1000e_cyclecounter_read+0xd4/0xf0 [e1000e]  [<ffffffff810d4a3c>] ? ktime_get+0x4c/0xc0  [<ffffffff810992bf>] ? update_load_avg+0x59f/0x6d0  [<ffffffff81099cbf>] ? update_curr+0x13f/0x200  [<ffffffff8102069d>] do_divide_error+0x1d/0x20  [<ffffffff816015a8>] divide_error+0x18/0x20  [<ffffffffa05a0ba4>] ? e1000e_cyclecounter_read+0xd4/0xf0 [e1000e]  [<ffffffff810d8459>] timecounter_read+0x19/0x60  [<ffffffffa05acc45>] e1000e_phc_gettime+0x45/0x80 [e1000e]  [<ffffffffa05ac960>] e1000e_systim_overflow_work+0x30/0x90 [e1000e]  [<ffffffff8107e3a6>] process_one_work+0x186/0x4e0  [<ffffffff810cd1e8>] ? mod_timer+0x108/0x1e0  [<ffffffff815fc6e0>] ? schedule+0x40/0xb0  [<ffffffff8107f35d>] worker_thread+0x16d/0x520  [<ffffffff8108f6b4>] ? try_to_wake_up+0x54/0x2b0 [<ffffffff8108f922>] ? default_wake_function+0x12/0x20  [<ffffffff810a35b6>] ? __wake_up_common+0x56/0x90  [<ffffffff8107f1f0>] ? maybe_create_worker+0x110/0x110  [<ffffffff815fc6e0>] ? schedule+0x40/0xb0  [<ffffffff8107f1f0>] ? maybe_create_worker+0x110/0x110  [<ffffffff81083ecc>] kthread+0xcc/0xf0  [<ffffffff8108eb9e>] ? schedule_tail+0x1e/0xc0  [<ffffffff815ffed2>] ret_from_fork+0x22/0x40  [<ffffffff81083e00>] ? kthread_freezable_should_stop+0x70/0x70
Code: 40 09 00 00 48 8b 40 c8 c9 48 c1 e8 02 83 e0 01 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66 66 66 66 90 48 8b 87 40 09 00 00 <48> 8b 40 d8 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66 RIP  [<ffffffff81083a70>] kthread_data+0x10/0x20  RSP <ffff8802254a7728>
CR2: ffffffffffffffd8
---[ end trace b2d401f389a3cf88 ]---
Fixing recursive fault but reboot is needed!
NMI watchdog: Watchdog detected hard LOCKUP on cpu 0 Modules linked in: e1000e 8021q igb ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge stp llc nfsd lockd grace nfs_acl auth_rpcgss autofs4 sunrpc cpufreq_ondemand ipv6 dm_mirror dm_region_hash dm_log dm_mod vhost_net macvtap macvlan vhost tun kvm_intel kvm irqbypass uinput video iTCO_wdt iTCO_vendor_support sg serio_raw i2c_i801 lpc_ich mfd_core dca i2c_algo_bit i2c_core ptp pps_core acpi_cpufreq ext4(E) mbcache(E) jbd2(E) sd_mod(E) usb_storage(E) ahci(E) libahci(E) [last unloaded: igb]
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D     E   4.6.0-rc2_next-queue_dev-queue_2146170 #12
Hardware name: Supermicro X9SCL/X9SCM/X9SCL/X9SCM, BIOS 2.0b 09/17/2012
task: ffffffff81c0b500 ti: ffffffff81c00000 task.ti: ffffffff81c00000
RIP: 0010:[<ffffffff814e970b>]  [<ffffffff814e970b>] cpuidle_enter_state+0xbb/0x2e0
RSP: 0018:ffffffff81c03de8  EFLAGS: 00000212
RAX: ffff88022fc15580 RBX: ffffe8ffffc082d0 RCX: 0000000000000018
RDX: 0000000000000000 RSI: ffffffff81c04000 RDI: 0000000000000000
RBP: ffffffff81c03e68 R08: 00000000ffffffff R09: 071c71c71c71c71c
R10: 0000000000000000 R11: 0000000000000349 R12: 0000000000000002
R13: 000000000002a92f R14: ffffffff81cb1b78 R15: 00000d35e294bc52
FS:  0000000000000000(0000) GS:ffff88022fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fde2c402008 CR3: 000000022575a000 CR4: 00000000000406f0
Stack:
 00ffffff81c03e68 0000000000000000 ffffffff00000000 0000000081cb1aa0
 ffffffff00000000 7fffffffffffffff ffffffff00000000 ffffffff814eabf3
 ffffffff00000000 0000003881095705 0000000000000000 ffffe8ffffc082d0 Call Trace:
[<ffffffff814eabf3>] ? menu_select+0x103/0x3a0  [<ffffffff814e9947>] cpuidle_enter+0x17/0x20  [<ffffffff810a456e>] call_cpuidle+0x2e/0x40  [<ffffffff810a45e8>] cpuidle_idle_call+0x68/0x100  [<ffffffff810a47d5>] cpu_idle_loop+0x155/0x240  [<ffffffff8108f922>] ? default_wake_function+0x12/0x20  [<ffffffff815fc6e0>] ? schedule+0x40/0xb0  [<ffffffff810a48e1>] cpu_startup_entry+0x21/0x30  [<ffffffff815f52b7>] rest_init+0x77/0x80  [<ffffffff81d44348>] start_kernel+0x3c8/0x3ca  [<ffffffff81d43da2>] ? set_init_arg+0x5f/0x5f  [<ffffffff81d433b2>] x86_64_start_reservations+0x2a/0x2c
 [<ffffffff81d436a2>] x86_64_start_kernel+0xee/0xf5
Code: 05 63 11 81 00 8b 53 04 85 c0 89 55 8c 89 45 b0 0f 8f 55 01 00 00 31 ff e8 23 ad bb ff 80 7d 87 00 0f 85 d6 00 00 00 fb 4d 29 fd <48> ba cf f7 53 e3 a5 9b c4 20 4c 89 e8 49 c1 fd 3f 48 f7 ea b8 Kernel panic - not syncing: Hard LOCKUP Shutting down cpus with NMI Kernel Offset: disabled ---[ end Kernel panic - not syncing: Hard LOCKUP _______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
