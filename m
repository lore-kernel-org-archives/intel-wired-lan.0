From: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 9 Nov 2017 15:22:22 +0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171109040945.gmd5v3iurajo5du5@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CAKgT0UfSTwTsQFP9ir=aOJDz-BvYONBd3Q6SOJWQherkQ8XpFQ@mail.gmail.com>
 <20171109031206.x6ta5ysdalf3lk3s@wfg-t540p.sh.intel.com>
 <20171109040945.gmd5v3iurajo5du5@wfg-t540p.sh.intel.com>
Message-ID: <20171109072222.7nybw6pqqzksp6gy@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 09, 2017 at 12:09:45PM +0800, Fengguang Wu wrote:
>On Thu, Nov 09, 2017 at 11:12:06AM +0800, Fengguang Wu wrote:
>>Hi Alex,
>>
>>>So looking over the trace the panic seems to be happening after a
>>>decnet interface is getting deleted. Is there any chance we could try
>>>compiling the kernel without decnet support to see if that is the
>>>source of these issues? I don't know if anyone on the Intel Wired Lan
>>>team is testing with that enabled so if we can eliminate that as a
>>>possible cause that would be useful.
>>
>>Sure and thank you for the suggestion!
>>
>>It looks disabling DECNET still triggers the vlan_device_event BUG.
>>However when looking at the dmesgs, I find another warning just before
>>the vlan_device_event BUG. Not sure if it's related one or independent
>>now-fixed issue.
>>
>>Please press Enter to activate this console.
>>[ 1291.938326] Writes:  Total: 2  Max/Min: 0/0   Fail: 0
>>[ 1297.731690] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>>[ 1297.828227] 8021q: adding VLAN 0 to HW filter on device eth0
>>[ 1300.506245] 8021q: adding VLAN 0 to HW filter on device eth0
>>[ 1302.467460] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>>LKP: HOSTNAME vm-lkp-wsx03-openwrt-i386-10, MAC , kernel 4.13.0 1, serial console /dev/ttyS0
>>[ 1304.161688] Kernel tests: Boot OK!
>>[ 1306.558532] 8021q: adding VLAN 0 to HW filter on device eth0
>>[ 1308.507499] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>>[ 1310.526380] 8021q: adding VLAN 0 to HW filter on device eth0
>>[ 1311.246017] LKP: waiting for network...
>>[ 1312.543432] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>>[ 1313.985807]
>>[ 1313.991541] =====================================
>>[ 1314.002398] WARNING: bad unlock balance detected!
>>[ 1314.013154] 4.13.0 #1 Not tainted
>>[ 1314.021549] -------------------------------------
>>[ 1314.032505] procd/1244 is trying to release lock (rcu_preempt_state) at:
>>[ 1314.047216] [<c10e5840>] rcu_read_unlock_special+0x580/0x5b0
>>[ 1314.059825] but there are no more locks to release!
>>[ 1314.070546]
>>[ 1314.070546] other info that might help us debug this:
>>[ 1314.085941] 2 locks held by procd/1244:
>>[ 1314.095139]  #0:  (&sig->cred_guard_mutex){......}, at: [<c12587b8>] prepare_bprm_creds+0x28/0xc0
>>[ 1314.114616]  #1:  (rcu_read_lock){......}, at: [<c1260140>] path_init+0x490/0x6f0
>>[ 1314.132155]
>>[ 1314.132155] stack backtrace:
>>[ 1314.144402] CPU: 0 PID: 1244 Comm: procd Not tainted 4.13.0 #1
>>[ 1314.160197] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>>[ 1314.179404] Call Trace:
>>[ 1314.186768]  dump_stack+0x16/0x1c
>>[ 1314.195387]  print_unlock_imbalance_bug+0xb9/0xd0
>>[ 1314.205753]  ? rcu_read_unlock_special+0x580/0x5b0
>>[ 1314.216381]  ? rcu_read_unlock_special+0x580/0x5b0
>>[ 1314.226982]  lock_release+0x1cc/0x490
>>[ 1314.235602]  ? rcu_gp_kthread_wake+0x34/0x50
>>[ 1314.245262]  ? rcu_read_unlock_special+0x580/0x5b0
>>[ 1314.255724]  rt_mutex_unlock+0x1e/0xb0
>>[ 1314.264610]  rcu_read_unlock_special+0x580/0x5b0
>>[ 1314.274814]  __rcu_read_unlock+0xa7/0xb0
>>[ 1314.283954]  unlazy_walk+0xcf/0x1f0
>>[ 1314.292409]  trailing_symlink+0x349/0x4e0
>>[ 1314.301583]  path_openat+0x333/0x1280
>>[ 1314.310197]  do_filp_open+0x67/0x140
>>[ 1314.318696]  ? getname_kernel+0x23/0x1e0
>>[ 1314.327766]  ? cache_alloc_debugcheck_after+0x13a/0x2a0
>>[ 1314.340076]  ? getname_kernel+0x23/0x1e0
>>[ 1314.349179]  do_open_execat+0xab/0x2a0
>>[ 1314.358063]  open_exec+0x57/0x80
>>[ 1314.366128]  load_script+0x33c/0x3d0
>>[ 1314.374556]  ? kvm_sched_clock_read+0x9/0x20
>>[ 1314.384219]  ? sched_clock+0x9/0x10
>>[ 1314.392611]  ? sched_clock_cpu+0x1a/0x1e0
>>[ 1314.401875]  ? _raw_read_unlock+0x55/0x90
>>[ 1314.411080]  search_binary_handler+0xd9/0x160
>>[ 1314.420799]  do_execveat_common+0x8f6/0xb10
>>[ 1314.430334]  SyS_execve+0x1f/0x30
>>[ 1314.438458]  do_int80_syscall_32+0x95/0x1b0
>>[ 1314.447956]  entry_INT80_32+0x2f/0x2f
>>[ 1314.456606] EIP: 0xb7e9ab07
>>[ 1314.464062] EFLAGS: 00000296 CPU: 0
>>[ 1314.472421] EAX: ffffffda EBX: 0807b584 ECX: bfb0fd70 EDX: 08061250
>>[ 1314.485257] ESI: 0807b584 EDI: 00000000 EBP: bfb0fd58 ESP: bfb0fd28
>>[ 1314.498024]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
>>[ 1314.613681] hotplug-call (1244) used greatest stack depth: 6384 bytes left
>>[ 1314.957636] 8021q: adding VLAN 0 to HW filter on device eth0
>>[ 1316.955154] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>>[ 1318.197800] 8021q: adding VLAN 0 to HW filter on device eth0
>>[ 1320.222754] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>>[ 1321.409456] BUG: unable to handle kernel paging request at 6b6b6f4f
>>[ 1321.421942] IP: vlan_device_event+0x7f5/0xa40
>>[ 1321.431239] *pde = 00000000
>
>Note that this call trace is different from the ones posted in earlier
>emails.
>
>[ 1321.431267]
>[ 1321.443356] Oops: 0000 [#1] PREEMPT
>[ 1321.451390] CPU: 0 PID: 798 Comm: netifd Not tainted 4.13.0 #1
>[ 1321.462802] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[ 1321.479743] task: cf8ae5c0 task.stack: cf114000
>[ 1321.489345] EIP: vlan_device_event+0x7f5/0xa40
>[ 1321.498701] EFLAGS: 00010206 CPU: 0
>[ 1321.506683] EAX: 000000f9 EBX: 00000002 ECX: 00000001 EDX: 6b6b6b6b
>[ 1321.518893] ESI: 000014f9 EDI: cf3ec700 EBP: cf115dd8 ESP: cf115da4
>[ 1321.531044]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
>[ 1321.541906] CR0: 80050033 CR2: 6b6b6f4f CR3: 10a02000 CR4: 00000690
>[ 1321.554097] Call Trace:
>[ 1321.560423]  ? __local_bh_enable_ip+0xf6/0x1a0
>[ 1321.569987]  ? _raw_write_unlock_bh+0x2a/0x30
>[ 1321.579393]  notifier_call_chain+0x4e/0xa0
>[ 1321.588336]  raw_notifier_call_chain+0xc/0x10
>[ 1321.597604]  call_netdevice_notifiers_info+0x59/0x90
>[ 1321.607779]  __dev_notify_flags+0xea/0x130
>[ 1321.616697]  dev_change_flags+0x60/0x70
>[ 1321.625255]  dev_ifsioc+0x47b/0x5a0
>[ 1321.633354]  ? mutex_lock_nested+0x14/0x20
>[ 1321.642292]  dev_ioctl+0x36f/0xb20
>[ 1321.650403]  sock_ioctl+0x1cd/0x350
>[ 1321.658401]  ? sock_fasync+0xb0/0xb0
>[ 1321.666573]  vfs_ioctl+0x33/0x70
>[ 1321.674214]  do_vfs_ioctl+0x8d/0xc60
>[ 1321.682384]  ? kmem_cache_free+0x186/0x290
>[ 1321.691201]  ? putname+0x9f/0xe0
>[ 1321.698876]  ? putname+0x9f/0xe0
>[ 1321.706491]  ? do_sys_open+0x28d/0x420
>[ 1321.714920]  ? __fget_light+0xb7/0xf0
>[ 1321.723153]  SyS_ioctl+0x98/0xb0
>[ 1321.730961]  do_int80_syscall_32+0x95/0x1b0
>[ 1321.740064]  entry_INT80_32+0x2f/0x2f
>[ 1321.748335] EIP: 0xb7eb9648
>[ 1321.755299] EFLAGS: 00000246 CPU: 0
>[ 1321.763209] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bfed0640
>[ 1321.775289] ESI: bfed0640 EDI: bfed0660 EBP: bfed0678 ESP: bfed060c
>[ 1321.787449]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
>[ 1321.798394] Code: 8d f4 5d b3 c4 8d 56 01 89 14 8d f4 5d b3 c4 0f 85 03 02 00 00 89 7d d4 31 f6 8b 7d d8 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e0 5d b3 c4 83 c0 01 85
>[ 1321.833755] EIP: vlan_device_event+0x7f5/0xa40 SS:ESP: 0068:cf115da4
>[ 1321.846005] CR2: 000000006b6b6f4f
>
>>[ 1321.431267]
>>
>>Attached is the full .config and dmesg. Please don't waste time on reproducing
>>-- it's not quite possible since it seems to only happen in one of our
>>host machine.
>
>Here are the faddr2line parsed 4.11 call traces:
>
>[  194.685204] wait for background monitors: 1164 oom-killer
>[  196.712107] BUG: unable to handle kernel paging request at 6b6b6e73
>[  196.725844] IP: vlan_device_event+0x725/0xa30:
>vlan_device_event at net/8021q/vlan.h:59
>[  196.735827] *pde = 00000000
>[  196.735855]
>[  196.749561] Oops: 0000 [#1] PREEMPT
>[  196.769520] CPU: 0 PID: 797 Comm: netifd Not tainted 4.11.0 #1
>[  196.792728] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[  196.821634] task: cfcc9000 task.stack: cfc7e000
>[  196.831969] EIP: vlan_device_event+0x725/0xa30:
>vlan_device_event at net/8021q/vlan.h:59
>[  196.842019] EFLAGS: 00010202 CPU: 0
>[  196.850925] EAX: 000000c2 EBX: 00000002 ECX: 00000000 EDX: 6b6b6b6b
>[  196.863985] ESI: 000008c2 EDI: d08c0f00 EBP: cfc7fdd4 ESP: cfc7fda0
>[  196.876463]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
>[  196.887903] CR0: 80050033 CR2: 6b6b6e73 CR3: 10f0b000 CR4: 00000690
>[  196.900970] Call Trace:
>[  196.907905]  ? dn_dev_delete+0x18c/0x1b0:
>dn_dev_delete at net/decnet/dn_dev.c:1219
>[  196.917749]  ? dn_dev_down+0x69/0x80:
>dn_dev_down at net/decnet/dn_dev.c:1235
>[  196.926701]  notifier_call_chain+0x4e/0xa0:
>notifier_call_chain at kernel/notifier.c:95 (discriminator 1)
>--
>[  197.042320]  do_vfs_ioctl+0x91/0xcc0:
>do_vfs_ioctl at fs/ioctl.c:685
>[  197.051621]  ? kmem_cache_free+0x124/0x270:
>kmem_cache_free at include/linux/rcupdate.h:981
>[  197.061767]  ? putname+0x9f/0xe0:
>putname at fs/namei.c:258
>[  197.080497]  ? putname+0x9f/0xe0:
>putname at fs/namei.c:258
>[  197.098679]  ? do_sys_open+0x271/0x3e0:
>do_sys_open at fs/open.c:1062
>[  197.108071]  ? __fget_light+0xb7/0xf0:
>__fget_light at fs/file.c:752 (discriminator 2)
>[  197.127385]  SyS_ioctl+0x96/0xb0:
>SyS_ioctl at fs/ioctl.c:700
>[  197.136262]  do_int80_syscall_32+0x95/0x1b0:
>do_int80_syscall_32 at arch/x86/entry/common.c:323
>[  197.146639]  entry_INT80_32+0x2f/0x2f:
>restore_all at arch/x86/entry/entry_32.S:530
>[  197.155513] EIP: 0xb7727648
>[  197.162874] EFLAGS: 00000246 CPU: 0
>[  197.171852] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bff1f5d0
>[  197.184875] ESI: bff1f5d0 EDI: bff1f5f0 EBP: bff1f608 ESP: bff1f59c
>[  197.198320]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
>[  197.210120] Code: 8d fc a1 8d c4 8d 56 01 89 14 8d fc a1 8d c4 0f 85 b4 02 00 00 89 7d d8 31 f6 8b 7d e0 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 e8 a1 8d c4 83 c0 01 85
>[  197.249301] EIP: vlan_device_event+0x725/0xa30:
>vlan_device_event at net/8021q/vlan.h:59 SS:ESP: 0068:cfc7fda0
>[  197.262812] CR2: 000000006b6b6e73
>[  199.290882] /bin/busybox wget -q http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-11/trinity-300s-openwrt-i386-2016-03-16.cgz-a351e9b9fc24e982ec2f0e76379a49826036da12-20171109-13235-ab6tcc-wait_kernel-4.yaml&loadavg=5.12%202.92%201.17%204/93%201360&start_time=1510191311&end_time=1510191314&version=/lkp/lkp/.src-20171109-011142& -O /dev/null
>[  199.356767] wget: socket(AF_INET,1,0): Address family not supported by protocol
>[  199.474622] ---[ end trace a8f7db573cc5216e ]---
>[  199.474631] Kernel panic - not syncing: Fatal exception
>[  199.474660] Kernel Offset: disabled
>[  199.534708] Rebooting in 3 seconds..

Here is yet another call trace, this time it's "NULL point dereference".

[  748.471023] procd: - init -
Please press Enter to activate this console.
[  753.540379] random: uci: uninitialized urandom read (6 bytes read)
[  754.030470] random: uci: uninitialized urandom read (6 bytes read)
[  754.245351] random: uci: uninitialized urandom read (6 bytes read)
[  757.258323] Writes:  Total: 2  Max/Min: 0/0   Fail: 0
[  760.340612] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  760.448681] 8021q: adding VLAN 0 to HW filter on device eth0
[  762.403927] 8021q: adding VLAN 0 to HW filter on device eth0
[  764.380369] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
LKP: HOSTNAME vm-lkp-wsx03-openwrt-i386-18, MAC , kernel 4.11.0-08060-g8d5e72d 1, serial console /dev/ttyS0
[  765.018938] Kernel tests: Boot OK!
[  766.118342] BUG: unable to handle kernel NULL pointer dereference at 00000639
[  766.127471] IP: vlan_device_event+0x7f5/0xa40
[  766.133669] *pde = 00000000
[  766.133694]
[  766.141020] Oops: 0000 [#1] PREEMPT
[  766.146171] CPU: 0 PID: 832 Comm: netifd Not tainted 4.11.0-08060-g8d5e72d #1
[  766.154925] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  766.166422] task: d1ac3000 task.stack: d2952000
[  766.172581] EIP: vlan_device_event+0x7f5/0xa40
[  766.178581] EFLAGS: 00010206 CPU: 0
[  766.183537] EAX: 0000018e EBX: 00000002 ECX: 00000000 EDX: 00000001
[  766.191471] ESI: 0000038e EDI: d1f0ed80 EBP: d2953dd8 ESP: d2953da4
[  766.199453]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  766.206997] CR0: 80050033 CR2: 00000639 CR3: 1199e000 CR4: 00000690
[  766.216394] Call Trace:
[  766.220644]  ? dn_dev_delete+0x138/0x1d0
[  766.226253]  ? dn_dev_down+0x69/0x80
[  766.231402]  notifier_call_chain+0x4e/0xa0
[  766.237335]  raw_notifier_call_chain+0xc/0x10
[  766.243331]  call_netdevice_notifiers_info+0x59/0x90
[  766.250689]  __dev_notify_flags+0xea/0x130
[  766.257746]  dev_change_flags+0x60/0x70
[  766.265073]  dev_ifsioc+0x44b/0x570
[  766.271028]  ? mutex_lock_nested+0x14/0x20
[  766.278162]  dev_ioctl+0x399/0xa70
[  766.284317]  ? slow_virt_to_phys+0x3e/0x110
[  766.291227]  sock_ioctl+0x1cd/0x350
[  766.297515]  ? sock_fasync+0xb0/0xb0
[  766.304019]  vfs_ioctl+0x33/0x70
[  766.309894]  do_vfs_ioctl+0x8d/0xc30
[  766.316242]  ? kmem_cache_free+0x186/0x290
[  766.323504]  ? putname+0x9f/0xe0
[  766.330082]  ? putname+0x9f/0xe0
[  766.335780]  ? do_sys_open+0x28d/0x420
[  766.342393]  ? __fget_light+0xb7/0xf0
[  766.348578]  SyS_ioctl+0x98/0xb0
[  766.353281]  do_int80_syscall_32+0x95/0x1b0
[  766.359117]  entry_INT80_32+0x2f/0x2f
[  766.364295] EIP: 0xb7766648
[  766.368512] EFLAGS: 00000246 CPU: 0
[  766.373497] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bfdae180
[  766.381443] ESI: bfdae180 EDI: bfdae1a0 EBP: bfdae1b8 ESP: bfdae14c
[  766.389775]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  766.396967] Code: 8d a4 80 9b c4 8d 56 01 89 14 8d a4 80 9b c4 0f 85 03 02 00 00 89 7d d4 31 f6 8b 7d d8 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 90 80 9b c4 83 c0 01 85
[  766.420978] EIP: vlan_device_event+0x7f5/0xa40 SS:ESP: 0068:d2953da4
[  766.428984] CR2: 0000000000000639
[  768.045479] ---[ end trace 4eaaf76db348fd80 ]---
[  768.105484] Kernel panic - not syncing: Fatal exception
[  768.112938] Kernel Offset: disabled
[  768.118386] Rebooting in 3 seconds..

kernel NULL pointer
-------------- next part --------------
early console in setup code
Probing EDD (edd=off to disable)... ok
early console in extract_kernel
input_data: 0x04234069
input_len: 0x01d2d293
output: 0x01000000
output_len: 0x03b40a3c
kernel_total_size: 0x04f78000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 4.11.0-08060-g8d5e72d (kbuild at lkp-hsx03) (gcc version 5.4.1 20160904 (Debian 5.4.1-2) ) #1 PREEMPT Wed Nov 8 18:31:13 CST 2017
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000013fdbfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000013fdc000-0x0000000013ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] tsc: Unable to calibrate against PIT
[    0.000000] tsc: No reference (HPET/PMTIMER) available
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x13fdc max_arch_pfn = 0x100000
[    0.000000] MTRR: Disabled
[    0.000000] x86/PAT: MTRRs disabled, skipping PAT initialization too.
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f6a90-0x000f6a9f] mapped at [c00f6a90]
[    0.000000]   mpc: f6aa0-f6b80
[    0.000000] initial memory mapped: [mem 0x00000000-0x063fffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x05e6c000, 0x05e6cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x13ca1000-0x13fcffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x0000000013FE15CE 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x0000000013FE142A 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x0000000013FE0040 0013EA (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x0000000013FE0000 000040
[    0.000000] ACPI: APIC 0x0000000013FE151E 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x0000000013FE1596 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] 319MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 13fdc000
[    0.000000]   low ram: 0 - 13fdc000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:13fdb001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 1712901788 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x0000000013fdbfff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000013fdbfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000013fdbfff]
[    0.000000] On node 0 totalpages: 81786
[    0.000000] free_area_init_node: node 0, pgdat c42b7580, node_mem_map d3a21020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 608 pages used for memmap
[    0.000000]   Normal zone: 77788 pages, LIFO batch:15
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 3fc97c0
[    0.000000] e820: [mem 0x14000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 81146
[    0.000000] Kernel command line: ip=::::vm-lkp-wsx03-openwrt-i386-18::dhcp root=/dev/ram0 user=lkp job=/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-18/trinity-300s-openwrt-i386-2016-03-16.cgz-8d5e72dfdf0fa29a21143fd72746c6f43295ce9f-20171108-5253-ystw19-0.yaml ARCH=i386 kconfig=i386-randconfig-b0-11061302 branch=linus/master commit=8d5e72dfdf0fa29a21143fd72746c6f43295ce9f BOOT_IMAGE=/pkg/linux/i386-randconfig-b0-11061302/gcc-5/8d5e72dfdf0fa29a21143fd72746c6f43295ce9f/vmlinuz-4.11.0-08060-g8d5e72d max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-b0-11061302/gcc-5/8d5e72dfdf0fa29a21143fd72746c6f43295ce9f/0 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,1152
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Memory: 240480K/327144K available (33000K kernel code, 10606K rwdata, 15792K rodata, 1100K init, 19528K bss, 86664K reserved, 0K cma-reserved)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfffa2000 - 0xfffff000   ( 372 kB)
[    0.000000]     vmalloc : 0xd47dc000 - 0xfffa0000   ( 695 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd3fdc000   ( 319 MB)
[    0.000000]       .init : 0xc4a2d000 - 0xc4b40000   (1100 kB)
[    0.000000]       .data : 0xc303a333 - 0xc4a03900   (26405 kB)
[    0.000000]       .text : 0xc1000000 - 0xc303a333   (33000 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] 
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** trace_printk() being used. Allocating extra memory.  **
[    0.000000] **                                                      **
[    0.000000] ** This means that this is a DEBUG kernel and it is     **
[    0.000000] ** unsafe for production use.                           **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your vendor!  **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.004000] Preemptible hierarchical RCU implementation.
[    0.004000] 	RCU kthread priority: 1.
[    0.004000] NR_IRQS:2304 nr_irqs:256 16
[    0.004000] CPU 0 irqstacks, hard=d35d4000 soft=d35d6000
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] console [ttyS0] enabled
[    0.004000] bootconsole [earlyser0] disabled
[    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.004000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.004000] ... MAX_LOCK_DEPTH:          48
[    0.004000] ... MAX_LOCKDEP_KEYS:        8191
[    0.004000] ... CLASSHASH_SIZE:          4096
[    0.004000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.004000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.004000] ... CHAINHASH_SIZE:          32768
[    0.004000]  memory used by lock dependency info: 5151 kB
[    0.004000]  per task-struct memory footprint: 2112 bytes
[    0.004000] ------------------------
[    0.004000] | Locking API testsuite:
[    0.004000] ----------------------------------------------------------------------------
[    0.004000]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.004000]   --------------------------------------------------------------------------
[    0.004000]                      A-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.004000]                  A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.004000]              A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.004000]              A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.004000]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.004000]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.004000]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.004000]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.004000]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.004000]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.004000]   --------------------------------------------------------------------------
[    0.004000]               recursive read-lock:             |  ok  |             |failed|
[    0.004000]            recursive read-lock #2:             |  ok  |             |failed|
[    0.004000]             mixed read-write-lock:             |failed|             |failed|
[    0.004000]             mixed write-read-lock:             |failed|             |failed|
[    0.004000]   --------------------------------------------------------------------------
[    0.004000]      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.004000]      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.004000]      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.004000]      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.004000]        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
[    0.004000]        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
[    0.004000]          hard-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.004000]          soft-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.004000]          hard-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.004000]          soft-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.004000]       hard-irq lock-inversion/123:failed|failed|  ok  |
[    0.004000]       soft-irq lock-inversion/123:failed|failed|  ok  |
[    0.004000]       hard-irq lock-inversion/132:failed|failed|  ok  |
[    0.004000]       soft-irq lock-inversion/132:failed|failed|  ok  |
[    0.004000]       hard-irq lock-inversion/213:failed|failed|  ok  |
[    0.004000]       soft-irq lock-inversion/213:failed|failed|  ok  |
[    0.004000]       hard-irq lock-inversion/231:failed|failed|  ok  |
[    0.004000]       soft-irq lock-inversion/231:failed|failed|  ok  |
[    0.004000]       hard-irq lock-inversion/312:failed|failed|  ok  |
[    0.004000]       soft-irq lock-inversion/312:failed|failed|  ok  |
[    0.004000]       hard-irq lock-inversion/321:failed|failed|  ok  |
[    0.004000]       soft-irq lock-inversion/321:failed|failed|  ok  |
[    0.004000]       hard-irq read-recursion/123:  ok  |
[    0.004000]       soft-irq read-recursion/123:  ok  |
[    0.004000]       hard-irq read-recursion/132:  ok  |
[    0.004000]       soft-irq read-recursion/132:  ok  |
[    0.004000]       hard-irq read-recursion/213:  ok  |
[    0.004000]       soft-irq read-recursion/213:  ok  |
[    0.004000]       hard-irq read-recursion/231:  ok  |
[    0.004000]       soft-irq read-recursion/231:  ok  |
[    0.004000]       hard-irq read-recursion/312:  ok  |
[    0.004000]       soft-irq read-recursion/312:  ok  |
[    0.004000]       hard-irq read-recursion/321:  ok  |
[    0.004000]       soft-irq read-recursion/321:  ok  |
[    0.004000]   --------------------------------------------------------------------------
[    0.004000]   | Wound/wait tests |
[    0.004000]   ---------------------
[    0.004000]                   ww api failures:  ok  |  ok  |  ok  |
[    0.004000]                ww contexts mixing:failed|  ok  |
[    0.004000]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.004000]                locking mismatches:  ok  |  ok  |  ok  |
[    0.004000]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.004000]            spinlock nest unlocked:  ok  |
[    0.004000]   -----------------------------------------------------
[    0.004000]                                  |block | try  |context|
[    0.004000]   -----------------------------------------------------
[    0.004000]                           context:failed|  ok  |  ok  |
[    0.004000]                               try:failed|  ok  |failed|
[    0.004000]                             block:failed|  ok  |failed|
[    0.004000]                          spinlock:failed|  ok  |failed|
[    0.004000] --------------------------------------------------------
[    0.004000] 141 out of 253 testcases failed, as expected. |
[    0.004000] ----------------------------------------------------
[    0.004000] ODEBUG: selftest passed
[    0.004000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.004000] hpet clockevent registered
[    0.004094] tsc: Detected 2260.998 MHz processor
[    0.008087] Calibrating delay loop (skipped) preset value.. 4521.99 BogoMIPS (lpj=9043992)
[    0.012129] pid_max: default: 32768 minimum: 301
[    0.016650] ACPI: Core revision 20170119
[    0.109475] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.114532] Security Framework initialized
[    0.116128] LoadPin: ready to pin (currently disabled)
[    0.120608] AppArmor: AppArmor initialized
[    0.129105] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.132094] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.141848] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.144069] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.148066] CPU: Intel QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
[    0.171245] Performance Events: PMU not available due to virtualization, using software events only.
[    0.185198] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.192545] enabled ExtINT on CPU#0
[    0.206564] ENABLING IO-APIC IRQs
[    0.208192] init IO_APIC IRQs
[    0.212104]  apic 0 pin 0 not connected
[    0.216457] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Active:0 Dest:1)
[    0.220387] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 Active:0 Dest:1)
[    0.224000] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 Active:0 Dest:1)
[    0.224000]  apic 0 pin 16 not connected
[    0.224000]  apic 0 pin 17 not connected
[    0.224000]  apic 0 pin 18 not connected
[    0.224000]  apic 0 pin 19 not connected
[    0.224000]  apic 0 pin 20 not connected
[    0.224000]  apic 0 pin 21 not connected
[    0.224000]  apic 0 pin 22 not connected
[    0.224000]  apic 0 pin 23 not connected
[    0.224000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.224000] Using local APIC timer interrupts.
[    0.224000] calibrating APIC timer ...
[    0.228000] ... lapic delta = 6247606
[    0.228000] ... PM-Timer delta = 357918
[    0.228000] ... PM-Timer result ok
[    0.228000] ..... delta 6247606
[    0.228000] ..... mult: 268332634
[    0.228000] ..... calibration result: 3998467
[    0.228000] ..... CPU clock speed is 2260.3317 MHz.
[    0.228000] ..... host bus clock speed is 999.2467 MHz.
[    0.228394] sched_clock: Marking stable (228000000, 0)->(4075338986, -3847338986)
[    0.243721] devtmpfs: initialized
[    0.270854] evm: security.ima
[    0.276129] evm: security.capability
[    0.302774] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.318807] futex hash table entries: 256 (order: 1, 13312 bytes)
[    0.337412] prandom: seed boundary self test passed
[    0.349695] prandom: 100 self tests passed
[    0.364347] regulator-dummy: Failed to create debugfs directory
[    0.373572] RTC time: 18:32:48, date: 11/08/17
[    0.386276] NET: Registered protocol family 16
[    0.420477] cpuidle: using governor menu
[    0.444700] ACPI: bus type PCI registered
[    0.452028] PCI: Using configuration type 1 for base access
[    1.061341] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    1.079524] test passed
[    1.086496] gpio-f7188x: Not a Fintek device at 0x0000002e
[    1.095662] gpio-f7188x: Not a Fintek device at 0x0000004e
[    1.108995] ACPI: Added _OSI(Module Device)
[    1.116100] ACPI: Added _OSI(Processor Device)
[    1.123321] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.131064] ACPI: Added _OSI(Processor Aggregator Device)
[    1.210146] ACPI: Interpreter enabled
[    1.220972] ACPI: (supports S0 S3 S5)
[    1.231312] ACPI: Using IOAPIC for interrupt routing
[    1.245715] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.420712] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.429374] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    1.437536] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.448036] PCI host bridge to bus 0000:00
[    1.455069] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.467546] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.479632] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.490586] pci_bus 0000:00: root bus resource [mem 0x14000000-0xfebfffff window]
[    1.504373] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.516022] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.532809] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.550480] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.609018] pci 0000:00:01.1: reg 0x20: [io  0xc0c0-0xc0cf]
[    1.636596] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.649510] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.658286] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.667586] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.682986] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.694912] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    1.705501] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    1.720500] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    1.749060] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    1.795939] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    1.889108] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    1.906149] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    1.930219] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.965489] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    2.068647] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    2.088486] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    2.131027] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    2.169543] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    2.265030] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
[    2.331964] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    2.374446] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
[    2.415276] pci 0000:00:05.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    2.494623] pci 0000:00:05.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit pref]
[    2.541949] pci 0000:00:06.0: [8086:25ab] type 00 class 0x088000
[    2.560065] pci 0000:00:06.0: reg 0x10: [mem 0xfebf3000-0xfebf300f]
[    2.629733] pci_bus 0000:00: on NUMA node 0
[    2.652990] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    2.667255] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    2.684668] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    2.701776] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    2.711949] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    2.728699] ACPI: Enabled 2 GPEs in block 00 to 0F
[    2.749534] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    2.763048] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.783642] pci 0000:00:02.0: vgaarb: bridge control possible
[    2.796547] vgaarb: loaded
[    2.816054] SCSI subsystem initialized
[    2.822510] libata version 3.00 loaded.
[    2.830126] ACPI: bus type USB registered
[    2.837026] usbcore: registered new interface driver usbfs
[    2.845024] usbcore: registered new interface driver hub
[    2.853264] usbcore: registered new device driver usb
[    2.863244] pps_core: LinuxPPS API ver. 1 registered
[    2.872308] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.890232] wmi: Mapper loaded
[    2.897366] FPGA manager framework
[    2.904393] Advanced Linux Sound Architecture Driver Initialized.
[    2.913658] PCI: Using ACPI for IRQ routing
[    2.919977] PCI: pci_cache_line_size set to 32 bytes
[    2.928468] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    2.936670] e820: reserve RAM buffer [mem 0x13fdc000-0x13ffffff]
[    2.971115] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    2.981348] clocksource: Switched to clocksource kvm-clock
[    3.073688] Warning: could not register all branches stats
[    3.081638] Warning: could not register annotated branches stats
[    3.875727] VFS: Disk quotas dquot_6.6.0
[    3.882436] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    3.895688] AppArmor: AppArmor Filesystem Enabled
[    3.904370] pnp: PnP ACPI init
[    3.911308] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.921449] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    3.931530] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    3.942514] pnp 00:03: [dma 2]
[    3.948247] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    3.959200] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    3.969675] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.980269] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.996999] pnp: PnP ACPI: found 7 devices
[    4.112834] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.126055] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    4.134426] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    4.142753] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.151823] pci_bus 0000:00: resource 7 [mem 0x14000000-0xfebfffff window]
[    4.163031] NET: Registered protocol family 1
[    4.169578] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    4.177942] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    4.186184] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    4.195116] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    4.207408] PCI: CLS 0 bytes, default 32
[    4.220121] Unpacking initramfs...
[   14.062897] Freeing initrd memory: 3260K
[   14.107616] cryptomgr_test (30) used greatest stack depth: 7408 bytes left
[   14.120942] The force parameter has not been set to 1. The Iris poweroff handler will not be installed.
[   14.135393] spin_lock-torture:--- Start of test [debug]: nwriters_stress=2 nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
[   14.158278] spin_lock-torture: Creating torture_shuffle task
[   14.167128] spin_lock-torture: Creating torture_stutter task
[   14.175327] spin_lock-torture: torture_shuffle task started
[   14.183521] spin_lock-torture: Creating lock_torture_writer task
[   14.191779] spin_lock-torture: torture_stutter task started
[   14.200076] spin_lock-torture: Creating lock_torture_writer task
[   14.208403] spin_lock-torture: lock_torture_writer task started
[   14.217261] spin_lock-torture: Creating lock_torture_stats task
[   14.225394] spin_lock-torture: lock_torture_writer task started
[   14.235624] torture_init_begin: Refusing rcu init: spin_lock running.
[   14.244385] spin_lock-torture: lock_torture_stats task started
[   14.252510] torture_init_begin: One torture test at a time!
[   14.268263] audit: initializing netlink subsys (disabled)
[   14.283196] audit: type=2000 audit(1510137179.017:1): state=initialized audit_enabled=0 res=1
[   14.298079] Key type blacklist registered
[   14.299698] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[   14.300477] zbud: loaded
[   14.325275] ntfs: driver 2.1.32 [Flags: R/O DEBUG].
[   14.326706] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   14.327286] qnx6: QNX6 filesystem 1.0.0 registered.
[   14.327481] fuse init (API version 7.26)
[   14.331079] orangefs_debugfs_init: called with debug mask: :none: :0:
[   14.332334] orangefs_init: module version upstream loaded
[   14.333278] JFS: nTxBlock = 1904, nTxLock = 15233
[   14.460381] NILFS version 2 loaded
[   14.460408] befs: version: 0.9.3
[   14.462125] ocfs2: Registered cluster interface o2cb
[   14.463168] OCFS2 User DLM kernel interface loaded
[   14.492528] cryptomgr_test (45) used greatest stack depth: 7380 bytes left
[   14.495860] cryptomgr_test (49) used greatest stack depth: 7288 bytes left
[   14.507301] cryptomgr_test (61) used greatest stack depth: 7240 bytes left
[   14.596632] NET: Registered protocol family 38
[   14.597500] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   14.597541] io scheduler noop registered
[   14.598053] io scheduler cfq registered (default)
[   14.598058] io scheduler kyber registered
[   14.598062] start plist test
[   14.734415] end plist test
[   14.734422] test_string_helpers: Running tests...
[   14.780856] test_hexdump: all 1184 tests passed
[   14.782062] test_firmware: interface ready
[   14.782089] Running rhashtable test nelem=8, max_size=0, shrinking=0
[   14.782092] Test 00:
[   14.794831]   Adding 50000 keys
[   15.970379]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   16.574956]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   16.586852]   Deleting 50000 keys
[   17.060846]   Duration of test: 2265980220 ns
[   17.079219] Test 01:
[   17.091433]   Adding 50000 keys
[   18.239976]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   18.743915]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   18.756153]   Deleting 50000 keys
[   19.185194]   Duration of test: 2087034228 ns
[   19.194693] Test 02:
[   19.206138]   Adding 50000 keys
[   20.309508]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   20.821431]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   20.838792]   Deleting 50000 keys
[   21.274812]   Duration of test: 2059706580 ns
[   21.284435] Test 03:
[   21.299248]   Adding 50000 keys
[   22.338686]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   22.830175]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[   22.842132]   Deleting 50000 keys
[   23.258607]   Duration of test: 1950946200 ns
[   23.266549] Average test time: 2090916807
[   23.272612] Testing concurrent rhashtable access from 10 threads
[   67.008149] rhashtable_thra (110) used greatest stack depth: 7128 bytes left
[   67.658801] rhashtable_thra (112) used greatest stack depth: 7100 bytes left
[   67.931439] Started 10 threads, 0 failed
[   67.980768] test_uuid: all 18 tests passed
[   68.054684] crc32: CRC_LE_BITS = 1, CRC_BE BITS = 1
[   68.065277] crc32: self tests passed, processed 225944 bytes in 25927534 nsec
[   68.100929] crc32c: CRC_LE_BITS = 1
[   68.107152] crc32c: self tests passed, processed 225944 bytes in 12222411 nsec
[   69.395486] crc32_combine: 8373 self tests passed
[   70.673634] crc32c_combine: 8373 self tests passed
[   70.794994] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   70.821757] no IO addresses supplied
[   70.831325] hgafb: HGA card not detected.
[   70.841819] hgafb: probe of hgafb.0 failed with error -22
[   70.858278] usbcore: registered new interface driver udlfb
[   70.875366] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   70.891140] ACPI: Power Button [PWRF]
[   70.901934] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[   70.913369] ACPI: Power Button [PWRF]
[   70.920995] Warning: Processor Platform Limit event detected, but not handled.
[   70.934109] Consider compiling CPUfreq support into your kernel.
[   71.529983] r3964: Philips r3964 Driver $Revision: 1.10 $
[   71.537755] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   71.608087] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   71.632199] console [ttyS0] disabled
[   71.700171] console [ttyS0] enabled
[   71.765760] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   71.845553] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   71.902311] lp: driver loaded but no devices found
[   71.914830] DoubleTalk PC - not found
[   71.923804] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
[   71.935535] ac.o: No PCI boards found.
[   71.941496] ac.o: For an ISA board you must supply memory and irq parameters.
[   71.951797] sonypi: Sony Programmable I/O Controller Driver v1.26.
[   71.961005] toshiba: not a supported Toshiba laptop
[   71.971573] nsc_gpio initializing
[   71.977440] telclk_interrupt = 0xf non-mcpbl0010 hw.
[   71.984987] Linux agpgart interface v0.103
[   72.003069] drm_mm: Testing DRM range manger (struct drm_mm), with random_seed=0x720306b max_iterations=8192 max_prime=128
[   72.018563] drm_mm: igt_sanitycheck - ok!
[   77.615568] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  139.039991] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  168.768122] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x20974986637, max_idle_ns: 440795286310 ns
[  200.475999] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  261.900413] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  323.328847] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  384.757576] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  446.197650] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  507.622303] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  569.062490] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  630.502798] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  691.919241] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  719.341595] [drm] radeon kernel modesetting enabled.
[  719.350054] [drm] amdgpu kernel modesetting enabled.
[  719.361174] [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
[  719.375728] [drm] Found bochs VGA, ID 0xb0c0.
[  719.382115] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[  719.392542] [TTM] Zone  kernel: Available graphics memory: 121870 kiB
[  719.400970] [TTM] Initializing pool allocator
[  719.409851] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 1
[  719.423689] [TTM] Finalizing pool allocator
[  719.431142] [TTM] Zone  kernel: Used memory at exit: 0 kiB
[  719.445374] [drm] Found bochs VGA, ID 0xb0c0.
[  719.451663] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[  719.462094] [TTM] Zone  kernel: Available graphics memory: 121870 kiB
[  719.470490] [TTM] Initializing pool allocator
[  719.478790] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 1
[  719.496484] parport_pc 00:04: reported by Plug and Play ACPI
[  719.506004] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[  719.626626] lp0: using parport0 (interrupt-driven).
[  719.634269] lp0: console ready
[  719.639721] console [lp0] disabled
[  719.647327] parport_pc 00:04: reported by Plug and Play ACPI
[  719.657277] parport1: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
[  719.779324] lp1: using parport1 (interrupt-driven).
[  719.817988] MM: desc_per_page = 128
[  719.825730] mtip32xx Version 1.3.1
[  719.847122] null: module loaded
[  719.852764] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
[  719.861573] dummy-irq: no IRQ given.  Use irq=N
[  719.869902] Phantom Linux Driver, version n0.9.8, init OK
[  719.880047] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
[  719.892490] c2port c2port0: C2 port uc added
[  719.898941] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 bytes total)
[  719.914586] Guest personality initialized and is inactive
[  719.923146] VMCI host device registered (name=vmci, major=10, minor=60)
[  719.932249] Initialized host personality
[  719.938317] panel: panel driver not yet registered
[  719.958404] usbcore: registered new interface driver dln2
[  719.966606] Loading iSCSI transport class v2.0-870.
[  719.977390] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[  719.988093] SCSI Media Changer driver v0.25 
[  720.004034] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  720.018393] mtdoops: mtd device (mtddev=name/number) must be supplied
[  720.026787] device id = 2440
[  720.031484] device id = 2480
[  720.036055] device id = 24c0
[  720.040684] device id = 24d0
[  720.045223] device id = 25a1
[  720.050183] device id = 2670
[  720.058768] SBC-GXx flash: IO:0x258-0x259 MEM:0xdc000-0xdffff
[  720.073927] slram: not enough parameters.
[  720.082453] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nortel Networks.
[  720.216549] pmc551: not detected
[  720.229320] ftl_cs: FTL header not found.
[  720.247984] parport1: cannot grant exclusive access for device spi-lm70llp
[  720.257679] spi_lm70llp: spi_lm70llp probe fail, status -12
[  720.267433] MACsec IEEE 802.1AE
[  720.292358] libphy: Fixed MDIO Bus: probed
[  720.315293] arcnet: arcnet loaded
[  720.320574] arcnet:rfc1201: RFC1201 "standard" (`a') encapsulation support loaded
[  720.332048] arcnet:com90io: COM90xx IO-mapped mode support (by David Woodhouse et el.)
[  720.343266] arcnet:com90io: E-mail me if you actually test this driver, please!
[  720.353634] (unnamed net_device) (uninitialized): No autoprobe for IO mapped cards; you must specify the base address!
[  720.368343] arcnet:arc_rimi: RIM I (entirely mem-mapped) support
[  720.376344] arcnet:arc_rimi: E-mail me if you actually test the RIM I driver, please!
[  720.387920] arcnet:arc_rimi: Given: node 00h, shmem 0h, irq 0
[  720.395474] arcnet:arc_rimi: No autoprobe for RIM I; you must specify the shmem and irq!
[  720.407421] ena: Elastic Network Adapter (ENA) v1.1.2
[  720.418019] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
[  720.429273] vxge: Copyright(c) 2002-2010 Exar Corp.
[  720.436075] vxge: Driver version: 2.5.3.22640-k
[  720.443434] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[  720.452444] e1000: Copyright (c) 1999-2006 Intel Corporation.
[  723.144761] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[  723.824840] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[  723.835010] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[  730.207068] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[  730.222614] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[  730.238621] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[  730.252170] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[  730.266333] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[  730.281661] igb: Copyright (c) 2007-2014 Intel Corporation.
[  730.295339] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[  730.314040] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[  730.328454] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.0.0-k
[  730.346825] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[  730.358627] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver - version 3.2.2-k
[  730.373010] ixgbevf: Copyright (c) 2009 - 2015 Intel Corporation.
[  730.382054] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 2.1.14-k
[  730.393037] i40e: Copyright (c) 2013 - 2014 Intel Corporation.
[  730.404086] Intel(R) Ethernet Switch Host Interface Driver - version 0.21.7-k
[  730.417266] Copyright(c) 2013 - 2017 Intel Corporation.
[  730.430451] jme: JMicron JMC2XX ethernet driver version 1.0.8
[  730.444322] sky2: driver version 1.30
[  730.462071] pch_gbe: EG20T PCH Gigabit Ethernet Driver - version 1.01
[  730.477308] QLogic 1/10 GbE Converged/Intelligent Ethernet Driver v5.3.65
[  730.492146] QLogic/NetXen Network Driver v4.0.82
[  730.500970] QLogic FastLinQ 4xxxx Core Module qed 8.10.10.21
[  730.511155] atp.c:v1.09=ac 2002/10/01 Donald Becker <becker@scyld.com>
[  730.525111] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
[  730.534348] tehuti: Options: hw_csum 
[  730.541245] tlan: ThunderLAN driver v1.17
[  730.548533] tlan: 0 devices installed, PCI: 0  EISA: 0
[  730.559161] AX.25: Z8530 SCC driver version 3.0.dl1bke
[  730.570766] AX.25: bpqether driver version 004
[  730.577731] baycom_ser_fdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[  730.577731] baycom_ser_fdx: version 0.10
[  730.605567] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA
[  730.614390] hdlcdrv: version 0.8
[  730.620283] baycom_epp: (C) 1998-2000 Thomas Sailer, HB9JNX/AE4WA
[  730.620283] baycom_epp: version 0.7
[  730.647181] PPP generic driver version 2.4.2
[  730.657293] PPP BSD Compression module registered
[  730.664647] PPP Deflate Compression module registered
[  730.672073] PPP MPPE Compression module registered
[  730.679035] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
[  730.690771] usbcore: registered new interface driver ath9k_htc
[  730.699424] usbcore: registered new interface driver ar5523
[  730.708305] usbcore: registered new interface driver usb8xxx
[  730.716022] libertas_sdio: Libertas SDIO driver
[  730.722721] libertas_sdio: Copyright Pierre Ossman
[  730.730206] libertas_spi: Libertas SPI driver
[  730.738053] usbcore: registered new interface driver lbtf_usb
[  730.748320] usbcore: registered new interface driver rt2800usb
[  730.756524] usbcore: registered new interface driver rtl8187
[  730.767287] usbcore: registered new interface driver zd1211rw
[  730.775610] usbcore: registered new interface driver zd1201
[  730.784162] usbcore: registered new interface driver rndis_wlan
[  730.792852] mac80211_hwsim: initializing netlink
[  730.805719] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[  730.821986] ieee80211 phy0: hwaddr 02:00:00:00:00:00 registered
[  730.835337] ieee80211 phy1: Selected rate control algorithm 'minstrel_ht'
[  730.851411] ieee80211 phy1: hwaddr 02:00:00:00:01:00 registered
[  730.863243] usbcore: registered new interface driver i2400m_usb
[  730.871758] usbcore: registered new interface driver catc
[  730.879925] usbcore: registered new interface driver kaweth
[  730.887967] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[  730.899076] usbcore: registered new interface driver pegasus
[  730.907474] usbcore: registered new interface driver r8152
[  730.915471] usbcore: registered new interface driver lan78xx
[  730.923583] usbcore: registered new interface driver asix
[  730.931809] usbcore: registered new interface driver cdc_ether
[  730.940445] usbcore: registered new interface driver cdc_eem
[  730.948905] usbcore: registered new interface driver dm9601
[  730.956908] usbcore: registered new interface driver sr9700
[  730.964910] usbcore: registered new interface driver smsc75xx
[  730.973048] usbcore: registered new interface driver smsc95xx
[  730.981378] usbcore: registered new interface driver gl620a
[  730.989582] usbcore: registered new interface driver net1080
[  730.997553] usbcore: registered new interface driver plusb
[  731.005567] usbcore: registered new interface driver rndis_host
[  731.014167] usbcore: registered new interface driver cdc_subset
[  731.022731] usbcore: registered new interface driver zaurus
[  731.030796] usbcore: registered new interface driver cdc_phonet
[  731.039351] usbcore: registered new interface driver ipheth
[  731.047223] usbcore: registered new interface driver sierra_net
[  731.056007] usbcore: registered new interface driver cx82310_eth
[  731.064601] usbcore: registered new interface driver cdc_ncm
[  731.072693] usbcore: registered new interface driver huawei_cdc_ncm
[  731.081661] usbcore: registered new interface driver qmi_wwan
[  731.090154] usbcore: registered new interface driver cdc_mbim
[  731.097995] Fusion MPT base driver 3.04.20
[  731.104057] Copyright (c) 1999-2008 LSI Corporation
[  731.111128] Fusion MPT FC Host driver 3.04.20
[  731.118289] Fusion MPT SAS Host driver 3.04.20
[  731.134519] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  731.143240] ohci-pci: OHCI PCI platform driver
[  731.150265] ohci-platform: OHCI generic platform driver
[  731.157783] uhci_hcd: USB Universal Host Controller Interface driver
[  731.169268] fotg210_hcd: FOTG210 Host Controller (EHCI) Driver
[  731.177157] Warning! fotg210_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[  731.191100] usbcore: registered new interface driver cdc_acm
[  731.199162] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[  731.212194] usbcore: registered new interface driver usblp
[  731.221259] usbcore: registered new interface driver cdc_wdm
[  731.229693] usbcore: registered new interface driver usbtmc
[  731.237567] usbcore: registered new interface driver uas
[  731.245338] usbcore: registered new interface driver usb-storage
[  731.253724] usbcore: registered new interface driver ums-alauda
[  731.262266] usbcore: registered new interface driver ums-cypress
[  731.270889] usbcore: registered new interface driver ums-datafab
[  731.279538] usbcore: registered new interface driver ums_eneub6250
[  731.288383] usbcore: registered new interface driver ums-freecom
[  731.296772] usbcore: registered new interface driver ums-karma
[  731.305267] usbcore: registered new interface driver ums-onetouch
[  731.313731] usbcore: registered new interface driver ums-sddr09
[  731.324324] usbcore: registered new interface driver ums-sddr55
[  731.333402] usbcore: registered new interface driver mdc800
[  731.341310] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
[  731.354469] usbcore: registered new interface driver microtekX6
[  731.363533] usbcore: registered new interface driver usbserial
[  731.371837] usbcore: registered new interface driver usbserial_generic
[  731.381527] usbserial: USB Serial support registered for generic
[  731.390300] usbcore: registered new interface driver ark3116
[  731.399727] usbserial: USB Serial support registered for ark3116
[  731.408301] usbcore: registered new interface driver cypress_m8
[  731.416567] usbserial: USB Serial support registered for DeLorme Earthmate USB
[  731.428351] usbserial: USB Serial support registered for HID->COM RS232 Adapter
[  731.442664] usbserial: USB Serial support registered for Nokia CA-42 V2 Adapter
[  731.454238] usbcore: registered new interface driver usb_debug
[  731.462409] usbserial: USB Serial support registered for debug
[  731.470774] usbserial: USB Serial support registered for xhci_dbc
[  731.484478] usbcore: registered new interface driver digi_acceleport
[  731.494357] usbserial: USB Serial support registered for Digi 2 port USB adapter
[  731.505594] usbserial: USB Serial support registered for Digi 4 port USB adapter
[  731.516643] usbcore: registered new interface driver io_edgeport
[  731.525721] usbserial: USB Serial support registered for Edgeport 2 port adapter
[  731.542410] usbserial: USB Serial support registered for Edgeport 4 port adapter
[  731.559125] usbserial: USB Serial support registered for Edgeport 8 port adapter
[  731.575954] usbserial: USB Serial support registered for EPiC device
[  731.700759] usbcore: registered new interface driver f81534
[  731.710823] usbserial: USB Serial support registered for Fintek F81532/F81534
[  731.721214] usbcore: registered new interface driver ftdi_sio
[  731.729094] usbserial: USB Serial support registered for FTDI USB Serial Device
[  731.740588] usbcore: registered new interface driver garmin_gps
[  731.753812] usbserial: USB Serial support registered for Garmin GPS usb/tty
[  731.763690] usbcore: registered new interface driver ipaq
[  731.772081] usbserial: USB Serial support registered for PocketPC PDA
[  731.781413] usbcore: registered new interface driver ipw
[  731.789256] usbserial: USB Serial support registered for IPWireless converter
[  731.799144] usbcore: registered new interface driver keyspan
[  731.807758] usbserial: USB Serial support registered for Keyspan - (without firmware)
[  731.819522] usbserial: USB Serial support registered for Keyspan 1 port adapter
[  731.831131] usbserial: USB Serial support registered for Keyspan 2 port adapter
[  731.844361] usbserial: USB Serial support registered for Keyspan 4 port adapter
[  731.856635] usbcore: registered new interface driver keyspan_pda
[  731.865412] usbserial: USB Serial support registered for Keyspan PDA
[  731.874319] usbserial: USB Serial support registered for Keyspan PDA - (prerenumeration)
[  731.887040] usbserial: USB Serial support registered for Xircom / Entrega PGS - (prerenumeration)
[  731.900057] usbcore: registered new interface driver kl5kusb105
[  731.912087] usbserial: USB Serial support registered for KL5KUSB105D / PalmConnect
[  731.925769] usbcore: registered new interface driver kobil_sct
[  731.934676] usbserial: USB Serial support registered for KOBIL USB smart card terminal
[  731.949594] usbcore: registered new interface driver mct_u232
[  731.961431] usbserial: USB Serial support registered for MCT U232
[  731.974495] usbcore: registered new interface driver metro_usb
[  731.987139] usbserial: USB Serial support registered for Metrologic USB to Serial
[  732.002367] usbcore: registered new interface driver mos7720
[  732.010108] usbserial: USB Serial support registered for Moschip 2 port adapter
[  732.020674] usbcore: registered new interface driver mos7840
[  732.028547] usbserial: USB Serial support registered for Moschip 7840/7820 USB Serial Driver
[  732.040471] usbcore: registered new interface driver mxuport
[  732.048259] usbserial: USB Serial support registered for MOXA UPort
[  732.056713] usbcore: registered new interface driver omninet
[  732.064475] usbserial: USB Serial support registered for ZyXEL - omni.net lcd plus usb
[  732.075785] usbcore: registered new interface driver opticon
[  732.083633] usbserial: USB Serial support registered for opticon
[  732.091918] usbcore: registered new interface driver pl2303
[  732.099571] usbserial: USB Serial support registered for pl2303
[  732.107678] usbcore: registered new interface driver safe_serial
[  732.115780] usbserial: USB Serial support registered for safe_serial
[  732.124269] usbcore: registered new interface driver sierra
[  732.131981] usbserial: USB Serial support registered for Sierra USB modem
[  732.141126] usbcore: registered new interface driver spcp8x5
[  732.148841] usbserial: USB Serial support registered for SPCP8x5
[  732.157074] usbcore: registered new interface driver upd78f0730
[  732.165174] usbserial: USB Serial support registered for upd78f0730
[  732.173980] usbcore: registered new interface driver visor
[  732.181529] usbserial: USB Serial support registered for Handspring Visor / Palm OS
[  732.192553] usbserial: USB Serial support registered for Sony Clie 5.0
[  732.201335] usbserial: USB Serial support registered for Sony Clie 3.5
[  732.210082] usbcore: registered new interface driver wishbone_serial
[  732.218479] usbserial: USB Serial support registered for wishbone_serial
[  732.227493] usbcore: registered new interface driver xsens_mt
[  732.235578] usbserial: USB Serial support registered for xsens_mt
[  732.243996] usbcore: registered new interface driver appledisplay
[  732.252265] usbcore: registered new interface driver cypress_cy7c63
[  732.260727] usbcore: registered new interface driver cytherm
[  732.268644] usbcore: registered new interface driver emi62 - firmware loader
[  732.277459] ftdi_elan: driver ftdi-elan
[  732.283390] usbcore: registered new interface driver ftdi-elan
[  732.291599] usbcore: registered new interface driver isight_firmware
[  732.300144] usbcore: registered new interface driver ldusb
[  732.307703] usbcore: registered new interface driver rio500
[  732.315572] usbcore: registered new interface driver usb_ehset_test
[  732.327757] usbcore: registered new interface driver usbsevseg
[  732.335926] usbcore: registered new interface driver yurex
[  732.345035] usbcore: registered new interface driver chaoskey
[  732.355725] usbcore: registered new interface driver sisusb
[  732.363499] usbcore: registered new interface driver lvs
[  732.376276] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
[  732.386992] dummy_hcd dummy_hcd.0: Dummy host controller
[  732.400779] dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
[  732.428390] hub 1-0:1.0: USB hub found
[  732.438075] hub 1-0:1.0: 1 port detected
[  732.452432] hub 1-0:1.0: USB hub found
[  732.463315] hub 1-0:1.0: 1 port detected
[  732.478006] hub 1-0:1.0: USB hub found
[  732.484074] hub 1-0:1.0: 1 port detected
[  732.491664] hub 1-0:1.0: USB hub found
[  732.497415] hub 1-0:1.0: 1 port detected
[  732.505620] dummy_hcd dummy_hcd.0: remove, state 1
[  732.512482] usb usb1: USB disconnect, device number 1
[  732.528849] dummy_hcd dummy_hcd.0: stopped
[  732.534845] dummy_hcd dummy_hcd.0: USB bus 1 deregistered
[  732.544537] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
[  732.555623] dummy_hcd dummy_hcd.0: Dummy host controller
[  732.564176] dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
[  732.580069] hub 1-0:1.0: USB hub found
[  732.586260] hub 1-0:1.0: 1 port detected
[  732.594611] hub 1-0:1.0: USB hub found
[  732.600451] hub 1-0:1.0: 1 port detected
[  732.611567] hub 1-0:1.0: USB hub found
[  732.617299] hub 1-0:1.0: 1 port detected
[  732.624850] hub 1-0:1.0: USB hub found
[  732.630518] hub 1-0:1.0: 1 port detected
[  732.642257] dummy_udc dummy_udc.0: unregistering gadget
[  732.651242] udc dummy_udc.0: releasing 'dummy_udc.0'
[  732.658404]  gadget: usb_udc_nop_release
[  732.669737] CHRDEV "ttyGS" major number 233 goes below the dynamic allocation range
[  732.680437] userial_init: registered 4 ttyGS* devices
[  732.687462] udc dummy_udc.0: registering UDC driver [g_ether]
[  732.695308] using random self ethernet address
[  732.702048] using random host ethernet address
[  732.711089] usb0: HOST MAC 8e:e2:a4:e1:13:28
[  732.717474] usb0: MAC 4e:bd:00:2f:d1:9f
[  732.723277] using random self ethernet address
[  732.729677] using random host ethernet address
[  732.735966] g_ether gadget: adding config #2 'RNDIS'/c422d200
[  732.743743] rndis_register: configNr = 0
[  732.749770] g_ether gadget: adding 'rndis'/cf19e3c0 to config 'RNDIS'/c422d200
[  732.760297] rndis_set_param_medium: 0 0
[  732.765744] g_ether gadget: RNDIS: super speed IN/ep1in-bulk OUT/ep2out-bulk NOTIFY/ep5in-int
[  732.777409] g_ether gadget: cfg 2/c422d200 speeds: super high full
[  732.785608] usb usb1: dummy_bus_suspend
[  732.791244] g_ether gadget:   interface 0 = rndis/cf19e3c0
[  732.798608] hub 1-0:1.0: hub_ext_port_status failed (err = -113)
[  732.798641] hub 1-0:1.0: activate --> -113
[  732.799033] usb usb1: dummy_bus_resume
[  732.821121] g_ether gadget:   interface 1 = rndis/cf19e3c0
[  732.828366] g_ether gadget: adding config #1 'CDC Ethernet (ECM)'/c422d180
[  732.837404] g_ether gadget: adding 'cdc_ethernet'/cf7ab7a0 to config 'CDC Ethernet (ECM)'/c422d180
[  732.849570] g_ether gadget: CDC Ethernet: super speed IN/ep1in-bulk OUT/ep2out-bulk NOTIFY/ep5in-int
[  732.861796] g_ether gadget: cfg 1/c422d180 speeds: super high full
[  732.869939] g_ether gadget:   interface 0 = cdc_ethernet/cf7ab7a0
[  732.878951] g_ether gadget:   interface 1 = cdc_ethernet/cf7ab7a0
[  732.886947] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[  732.895471] g_ether gadget: g_ether ready
[  732.901115] dummy_udc dummy_udc.0: This device can perform faster if you connect it to a super-speed port...
[  732.914025] dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
[  732.922638] dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
[  732.931271] usbip_core: USB/IP Core v1.0.0
[  732.941020] vhci_hcd vhci_hcd: USB/IP Virtual Host Controller
[  732.950415] vhci_hcd vhci_hcd: new USB bus registered, assigned bus number 2
[  732.961985] vhci_hcd: created sysfs vhci_hcd
[  732.973309] hub 2-0:1.0: USB hub found
[  732.979537] hub 2-0:1.0: 8 ports detected
[  732.997161] hub 2-0:1.0: USB hub found
[  733.003056] hub 2-0:1.0: 8 ports detected
[  733.023428] hub 2-0:1.0: USB hub found
[  733.029227] hub 2-0:1.0: 8 ports detected
[  733.045533] hub 2-0:1.0: USB hub found
[  733.051300] hub 2-0:1.0: 8 ports detected
[  733.064329] vhci_hcd vhci_hcd: remove, state 1
[  733.071035] usb usb2: USB disconnect, device number 1
[  733.089638] vhci_hcd: stop threads
[  733.095240] vhci_hcd: release socket
[  733.101307] vhci_hcd: disconnect device
[  733.109014] vhci_hcd: stop threads
[  733.114522] vhci_hcd: release socket
[  733.120582] vhci_hcd: disconnect device
[  733.127110] vhci_hcd: stop threads
[  733.132600] vhci_hcd: release socket
[  733.138693] vhci_hcd: disconnect device
[  733.145106] vhci_hcd: stop threads
[  733.150965] vhci_hcd: release socket
[  733.265764] vhci_hcd: disconnect device
[  733.272560] vhci_hcd: stop threads
[  733.278264] vhci_hcd: release socket
[  733.284237] vhci_hcd: disconnect device
[  733.290302] vhci_hcd: stop threads
[  733.296436] g_ether gadget: resume
[  733.296469] dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
[  733.312023] vhci_hcd: release socket
[  733.317728] vhci_hcd: disconnect device
[  733.324275] vhci_hcd: stop threads
[  733.329846] vhci_hcd: release socket
[  733.335689] vhci_hcd: disconnect device
[  733.341621] vhci_hcd: stop threads
[  733.347654] vhci_hcd: release socket
[  733.353467] vhci_hcd: disconnect device
[  733.359752] vhci_hcd vhci_hcd: USB bus 2 deregistered
[  733.369640] vhci_hcd vhci_hcd: USB/IP Virtual Host Controller
[  733.380177] vhci_hcd vhci_hcd: new USB bus registered, assigned bus number 2
[  733.390484] vhci_hcd: created sysfs vhci_hcd
[  733.397308] usb 1-1: new high-speed USB device number 2 using dummy_hcd
[  733.413933] hub 2-0:1.0: USB hub found
[  733.420450] hub 2-0:1.0: 8 ports detected
[  733.439191] hub 2-0:1.0: USB hub found
[  733.457278] hub 2-0:1.0: 8 ports detected
[  733.479512] hub 2-0:1.0: USB hub found
[  733.485663] hub 2-0:1.0: 8 ports detected
[  733.498917] g_ether gadget: resume
[  733.510132] hub 2-0:1.0: USB hub found
[  733.516401] dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
[  733.526259] hub 2-0:1.0: 8 ports detected
[  733.540549] vhci_hcd: USB/IP 'Virtual' Host Controller (VHCI) Driver v1.0.0
[  733.594769] dummy_udc dummy_udc.0: set_address = 2
[  733.647116] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.662937] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.677776] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.691635] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.700758] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.709254] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.719079] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.727434] hub 2-0:1.0: hub_ext_port_status failed (err = -113)
[  733.735802] hub 2-0:1.0: activate --> -113
[  733.751414] usb 1-1: Dual-Role OTG device on HNP port
[  733.782780] g_ether gadget: HNP inactive
[  733.792312] g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
[  733.806071] g_ether gadget: reset ecm control 0
[  733.816372] g_ether gadget: init ecm ctrl 0
[  733.826630] dummy_udc dummy_udc.0: enabled ep5in-int (ep5in-intr) maxpacket 16 stream disabled
[  733.846008] g_ether gadget: init ecm
[  733.854778] g_ether gadget: notify connect false
[  733.862100] g_ether gadget: notify speed 425984000
[  733.882694] g_ether gadget: activate ecm
[  733.888454] dummy_udc dummy_udc.0: enabled ep1in-bulk (ep1in-bulk) maxpacket 512 stream disabled
[  733.900769] dummy_udc dummy_udc.0: enabled ep2out-bulk (ep2out-bulk) maxpacket 512 stream disabled
[  733.913537] usb0: qlen 10
[  733.917977] g_ether gadget: ecm_close
[  733.930691] g_ether gadget: non-core control req21.43 v000c i0000 l0
[  733.939574] g_ether gadget: packet filter 0c
[  733.945642] g_ether gadget: ecm req21.43 v000c i0000 l0
[  733.962220] cdc_ether 1-1:1.0 usb1: register 'cdc_ether' at usb-dummy_hcd.0-1, CDC Ethernet Device, 8e:e2:a4:e1:13:28
[  733.979070] cdc_ether 1-1:1.0 usb1: unregister 'cdc_ether' usb-dummy_hcd.0-1, CDC Ethernet Device
[  734.006646] g_ether gadget: reset ecm
[  734.013162] usb0: gether_disconnect
[  734.019217] dummy_udc dummy_udc.0: disabled ep1in-bulk
[  734.027419] dummy_udc dummy_udc.0: disabled ep2out-bulk
[  734.035639] g_ether gadget: init ecm
[  734.050613] g_ether gadget: activate ecm
[  734.057283] dummy_udc dummy_udc.0: enabled ep1in-bulk (ep1in-bulk) maxpacket 512 stream disabled
[  734.071029] dummy_udc dummy_udc.0: enabled ep2out-bulk (ep2out-bulk) maxpacket 512 stream disabled
[  734.085417] usb0: qlen 10
[  734.090440] g_ether gadget: ecm_close
[  734.102612] g_ether gadget: non-core control req21.43 v000c i0000 l0
[  734.112394] g_ether gadget: packet filter 0c
[  734.119330] g_ether gadget: ecm req21.43 v000c i0000 l0
[  734.138528] cdc_ether 1-1:1.0 usb1: register 'cdc_ether' at usb-dummy_hcd.0-1, CDC Ethernet Device, 8e:e2:a4:e1:13:28
[  734.167482] cdc_ether 1-1:1.0 usb1: unregister 'cdc_ether' usb-dummy_hcd.0-1, CDC Ethernet Device
[  734.198602] g_ether gadget: HNP inactive
[  734.205377] g_ether gadget: reset config
[  734.212244] g_ether gadget: ecm deactivated
[  734.219018] usb0: gether_disconnect
[  734.224980] dummy_udc dummy_udc.0: disabled ep1in-bulk
[  734.232826] dummy_udc dummy_udc.0: disabled ep2out-bulk
[  734.240759] dummy_udc dummy_udc.0: disabled ep5in-int
[  734.249157] g_ether gadget: high-speed config #0: unconfigured
[  734.266540] g_ether gadget: HNP inactive
[  734.272724] g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
[  734.281442] g_ether gadget: reset ecm control 0
[  734.288414] g_ether gadget: init ecm ctrl 0
[  734.294574] dummy_udc dummy_udc.0: enabled ep5in-int (ep5in-intr) maxpacket 16 stream disabled
[  734.307112] g_ether gadget: init ecm
[  734.312494] g_ether gadget: notify connect false
[  734.319162] g_ether gadget: notify speed 425984000
[  734.334513] g_ether gadget: activate ecm
[  734.340961] dummy_udc dummy_udc.0: enabled ep1in-bulk (ep1in-bulk) maxpacket 512 stream disabled
[  734.353316] dummy_udc dummy_udc.0: enabled ep2out-bulk (ep2out-bulk) maxpacket 512 stream disabled
[  734.365785] usb0: qlen 10
[  734.370387] g_ether gadget: ecm_close
[  734.388277] g_ether gadget: non-core control req21.43 v000c i0000 l0
[  734.397509] g_ether gadget: packet filter 0c
[  734.403698] g_ether gadget: ecm req21.43 v000c i0000 l0
[  734.421652] cdc_ether 1-1:1.0 usb1: register 'cdc_ether' at usb-dummy_hcd.0-1, CDC Ethernet Device, 8e:e2:a4:e1:13:28
[  734.437955] cdc_ether 1-1:1.0 usb1: unregister 'cdc_ether' usb-dummy_hcd.0-1, CDC Ethernet Device
[  734.462480] g_ether gadget: reset ecm
[  734.468928] usb0: gether_disconnect
[  734.474792] dummy_udc dummy_udc.0: disabled ep1in-bulk
[  734.482986] dummy_udc dummy_udc.0: disabled ep2out-bulk
[  734.492678] g_ether gadget: init ecm
[  734.506441] g_ether gadget: activate ecm
[  734.513311] dummy_udc dummy_udc.0: enabled ep1in-bulk (ep1in-bulk) maxpacket 512 stream disabled
[  734.528122] dummy_udc dummy_udc.0: enabled ep2out-bulk (ep2out-bulk) maxpacket 512 stream disabled
[  734.542502] usb0: qlen 10
[  734.547173] g_ether gadget: ecm_close
[  734.562432] g_ether gadget: non-core control req21.43 v000c i0000 l0
[  734.571898] g_ether gadget: packet filter 0c
[  734.578439] g_ether gadget: ecm req21.43 v000c i0000 l0
[  734.597712] cdc_ether 1-1:1.0 usb1: register 'cdc_ether' at usb-dummy_hcd.0-1, CDC Ethernet Device, 8e:e2:a4:e1:13:28
[  734.618002] usbcore: registered new device driver usbip-host
[  734.628176] usbip_host: USB/IP Host Driver v1.0.0
[  734.644026] usbip-vudc usbip-vudc.0: unregistering gadget
[  734.657345] udc usbip-vudc.0: releasing 'usbip-vudc.0'
[  734.668657]  gadget: usb_udc_nop_release
[  734.680953] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[  734.709335] serio: i8042 KBD port at 0x60,0x64 irq 1
[  734.723237] serio: i8042 AUX port at 0x60,0x64 irq 12
[  735.171427] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[  735.184806] usbcore: registered new interface driver appletouch
[  735.185262] usbcore: registered new interface driver bcm5974
[  735.190542] usbcore: registered new interface driver xpad
[  735.192589] i2c /dev entries driver
[  735.203827] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[  735.232289] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[  735.268509] usbcore: registered new interface driver i2c-diolan-u2c
[  735.284615] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[  735.304349] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input6
[  735.308306] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input5
[  735.335168] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input8
[  735.339744] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input7
[  735.378110] i2c-parport: adapter type unspecified
[  735.384587] i2c-parport-light: adapter type unspecified
[  735.393987] usbcore: registered new interface driver RobotFuzz Open Source InterFace, OSIF
[  735.405558] usbcore: registered new interface driver i2c-tiny-usb
[  735.414668] isa i2c-pca-isa.0: Please specify I/O base
[  735.424514] pps_ldisc: PPS line discipline registered
[  735.431258] pps_parport: parallel port PPS client
[  735.437640] parport1: cannot grant exclusive access for device pps_parport
[  735.446285] pps_parport: couldn't register with parport1
[  735.454257] Driver for 1-wire Dallas network protocol.
[  735.462782] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[  735.574533] w83781d: Detection failed at step 2
[  736.218453] applesmc: supported laptop not found!
[  736.225426] applesmc: driver init failed (ret=-19)!
[  737.274298] pc87360: PC8736x not detected, module not inserted
[  737.283274] sch56xx_common: Unsupported device id: 0xff
[  737.290628] sch56xx_common: Unsupported device id: 0xff
[  737.599558] mixcomwd: No card detected, or port not available
[  737.608112] usbcore: registered new interface driver pcwd_usb
[  737.617417] acquirewdt: WDT driver for Acquire single board computer initialising
[  737.629928] acquirewdt: I/O address 0x0043 already in use
[  737.637345] acquirewdt: probe of acquirewdt failed with error -5
[  737.648820] advantechwdt: WDT driver for Advantech single board computer initialising
[  737.662849] advantechwdt: initialized. timeout=60 sec (nowayout=0)
[  737.671343] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[  737.678506] alim7101_wdt: ALi M7101 PMU not present - WDT not set
[  737.686219] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[  737.698823] geodewdt: No timers were available
[  737.706405] wafer5823wdt: WDT driver for Wafer 5823 single board computer initialising
[  737.717490] wafer5823wdt: I/O address 0x0443 already in use
[  737.724974] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[  737.732753] iTCO_vendor_support: vendor-support=0
[  737.739615] it87_wdt: no device
[  737.744806] sc1200wdt: build 20020303
[  737.750404] sc1200wdt: io parameter must be specified
[  737.757480] pc87413_wdt: Version 1.1 at io 0x2E
[  737.763733] pc87413_wdt: cannot register miscdev on minor=130 (err=-16)
[  737.772668] sbc60xxwdt: I/O address 0x0443 already in use
[  737.779898] sbc7240_wdt: I/O address 0x0443 already in use
[  737.787418] cpu5wdt: misc_register failed
[  737.793191] smsc37b787_wdt: SMsC 37B787 watchdog component driver 1.1 initialising...
[  737.805564] smsc37b787_wdt: Unable to register miscdev on minor 130
[  737.814481] w83877f_wdt: I/O address 0x0443 already in use
[  737.821798] machzwd: MachZ ZF-Logic Watchdog driver initializing
[  737.829743] machzwd: no ZF-Logic found
[  737.835183] sbc_epx_c3: cannot register miscdev on minor=130 (err=-16)
[  737.847310] watchdog: Software Watchdog: cannot register miscdev on minor=130 (err=-16).
[  737.858325] watchdog: Software Watchdog: a legacy watchdog module is probably present.
[  737.871773] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
[  737.954666] ISDN subsystem Rev: 1.1.2.3/
[  737.954698] 1.1.2.2/
[  737.960403] none/
[  737.964255] none/
[  737.967627] 1.1.2.2
[  737.971286] 
[  737.978192] Modular ISDN core version 1.1.29
[  737.985739] NET: Registered protocol family 34
[  737.991995] DSP module 2.0
[  737.996373] mISDN_dsp: DSP clocks every 64 samples. This equals 2 jiffies.
[  738.016594] mISDN: Layer-1-over-IP driver Rev. 2.00
[  738.024629] 0 virtual devices registered
[  738.030265] mISDN: HFC-multi driver 2.03
[  738.037327] usbcore: registered new interface driver HFC-S_USB
[  738.045082] AVM Fritz PCI driver Rev. 2.3
[  738.051271] Infineon ISDN Driver Rev. 1.0
[  738.057560] Winbond W6692 PCI driver Rev. 2.0
[  738.063972] Netjet PCI driver Rev. 2.0
[  738.069775] mISDNipac module version 2.0
[  738.075307] HiSax: Linux Driver for passive ISDN cards
[  738.082220] HiSax: Version 3.5 (kernel)
[  738.087623] HiSax: Layer1 Revision 2.46.2.5
[  738.093396] HiSax: Layer2 Revision 2.30.2.4
[  738.099391] HiSax: TeiMgr Revision 2.20.2.3
[  738.105449] HiSax: Layer3 Revision 2.22.2.3
[  738.111408] HiSax: LinkLayer Revision 2.59.2.4
[  738.117730] HiSax: Total 1 card defined
[  738.123726] HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
[  738.130569] HiSax: Traverse Tech. NETspider-U driver Rev. 2.14.2.3
[  738.138438] NETspider-U: No PCI card found
[  738.144372] HiSax: Card NETspider-U not installed !
[  738.151140] HFC-S USB: driver module revision 2.3.2.24 date 2007/10/14 loaded, (debug=0)
[  738.162747] usbcore: registered new interface driver hfc_usb
[  738.170263] HFC-4S/8S: Layer 1 driver module for HFC-4S/8S isdn chips, Revision: 1.10
[  738.181018] HFC-4S/8S: (C) 2003 Cornelius Consult, www.cornelius-consult.de
[  738.190286] HFC-4S/8S: found 0 cards
[  738.195600] hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0
[  738.202670] hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1
[  738.211390] Error: Driver 'fcpci' is already registered, aborting...
[  738.221040] CHRDEV "ttySDIO" major number 232 goes below the dynamic allocation range
[  738.232097] sdhci: Secure Digital Host Controller Interface driver
[  738.240066] sdhci: Copyright(c) Pierre Ossman
[  738.246380] wbsd: Winbond W83L51xD SD/MMC card interface driver
[  738.254157] wbsd: Copyright(c) Pierre Ossman
[  738.261383] usbcore: registered new interface driver ushc
[  738.269522] sdhci-pltfm: SDHCI platform and OF driver helper
[  738.289154] ledtrig-cpu: registered to indicate activity on CPUs
[  738.303481] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[  738.315371] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[  738.326106] cs5535-clockevt: Could not allocate MFGPT timer
[  738.346902] CHRDEV "roccat" major number 231 goes below the dynamic allocation range
[  738.367422] usbcore: registered new interface driver usbhid
[  738.374806] usbhid: USB HID core driver
[  738.383172] NET: Registered protocol family 40
[  738.390846] usbcore: registered new interface driver prism2_usb
[  738.409817] no options.
[  738.415974] input: Speakup as /devices/virtual/input/input9
[  738.426406] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
[  738.435513] speakup 3.1.6: initialized
[  738.441444] synth name on entry is: (null)
[  738.448958] ashmem: initialized
[  738.454305] FPGA DOWNLOAD --->
[  738.459043] FPGA image file name: xlinx_fpga_firmware.bit
[  738.468146] GPIO INIT FAIL!!
[  738.483311] mostcore: init()
[  738.489701] aim_cdev: init()
[  738.494326] CHRDEV "cdev" major number 230 goes below the dynamic allocation range
[  738.505441] mostcore: registered new application interfacing module cdev
[  738.514006] aim_network: most_net_init()
[  738.520031] mostcore: registered new application interfacing module networking
[  738.530526] hdm_usb: hdm_usb_init()
[  738.536556] usbcore: registered new interface driver hdm_usb
[  738.546081] usbcore: registered new interface driver es2_ap_driver
[  738.554382] CHRDEV "gb_fw_mgmt" major number 229 goes below the dynamic allocation range
[  738.565758] CHRDEV "gb_authenticate" major number 228 goes below the dynamic allocation range
[  738.577682] greybus: registered new driver gb-firmware
[  738.585267] greybus: registered new driver hid
[  738.592137] greybus: registered new driver loopback
[  738.599296] greybus: registered new driver power_supply
[  738.606915] greybus: registered new driver gbphy
[  738.613647] gb_gbphy: registered new driver gpio
[  738.620289] gb_gbphy: registered new driver i2c
[  738.626933] gb_gbphy: registered new driver sdio
[  738.633515] gb_gbphy: registered new driver spi
[  738.640034] CHRDEV "ttyGB" major number 227 goes below the dynamic allocation range
[  738.651141] gb_gbphy: registered new driver uart
[  738.657756] gb_gbphy: registered new driver usb
[  738.669971] Software Queue-Pair Transport over NTB, version 4
[  738.692327] CHRDEV "dummy_stm.0" major number 225 goes below the dynamic allocation range
[  738.718781] CHRDEV "dummy_stm.1" major number 224 goes below the dynamic allocation range
[  738.744279] CHRDEV "dummy_stm.2" major number 223 goes below the dynamic allocation range
[  738.770951] CHRDEV "dummy_stm.3" major number 222 goes below the dynamic allocation range
[  738.799761] ASIHPI driver 4.14.03
[  738.820529] usbcore: registered new interface driver snd-ua101
[  738.828921] usbcore: registered new interface driver snd-usb-us122l
[  738.837290] usbcore: registered new interface driver snd-usb-6fire
[  738.845803] usbcore: registered new interface driver snd-usb-hiface
[  738.854360] usbcore: registered new interface driver snd-bcd2000
[  738.862750] usbcore: registered new interface driver snd_usb_pod
[  738.871280] usbcore: registered new interface driver snd_usb_podhd
[  738.880024] usbcore: registered new interface driver snd_usb_toneport
[  738.888709] usbcore: registered new interface driver snd_usb_variax
[  738.896842] oprofile: using NMI interrupt.
[  738.903941] NET: Registered protocol family 26
[  738.910397] NET: Registered protocol family 17
[  738.916967] NET: Registered protocol family 15
[  738.924099] NET: Registered protocol family 5
[  738.954984] NET: Registered protocol family 11
[  738.961722] NET: Registered protocol family 3
[  738.967980] NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team
[  738.980161] DECnet: Routing cache hash table of 256 buckets, 11Kbytes
[  738.989333] NET: Registered protocol family 12
[  738.996075] NET: Registered protocol family 35
[  739.002851] 8021q: 802.1Q VLAN Support v1.8
[  739.009067] lib80211: common routines for IEEE802.11 drivers
[  739.016785] lib80211_crypt: registered algorithm 'NULL'
[  739.024040] 9pnet: Installing 9P2000 support
[  739.031206] Key type dns_resolver registered
[  739.056382] ... APIC ID:      00000000 (0)
[  739.062275] ... APIC VERSION: 01050014
[  739.067729] 0000000000000000000000000000000000000000000000000000000000000000
[  739.078480] 0000000000000000000000000000000000000000000000000000000000000000
[  739.089386] 0000000000000000000000000000000000000000000000000000000000008000
[  739.099266] number of MP IRQ sources: 15.
[  739.105141] number of IO-APIC #0 registers: 24.
[  739.218397] testing the IO APIC.......................
[  739.226105] IO APIC #0......
[  739.231713] .... register #00: 00000000
[  739.238003] .......    : physical APIC id: 00
[  739.244388] .......    : Delivery Type: 0
[  739.250543] .......    : LTS          : 0
[  739.256597] .... register #01: 00170011
[  739.262336] .......     : max redirection entries: 17
[  739.269628] .......     : PRQ implemented: 0
[  739.279482] .......     : IO APIC version: 11
[  739.285835] .... register #02: 00000000
[  739.291570] .......     : arbitration: 00
[  739.297438] .... IRQ redirection table:
[  739.303270] IOAPIC 0:
[  739.307422]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.318633]  pin01, enabled , edge , high, V(31), IRR(0), S(0), logical , D(01), M(1)
[  739.329907]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(1)
[  739.341182]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.355418]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.367635]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.378976]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.390278]  pin07, enabled , edge , high, V(37), IRR(0), S(0), logical , D(01), M(1)
[  739.401334]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.412716]  pin09, enabled , level, high, V(39), IRR(0), S(0), logical , D(01), M(1)
[  739.427684]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.443049]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.454212]  pin0c, enabled , edge , high, V(3C), IRR(0), S(0), logical , D(01), M(1)
[  739.467314]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.478569]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.492132]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.506520]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.520978]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.534170]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.545447]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.556715]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.567907]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.579238]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.590583]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  739.604744] IRQ to pin mappings:
[  739.610355] IRQ0 -> 0:2
[  739.615152] IRQ1 -> 0:1
[  739.619399] IRQ3 -> 0:3
[  739.623774] IRQ4 -> 0:4
[  739.628009] IRQ5 -> 0:5
[  739.632161] IRQ6 -> 0:6
[  739.636564] IRQ7 -> 0:7
[  739.640714] IRQ8 -> 0:8
[  739.645027] IRQ9 -> 0:9
[  739.649175] IRQ10 -> 0:10
[  739.653618] IRQ11 -> 0:11
[  739.658020] IRQ12 -> 0:12
[  739.662366] IRQ13 -> 0:13
[  739.666710] IRQ14 -> 0:14
[  739.671182] IRQ15 -> 0:15
[  739.675640] .................................... done.
[  739.682731] Using IPI Shortcut mode
[  739.693148] page_owner is disabled
[  739.789236] Key type big_key registered
[  739.797270] Key type trusted registered
[  739.805599] Key type encrypted registered
[  739.812737] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[  739.822061] evm: HMAC attrs: 0x0
[  739.832957] RIO: rio_register_scan for mport_id=-1
[  739.841351]   Magic number: 9:20:544
[  739.849938] console [netcon0] enabled
[  739.855609] netconsole: network logging started
[  739.862699] BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
[  739.872981] ALSA device list:
[  739.877936]   No soundcards found.
[  739.894430] Freeing unused kernel memory: 1100K
[  739.909372] Write protecting the kernel text: 33004k
[  739.926643] Write protecting the kernel read-only data: 15796k
[  739.934542] rodata_test: all tests were successful
[  740.471366] init: Console is alive
[  740.478819] init: - watchdog -
[  740.499755] kmodloader (161) used greatest stack depth: 6924 bytes left
[  741.489829] init: - preinit -
[  741.582467] procd (162) used greatest stack depth: 6844 bytes left
[  741.606355] procd: - early -
[  741.612670] procd: - watchdog -
[  742.338911] hotplug-call (172) used greatest stack depth: 6736 bytes left
[  742.531447] hotplug-call (176) used greatest stack depth: 6724 bytes left
[  742.779322] hotplug-call (181) used greatest stack depth: 6592 bytes left
[  744.191113] hotplug-call (210) used greatest stack depth: 6504 bytes left
[  745.314305] hotplug-call (233) used greatest stack depth: 6396 bytes left
[  746.837779] udevtrigger (165) used greatest stack depth: 6376 bytes left
[  747.335700] procd: - ubus -
[  748.346709] random: ubusd: uninitialized urandom read (4 bytes read)
[  748.361622] random: ubusd: uninitialized urandom read (4 bytes read)
[  748.381127] random: ubusd: uninitialized urandom read (4 bytes read)
[  748.398038] random: ubusd: uninitialized urandom read (4 bytes read)
[  748.413205] random: ubusd: uninitialized urandom read (4 bytes read)
[  748.433689] random: ubusd: uninitialized urandom read (4 bytes read)
[  748.453206] random: ubusd: uninitialized urandom read (4 bytes read)
[  748.471023] procd: - init -
Please press Enter to activate this console.
[  753.540379] random: uci: uninitialized urandom read (6 bytes read)
[  754.030470] random: uci: uninitialized urandom read (6 bytes read)
[  754.245351] random: uci: uninitialized urandom read (6 bytes read)
[  757.258323] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[  760.340612] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  760.448681] 8021q: adding VLAN 0 to HW filter on device eth0
[  762.403927] 8021q: adding VLAN 0 to HW filter on device eth0
[  764.380369] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
LKP: HOSTNAME vm-lkp-wsx03-openwrt-i386-18, MAC , kernel 4.11.0-08060-g8d5e72d 1, serial console /dev/ttyS0
[  765.018938] Kernel tests: Boot OK!
[  766.118342] BUG: unable to handle kernel NULL pointer dereference at 00000639
[  766.127471] IP: vlan_device_event+0x7f5/0xa40
[  766.133669] *pde = 00000000 
[  766.133694] 
[  766.141020] Oops: 0000 [#1] PREEMPT
[  766.146171] CPU: 0 PID: 832 Comm: netifd Not tainted 4.11.0-08060-g8d5e72d #1
[  766.154925] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  766.166422] task: d1ac3000 task.stack: d2952000
[  766.172581] EIP: vlan_device_event+0x7f5/0xa40
[  766.178581] EFLAGS: 00010206 CPU: 0
[  766.183537] EAX: 0000018e EBX: 00000002 ECX: 00000000 EDX: 00000001
[  766.191471] ESI: 0000038e EDI: d1f0ed80 EBP: d2953dd8 ESP: d2953da4
[  766.199453]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  766.206997] CR0: 80050033 CR2: 00000639 CR3: 1199e000 CR4: 00000690
[  766.216394] Call Trace:
[  766.220644]  ? dn_dev_delete+0x138/0x1d0
[  766.226253]  ? dn_dev_down+0x69/0x80
[  766.231402]  notifier_call_chain+0x4e/0xa0
[  766.237335]  raw_notifier_call_chain+0xc/0x10
[  766.243331]  call_netdevice_notifiers_info+0x59/0x90
[  766.250689]  __dev_notify_flags+0xea/0x130
[  766.257746]  dev_change_flags+0x60/0x70
[  766.265073]  dev_ifsioc+0x44b/0x570
[  766.271028]  ? mutex_lock_nested+0x14/0x20
[  766.278162]  dev_ioctl+0x399/0xa70
[  766.284317]  ? slow_virt_to_phys+0x3e/0x110
[  766.291227]  sock_ioctl+0x1cd/0x350
[  766.297515]  ? sock_fasync+0xb0/0xb0
[  766.304019]  vfs_ioctl+0x33/0x70
[  766.309894]  do_vfs_ioctl+0x8d/0xc30
[  766.316242]  ? kmem_cache_free+0x186/0x290
[  766.323504]  ? putname+0x9f/0xe0
[  766.330082]  ? putname+0x9f/0xe0
[  766.335780]  ? do_sys_open+0x28d/0x420
[  766.342393]  ? __fget_light+0xb7/0xf0
[  766.348578]  SyS_ioctl+0x98/0xb0
[  766.353281]  do_int80_syscall_32+0x95/0x1b0
[  766.359117]  entry_INT80_32+0x2f/0x2f
[  766.364295] EIP: 0xb7766648
[  766.368512] EFLAGS: 00000246 CPU: 0
[  766.373497] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bfdae180
[  766.381443] ESI: bfdae180 EDI: bfdae1a0 EBP: bfdae1b8 ESP: bfdae14c
[  766.389775]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  766.396967] Code: 8d a4 80 9b c4 8d 56 01 89 14 8d a4 80 9b c4 0f 85 03 02 00 00 89 7d d4 31 f6 8b 7d d8 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00 <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 90 80 9b c4 83 c0 01 85
[  766.420978] EIP: vlan_device_event+0x7f5/0xa40 SS:ESP: 0068:d2953da4
[  766.428984] CR2: 0000000000000639
[  768.045479] ---[ end trace 4eaaf76db348fd80 ]---
[  768.105484] Kernel panic - not syncing: Fatal exception
[  768.112938] Kernel Offset: disabled
[  768.118386] Rebooting in 3 seconds..

Elapsed time: 770

initrds=(
	/osimage/openwrt/openwrt-i386-2016-03-16.cgz
	/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-18/trinity-300s-openwrt-i386-2016-03-16.cgz-8d5e72dfdf0fa29a21143fd72746c6f43295ce9f-20171108-5253-ystw19-0.cgz
	/lkp/lkp/lkp-i386.cgz
	/osimage/pkg/static/trinity-i386.cgz
)

cat "${initrds[@]}" > /fs/sdc1/initrd-vm-lkp-wsx03-openwrt-i386-18

kvm=(
	qemu-system-i386
	-enable-kvm
	-kernel /pkg/linux/i386-randconfig-b0-11061302/gcc-5/8d5e72dfdf0fa29a21143fd72746c6f43295ce9f/vmlinuz-4.11.0-08060-g8d5e72d
	-initrd /fs/sdc1/initrd-vm-lkp-wsx03-openwrt-i386-18
	-m 320
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-drive file=/fs/sdc1/disk0-vm-lkp-wsx03-openwrt-i386-18,media=disk,if=virtio
	-drive file=/fs/sdc1/disk1-vm-lkp-wsx03-openwrt-i386-18,media=disk,if=virtio
	-pidfile /dev/shm/kboot/pid-vm-lkp-wsx03-openwrt-i386-18
	-serial file:/dev/shm/kboot/vm-lkp-wsx03-openwrt-i386-18/serial
	-serial file:/dev/shm/kboot/vm-lkp-wsx03-openwrt-i386-18/kmsg
	-daemonize
	-display none
	-monitor null
)

append=(
	ip=::::vm-lkp-wsx03-openwrt-i386-18::dhcp
	root=/dev/ram0
	user=lkp
	job=/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-18/trinity-300s-openwrt-i386-2016-03-16.cgz-8d5e72dfdf0fa29a21143fd72746c6f43295ce9f-20171108-5253-ystw19-0.yaml
	ARCH=i386
	kconfig=i386-randconfig-b0-11061302
	branch=linus/master
	commit=8d5e72dfdf0fa29a21143fd72746c6f43295ce9f
	BOOT_IMAGE=/pkg/linux/i386-randconfig-b0-11061302/gcc-5/8d5e72dfdf0fa29a21143fd72746c6f43295ce9f/vmlinuz-4.11.0-08060-g8d5e72d
	max_uptime=1500
	RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-b0-11061302/gcc-5/8d5e72dfdf0fa29a21143fd72746c6f43295ce9f/0
	LKP_SERVER=inn
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"
