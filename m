From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 13 Nov 2017 10:05:27 +0800
Subject: [Intel-wired-lan] CONFIG_DEBUG_INFO_SPLIT impacts on faddr2line
In-Reply-To: <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
 <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
Message-ID: <1510538727.2418.41.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2017-11-13 at 09:13 +0800, Fengguang Wu wrote:
> CC Andi and more DEBUG_INFO_SPLIT people.
> 
> On Sun, Nov 12, 2017 at 11:31:56AM -0800, Linus Torvalds wrote:
> > 
> > On Wed, Nov 8, 2017 at 9:12 AM, Fengguang Wu <fengguang.wu@intel.co
> > m> wrote:
> > > 
> > > 
> > > OK. Here is the original faddr2line output:
> > > 
> > > $ ~/linux/scripts/faddr2line vmlinux
> > > vlan_device_event+0x7f5/0xa40
> > > vlan_device_event+0x7f5/0xa40:
> > > vlan_device_event at net/8021q/vlan.h:60
> > > 
> > > And below is call trace embedded with full faddr2line output.
> > > 
> > > I notice that this trace shows no additional inline files at all.
> > > Is it because I did some kconfig option wrong, so that inline
> > > info is
> > > lost? Eg.
> > > 
> > > CONFIG_OPTIMIZE_INLINING=y (it looks better set to N)
> > > CONFIG_DEBUG_INFO_REDUCED=y
> > > CONFIG_DEBUG_INFO_SPLIT=y
> > Ok, this annoyed me, so I went back and looked.
> > 
> > It's the "CONFIG_DEBUG_INFO_SPLIT" thing that makes faddr2line
> > unable
> > to see the inlining information,
> > 
> > Using OPTIMIZE_INLINING is fine.
> Good to know that!
> 
> > 
> > I'm not sure that addr2line could be made to understand the .dwo
> > files
> > that DEBUG_INFO_SPLIT causes (particularly since we munge the
> > vmlinux
> > file itself, who knows how that could confuse things).
> > 
> > So can I ask that you make the 0day build scripts always use
> > 
> > ?CONFIG_DEBUG_INFO=y
> > ?CONFIG_DEBUG_INFO_REDUCED=y
> > ?# CONFIG_DEBUG_INFO_SPLIT is not set
> > 
> > because with that "DEBUG_INFO_REDUCED=y", the use of
> > DEBUG_INFO_SPLIT
> > shouldn't be _that_ big of a deal.
> > 
> > Yes, splitting the debug info does help reduce disk usage for the
> > build, and presumably speed it up a bit too due to less IO and
> > reduced
> > copying of the debug info data, but right now it really makes the
> > debug info much less useful.
> Yes DEBUG_INFO_SPLIT helps reduce build cost. Equally importantly,
> it helps cut down the *.ko sizes, which saves boot test cost, too.
> Since in our test scheme, the below modules.cgz will be loaded as
> part
> of initrd on boot testing. Which will cost memory, and to the lesser
> degree, IO and uncompressing time.
> 
> Here is the diff of the modules.cgz size:
> 
> Big files under /pkg/linux/x86_64-rhel-
> 7.2+CONFIG_DEBUG_INFO_REDUCED/gcc-6/v4.14-rc7/,
> comparing to +CONFIG_DEBUG_INFO_SPLIT:
> 
> =>????54M??135M??modules.cgz
> ?????7.3M??7.3M??vmlinuz-4.14.0-rc7
> ?????1.2M??1.2M??linux-headers.cgz
> ?????7.6M??7.7M??linux-selftests.cgz
> ??????31M???31M??linux-perf.cgz
> 
> Nevertheless, that's machine cost. If DEBUG_INFO_SPLIT hurts our
> ability to analyze bugs, I think the forthright way would be to
> disable it in our tests.
> 
> > 
> > Just to see the difference:
> > 
> > - with DEBUG_INFO_SPLIT=y
> > 
> > ???[torvalds at i7 linux]$ ./scripts/faddr2line vmlinux
> > __schedule+0x314
> > ???__schedule+0x314/0x840:
> > ???__schedule at kernel/sched/stats.h:12
> > 
> > - with DEBUG_INFO_SPLIT is not set
> > 
> > ???[torvalds at i7 linux]$ ./scripts/faddr2line vmlinux
> > __schedule+0x314
> > ???__schedule+0x314/0x840:
> > ???rq_sched_info_arrive at kernel/sched/stats.h:12
> > ????(inlined by) sched_info_arrive at kernel/sched/stats.h:99
> > ????(inlined by) __sched_info_switch at kernel/sched/stats.h:151
> > ????(inlined by) sched_info_switch at kernel/sched/stats.h:158
> > ????(inlined by) prepare_task_switch at kernel/sched/core.c:2582
> > ????(inlined by) context_switch at kernel/sched/core.c:2755
> > ????(inlined by) __schedule at kernel/sched/core.c:3366
> > 
> > and while (once again) this is a pretty extreme case, we do use a
> > lot
> > of inlines, and gcc will add its own inlining. Getting this whole
> > information - particularly for the faulting IP - would really help
> > in
> > some situations.
> > 
> > I love what the 0day robot is doing, this would be another big step
> > forward.
> Thank you for the helpful information and appreciations!
> I'll make the change to disable DEBUG_INFO_SPLIT.
> 
> > 
> > Oh - and talking about "big step forward" - does the 0day robot do
> > any
> > suspend/resume testing at all?
> Yes, we do. CC Rui and Aaron on power testing.
> 
yes, we have added suspend/resume test in 0day, including both
functionality and suspend/resume performance. It is not widely run
because most of the 0Day testboxes are servers/desktops, now we've just
added some client laptops as testboxes, and will add more in the near
future. :)
> > 
> > Even on non-laptop hardware, it should be possible to do something
> > like
> > 
> > ???echo platform > /sys/power/pm_test
> > ???echo freeze > /sys/power/state
> > 
> > or similar (assuming CONFIG_PM_DEBUG is enabled).
> > 

yes.

I will run native suspend/resume test on laptops and other test boxes
that really support it, and run suspend/resume test in pm_test modes on
the others to help us find more issues.

thanks,
rui
> > Maybe you already do something like this?
> Rui/Aaron have better knowledge on the current status. It does look
> an
> error-prone area that's worth more testing efforts.
> 
> > 
> > Anyway, regardless this was a good release for the 0day robot.
> > Thanks.
> My (and our) pleasure. I'd like to thank you and all the people who
> take time to analyze/fix the bugs. It's great to see the long
> standing
> bugs being fixed in mainline -- they have been a big source of noises
> that hurt our auto bisect&reporting capabilities.
> 
> Regards,
> Fengguang
