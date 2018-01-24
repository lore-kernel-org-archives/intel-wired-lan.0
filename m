From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 24 Jan 2018 18:34:43 +0200
Subject: [Intel-wired-lan] e1000e hardware unit hangs
In-Reply-To: <CAKgT0Ue0ym7Q=R2KWqbeDNr8D22toe1Lqq5yHeykjvutirx=+A@mail.gmail.com>
References: <a9230667-967c-55d2-1357-27127c3d8aa9@candelatech.com>
 <CAKgT0Ue0ym7Q=R2KWqbeDNr8D22toe1Lqq5yHeykjvutirx=+A@mail.gmail.com>
Message-ID: <e7571d99-c443-e3bd-8fea-56634657e4c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/24/2018 18:11, Alexander Duyck wrote:
> On Tue, Jan 23, 2018 at 3:46 PM, Ben Greear <greearb@candelatech.com> wrote:
>> Hello,
>>
>> Anyone have any more suggestions for making e1000e work better?  This is
>> from a 4.9.65+ kernel,
>> with these additional e1000e patches applied:
>>
>> e1000e: Fix error path in link detection
>> e1000e: Fix wrong comment related to link detection
>> e1000e: Fix return value test
>> e1000e: Separate signaling for link check/link up
>> e1000e: Avoid receiver overrun interrupt bursts
> 
> Most of these patches shouldn't address anything that would trigger Tx
> hangs. They are mostly related to just link detection.
> 
>> Test case is simply to run 30000 tcp connections each trying to send 56Kbps
>> of bi-directional
>> data between a pair of e1000e interfaces :)
>>
>> No OOM related issues are seen on this kernel...similar test on 4.13 showed
>> some OOM
>> issues, but I have not debugged that yet...
> 
> Really a question like this probably belongs on e1000-devel or
> intel-wired-lan so I have added those lists and the e1000e maintainer
> to the thread.
> 
> It would be useful if you could provide more information about the
> device itself such as the ID and the kind of test you are running.
> Keep in mind the e1000e driver supports a pretty broad swath of
> devices so we need to narrow things down a bit.
> 
please, also re-check if your kernel include:
e1000e: fix buffer overrun while the I219 is processing DMA transactions
e1000e: fix the use of magic numbers for buffer overrun issue
where you take fresh version of kernel?

>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth3
>> (e1000e): transmit queue 0 timed out, trans_start: 4294737199, wd-timeout:
>> 5000 jiffies: 4294745088 tx-queues: 1
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth2
>> (e1000e): transmit queue 0 timed out, trans_start: 4294737200, wd-timeout:
>> 5000 jiffies: 4294745088 tx-queues: 1
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: ------------[ cut here
>> ]------------
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: WARNING: CPU: 7 PID: 0
>> at /home/greearb/git/linux-4.9.dev.y/net/sched/sch_generic.c:322
>> dev_watchdog+0x267/0x270
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: Modules linked in:
>> nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv4 cfg80211 bnep
>> bluetooth macvlan wanlink(O) pktgen fuse corete...sunrpc ipmi_d
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: CPU: 7 PID: 0 Comm:
>> swapper/7 Tainted: G           O    4.9.65+ #21
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: Hardware name:
>> Supermicro X9SCI/X9SCA/X9SCI/X9SCA, BIOS 2.0b 09/17/2012
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  ffff88042fdc3df0
>> ffffffff8142d791 0000000000000000 0000000000000000
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  ffff88042fdc3e30
>> ffffffff8110f266 000001422fdc3e08 0000000000000000
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  0000000000001388
>> 00000000fffc7d30 ffff880417d0c000 00000000fffc9c00
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: Call Trace:
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  <IRQ>
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8142d791>]
>> dump_stack+0x63/0x82
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8110f266>]
>> __warn+0xc6/0xe0
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8110f338>]
>> warn_slowpath_null+0x18/0x20
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff817da497>]
>> dev_watchdog+0x267/0x270
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff817da230>] ?
>> qdisc_rcu_free+0x40/0x40
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8117bf70>]
>> call_timer_fn+0x30/0x150
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff817da230>] ?
>> qdisc_rcu_free+0x40/0x40
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8117c350>]
>> run_timer_softirq+0x1f0/0x450
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff81051021>] ?
>> lapic_next_deadline+0x21/0x30
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8118a54d>] ?
>> clockevents_program_event+0x7d/0x120
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff81115101>]
>> __do_softirq+0xc1/0x2c0
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff81115461>]
>> irq_exit+0xb1/0xc0
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff81051c9d>]
>> smp_apic_timer_interrupt+0x3d/0x50
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff81895842>]
>> apic_timer_interrupt+0x82/0x90
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  <EOI>
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff81726e46>] ?
>> cpuidle_enter_state+0x126/0x300
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff81727042>]
>> cpuidle_enter+0x12/0x20
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff811521ce>]
>> call_cpuidle+0x1e/0x40
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8115240a>]
>> cpu_startup_entry+0x13a/0x220
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel:  [<ffffffff8104fbd9>]
>> start_secondary+0x149/0x170
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: ---[ end trace
>> 69e31de175b59d4f ]---
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0
>> eth2: Reset adapter unexpectedly
>> Jan 23 15:38:59 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0
>> eth3: Reset adapter unexpectedly
>> Jan 23 15:39:02 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is
>> Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
>> Jan 23 15:39:02 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0
>> eth2: Detected Hardware Unit Hang:
>>                                                        TDH
>> <a8>
>>                                                        TDT
>> <f3>...
>> Jan 23 15:39:02 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is
>> Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
>> Jan 23 15:39:13 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth3
>> (e1000e): transmit queue 0 timed out, trans_start: 4294748730, wd-timeout:
>> 5000 jiffies: 4294759424 tx-queues: 1
>> Jan 23 15:39:13 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth2
>> (e1000e): transmit queue 0 timed out, trans_start: 4294748730, wd-timeout:
>> 5000 jiffies: 4294759424 tx-queues: 1
>> Jan 23 15:39:13 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0
>> eth3: Reset adapter unexpectedly
>> Jan 23 15:39:13 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0
>> eth2: Reset adapter unexpectedly
>> Jan 23 15:39:20 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is
>> Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
>> Jan 23 15:39:20 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is
>> Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
>> Jan 23 15:39:25 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth2
>> (e1000e): transmit queue 0 timed out, trans_start: 4294766123, wd-timeout:
>> 5000 jiffies: 4294771200 tx-queues: 1
>> Jan 23 15:39:25 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth3
>> (e1000e): transmit queue 0 timed out, trans_start: 4294766125, wd-timeout:
>> 5000 jiffies: 4294771200 tx-queues: 1
>> Jan 23 15:39:25 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0
>> eth2: Reset adapter unexpectedly
>> Jan 23 15:39:25 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0
>> eth3: Reset adapter unexpectedly
>> Jan 23 15:39:28 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is
>> Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
>> Jan 23 15:39:28 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0
>> eth2: Detected Hardware Unit Hang:
>>                                                        TDH
>> <c8>
>>                                                        TDT
>> <f5>...
>> Jan 23 15:39:28 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is
>> Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
>>
>>
>> Thanks,
>> Ben
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
>>

