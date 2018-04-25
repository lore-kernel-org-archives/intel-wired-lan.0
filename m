From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 25 Apr 2018 19:59:10 +0000
Subject: [Intel-wired-lan] e1000e I219 timestamping oops related to
 TSYNCRXCTL read
In-Reply-To: <20180425065243.g5mqewg5irkwgwgv@f2>
References: <20180425065243.g5mqewg5irkwgwgv@f2>
Message-ID: <02874ECE860811409154E81DA85FBB5882D918F3@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Benjamin,

> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Benjamin Poirier
> Sent: Tuesday, April 24, 2018 11:53 PM
> To: Allan, Bruce W <bruce.w.allan@intel.com>; Yanir Lubetkin
> <yanirx.lubetkin@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Neftin,
> Sasha <sasha.neftin@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Achim Mildenberger <admin@fph.physik.uni-
> karlsruhe.de>; olouvignes at gmail.com; jayanth at goubiq.com;
> ehabkost at redhat.com; postmodern.mod3 at gmail.com;
> Bart.VanAssche at wdc.com; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Subject: e1000e I219 timestamping oops related to TSYNCRXCTL read
> 
> In the following openSUSE bug report
> https://bugzilla.suse.com/show_bug.cgi?id=1075876
> Achim reported an oops related to e1000e timestamping:
> kernel: RIP: 0010:[<ffffffff8110303f>] timecounter_read+0xf/0x50
> [...]
> kernel: Call Trace:
> kernel:  [<ffffffffa0806b0f>] e1000e_phc_gettime+0x2f/0x60 [e1000e]
> kernel:  [<ffffffffa0806c5d>] e1000e_systim_overflow_work+0x1d/0x80 [e1000e]
> kernel:  [<ffffffff810992c5>] process_one_work+0x155/0x440
> kernel:  [<ffffffff81099e16>] worker_thread+0x116/0x4b0
> kernel:  [<ffffffff8109f422>] kthread+0xd2/0xf0
> kernel:  [<ffffffff8163184f>] ret_from_fork+0x3f/0x70
> 
> It always occurs 4 hours after boot but not on every boot. It is most
> likely the same problem reported here:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1668356
> http://lkml.iu.edu/hypermail/linux/kernel/1506.2/index.html#02530
> https://bugzilla.redhat.com/show_bug.cgi?id=1463882
> https://bugzilla.redhat.com/show_bug.cgi?id=1431863
> 

It probably occurs due to the systim overflow check, yes.

> This occurs with MAC: 12, e1000_pch_spt/I219. The reporter has
> reproduced it on a v4.16 derivative.
> 
> We've traced it to the fact that e1000e_systim_reset() skips the
> timecounter_init() call if e1000e_get_base_timinca() returns -EINVAL,
> which leads to a null deref in timecounter_read() (see comment 8 of the
> suse bugzilla for more details.)
> 
> In commit 83129b37ef35 ("e1000e: fix systim issues", v4.2-rc1) Yanir
> reworked e1000e_get_base_timinca() in such a way that it can return
> -EINVAL for e1000_pch_spt if the SYSCFI bit is not set in TSYNCRXCTL.
> This is also the commit that was identified by bisection in the second
> link above (lkml).
> 
> What we've observed (in comment 14) is that TSYNCRXCTL reads sometimes
> don't have the SYSCFI bit set. Retrying the read shortly after finds the
> bit to be set. This was observed at boot (probe) but also link up and
> link down.
> 

I don't know offhand what the SYSCFI bit is for yet still digging into it.

> I have a few questions:
> 
> What's the purpose of the SYSCFI bit in TSYNCRXCTL ("Reserved" in the
> datasheet)?
> 
> Why does it look like subsequent reads of TSYNCRXCTL sometimes have the
> SYSCFI bit set/not set on I219?
> 
> Is it right to check the SYSCFI bit in e1000e_get_base_timinca() for
> _spt and return -EINVAL if it's not set? Could we just remove that
> check?
> 

I think the right approach might be proper cleanup when we fail to reset. I think the problem is that when e1000e_systim_reset is called and fails, we don't properly cleanup the work items. I think we need to actually stop and kill the work task so that it won't run.

> The patch in comment 13 of the suse bugzilla works around the problem by
> retrying TSYNCRXCTL reads, maybe we could instead remove that read
> altogether or move the timecounter_init() call to at least avoid the
> oops. The best approach to take seems to depend on the behavior expected
> of TSYNCRXCTL reads on I219 so I'm hoping that you could provide more
> info on that.
> 

Yea, we need to do something here, I'm still investigating why we need the SYSCFI check, but at a minimum, we should disable the overflow check task if we fail here, I think.

It looks like the SYSCFI is the System Clock Frequency Indicator bit, and it should be used to tell which of two clock frequencies to choose. I do not understand why that would be changing at different reads. We do need to make sure the clock is already enabled, but we do that prior to the switch case... Something is really weird here...

Thanks,
Jake

> Thanks,
> -Benjamin
