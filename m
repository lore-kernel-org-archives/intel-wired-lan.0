From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Date: Thu, 11 Jun 2015 22:57:48 -0400
Subject: [Intel-wired-lan] next-20150610 - repeated hangs at
	e1000e_phc_gettime+0x2e/0x60
Message-ID: <21937.1434077868@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'm seeing repeated hard lockups on my Dell Latitude E6530.
Helpful info:

0) next-20150603 works, so the problem landed in linux-next in the last week.

1) All 3 times happened while I was at home, using wireless, so
the interface didn't have link and was ifconfig'ed down.

2) Remarkably similar times for it to blow up:

[14513.365378] Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 1
[14482.271716] Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 3
[14479.906820] Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 0

(I suspect the offsets were caused by differences in how long it took me
to correctly enter the cryptLUKS passphrase for my encrypted root filesystem)

Oddly enough, I don't see any patches to the e1000e driver in quite some
time... but that's where it keeps locking up.

This ringing any bells?

All 3 traces look like:

[14479.906908] Call Trace:
[14479.906914]  <NMI>  [<ffffffffba94db16>] dump_stack+0x50/0xa8
[14479.906930]  [<ffffffffba948bb9>] panic+0xcd/0x1e4
[14479.906940]  [<ffffffffba166a60>] ? perf_event_task_disable+0xc0/0xc0
[14479.906952]  [<ffffffffba125d8b>] watchdog_overflow_callback+0x9b/0xa0
[14479.906959]  [<ffffffffba16a684>] __perf_event_overflow+0xc4/0x1f0
[14479.906968]  [<ffffffffba16b3a4>] perf_event_overflow+0x14/0x20
[14479.906976]  [<ffffffffba022271>] intel_pmu_handle_irq+0x1e1/0x430
[14479.906990]  [<ffffffffba01a0f6>] perf_event_nmi_handler+0x26/0x40
[14479.906999]  [<ffffffffba0085b3>] nmi_handle+0x103/0x340
[14479.907005]  [<ffffffffba0084b5>] ? nmi_handle+0x5/0x340
[14479.907017]  [<ffffffffba008a53>] default_do_nmi+0xc3/0x120
[14479.907032]  [<ffffffffba008b98>] do_nmi+0xe8/0x130
[14479.907044]  [<ffffffffba95c9a8>] end_repeat_nmi+0x1e/0x2e
[14479.907055]  [<ffffffffba529886>] ? e1000e_cyclecounter_read+0x16/0xc0
[14479.907061]  [<ffffffffba529886>] ? e1000e_cyclecounter_read+0x16/0xc0
[14479.907069]  [<ffffffffba529886>] ? e1000e_cyclecounter_read+0x16/0xc0
[14479.907075]  <<EOE>>  [<ffffffffba0e9529>] timecounter_read+0x19/0x60
[14479.907088]  [<ffffffffba53687e>] e1000e_phc_gettime+0x2e/0x60
[14479.907098]  [<ffffffffba536a31>] e1000e_systim_overflow_work+0x31/0x70
[14479.907105]  [<ffffffffba07ad19>] process_one_work+0x3c9/0x980
[14479.907115]  [<ffffffffba07ac62>] ? process_one_work+0x312/0x980
[14479.907125]  [<ffffffffba07b348>] ? worker_thread+0x78/0x760
[14479.907134]  [<ffffffffba07b59c>] worker_thread+0x2cc/0x760
[14479.907144]  [<ffffffffba07b2d0>] ? process_one_work+0x980/0x980
[14479.907154]  [<ffffffffba082a5e>] kthread+0xfe/0x120
[14479.907163]  [<ffffffffba08ca50>] ? finish_task_switch+0x50/0x1c0
[14479.907173]  [<ffffffffba082960>] ? kthread_create_on_node+0x270/0x270
[14479.907179]  [<ffffffffba95ae4f>] ret_from_fork+0x3f/0x70
[14479.907188]  [<ffffffffba082960>] ? kthread_create_on_node+0x270/0x270
[14479.907243] Kernel Offset: 0x39000000 from 0xffffffff81000000 (relocation range:
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150611/94adb9a5/attachment.asc>
