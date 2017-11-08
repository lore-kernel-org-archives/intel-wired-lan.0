From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 8 Nov 2017 10:36:18 -0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
Message-ID: <CAKgT0UfSTwTsQFP9ir=aOJDz-BvYONBd3Q6SOJWQherkQ8XpFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 8, 2017 at 9:12 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> Hi Linus,
>
>
> On Wed, Nov 08, 2017 at 08:20:38AM -0800, Linus Torvalds wrote:
>>
>> On Wed, Nov 8, 2017 at 1:48 AM, Fengguang Wu <fengguang.wu@intel.com>
>> wrote:
>>>
>>>
>>> Now I got the faddr2line output. :)
>>
>>
>> Thank you, but this also shows that you then compress the output too
>> much for convenience.
>>
>>> [  745.719623] BUG: unable to handle kernel paging request at 6b6b6f4f
>>> [  745.732871] IP: vlan_device_event at net/8021q/vlan.h:60
>>
>>
>> So this looks more legible than "vlan_device_event+0x7f5/0xa40" (or
>> whatever), but in fact it's not.
>>
>> The reason faddr2line is great is because it gives inlining
>> information, so that you can see exactly which access it is, even if
>> it's inside some helper inline function (macros still obviously are
>> going to be problematic).
>>
>> And you've cut the whole information down, to the point where there is
>> _less_ information than there used to be.
>>
>> So the full faddr2line output is actually important, and should look
>> something like this:
>>
>>    __schedule+0x315/0x840:
>>    rq_sched_info_arrive at kernel/sched/stats.h:13
>>     (inlined by) sched_info_arrive at kernel/sched/stats.h:99
>>     (inlined by) __sched_info_switch at kernel/sched/stats.h:151
>>     (inlined by) sched_info_switch at kernel/sched/stats.h:158
>>     (inlined by) prepare_task_switch at kernel/sched/core.c:2582
>>     (inlined by) context_switch at kernel/sched/core.c:2755
>>     (inlined by) __schedule at kernel/sched/core.c:3366
>>
>> which is admittedly a fairly extreme case, but it shows how involved
>> things can be.
>
>
> Indeed! I wasn't aware that faddr2line could have so informative
> output! After checking several of its outputs, I decided to pipe its
> output to |tail -1 :/  That's clearly due to my lacking of first hand
> experience on oops analyzing!
>
> IMHO this kind of informative demo in your email could be very good
> candidates to put in Documentation/. If you search faddr2line under
> Documentation there's no single mention of it (addr2line does show up
> 7 times).
>
>
>> Note how in my example above the access itself is from a header file
>> (that inlined rq_sched_info_arrive() function), and I happened to pick
>> the
>>
>>                rq->rq_sched_info.pcount++;
>>
>> line. But Many inline functions are inlined from different points,
>> often many times in the same top-level function (think of the atomic
>> helper inlines, for example).
>>
>> In your case, that net/8021q/vlan.h:60 information is literally not
>> helping, because it only shows what I could already figure out from
>> looking at the constants in the disassembly: the code comes from the
>>
>>        vlan_group_for_each_dev(...) {
>>                ..
>>
>> loop setup (it's the inline __vlan_group_get_device() function, and
>> the constants I could recognize are the VLAN_GROUP_ARRAY_PART_LEN
>> things.
>>
>> But exactly like the constants didn't tell me *which* invocation of
>> that loop it was, your "net/8021q/vlan.h:60" doesn't tell me which one
>> it is.
>>
>> There's at least _eight_ different "vlan_group_for_each_dev() {" loops
>> in vlan_device_event(), and maybe it's not all that meaningful which
>> of the eight it is in this case, in other cases it's critical.
>>
>> And since you've actually replaced the "vlan_device_event+0x7f5/0xa40"
>> with that "net/8021q/vlan.h:60" entirely, all the offset information
>> that *could* maybe have been used to pick one case over another (but
>> likely not) is also gone.
>>
>> That's why that inlining chain is important - so that we can see how
>> it got to that access in __vlan_group_get_device().
>>
>> So please do keep _all_ of the faddr2line output, at least for the
>> "IP:" line (the stack traces might not be worth it).
>
>
> OK. Here is the original faddr2line output:
>
> $ ~/linux/scripts/faddr2line vmlinux vlan_device_event+0x7f5/0xa40
> vlan_device_event+0x7f5/0xa40:
> vlan_device_event at net/8021q/vlan.h:60
>
> And below is call trace embedded with full faddr2line output.
>
> I notice that this trace shows no additional inline files at all.
> Is it because I did some kconfig option wrong, so that inline info is
> lost? Eg.
>
> CONFIG_OPTIMIZE_INLINING=y (reading lib/Kconfig.debug, it looks better set
> to N)
> CONFIG_DEBUG_INFO_REDUCED=y
> CONFIG_DEBUG_INFO_SPLIT=y
> (full .config attached)
>
> [  745.719623] BUG: unable to handle kernel paging request at 6b6b6f4f
> [  745.732871] IP: vlan_device_event+0x7f5/0xa40:
> vlan_device_event at net/8021q/vlan.h:60
> [  745.742106] *pde = 00000000
> [  745.748587] Oops: 0000 [#1] PREEMPT
> [  745.756104] CPU: 0 PID: 786 Comm: netifd Not tainted 4.14.0-rc8 #1
> [  745.769171] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.10.2-1 04/01/2014
> [  745.786791] task: cf768780 task.stack: d187a000
> [  745.796485] EIP: vlan_device_event+0x7f5/0xa40:
> vlan_device_event at net/8021q/vlan.h:60
> [  745.805877] EFLAGS: 00010206 CPU: 0
> [  745.813237] EAX: 000000f9 EBX: 00000002 ECX: 00000000 EDX: 6b6b6b6b
> [  745.825774] ESI: 000002f9 EDI: d1de3700 EBP: d187bdd8 ESP: d187bda4
> [  745.838871]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
> [  745.850218] CR0: 80050033 CR2: 6b6b6f4f CR3: 0f4c8000 CR4: 00000690
> [  745.862750] Call Trace:
> [  745.868650]  ? dn_dev_delete+0x138/0x1d0:
> dn_dev_delete at net/decnet/dn_dev.c:1224
> [  745.876751]  ? dn_dev_down+0x69/0x80:
> dn_dev_down at net/decnet/dn_dev.c:1240
> [  745.885084]  notifier_call_chain+0x4e/0xa0:
> notifier_call_chain at kernel/notifier.c:95 (discriminator 1)
> [  745.894254]  raw_notifier_call_chain+0xc/0x10:
> raw_notifier_call_chain at kernel/notifier.c:402
> [  745.903979]  call_netdevice_notifiers_info+0x59/0x90:
> call_netdevice_notifiers_info at net/core/dev.c:1672
> [  745.914670]  __dev_notify_flags+0xea/0x130:
> __dev_notify_flags at net/core/dev.c:1687
> [  745.923446]  dev_change_flags+0x60/0x70:
> dev_change_flags at net/core/dev.c:6813
> [  745.931679]  dev_ifsioc+0x49b/0x610:
> dev_ifsioc at net/core/dev_ioctl.c:257
> [  745.939102]  ? mutex_lock_nested+0x14/0x20:
> mutex_lock_nested at kernel/locking/mutex.c:909
> [  745.948173]  dev_ioctl+0x36f/0xb20:
> dev_ioctl at net/core/dev_ioctl.c:566
> [  745.956154]  sock_ioctl+0x1cd/0x350:
> sock_ioctl at net/socket.c:968
> [  745.964313]  ? sock_fasync+0xb0/0xb0:
> sock_ioctl at net/socket.c:984
> [  745.972512]  vfs_ioctl+0x33/0x70:
> vfs_ioctl at fs/ioctl.c:47
> [  745.979867]  do_vfs_ioctl+0x8d/0xc60:
> do_vfs_ioctl at fs/ioctl.c:690
> [  745.987782]  ? kmem_cache_free+0x186/0x290:
> kmem_cache_free at include/linux/rcupdate.h:777
> [  745.996138]  ? putname+0x9f/0xe0:
> putname at fs/namei.c:259
> [  746.003434]  ? putname+0x9f/0xe0:
> putname at fs/namei.c:259
> [  746.011240]  ? do_sys_open+0x28d/0x420:
> do_sys_open at fs/open.c:1069
> [  746.019728]  ? __fget_light+0xb7/0xf0:
> __fget_light at fs/file.c:739 (discriminator 2)
> bad symbol size: base: 0xc1277040 end: 0xc1277040
> [  746.029292]  SyS_ioctl+0x98/0xb0
> [  746.036680]  do_int80_syscall_32+0x95/0x290:
> do_int80_syscall_32 at arch/x86/entry/common.c:329
> [  746.045685]  entry_INT80_32+0x2f/0x2f:
> restore_all at arch/x86/entry/entry_32.S:536
> [  746.053427] EIP: 0xb7e97648
> [  746.059907] EFLAGS: 00000246 CPU: 0
> [  746.068336] EAX: ffffffda EBX: 00000005 ECX: 00008914 EDX: bfcaa350
> [  746.081238] ESI: bfcaa350 EDI: bfcaa370 EBP: bfcaa388 ESP: bfcaa31c
> [  746.093449]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
> [  746.103600] Code: 8d e0 db b4 c4 8d 56 01 89 14 8d e0 db b4 c4 0f 85 03
> 02 00 00 89 7d d4 31 f6 8b 7d d8 e9 84 00 00 00 8d 74 26 00 25 ff 01 00 00
> <8b> 1c 82 31 d2 85 db 0f 95 c2 8b 04 95 cc db b4 c4 83 c0 01 85
> [  746.140089] EIP: vlan_device_event+0x7f5/0xa40:
> vlan_device_event at net/8021q/vlan.h:60 SS:ESP: 0068:d187bda4
> [  746.153505] CR2: 000000006b6b6f4f
> [  746.413297] Kernel tests: Boot OK!
> [  748.237463] ---[ end trace 40505af7d815b57d ]---
> [  748.281157] Kernel panic - not syncing: Fatal exception
>
>> Anyway, it does all mean that the use-after-free almost certainly is
>> that "array[]" access, which was the main suspect to begin with.
>>
>> I'm adding Jeff Kirsher and the e1000 list to the cc, since apparently
>> the e1000 driver is involved. Of course, all the stack traces are in
>> generic networking code, so it is possibly a generic networking issue,
>> but it would probably be good to have a few people look at it.
>>
>> But all of this code is ancient. So it's almost certainly not a new
>> bug, whatever it is.
>>
>> But as a test-case for your faddr2line improvements, this is excellent!
>>
>>                   Linus
>>
>
> Regards,
> Fengguang

So looking over the trace the panic seems to be happening after a
decnet interface is getting deleted. Is there any chance we could try
compiling the kernel without decnet support to see if that is the
source of these issues? I don't know if anyone on the Intel Wired Lan
team is testing with that enabled so if we can eliminate that as a
possible cause that would be useful.

- Alex
