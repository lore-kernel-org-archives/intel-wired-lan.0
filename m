From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Nov 2017 08:20:38 -0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
Message-ID: <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 8, 2017 at 1:48 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>
> Now I got the faddr2line output. :)

Thank you, but this also shows that you then compress the output too
much for convenience.

> [  745.719623] BUG: unable to handle kernel paging request at 6b6b6f4f
> [  745.732871] IP: vlan_device_event at net/8021q/vlan.h:60

So this looks more legible than "vlan_device_event+0x7f5/0xa40" (or
whatever), but in fact it's not.

The reason faddr2line is great is because it gives inlining
information, so that you can see exactly which access it is, even if
it's inside some helper inline function (macros still obviously are
going to be problematic).

And you've cut the whole information down, to the point where there is
_less_ information than there used to be.

So the full faddr2line output is actually important, and should look
something like this:

    __schedule+0x315/0x840:
    rq_sched_info_arrive at kernel/sched/stats.h:13
     (inlined by) sched_info_arrive at kernel/sched/stats.h:99
     (inlined by) __sched_info_switch at kernel/sched/stats.h:151
     (inlined by) sched_info_switch at kernel/sched/stats.h:158
     (inlined by) prepare_task_switch at kernel/sched/core.c:2582
     (inlined by) context_switch at kernel/sched/core.c:2755
     (inlined by) __schedule at kernel/sched/core.c:3366

which is admittedly a fairly extreme case, but it shows how involved
things can be.

Note how in my example above the access itself is from a header file
(that inlined rq_sched_info_arrive() function), and I happened to pick
the

                rq->rq_sched_info.pcount++;

line. But Many inline functions are inlined from different points,
often many times in the same top-level function (think of the atomic
helper inlines, for example).

In your case, that net/8021q/vlan.h:60 information is literally not
helping, because it only shows what I could already figure out from
looking at the constants in the disassembly: the code comes from the

        vlan_group_for_each_dev(...) {
                ..

loop setup (it's the inline __vlan_group_get_device() function, and
the constants I could recognize are the VLAN_GROUP_ARRAY_PART_LEN
things.

But exactly like the constants didn't tell me *which* invocation of
that loop it was, your "net/8021q/vlan.h:60" doesn't tell me which one
it is.

There's at least _eight_ different "vlan_group_for_each_dev() {" loops
in vlan_device_event(), and maybe it's not all that meaningful which
of the eight it is in this case, in other cases it's critical.

And since you've actually replaced the "vlan_device_event+0x7f5/0xa40"
with that "net/8021q/vlan.h:60" entirely, all the offset information
that *could* maybe have been used to pick one case over another (but
likely not) is also gone.

That's why that inlining chain is important - so that we can see how
it got to that access in __vlan_group_get_device().

So please do keep _all_ of the faddr2line output, at least for the
"IP:" line (the stack traces might not be worth it).

Anyway, it does all mean that the use-after-free almost certainly is
that "array[]" access, which was the main suspect to begin with.

I'm adding Jeff Kirsher and the e1000 list to the cc, since apparently
the e1000 driver is involved. Of course, all the stack traces are in
generic networking code, so it is possibly a generic networking issue,
but it would probably be good to have a few people look at it.

But all of this code is ancient. So it's almost certainly not a new
bug, whatever it is.

But as a test-case for your faddr2line improvements, this is excellent!

                   Linus
