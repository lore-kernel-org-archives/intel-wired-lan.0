From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 26 Jul 2018 09:05:57 -0700
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <1265852288.743881.1532617415845@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
 <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
 <1265852288.743881.1532617415845@mail.libero.it>
Message-ID: <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jul 26, 2018 at 8:03 AM, Marco Berizzi <pupilla@libero.it> wrote:
>> Il 26 luglio 2018 alle 16.32 Alexander Duyck <alexander.duyck@gmail.com> ha scritto:
>> Could you include an lspci -vvv for the igb functions.
>
> Hi Alexander.
> Thanks for the reply.
> Here is the output from lspci -vvv
>
> 08:00.0 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
>         Subsystem: Fujitsu Technology Solutions 82575EB Gigabit Network Connection
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at ce260000 (32-bit, non-prefetchable) [size=128K]
>         Region 1: Memory at ce240000 (32-bit, non-prefetchable) [size=128K]
>         Region 2: I/O ports at 3000 [size=32]
>         Region 3: Memory at ce200000 (32-bit, non-prefetchable) [size=16K]
>         [virtual] Expansion ROM at ce220000 [disabled] [size=128K]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [60] MSI-X: Enable+ Count=10 Masked-
>                 Vector table: BAR=3 offset=00000000
>                 PBA: BAR=3 offset=00002000
>         Capabilities: [a0] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
>                 DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 CEMsk:  RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>         Capabilities: [140 v1] Device Serial Number 00-19-99-ff-ff-ab-0b-38
>         Kernel driver in use: igb
>         Kernel modules: igb
>
> 08:00.1 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
>         Subsystem: Fujitsu Technology Solutions 82575EB Gigabit Network Connection
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin B routed to IRQ 17
>         Region 0: Memory at ce2c0000 (32-bit, non-prefetchable) [size=128K]
>         Region 1: Memory at ce2a0000 (32-bit, non-prefetchable) [size=128K]
>         Region 2: I/O ports at 3020 [size=32]
>         Region 3: Memory at ce204000 (32-bit, non-prefetchable) [size=16K]
>         [virtual] Expansion ROM at ce280000 [disabled] [size=128K]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [60] MSI-X: Enable+ Count=10 Masked-
>                 Vector table: BAR=3 offset=00000000
>                 PBA: BAR=3 offset=00002000
>         Capabilities: [a0] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
>                 DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 CEMsk:  RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>         Capabilities: [140 v1] Device Serial Number 00-19-99-ff-ff-ab-0b-38
>         Kernel driver in use: igb
>         Kernel modules: igb
>


This is helpful. At least now we know we are dealing with an 82575. So
the upper limit is 4 queues, and no support for SR-IOV.

>> Also I assume
>> this is a direct assigned port?
>
> Apologies, but I did not understand this question.

Is the adapter above running in the VM and passed through, or is it
just running in the host? You mentioned virtualbox so I thought you
were implying that this was being used inside of a VM.

>> From what I can get based on the log below somehow the driver and the
>> device are falling out of sync. It looks like either we missed a tail
>> update at some point after we stopped the queue.
>>
>> It looks like the error took 2 to 3 days to show up.
>
> yes, indeed.

I don't suppose by any chance you would be willing to try and bisect
the issue? Unfortunately there haven't been that many changes to igb
itself so my concern is that we are looking at a change in the traffic
behavior and that is somehow triggering issues in igb. Being able to
bisect it would be very useful.

>> Do you know if
>> there are any reproduction steps that might let us start bisecting
>> this, or that would at least allow us to reproduce the issue more
>> quickly?
>
> Impossibile for me to reproduce. I'm not able to understand
> why/when it is happening.

We can try and see if we can reproduce it, but we haven't seen any
similar issues in our validation environment so I don't know if we
could be able to get to root cause as there isn't anything obvious
that should be causing the issue.

>> Also, what sort of traffic are you sending over the port?
>
> this host is running slackware linux 14.2 64bit with oracle
> virtualbox 5.2.16
> The traffic to this hosts is small: after 3 dayes uptime
> it is less than 10GBytes:
>
> root at Kaa:~# last | head | grep reboot
> reboot   system boot  4.18.0-rc6       Mon Jul 23 13:18 - 16:52 (3+03:33)
> root at Kaa:~# ifconfig  eth0
> eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9000
>         inet 10.81.110.15  netmask 255.255.255.0  broadcast 10.81.110.255
>         ether 00:19:99:ab:0b:38  txqueuelen 1000  (Ethernet)
>         RX packets 10813141  bytes 2139165411 (1.9 GiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 10860078  bytes 4702798829 (4.3 GiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>         device memory 0xce260000-ce27ffff
>
> there are around 12 virtual machine hosted running (mainly windows7).
>
> bind/dhcp/proftpd/openssh/ntp and the above mentioned oracle virtualbox
> are the only running applications on this host.
>
> Problem popped up from linux 4.17.0
>
> root at Kaa:~# ethtool -k eth0
> Features for eth0:
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> rx-checksumming: on
> tx-checksumming: on
>         tx-checksum-ipv4: off [fixed]
>         tx-checksum-ip-generic: on
>         tx-checksum-ipv6: off [fixed]
>         tx-checksum-fcoe-crc: off [fixed]
>         tx-checksum-sctp: off [fixed]
> scatter-gather: on
>         tx-scatter-gather: on
>         tx-scatter-gather-fraglist: off [fixed]
> tcp-segmentation-offload: on
>         tx-tcp-segmentation: on
>         tx-tcp-ecn-segmentation: off [fixed]
>         tx-tcp-mangleid-segmentation: off
>         tx-tcp6-segmentation: on
> udp-fragmentation-offload: off
> generic-segmentation-offload: on
> generic-receive-offload: on
> large-receive-offload: off [fixed]
> rx-vlan-offload: on
> tx-vlan-offload: on
> ntuple-filters: off [fixed]
> receive-hashing: on
> highdma: on [fixed]
> rx-vlan-filter: on [fixed]
> vlan-challenged: off [fixed]
> tx-lockless: off [fixed]
> netns-local: off [fixed]
> tx-gso-robust: off [fixed]
> tx-fcoe-segmentation: off [fixed]
> tx-gre-segmentation: on
> tx-gre-csum-segmentation: on
> tx-ipxip4-segmentation: on
> tx-ipxip6-segmentation: on
> tx-udp_tnl-segmentation: on
> tx-udp_tnl-csum-segmentation: on
> tx-gso-partial: on
> tx-sctp-segmentation: off [fixed]
> tx-esp-segmentation: off [fixed]
> tx-udp-segmentation: off [fixed]
> fcoe-mtu: off [fixed]
> tx-nocache-copy: off
> loopback: off [fixed]
> rx-fcs: off [fixed]
> rx-all: off
> tx-vlan-stag-hw-insert: off [fixed]
> rx-vlan-stag-hw-parse: off [fixed]
> rx-vlan-stag-filter: off [fixed]
> l2-fwd-offload: off [fixed]
> hw-tc-offload: off [fixed]
> esp-hw-offload: off [fixed]
> esp-tx-csum-hw-offload: off [fixed]
> rx-udp_tunnel-port-offload: off [fixed]
> tls-hw-tx-offload: off [fixed]
> rx-gro-hw: off [fixed]
> tls-hw-record: off [fixed]

The only thing I can think of that you might want to try as an
alternative to bisecting might be to try disabling features.
Specifically you could start by disabling TSO. If disabling that
causes the issue to disappear then that would be at least a data-point
that would push us toward the direction of identifying the root cause.
Other than that the only other thing I could think of would be to look
at disabling scatter-gather. But it is unlikely that it is causing the
issue.
