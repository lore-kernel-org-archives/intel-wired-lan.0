From: Ben Greear <greearb@candelatech.com>
Date: Wed, 24 Jan 2018 10:31:02 -0800
Subject: [Intel-wired-lan] e1000e hardware unit hangs
In-Reply-To: <e7571d99-c443-e3bd-8fea-56634657e4c4@intel.com>
References: <a9230667-967c-55d2-1357-27127c3d8aa9@candelatech.com>
 <CAKgT0Ue0ym7Q=R2KWqbeDNr8D22toe1Lqq5yHeykjvutirx=+A@mail.gmail.com>
 <e7571d99-c443-e3bd-8fea-56634657e4c4@intel.com>
Message-ID: <51bbb33a-e7dd-88c0-4fff-bebb6ef75a78@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01/24/2018 08:34 AM, Neftin, Sasha wrote:
> On 1/24/2018 18:11, Alexander Duyck wrote:
>> On Tue, Jan 23, 2018 at 3:46 PM, Ben Greear <greearb@candelatech.com> wrote:
>>> Hello,
>>>
>>> Anyone have any more suggestions for making e1000e work better?  This is
>>> from a 4.9.65+ kernel,
>>> with these additional e1000e patches applied:
>>>
>>> e1000e: Fix error path in link detection
>>> e1000e: Fix wrong comment related to link detection
>>> e1000e: Fix return value test
>>> e1000e: Separate signaling for link check/link up
>>> e1000e: Avoid receiver overrun interrupt bursts
>>
>> Most of these patches shouldn't address anything that would trigger Tx
>> hangs. They are mostly related to just link detection.
>>
>>> Test case is simply to run 30000 tcp connections each trying to send 56Kbps
>>> of bi-directional
>>> data between a pair of e1000e interfaces :)
>>>
>>> No OOM related issues are seen on this kernel...similar test on 4.13 showed
>>> some OOM
>>> issues, but I have not debugged that yet...
>>
>> Really a question like this probably belongs on e1000-devel or
>> intel-wired-lan so I have added those lists and the e1000e maintainer
>> to the thread.
>>
>> It would be useful if you could provide more information about the
>> device itself such as the ID and the kind of test you are running.
>> Keep in mind the e1000e driver supports a pretty broad swath of
>> devices so we need to narrow things down a bit.
>>
> please, also re-check if your kernel include:
> e1000e: fix buffer overrun while the I219 is processing DMA transactions
> e1000e: fix the use of magic numbers for buffer overrun issue
> where you take fresh version of kernel?

Hello,

I tried adding those two patches, but I still see this splat shortly after starting
my test.  The kernel I am using is here:

https://github.com/greearb/linux-ct-4.13

I've seen similar issues at least back to the 4.0 kernel, including stock kernels and my
own kernels with additional patches.

Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth2 (e1000e): transmit queue 0 timed out, trans_start: 4295298499, wd-timeout: 5000 
jiffies: 4295304192 tx-queues: 1
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: ------------[ cut here ]------------
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: WARNING: CPU: 0 PID: 0 at /home/greearb/git/linux-4.13.dev.y/net/sched/sch_generic.c:322 
dev_watchdog+0x228/0x250
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv4 libcrc32c cfg80211 macvlan 
wanlink(O) pktgen bnep bluetooth f...ss tpm_tis ip
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    4.13.16+ #22
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: Hardware name: Supermicro X9SCI/X9SCA/X9SCI/X9SCA, BIOS 2.0b 09/17/2012
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: task: ffffffff81e104c0 task.stack: ffffffff81e00000
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RIP: 0010:dev_watchdog+0x228/0x250
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RSP: 0018:ffff88042fc03e50 EFLAGS: 00010282
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RAX: 0000000000000086 RBX: 0000000000000000 RCX: 0000000000000000
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RDX: ffff88042fc15b40 RSI: ffff88042fc0dbf8 RDI: ffff88042fc0dbf8
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RBP: ffff88042fc03e98 R08: 0000000000000001 R09: 00000000000003c4
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: R10: 0000000000000000 R11: 00000000000003c4 R12: 0000000000001388
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: R13: 0000000100050dc3 R14: ffff880417670000 R15: 0000000100052400
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: FS:  0000000000000000(0000) GS:ffff88042fc00000(0000) knlGS:0000000000000000
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: CR2: 0000000001d14000 CR3: 0000000001e09000 CR4: 00000000001406f0
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: Call Trace:
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  <IRQ>
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  ? qdisc_rcu_free+0x40/0x40
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  call_timer_fn+0x30/0x160
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  ? qdisc_rcu_free+0x40/0x40
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  run_timer_softirq+0x1f0/0x450
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  ? lapic_next_deadline+0x21/0x30
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  ? clockevents_program_event+0x78/0xf0
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  __do_softirq+0xc1/0x2c0
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  irq_exit+0xb1/0xc0
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  smp_apic_timer_interrupt+0x38/0x50
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  apic_timer_interrupt+0x89/0x90
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RIP: 0010:cpuidle_enter_state+0x12b/0x310
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RSP: 0018:ffffffff81e03de8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000000001f
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RDX: 0000000000000000 RSI: 00000000238e2b4c RDI: 0000000000000000
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: RBP: ffffffff81e03e20 R08: 00000000000000af R09: 0000000000000018
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: R10: 00000000000000af R11: 0000000000000f27 R12: 0000000000000003
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: R13: ffff88042fc24918 R14: ffffffff81eae658 R15: 00000093fd9af742
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  </IRQ>
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  ? cpuidle_enter_state+0x119/0x310
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  cpuidle_enter+0x12/0x20
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  call_cpuidle+0x1e/0x40
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  do_idle+0x17f/0x1d0
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  cpu_startup_entry+0x5f/0x70
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  rest_init+0xc9/0xd0
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  start_kernel+0x483/0x490
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  ? early_idt_handler_array+0x120/0x120
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  x86_64_start_reservations+0x2a/0x2c
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  x86_64_start_kernel+0x13c/0x14b
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel:  secondary_startup_64+0x9f/0x9f
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: Code: 04 00 00 89 4d cc e8 b8 88 fd ff 8b 4d cc 45 89 e1 4d 89 e8 48 89 c2 4c 89 f6 48 c7 c7 98 23 d4 81 51 
41 57 89 d9 e8 44 48 94 ff <0f>... 63 8e 60 04
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: ---[ end trace 04264863cdced748 ]---
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0 eth2: Reset adapter unexpectedly
Jan 24 10:19:42 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is Down
Jan 24 10:19:48 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:19:48 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

....


Jan 24 10:27:05 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:27:24 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth3 (e1000e): transmit queue 0 timed out, trans_start: 4295760337, wd-timeout: 5000 
jiffies: 4295767040 tx-queues: 1
Jan 24 10:27:24 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0 eth3: Reset adapter unexpectedly
Jan 24 10:27:27 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0 eth2: Detected Hardware Unit Hang:
                                                       TDH                  <43>
                                                       TDT                  <90>...
Jan 24 10:27:29 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:27:46 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth3 (e1000e): transmit queue 0 timed out, trans_start: 4295782403, wd-timeout: 5000 
jiffies: 4295789056 tx-queues: 1
Jan 24 10:27:46 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0 eth3: Reset adapter unexpectedly
Jan 24 10:27:51 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:28:06 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth2 (e1000e): transmit queue 0 timed out, trans_start: 4295802883, wd-timeout: 5000 
jiffies: 4295809024 tx-queues: 1
Jan 24 10:28:06 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0 eth2: Reset adapter unexpectedly
Jan 24 10:28:10 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0 eth3: Detected Hardware Unit Hang:
                                                       TDH                  <10>
                                                       TDT                  <5d>...
Jan 24 10:28:11 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:28:30 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth3 (e1000e): transmit queue 0 timed out, trans_start: 4295827457, wd-timeout: 5000 
jiffies: 4295833088 tx-queues: 1
Jan 24 10:28:30 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0 eth3: Reset adapter unexpectedly
Jan 24 10:28:35 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:28:45 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth2 (e1000e): transmit queue 0 timed out, trans_start: 4295841678, wd-timeout: 5000 
jiffies: 4295847424 tx-queues: 1
Jan 24 10:28:45 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:06:00.0 eth2: Reset adapter unexpectedly
Jan 24 10:28:48 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0 eth3: Detected Hardware Unit Hang:
                                                       TDH                  <8>
                                                       TDT                  <55>...
Jan 24 10:28:49 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:29:20 lf1003-e3v2-13100124-f20x64 kernel: NETDEV WATCHDOG: eth3 (e1000e): transmit queue 0 timed out, trans_start: 4295874528, wd-timeout: 5000 
jiffies: 4295882240 tx-queues: 1
Jan 24 10:29:20 lf1003-e3v2-13100124-f20x64 kernel: e1000e 0000:07:00.0 eth3: Reset adapter unexpectedly
Jan 24 10:29:20 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is Down
Jan 24 10:29:26 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Jan 24 10:29:26 lf1003-e3v2-13100124-f20x64 kernel: e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

.....


[root at lf1003-e3v2-13100124-f20x64 ~]# ethtool -i eth2
driver: e1000e
version: 3.2.6-k
firmware-version: 2.1-2
bus-info: 0000:06:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

[root at lf1003-e3v2-13100124-f20x64 ~]# lspci -vvv -s 0000:06:00.0
06:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
	Subsystem: Super Micro Computer Inc Device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at df600000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at b000 [size=32]
	Region 3: Memory at df620000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <128ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-25-90-ff-ff-d2-06-aa
	Kernel driver in use: e1000e
	Kernel modules: e1000e


My test is a (custom) traffic generator that is setting up 30k tcp connections
between two e1000e ports and sending traffic as fast as possible.
I'd be happy to help you set up this exact tool on your system(s),
but we have seen similar issues with e1000e in other high-speed tests, so I don't think it
is specific to this particular test.  Maybe this test makes it easier to reproduce
however.

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

