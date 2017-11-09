From: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 9 Nov 2017 12:09:45 +0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171109031206.x6ta5ysdalf3lk3s@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CAKgT0UfSTwTsQFP9ir=aOJDz-BvYONBd3Q6SOJWQherkQ8XpFQ@mail.gmail.com>
 <20171109031206.x6ta5ysdalf3lk3s@wfg-t540p.sh.intel.com>
Message-ID: <20171109040945.gmd5v3iurajo5du5@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 09, 2017 at 11:12:06AM +0800, Fengguang Wu wrote:
>Hi Alex,
>
>>So looking over the trace the panic seems to be happening after a
>>decnet interface is getting deleted. Is there any chance we could try
>>compiling the kernel without decnet support to see if that is the
>>source of these issues? I don't know if anyone on the Intel Wired Lan
>>team is testing with that enabled so if we can eliminate that as a
>>possible cause that would be useful.
>
>Sure and thank you for the suggestion!
>
>It looks disabling DECNET still triggers the vlan_device_event BUG.
>However when looking at the dmesgs, I find another warning just before
>the vlan_device_event BUG. Not sure if it's related one or independent
>now-fixed issue.
>
>Please press Enter to activate this console.
>[ 1291.938326] Writes:  Total: 2  Max/Min: 0/0   Fail: 0
>[ 1297.731690] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[ 1297.828227] 8021q: adding VLAN 0 to HW filter on device eth0
>[ 1300.506245] 8021q: adding VLAN 0 to HW filter on device eth0
>[ 1302.467460] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>LKP: HOSTNAME vm-lkp-wsx03-openwrt-i386-10, MAC , kernel 4.13.0 1, serial console /dev/ttyS0
>[ 1304.161688] Kernel tests: Boot OK!
>[ 1306.558532] 8021q: adding VLAN 0 to HW filter on device eth0
>[ 1308.507499] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[ 1310.526380] 8021q: adding VLAN 0 to HW filter on device eth0
>[ 1311.246017] LKP: waiting for network...
>[ 1312.543432] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[ 1313.985807]
>[ 1313.991541] =====================================
>[ 1314.002398] WARNING: bad unlock balance detected!
>[ 1314.013154] 4.13.0 #1 Not tainted
>[ 1314.021549] -------------------------------------
>[ 1314.032505] procd/1244 is trying to release lock (rcu_preempt_state) at:
>[ 1314.047216] [<c10e5840>] rcu_read_unlock_special+0x580/0x5b0
>[ 1314.059825] but there are no more locks to release!
>[ 1314.070546]
>[ 1314.070546] other info that might help us debug this:
>[ 1314.085941] 2 locks held by procd/1244:
>[ 1314.095139]  #0:  (&sig->cred_guard_mutex){......}, at: [<c12587b8>] prepare_bprm_creds+0x28/0xc0
>[ 1314.114616]  #1:  (rcu_read_lock){......}, at: [<c1260140>] path_init+0x490/0x6f0
>[ 1314.132155]
>[ 1314.132155] stack backtrace:
>[ 1314.144402] CPU: 0 PID: 1244 Comm: procd Not tainted 4.13.0 #1
>[ 1314.160197] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[ 1314.179404] Call Trace:
>[ 1314.186768]  dump_stack+0x16/0x1c
>[ 1314.195387]  print_unlock_imbalance_bug+0xb9/0xd0
>[ 1314.205753]  ? rcu_read_unlock_special+0x580/0x5b0
>[ 1314.216381]  ? rcu_read_unlock_special+0x580/0x5b0
>[ 1314.226982]  lock_release+0x1cc/0x490
>[ 1314.235602]  ? rcu_gp_kthread_wake+0x34/0x50
>[ 1314.245262]  ? rcu_read_unlock_special+0x580/0x5b0
>[ 1314.255724]  rt_mutex_unlock+0x1e/0xb0
>[ 1314.264610]  rcu_read_unlock_special+0x580/0x5b0
>[ 1314.274814]  __rcu_read_unlock+0xa7/0xb0
>[ 1314.283954]  unlazy_walk+0xcf/0x1f0
>[ 1314.292409]  trailing_symlink+0x349/0x4e0
>[ 1314.301583]  path_openat+0x333/0x1280
>[ 1314.310197]  do_filp_open+0x67/0x140
>[ 1314.318696]  ? getname_kernel+0x23/0x1e0
>[ 1314.327766]  ? cache_alloc_debugcheck_after+0x13a/0x2a0
>[ 1314.340076]  ? getname_kernel+0x23/0x1e0
>[ 1314.349179]  do_open_execat+0xab/0x2a0
>[ 1314.358063]  open_exec+0x57/0x80
>[ 1314.366128]  load_script+0x33c/0x3d0
>[ 1314.374556]  ? kvm_sched_clock_read+0x9/0x20
>[ 1314.384219]  ? sched_clock+0x9/0x10
>[ 1314.392611]  ? sched_clock_cpu+0x1a/0x1e0
>[ 1314.401875]  ? _raw_read_unlock+0x55/0x90
>[ 1314.411080]  search_binary_handler+0xd9/0x160
>[ 1314.420799]  do_execveat_common+0x8f6/0xb10
>[ 1314.430334]  SyS_execve+0x1f/0x30
>[ 1314.438458]  do_int80_syscall_32+0x95/0x1b0
>[ 1314.447956]  entry_INT80_32+0x2f/0x2f
>[ 1314.456606] EIP: 0xb7e9ab07
>[ 1314.464062] EFLAGS: 00000296 CPU: 0
>[ 1314.472421] EAX: ffffffda EBX: 0807b584 ECX: bfb0fd70 EDX: 08061250
>[ 1314.485257] ESI: 0807b584 EDI: 00000000 EBP: bfb0fd58 ESP: bfb0fd28
>[ 1314.498024]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
>[ 1314.613681] hotplug-call (1244) used greatest stack depth: 6384 bytes left
>[ 1314.957636] 8021q: adding VLAN 0 to HW filter on device eth0
>[ 1316.955154] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[ 1318.197800] 8021q: adding VLAN 0 to HW filter on device eth0
>[ 1320.222754] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[ 1321.409456] BUG: unable to handle kernel paging request at 6b6b6f4f
>[ 1321.421942] IP: vlan_device_event+0x7f5/0xa40
>[ 1321.431239] *pde = 00000000

Note that this call trace is different from the ones posted in earlier
emails.

[ 1321.431267]
[ 1321.443356] Oops: 0000 [#1] PREEMPT
[ 1321.451390] CPU: 0 PID: 798 Comm: netifd Not tainted 4.13.0 #1
[ 1321.462802] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[ 1321.479743] task: cf8ae5c0 task.stack: cf114000
[ 1321.489345] EIP: vlan_device_event+0x7f5/0xa40
[ 1321.498701] EFLAGS: 00010206 CPU: 0
[ 1321.506683] EAX: 000000f9 EBX: 00000002 ECX: 00000001 EDX: 6b6b6b6b
[ 1321.518893] ESI: 000014f9 EDI: cf3ec700 EBP: cf115dd8 ESP: cf115da4
[ 1321.531044]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[ 1321.541906] CR0: 80050033 CR2: 6b6b6f4f CR3: 10a02000 CR4: 00000690
[ 1321.554097] Call Trace:
[ 1321.560423]  ? __local_bh_enable_ip+0xf6/0x1a0
[ 1321.569987]  ? _raw_write_unlock_bh+0x2a/0x30
[ 1321.579393]  notifier_call_chain+0x4e/0xa0
[ 1321.588336]  raw_notifier_call_chain+0xc/0x10
[ 1321.597604]  call_netdevice_notifiers_info+0x59/0x90
[ 1321.607779]  __dev_notify_flags+0xea/0x130
[ 1321.616697]  dev_change_flags+0x60/0x70
[ 1321.625255]  dev_ifsioc+0x47b/0x5a0
[ 1321.633354]  ? mutex_lock_nested+0x14/0x20
[ 1321.642292]  dev_ioctl+0x36f/0xb20
[ 1321.650403]  sock_ioctl+0x1cd/0x350
[ 1321.658401]  ? sock_fasync+0xb0/0xb0
[ 1321.666573]  vfs_ioctl+0x33/0x70
[ 1321.674214]  do_vfs_ioctl+0x8d/0xc60
[ 1321.682384]  ? kmem_cache_free+0x186/0x290
[ 1321.691201]  ? putname+0x9f/0xe0
[ 1321.698876]  ? putname+0x9f/0xe0
[ 1321.706491]  ? do_sys_open+0x28d/0x420
[ 1321.714920]  ? __fget_light+0xb7/0xf0
[ 1321.723153]  SyS_ioctl+0x98/0xb0
[ 1321.730961]  do_int80_syscall_32+0x95/0x1b0
[ 1321.740064]  entry_INT80_32+0x2f/0x2f
[ 1321.748335] EIP: 0xb7eb9648
[ 1321.755299] EFLAGS: 00000246 CPU: 0
[ 1321.763209] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bfed0640
[ 1321.775289] ESI: bfed0640 EDI: bfed0660 EBP: bfed0678 ESP: bfed060c
[ 1321.787449]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[ 1321.798394] Code: 8d f4 5d b3 c4 8d 56 01 89 14 8d f4 5d b3 c4 0f 85 03 02 00 00 89 7d d4 31 f6 8b 7d d8 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e0 5d b3 c4 83 c0 01 85
[ 1321.833755] EIP: vlan_device_event+0x7f5/0xa40 SS:ESP: 0068:cf115da4
[ 1321.846005] CR2: 000000006b6b6f4f

>[ 1321.431267]
>
>Attached is the full .config and dmesg. Please don't waste time on reproducing
>-- it's not quite possible since it seems to only happen in one of our
>host machine.

Here are the faddr2line parsed 4.11 call traces:

[  194.685204] wait for background monitors: 1164 oom-killer
[  196.712107] BUG: unable to handle kernel paging request at 6b6b6e73
[  196.725844] IP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  196.735827] *pde = 00000000
[  196.735855]
[  196.749561] Oops: 0000 [#1] PREEMPT
[  196.769520] CPU: 0 PID: 797 Comm: netifd Not tainted 4.11.0 #1
[  196.792728] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  196.821634] task: cfcc9000 task.stack: cfc7e000
[  196.831969] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  196.842019] EFLAGS: 00010202 CPU: 0
[  196.850925] EAX: 000000c2 EBX: 00000002 ECX: 00000000 EDX: 6b6b6b6b
[  196.863985] ESI: 000008c2 EDI: d08c0f00 EBP: cfc7fdd4 ESP: cfc7fda0
[  196.876463]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  196.887903] CR0: 80050033 CR2: 6b6b6e73 CR3: 10f0b000 CR4: 00000690
[  196.900970] Call Trace:
[  196.907905]  ? dn_dev_delete+0x18c/0x1b0:
dn_dev_delete at net/decnet/dn_dev.c:1219
[  196.917749]  ? dn_dev_down+0x69/0x80:
dn_dev_down at net/decnet/dn_dev.c:1235
[  196.926701]  notifier_call_chain+0x4e/0xa0:
notifier_call_chain at kernel/notifier.c:95 (discriminator 1)
--
[  197.042320]  do_vfs_ioctl+0x91/0xcc0:
do_vfs_ioctl at fs/ioctl.c:685
[  197.051621]  ? kmem_cache_free+0x124/0x270:
kmem_cache_free at include/linux/rcupdate.h:981
[  197.061767]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  197.080497]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  197.098679]  ? do_sys_open+0x271/0x3e0:
do_sys_open at fs/open.c:1062
[  197.108071]  ? __fget_light+0xb7/0xf0:
__fget_light at fs/file.c:752 (discriminator 2)
[  197.127385]  SyS_ioctl+0x96/0xb0:
SyS_ioctl at fs/ioctl.c:700
[  197.136262]  do_int80_syscall_32+0x95/0x1b0:
do_int80_syscall_32 at arch/x86/entry/common.c:323
[  197.146639]  entry_INT80_32+0x2f/0x2f:
restore_all at arch/x86/entry/entry_32.S:530
[  197.155513] EIP: 0xb7727648
[  197.162874] EFLAGS: 00000246 CPU: 0
[  197.171852] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bff1f5d0
[  197.184875] ESI: bff1f5d0 EDI: bff1f5f0 EBP: bff1f608 ESP: bff1f59c
[  197.198320]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  197.210120] Code: 8d fc a1 8d c4 8d 56 01 89 14 8d fc a1 8d c4 0f 85 b4 02 00 00 89 7d d8 31 f6 8b 7d e0 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e8 a1 8d c4 83 c0 01 85
[  197.249301] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59 SS:ESP: 0068:cfc7fda0
[  197.262812] CR2: 000000006b6b6e73
[  199.290882] /bin/busybox wget -q http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-11/trinity-300s-openwrt-i386-2016-03-16.cgz-a351e9b9fc24e982ec2f0e76379a49826036da12-20171109-13235-ab6tcc-wait_kernel-4.yaml&loadavg=5.12%202.92%201.17%204/93%201360&start_time=1510191311&end_time=1510191314&version=/lkp/lkp/.src-20171109-011142& -O /dev/null
[  199.356767] wget: socket(AF_INET,1,0): Address family not supported by protocol
[  199.474622] ---[ end trace a8f7db573cc5216e ]---
[  199.474631] Kernel panic - not syncing: Fatal exception
[  199.474660] Kernel Offset: disabled
[  199.534708] Rebooting in 3 seconds..

Elapsed time: 210
--
[  180.393049] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  182.599047] BUG: unable to handle kernel paging request at 6b6b7147
[  182.613337] IP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  182.619888] *pde = 00000000
[  182.619914]
[  182.628048] Oops: 0000 [#1] PREEMPT
[  182.633526] CPU: 0 PID: 825 Comm: netifd Not tainted 4.11.0 #1
[  182.641430] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  182.652999] task: d14d4000 task.stack: d0f08000
[  182.662367] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  182.669241] EFLAGS: 00010206 CPU: 0
[  182.676657] EAX: 00000177 EBX: 00000002 ECX: 00000000 EDX: 6b6b6b6b
[  182.689423] ESI: 00000177 EDI: d0f60380 EBP: d0f09dd4 ESP: d0f09da0
[  182.702454]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  182.714021] CR0: 80050033 CR2: 6b6b7147 CR3: 1377b000 CR4: 00000690
[  182.882308] Call Trace:
[  182.889342]  ? dn_dev_delete+0x18c/0x1b0:
dn_dev_delete at net/decnet/dn_dev.c:1219
[  182.898571]  ? dn_dev_down+0x69/0x80:
dn_dev_down at net/decnet/dn_dev.c:1235
[  182.907290]  notifier_call_chain+0x4e/0xa0:
notifier_call_chain at kernel/notifier.c:95 (discriminator 1)
--
[  183.008332]  do_vfs_ioctl+0x91/0xcc0:
do_vfs_ioctl at fs/ioctl.c:685
[  183.017013]  ? kmem_cache_free+0x124/0x270:
kmem_cache_free at include/linux/rcupdate.h:981
[  183.026481]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  183.034490]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  183.043013]  ? do_sys_open+0x271/0x3e0:
do_sys_open at fs/open.c:1062
[  183.051952]  ? __fget_light+0xb7/0xf0:
__fget_light at fs/file.c:752 (discriminator 2)
[  183.060765]  SyS_ioctl+0x96/0xb0:
SyS_ioctl at fs/ioctl.c:700
[  183.068929]  do_int80_syscall_32+0x95/0x1b0:
do_int80_syscall_32 at arch/x86/entry/common.c:323
[  183.078625]  entry_INT80_32+0x2f/0x2f:
restore_all at arch/x86/entry/entry_32.S:530
[  183.087469] EIP: 0xb7730648
[  183.094893] EFLAGS: 00000246 CPU: 0
[  183.103476] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bfa14970
[  183.116369] ESI: bfa14970 EDI: bfa14990 EBP: bfa149a8 ESP: bfa1493c
[  183.129277]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  183.140907] Code: 8d fc a1 8d c4 8d 56 01 89 14 8d fc a1 8d c4 0f 85 b4 02 00 00 89 7d d8 31 f6 8b 7d e0 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e8 a1 8d c4 83 c0 01 85
[  183.174933] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59 SS:ESP: 0068:d0f09da0
[  183.183587] CR2: 000000006b6b7147
[  184.194926] LKP: waiting for network...
[  184.746928] ---[ end trace c7ee9b1b350863af ]---
[  184.782874] Kernel panic - not syncing: Fatal exception
[  184.815306] Kernel Offset: disabled
[  184.823836] Rebooting in 3 seconds..

Elapsed time: 190

--
[  183.673561] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  184.515624] BUG: unable to handle kernel paging request at 6b6b7023
[  184.524212] IP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  184.530509] *pde = 00000000
[  184.530535]
[  184.538642] Oops: 0000 [#1] PREEMPT
[  184.544085] CPU: 0 PID: 840 Comm: netifd Not tainted 4.11.0 #1
[  184.551887] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  184.569331] task: d1382000 task.stack: d12f6000
[  184.578697] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  184.589091] EFLAGS: 00010206 CPU: 0
[  184.597582] EAX: 0000012e EBX: 00000002 ECX: 00000001 EDX: 6b6b6b6b
[  184.610288] ESI: 00001b2e EDI: d1430880 EBP: d12f7dd4 ESP: d12f7da0
[  184.622995]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  184.634749] CR0: 80050033 CR2: 6b6b7023 CR3: 112d9000 CR4: 00000690
[  184.644895] Call Trace:
[  184.649242]  ? dn_dev_delete+0x18c/0x1b0:
dn_dev_delete at net/decnet/dn_dev.c:1219
[  184.655134]  ? dn_dev_down+0x69/0x80:
dn_dev_down at net/decnet/dn_dev.c:1235
[  184.661137]  notifier_call_chain+0x4e/0xa0:
notifier_call_chain at kernel/notifier.c:95 (discriminator 1)
--
[  184.757796]  do_vfs_ioctl+0x91/0xcc0:
do_vfs_ioctl at fs/ioctl.c:685
[  184.763308]  ? kmem_cache_free+0x124/0x270:
kmem_cache_free at include/linux/rcupdate.h:981
[  184.769403]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  184.774518]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  184.781752]  ? do_sys_open+0x271/0x3e0:
do_sys_open at fs/open.c:1062
[  184.790883]  ? __fget_light+0xb7/0xf0:
__fget_light at fs/file.c:752 (discriminator 2)
[  184.800766]  SyS_ioctl+0x96/0xb0:
SyS_ioctl at fs/ioctl.c:700
[  184.810041]  do_int80_syscall_32+0x95/0x1b0:
do_int80_syscall_32 at arch/x86/entry/common.c:323
[  184.819724]  entry_INT80_32+0x2f/0x2f:
restore_all at arch/x86/entry/entry_32.S:530
[  184.828896] EIP: 0xb76b6648
[  184.836320] EFLAGS: 00000246 CPU: 0
[  184.844521] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bff988c0
[  184.857641] ESI: bff988c0 EDI: bff988e0 EBP: bff988f8 ESP: bff9888c
[  184.870665]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  184.882792] Code: 8d fc a1 8d c4 8d 56 01 89 14 8d fc a1 8d c4 0f 85 b4 02 00 00 89 7d d8 31 f6 8b 7d e0 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e8 a1 8d c4 83 c0 01 85
[  184.920418] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59 SS:ESP: 0068:d12f7da0
[  184.932108] CR2: 000000006b6b7023
[  185.887101] ---[ end trace cb1ea16ac74a42c5 ]---
[  185.923169] Kernel panic - not syncing: Fatal exception
[  185.933931] Kernel Offset: disabled
[  185.941930] Rebooting in 3 seconds..

Elapsed time: 200

initrds=(
--
[  187.387267] Kernel tests: Boot OK!
[  187.599199] BUG: unable to handle kernel paging request at 00010469
[  187.612158] IP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  187.621886] *pde = 00000000
[  187.621914]
[  187.634461] Oops: 0000 [#1] PREEMPT
[  187.643080] CPU: 0 PID: 843 Comm: netifd Not tainted 4.11.0 #1
[  187.655163] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  187.672953] task: d1fb4000 task.stack: d37f0000
[  187.682807] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  187.692696] EFLAGS: 00010202 CPU: 0
[  187.701021] EAX: 000000da EBX: 00000002 ECX: 00000001 EDX: 00010101
[  187.713754] ESI: 000014da EDI: d1430400 EBP: d37f1dd4 ESP: d37f1da0
[  187.726692]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  187.737968] CR0: 80050033 CR2: 00010469 CR3: 112f6000 CR4: 00000690
[  187.750892] Call Trace:
[  187.757538]  ? dn_dev_delete+0x18c/0x1b0:
dn_dev_delete at net/decnet/dn_dev.c:1219
[  187.766612]  ? dn_dev_down+0x69/0x80:
dn_dev_down at net/decnet/dn_dev.c:1235
[  187.775196]  notifier_call_chain+0x4e/0xa0:
notifier_call_chain at kernel/notifier.c:95 (discriminator 1)
--
[  188.034214]  do_vfs_ioctl+0x91/0xcc0:
do_vfs_ioctl at fs/ioctl.c:685
[  188.042772]  ? kmem_cache_free+0x124/0x270:
kmem_cache_free at include/linux/rcupdate.h:981
[  188.051981]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  188.060043]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  188.067987]  ? do_sys_open+0x271/0x3e0:
do_sys_open at fs/open.c:1062
[  188.076807]  ? __fget_light+0xb7/0xf0:
__fget_light at fs/file.c:752 (discriminator 2)
[  188.085329]  SyS_ioctl+0x96/0xb0:
SyS_ioctl at fs/ioctl.c:700
[  188.093430]  do_int80_syscall_32+0x95/0x1b0:
do_int80_syscall_32 at arch/x86/entry/common.c:323
[  188.102980]  entry_INT80_32+0x2f/0x2f:
restore_all at arch/x86/entry/entry_32.S:530
[  188.111665] EIP: 0xb769e648
[  188.118966] EFLAGS: 00000246 CPU: 0
[  188.127423] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bfca7f30
[  188.140188] ESI: bfca7f30 EDI: bfca7f50 EBP: bfca7f68 ESP: bfca7efc
[  188.152891]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  188.163971] Code: 8d fc a1 8d c4 8d 56 01 89 14 8d fc a1 8d c4 0f 85 b4 02 00 00 89 7d d8 31 f6 8b 7d e0 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e8 a1 8d c4 83 c0 01 85
[  188.200306] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59 SS:ESP: 0068:d37f1da0
[  188.213133] CR2: 0000000000010469
[  190.758141] ---[ end trace e2dace73b5c3f492 ]---
[  190.801431] Kernel panic - not syncing: Fatal exception
[  190.813396] Kernel Offset: disabled
[  190.822370] Rebooting in 3 seconds..

Elapsed time: 200

initrds=(
--
[  164.885369] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  166.578856] BUG: unable to handle kernel paging request at 6b6b6dff
[  166.592439] IP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  166.602482] *pde = 00000000
[  166.602489]
[  166.615576] Oops: 0000 [#1] PREEMPT
[  166.624387] CPU: 0 PID: 854 Comm: netifd Not tainted 4.11.0 #1
[  166.636837] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  166.655248] task: d1067000 task.stack: cec6a000
[  166.665648] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59
[  166.676310] EFLAGS: 00010206 CPU: 0
[  166.685169] EAX: 000000a5 EBX: 00000002 ECX: 00000000 EDX: 6b6b6b6b
[  166.699033] ESI: 000002a5 EDI: d08c0600 EBP: cec6bdd4 ESP: cec6bda0
[  166.712190]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  166.879605] CR0: 80050033 CR2: 6b6b6dff CR3: 0ff72000 CR4: 00000690
[  166.892850] Call Trace:
[  166.899886]  ? dn_dev_delete+0x18c/0x1b0:
dn_dev_delete at net/decnet/dn_dev.c:1219
[  166.909194]  ? dn_dev_down+0x69/0x80:
dn_dev_down at net/decnet/dn_dev.c:1235
[  166.917921]  notifier_call_chain+0x4e/0xa0:
notifier_call_chain at kernel/notifier.c:95 (discriminator 1)
--
[  167.019748]  do_vfs_ioctl+0x91/0xcc0:
do_vfs_ioctl at fs/ioctl.c:685
[  167.028761]  ? kmem_cache_free+0x124/0x270:
kmem_cache_free at include/linux/rcupdate.h:981
[  167.038544]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  167.046836]  ? putname+0x9f/0xe0:
putname at fs/namei.c:258
[  167.054973]  ? do_sys_open+0x271/0x3e0:
do_sys_open at fs/open.c:1062
[  167.064009]  ? __fget_light+0xb7/0xf0:
__fget_light at fs/file.c:752 (discriminator 2)
[  167.073020]  SyS_ioctl+0x96/0xb0:
SyS_ioctl at fs/ioctl.c:700
[  167.081231]  do_int80_syscall_32+0x95/0x1b0:
do_int80_syscall_32 at arch/x86/entry/common.c:323
[  167.091042]  entry_INT80_32+0x2f/0x2f:
restore_all at arch/x86/entry/entry_32.S:530
[  167.099964] EIP: 0xb766b648
[  167.107350] EFLAGS: 00000246 CPU: 0
[  167.115941] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bf91e3e0
[  167.128933] ESI: bf91e3e0 EDI: bf91e400 EBP: bf91e418 ESP: bf91e3ac
[  167.142058]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  167.153722] Code: 8d fc a1 8d c4 8d 56 01 89 14 8d fc a1 8d c4 0f 85 b4 02 00 00 89 7d d8 31 f6 8b 7d e0 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e8 a1 8d c4 83 c0 01 85
[  167.191925] EIP: vlan_device_event+0x725/0xa30:
vlan_device_event at net/8021q/vlan.h:59 SS:ESP: 0068:cec6bda0
[  167.205183] CR2: 000000006b6b6dff
[  169.346073] ---[ end trace bdae39c57c143494 ]---
[  169.453966] Kernel panic - not syncing: Fatal exception
[  169.465655] Kernel Offset: disabled
[  169.474311] Rebooting in 3 seconds..

Thanks,
Fengguang
