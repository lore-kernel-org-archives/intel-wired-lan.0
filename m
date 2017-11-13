From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Nov 2017 11:14:42 -0800
Subject: [Intel-wired-lan] CONFIG_DEBUG_INFO_SPLIT impacts on faddr2line
In-Reply-To: <20171113185227.GM8522@tassilo.jf.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
 <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
 <20171113185227.GM8522@tassilo.jf.intel.com>
Message-ID: <CA+55aFzbQBPOwah9gQPHR9WL+zZBOXnHsP6GKmC=QE7qOn+psw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 13, 2017 at 10:52 AM, Andi Kleen <ak@linux.intel.com> wrote:
>
> It works for me.

No it clearly does not.

> % ./linux/scripts/faddr2line obj/vmlinux schedule+10
> schedule+10/0x80:
> schedule at arch/x86/include/asm/current.h:15

That's obviously garbage and the problem.

Just look at it. It claims it is in "schedule()", at line 15 in the
file arch/x86/include/asm/current.h.

It's bullshit, and it's almost entirely useless, because while you see
which line it was, you have no idea how it got there, which can be a
big problem particularly with the trivial inlines. _Which_ of the
different invocations of some atomic update was it?

The _real_ output is supposed to be like this:

   [torvalds at i7 linux]$ ./scripts/faddr2line vmlinux __schedule+0x314
   __schedule+0x314/0x840:
   rq_sched_info_arrive at kernel/sched/stats.h:12
    (inlined by) sched_info_arrive at kernel/sched/stats.h:99
    (inlined by) __sched_info_switch at kernel/sched/stats.h:151
    (inlined by) sched_info_switch at kernel/sched/stats.h:158
    (inlined by) prepare_task_switch at kernel/sched/core.c:2582
    (inlined by) context_switch at kernel/sched/core.c:2755
    (inlined by) __schedule at kernel/sched/core.c:3366

See how now it knows that __schedule is in kernel/sched/core.c, and
how it has inlined things and just how it ended up in that header file
and which inline function it was.

So your addr2line is equally broken, and doesn't give the right information.

Put another way: the CONFIG_DEBUG_INFO_SPLIT option is useless. Yes,
it saves time and disk space, but does so at the expense of making all
the debug information unavailable to basic tools.

             Linus
