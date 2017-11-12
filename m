From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 Nov 2017 11:31:56 -0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
Message-ID: <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 8, 2017 at 9:12 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
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
> CONFIG_OPTIMIZE_INLINING=y (it looks better set to N)
> CONFIG_DEBUG_INFO_REDUCED=y
> CONFIG_DEBUG_INFO_SPLIT=y

Ok, this annoyed me, so I went back and looked.

It's the "CONFIG_DEBUG_INFO_SPLIT" thing that makes faddr2line unable
to see the inlining information,

Using OPTIMIZE_INLINING is fine.

I'm not sure that addr2line could be made to understand the .dwo files
that DEBUG_INFO_SPLIT causes (particularly since we munge the vmlinux
file itself, who knows how that could confuse things).

So can I ask that you make the 0day build scripts always use

  CONFIG_DEBUG_INFO=y
  CONFIG_DEBUG_INFO_REDUCED=y
  # CONFIG_DEBUG_INFO_SPLIT is not set

because with that "DEBUG_INFO_REDUCED=y", the use of DEBUG_INFO_SPLIT
shouldn't be _that_ big of a deal.

Yes, splitting the debug info does help reduce disk usage for the
build, and presumably speed it up a bit too due to less IO and reduced
copying of the debug info data, but right now it really makes the
debug info much less useful.

Just to see the difference:

 - with DEBUG_INFO_SPLIT=y

    [torvalds at i7 linux]$ ./scripts/faddr2line vmlinux __schedule+0x314
    __schedule+0x314/0x840:
    __schedule at kernel/sched/stats.h:12

 - with DEBUG_INFO_SPLIT is not set

    [torvalds at i7 linux]$ ./scripts/faddr2line vmlinux __schedule+0x314
    __schedule+0x314/0x840:
    rq_sched_info_arrive at kernel/sched/stats.h:12
     (inlined by) sched_info_arrive at kernel/sched/stats.h:99
     (inlined by) __sched_info_switch at kernel/sched/stats.h:151
     (inlined by) sched_info_switch at kernel/sched/stats.h:158
     (inlined by) prepare_task_switch at kernel/sched/core.c:2582
     (inlined by) context_switch at kernel/sched/core.c:2755
     (inlined by) __schedule at kernel/sched/core.c:3366

and while (once again) this is a pretty extreme case, we do use a lot
of inlines, and gcc will add its own inlining. Getting this whole
information - particularly for the faulting IP - would really help in
some situations.

I love what the 0day robot is doing, this would be another big step forward.

Oh - and talking about "big step forward" - does the 0day robot do any
suspend/resume testing at all?

Even on non-laptop hardware, it should be possible to do something like

    echo platform > /sys/power/pm_test
    echo freeze > /sys/power/state

or similar (assuming CONFIG_PM_DEBUG is enabled).

Maybe you already do something like this?

Anyway, regardless this was a good release for the 0day robot. Thanks.

                     Linus
