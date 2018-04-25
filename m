From: Benjamin Poirier <bpoirier@suse.com>
Date: Wed, 25 Apr 2018 15:52:43 +0900
Subject: [Intel-wired-lan] e1000e I219 timestamping oops related to
 TSYNCRXCTL read
Message-ID: <20180425065243.g5mqewg5irkwgwgv@f2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the following openSUSE bug report
https://bugzilla.suse.com/show_bug.cgi?id=1075876
Achim reported an oops related to e1000e timestamping:
kernel: RIP: 0010:[<ffffffff8110303f>] timecounter_read+0xf/0x50
[...]
kernel: Call Trace:
kernel:  [<ffffffffa0806b0f>] e1000e_phc_gettime+0x2f/0x60 [e1000e]
kernel:  [<ffffffffa0806c5d>] e1000e_systim_overflow_work+0x1d/0x80 [e1000e]
kernel:  [<ffffffff810992c5>] process_one_work+0x155/0x440
kernel:  [<ffffffff81099e16>] worker_thread+0x116/0x4b0
kernel:  [<ffffffff8109f422>] kthread+0xd2/0xf0
kernel:  [<ffffffff8163184f>] ret_from_fork+0x3f/0x70

It always occurs 4 hours after boot but not on every boot. It is most
likely the same problem reported here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1668356
http://lkml.iu.edu/hypermail/linux/kernel/1506.2/index.html#02530
https://bugzilla.redhat.com/show_bug.cgi?id=1463882
https://bugzilla.redhat.com/show_bug.cgi?id=1431863

This occurs with MAC: 12, e1000_pch_spt/I219. The reporter has
reproduced it on a v4.16 derivative.

We've traced it to the fact that e1000e_systim_reset() skips the
timecounter_init() call if e1000e_get_base_timinca() returns -EINVAL,
which leads to a null deref in timecounter_read() (see comment 8 of the
suse bugzilla for more details.)

In commit 83129b37ef35 ("e1000e: fix systim issues", v4.2-rc1) Yanir
reworked e1000e_get_base_timinca() in such a way that it can return
-EINVAL for e1000_pch_spt if the SYSCFI bit is not set in TSYNCRXCTL.
This is also the commit that was identified by bisection in the second
link above (lkml).

What we've observed (in comment 14) is that TSYNCRXCTL reads sometimes
don't have the SYSCFI bit set. Retrying the read shortly after finds the
bit to be set. This was observed at boot (probe) but also link up and
link down.

I have a few questions:

What's the purpose of the SYSCFI bit in TSYNCRXCTL ("Reserved" in the
datasheet)?

Why does it look like subsequent reads of TSYNCRXCTL sometimes have the
SYSCFI bit set/not set on I219?

Is it right to check the SYSCFI bit in e1000e_get_base_timinca() for
_spt and return -EINVAL if it's not set? Could we just remove that
check?

The patch in comment 13 of the suse bugzilla works around the problem by
retrying TSYNCRXCTL reads, maybe we could instead remove that read
altogether or move the timecounter_init() call to at least avoid the
oops. The best approach to take seems to depend on the behavior expected
of TSYNCRXCTL reads on I219 so I'm hoping that you could provide more
info on that.

Thanks,
-Benjamin
