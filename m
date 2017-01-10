From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 10 Jan 2017 09:13:40 +0000
Subject: [Intel-wired-lan] [next PATCH 2/9] igb: Use length to determine
 if	descriptor is done
In-Reply-To: <20170106161049.2030.71315.stgit@localhost.localdomain>
References: <20170106160850.2030.39073.stgit@localhost.localdomain>
 <20170106161049.2030.71315.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8201B36A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, January 6, 2017 8:11 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH 2/9] igb: Use length to determine if
> descriptor is done
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change makes it so that we use the length of the packet instead of the
> DD status bit to determine if a new descriptor is ready to be processed.
> The obvious advantage is that it cuts down on reads as we don't really even
> need the DD bit if going from a 0 to a non-zero value on size is enough to
> inform us that the packet has been completed.
> 
> In addition I have updated the code so that we only reset the Rx descriptor
> length for descriptor zero when resetting a ring instead of having to do a
> memset with 0 over the entire ring.  By doing this we can save some time on
> initialization.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
This seems to be causing ethtool diagnostics to fail on some adapters.

Hangs with a trace on complete set of patches on an ethtool diags (default ethtool -t) with our without the interface configured.  On one system the console recovered after the trace and I was able to pull the following trace from dmesg.  On that same system with just 1/9 and 2/9 of this series applied the same system simply hung on an ethtool -t (unresponsive system on any consoles) and never came back.  Could be coincidence, other systems hung and never came back with the whole series applied as well.

With just 1/9 applied the system passes ethtool diagnostics without problems.

Here is dmesg output for driver load followed by an ethtool -t ethX.  This is from an i350, but I am seeing similar results on pretty much all adapters I've tried.
--------------------------------------------------------------------------
igb: Copyright (c) 2007-2014 Intel Corporation.
igb 0000:08:00.0: added PHC on eth0
igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:08:00.0: eth0: (PCIe:2.5Gb/s:Width x4) a0:36:9f:00:12:68
igb 0000:08:00.0: eth0: PBA No: G15137-006
igb 0000:08:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
igb 0000:08:00.1: added PHC on eth1
igb 0000:08:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:08:00.1: eth1: (PCIe:2.5Gb/s:Width x4) a0:36:9f:00:12:69
igb 0000:08:00.1: eth1: PBA No: G15137-006
igb 0000:08:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
igb 0000:09:00.0: added PHC on eth2
igb 0000:09:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:09:00.0: eth2: (PCIe:2.5Gb/s:Width x4) 00:1b:21:2c:65:6c
igb 0000:09:00.0: eth2: PBA No: Unknown
igb 0000:09:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
igb 0000:09:00.1: added PHC on eth3
igb 0000:09:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:09:00.1: eth3: (PCIe:2.5Gb/s:Width x4) 00:1b:21:2c:65:6d
igb 0000:09:00.1: eth3: PBA No: Unknown
igb 0000:09:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
igb 0000:08:00.0: offline testing starting
igb 0000:08:00.0: testing shared interrupt
Slab corruption (Not tainted): skbuff_head_cache start=ffff88013adff000, len=200
0c0: 6b 6b 6b 6b 3e a3 3f 9f                          kkkk>.?.
Next obj: start=ffff88013adff100, len=200
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
swap_free: Bad swap offset entry 3ff4f6c5c0000
BUG: Bad page map in process crond  pte:ffd3db1700000000 pmd:13adff067
addr:00007f5e42218000 vm_flags:00000070 anon_vma:          (null) mapping:ffff88013b02b7d8 index:191
file:pam_localuser.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 3 PID: 5108 Comm: crond Not tainted 4.10.0-rc2_next-queue_dev-queue_46091fe #11
Hardware name: Supermicro X7DB8/X7DB8, BIOS 6.00 08/11/2006
Call Trace:
 dump_stack+0x53/0x74
 ? ext4_bh_unmapped+0x13/0x13
 ? ext4_file_open+0x1f3/0x1f3
 print_bad_pte+0x217/0x235
 unmap_page_range+0x4f6/0x74a
 unmap_single_vma+0xba/0xc5
 unmap_vmas+0x2d/0x44
 unmap_region+0xc5/0x114
 ? __vma_rb_erase+0x231/0x236
 ? handle_mm_fault+0x114/0x16a
 do_munmap+0x262/0x2e7
 SyS_munmap+0x51/0x68
 entry_SYSCALL_64_fastpath+0x13/0x94
RIP: 0033:0x7f5e499f8e87
RSP: 002b:00007ffc348c0fb8 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5e499f8e87
RDX: 000000000000000a RSI: 0000000000202060 RDI: 00007f5e42087000
RBP: 00007ffc348c0fc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 00007f5e42288de0
R13: 000000000000000b R14: 00007ffc348c10cb R15: 00007ffc348c1038
Disabling lock debugging due to kernel taint
BUG: Bad rss-counter state mm:ffff88013a263000 idx:2 val:-1
------------[ cut here ]------------
kernel BUG at mm/slab.c:2796!
invalid opcode: 0000 [#1] PREEMPT SMP
Modules linked in: igb dca i2c_algo_bit i2c_core ptp pps_core hwmon nfsd lockd grace sunrpc
CPU: 0 PID: 5107 Comm: ethtool Tainted: G    B           4.10.0-rc2_next-queue_dev-queue_46091fe #11
Hardware name: Supermicro X7DB8/X7DB8, BIOS 6.00 08/11/2006
task: ffff880139c74a80 task.stack: ffffc900053e4000
RIP: 0010:___cache_free+0x94/0x409
RSP: 0018:ffffc900053e79c8 EFLAGS: 00010007
RAX: ffffea00044e0fc8 RBX: ffff88013f087500 RCX: ffffea00044b579f
RDX: ffffea00044b5700 RSI: ffffffff81700654 RDI: ffffffff8170ea10
RBP: ffffc900053e7a78 R08: 0000000000000001 R09: ffffc900053e7ae8
R10: 0000160000000000 R11: ffffffff00001be4 R12: 000000000001d120
R13: ffff88013adff000 R14: ffffc9000531b9a0 R15: ffff88013ab995c0
FS:  00007f4518989700(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000013a1ad000 CR4: 00000000000006f0
Call Trace:
 ? __kfree_skb+0x5e/0x65
 ? __schedule+0x3d6/0x414
 kmem_cache_free+0x6d/0x76
 ? skb_release_all+0x11/0x28
 __kfree_skb+0x5e/0x65
 consume_skb+0x39/0x3b
 __dev_kfree_skb_any+0x25/0x27
 igb_diag_test+0xdce/0x1115 [igb]
 ? __kmalloc+0xed/0x119
 ethtool_self_test+0xc9/0x141
 dev_ethtool+0xa10/0x14d5
 ? netdev_run_todo+0x61/0x32b
 ? debug_smp_processor_id+0x17/0x1c
 ? __might_sleep+0x76/0x7f
 dev_ioctl+0x4ca/0x64d
 sock_ioctl+0x24b/0x258
 vfs_ioctl+0x13/0x23
 do_vfs_ioctl+0x649/0x682
 ? __do_page_fault+0x3e9/0x4e4
 SyS_ioctl+0x43/0x62
 entry_SYSCALL_64_fastpath+0x13/0x94
RIP: 0033:0x3ab1edd847
RSP: 002b:00007ffd93127128 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000003ab219ce80 RCX: 0000003ab1edd847
RDX: 00007ffd93127190 RSI: 0000000000008946 RDI: 0000000000000003
RBP: 00000000000000c0 R08: 0000000000000028 R09: 0101010101010101
R10: 0000000000000038 R11: 0000000000000246 R12: 0000003ab219ced8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000003ab219bd80
Code: 00 00 00 00 ea ff ff 48 c1 e8 0c 48 6b c0 38 48 01 d0 48 8b 50 20 48 89 55 80 48 8d 4a ff 80 e2 01 48 0f 45 c1 48 39 58 30 74 04 <0f> 0b eb fe 48 63 83 e0 00 00 00 49 29 c5 4c 89 ef e8 e1 fd ff
RIP: ___cache_free+0x94/0x409 RSP: ffffc900053e79c8
---[ end trace 9bcc0d1ee8a9c30e ]---
BUG: sleeping function called from invalid context at ./include/linux/sched.h:3153
in_atomic(): 0, irqs_disabled(): 1, pid: 5107, name: ethtool
CPU: 0 PID: 5107 Comm: ethtool Tainted: G    B D         4.10.0-rc2_next-queue_dev-queue_46091fe #11
Hardware name: Supermicro X7DB8/X7DB8, BIOS 6.00 08/11/2006
Call Trace:
 dump_stack+0x53/0x74
 ___might_sleep+0x15b/0x170
 __might_sleep+0x76/0x7f
 exit_signals+0x21/0xfd
 ? blocking_notifier_call_chain+0xf/0x11
 do_exit+0x13a/0x523
 ? do_vfs_ioctl+0x649/0x682
 ? __do_page_fault+0x3e9/0x4e4
 ? SyS_ioctl+0x43/0x62
 rewind_stack_do_exit+0x17/0x19
RIP: 0033:0x3ab1edd847
RSP: 002b:00007ffd93127128 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000003ab219ce80 RCX: 0000003ab1edd847
RDX: 00007ffd93127190 RSI: 0000000000008946 RDI: 0000000000000003
RBP: 00000000000000c0 R08: 0000000000000028 R09: 0101010101010101
R10: 0000000000000038 R11: 0000000000000246 R12: 0000003ab219ced8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000003ab219bd80
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5107 at kernel/softirq.c:161 __local_bh_enable_ip+0x41/0x85
Modules linked in: igb dca i2c_algo_bit i2c_core ptp pps_core hwmon nfsd lockd grace sunrpc
CPU: 0 PID: 5107 Comm: ethtool Tainted: G    B D W       4.10.0-rc2_next-queue_dev-queue_46091fe #11
Hardware name: Supermicro X7DB8/X7DB8, BIOS 6.00 08/11/2006
Call Trace:
 dump_stack+0x53/0x74
 __warn+0xd7/0xf5
 warn_slowpath_null+0x18/0x1a
 __local_bh_enable_ip+0x41/0x85
 _raw_spin_unlock_bh+0x17/0x19
 udp_destroy_sock+0x39/0x67
 sk_common_release+0x1d/0xb1
 udp_lib_close+0x9/0xb
 inet_release+0x4f/0x56
 sock_release+0x1a/0x70
 sock_close+0xd/0x11
 __fput+0x100/0x1ba
 ____fput+0x9/0xb
 task_work_run+0x76/0xa2
 ? switch_task_namespaces+0x49/0x68
 do_exit+0x456/0x523
 ? do_vfs_ioctl+0x649/0x682
 ? __do_page_fault+0x3e9/0x4e4
 ? SyS_ioctl+0x43/0x62
 rewind_stack_do_exit+0x17/0x19
RIP: 0033:0x3ab1edd847
RSP: 002b:00007ffd93127128 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000003ab219ce80 RCX: 0000003ab1edd847
RDX: 00007ffd93127190 RSI: 0000000000008946 RDI: 0000000000000003
RBP: 00000000000000c0 R08: 0000000000000028 R09: 0101010101010101
R10: 0000000000000038 R11: 0000000000000246 R12: 0000003ab219ced8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000003ab219bd80
---[ end trace 9bcc0d1ee8a9c30f ]---

