From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Tue, 2 Apr 2019 21:41:12 +0000
Subject: [Intel-wired-lan] Problem when igb is forced to 10-HD on both
 sides.
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD69AF51A04@ORSMSX115.amr.corp.intel.com>
References: <4e4b56a7-8695-ca9e-018c-4c54d8ba9da1@candelatech.com>
 <9B4A1B1917080E46B64F07F2989DADD69AF518AA@ORSMSX115.amr.corp.intel.com>
 <28f0a365-d0d8-053e-cd59-cfe7cab8bc3f@candelatech.com>
 <f4bddb16-14df-141b-d7f2-d0fb3d11c871@candelatech.com>
 <610c9955-5f0d-b569-401a-7223dd022198@candelatech.com>
 <9B4A1B1917080E46B64F07F2989DADD69AF519E0@ORSMSX115.amr.corp.intel.com>
 <f2fd3e20-6260-5347-b7d0-4b286ca3e287@candelatech.com>
 <9B4A1B1917080E46B64F07F2989DADD69AF51A04@ORSMSX115.amr.corp.intel.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69AF51A27@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

man ethtool will show you how to change advertised speeds.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Fujinaka, Todd
Sent: Tuesday, April 2, 2019 2:33 PM
To: Ben Greear <greearb@candelatech.com>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] Problem when igb is forced to 10-HD on both sides.

Autonegotiate isn't the same for 10, 100, and 1G. If you start at 1G and don't advertise 1G it's one thing, but slower speeds are different. Like I said, you may need to read the IEEE documentation.

And no, Auto-MDI/MDI-X is not something that works everywhere with everything. It didn't really get developed until 1G times. I'm not sure what it physically does at lower line rates.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Ben Greear [mailto:greearb at candelatech.com]
Sent: Tuesday, April 2, 2019 2:29 PM
To: Fujinaka, Todd <todd.fujinaka@intel.com>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] Problem when igb is forced to 10-HD on both sides.

I'm quite sure that most real 10Mbps hardware didn't support auto-MDI, so it is not required.

The igb hardware can definitely set link to 10Mbps, and it can definitely do auto-MDI, so it would seem reasonable to allow it to do both at the same time.

My question below is more about having the igb NIC advertise itself as supporting 10/100 autonegotiate (instead of 10/100/1000).

Thanks,
Ben

On 4/2/19 2:19 PM, Fujinaka, Todd wrote:
> I think you need to read the IEEE spec on this. I'm still trying to figure out if 10-HD actually requires auto-MDI/MDI-X or if that's not covered.
> 
> I'm trying to find someone who remembers that far back. 10BASE-T is kind of historic at this time.
> 
> Todd Fujinaka
> Software Application Engineer
> Datacenter Engineering Group
> Intel Corporation
> todd.fujinaka at intel.com
> 
> 
> -----Original Message-----
> From: Ben Greear [mailto:greearb at candelatech.com]
> Sent: Tuesday, April 2, 2019 12:21 PM
> To: Fujinaka, Todd <todd.fujinaka@intel.com>; 
> intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] Problem when igb is forced to 10-HD on both sides.
> 
> Hello,
> 
> Here is a related question:
> 
> Is there any way to make igb auto-negotiate at 10 and/or 100Mbps, but NOT 1Gbps?
> 
> For instance:
> 
> ethtool -s eth2 advertise 0x02
> 
> puts in into fixed 10-FD mode.
> 
> Thanks,
> Ben
> 
> 
> On 4/2/19 12:03 PM, Ben Greear wrote:
>> Yes, it works with a cross-over cable.
>>
>> Is it valid to enable AUTO_MDI in 'fixed' mode, or do we just have to 
>> use proper cables in fixed mode?
>>
>> Thanks,
>> Ben
>>
>> On 4/2/19 11:50 AM, Ben Greear wrote:
>>> They are directly cabled with a non-cross-over cable.? I'll try with 
>>> a cross-over cable.
>>>
>>> Thanks,
>>> Ben
>>>
>>> On 4/2/19 11:36 AM, Fujinaka, Todd wrote:
>>>> Are those back-to-back or through a switch. I'm wondering if auto-MDI/MDI-X was turned off and you need to use a crossover cable.
>>>>
>>>> Todd Fujinaka
>>>> Software Application Engineer
>>>> Datacenter Engineering Group
>>>> Intel Corporation
>>>> todd.fujinaka at intel.com
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org]
>>>> On Behalf Of Ben Greear
>>>> Sent: Tuesday, April 2, 2019 11:13 AM
>>>> To: intel-wired-lan at lists.osuosl.org
>>>> Subject: [Intel-wired-lan] Problem when igb is forced to 10-HD on both sides.
>>>>
>>>> Hello,
>>>>
>>>> We found a problem with igb when forcing the negotiation rates.
>>>>
>>>> If I leave one side to 1GB AUTO, then I can force the other side to any supported combination and it appears to work fine.
>>>>
>>>> But, if I set both sides to 10-HD, then link will not be established.? I added a bit of debugging to the kernel and I see this in the logs.
>>>>
>>>> Our user was also setting MTU to 3800, but it turns out that is not needed to reproduce the issue.
>>>>
>>>> [360212.156670] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k [360212.156672] igb: Copyright (c) 2007-2014 Intel Corporation.
>>>> [360212.216114] igb 0000:01:00.0: added PHC on eth0 [360212.216116] 
>>>> igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection 
>>>> [360212.216118] igb
>>>> 0000:01:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 00:30:18:01:64:77 [360212.216200] igb 0000:01:00.0: eth0: PBA No: 106300-000 [360212.216202] igb 0000:01:00.0:
>>>> Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s) 
>>>> [360212.271608] igb 0000:01:00.1: added PHC on eth1 [360212.271610] igb 0000:01:00.1: Intel(R) Gigabit Ethernet Network Connection [360212.271611] igb 0000:01:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 00:30:18:01:64:78 [360212.271694] igb 0000:01:00.1: eth1: PBA No:
>>>> 106300-000 [360212.271695] igb 0000:01:00.1: Using MSI-X interrupts.
>>>> 4 rx queue(s), 4 tx queue(s) [360212.326533] igb 0000:01:00.2: 
>>>> added PHC on eth2 [360212.326535] igb 0000:01:00.2: Intel(R) 
>>>> Gigabit Ethernet Network Connection [360212.326537] igb 0000:01:00.2: eth2:
>>>> (PCIe:5.0Gb/s:Width x4)
>>>> 00:30:18:01:64:79 [360212.326620] igb 0000:01:00.2: eth2: PBA No:
>>>> 106300-00
>>> 0 [360212.326621] igb 0000:01:00.2: Using MSI-X interrupts. 4 rx 
>>> queue(s), 4 tx queue(s) [360212.438974] igb 0000:01:00.3: added PHC 
>>> on eth3 [360212.438977] igb 0000:01:00.3: Intel(R) Gigabit Ethernet 
>>> Network Connection [360212.438979] igb 0000:01:00.3: eth3:
>>> (PCIe:5.0Gb/s:Width x4) 00:30:18:01:64:7a [360212.439070] igb
>>> 0000:01:00.3: eth3: PBA No: 106300-000 [360212.439076] igb
>>> 0000:01:00.3: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s) 
>>> [360212.482565] igb 0000:02:00.0: added PHC on eth4 [360212.482566] 
>>> igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection 
>>> [360212.482568] igb
>>> 0000:02:00.0: eth4: (PCIe:2.5Gb/s:Width x1) 00:30:18:01:64:7b [360212.482569] igb 0000:02:00.0: eth4: PBA No: FFFFFF-0FF [360212.482570] igb 0000:02:00.0:
>>> Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s) [360215.943458] igb 0000:01:00.2 eth2: igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>>> RX/TX [360216.276567] igb 0000:01:00.1 eth1: igb: eth1 NIC Link is 
>>> Up
>>> 1000 Mbps F ull Duplex, Flow Control: RX/TX [360216.493576] igb
>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Up 1000 Mbps Full Duplex, 
>>> Flow Control: RX/TX [360255.427240] igb
>>> 0000:01:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, 
>>> Flow Control: RX/TX [360275.927145] igb 0000:01:00.0 eth0: igb: eth0 
>>> NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX 
>>> [360388.503634] igb 0000:01:00.2: Set Speed: 10? dplx: 0? autoneg: 0
>>> forced-speed-duplex: 1 [360389.299798] igb
>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Down [360391.609996] igb
>>> 0000:01:00.2 eth2: igb: eth2 NIC Link is Up 10 Mbps Half Duplex, Flow Control: None [360391.609998] igb 0000:01:00.2: EEE Disabled: unsupported at half duplex. Re-enable using ethtool when at full duplex.
>>>> [360391.610233] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is Up 10 Mbps Half Duplex, Flow Control: None [360391.610234] igb 0000:01:00.3: EEE Disabled:
>>>> unsupported at half duplex. Re-enable using ethtool when at full duplex.
>>>> [360421.400233] igb 0000:01:00.2: Set Speed: 10? dplx: 1? autoneg: 
>>>> 0
>>>> forced-speed-duplex: 2 [360421.513446] igb 0000:01:00.3 eth3: igb:
>>>> eth3 NIC Link is Down [360423.815595] igb 0000:01:00.2 eth2: igb:
>>>> eth2 NIC Link is Up 10 Mbps Full Duplex, Flow Control: None 
>>>> [360423.815928] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is Up 10 
>>>> Mbps Half Duplex, Flow Control: None [360465.832992] igb
>>>> 0000:01:00.2: Set Speed: 100? dplx: 0? autoneg: 0
>>>> forced-speed-duplex: 4 [360465.948361] igb 0000:01:00.3 eth3: igb:
>>>> eth3 NIC Link is Down [360468.272516] igb 0000:01:00.3 eth3: igb:
>>>> eth3 NIC Link is Up 100 Mbps Half Duplex, Flow
>>>> Control: None [360468.318388] igb 0000:01:00.2 eth2: igb: eth2 NIC 
>>>> Link is Up 100 Mbps Half Duplex, Flow Control: None [360486.514016] 
>>>> igb 0000:01:00.2: Set
>>>> Speed: 100? dplx: 1? autoneg: 0? forced-speed-duplex: 8 
>>>> [360486.539733] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is Down 
>>>> [360488.707926] igb 0000:01:00.3
>>>> eth3: igb: eth3 NIC Link is Up 100 Mbps Half Duplex, Flow
>>> Control: None [360488.753727] igb 0000:01:00.2 eth2: igb: eth2 NIC 
>>> Link is Up 100 Mbps Full Duplex, Flow Control: None [360503.658416] 
>>> igb 0000:01:00.2: Set
>>> Speed: 1000? dplx: 1? autoneg: 1? forced-speed-duplex: 8 
>>> [360503.684089] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is Down 
>>> [360506.572410] igb 0000:01:00.3
>>> eth3: igb: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>>> RX [360507.120348] igb 0000:01:00.2 eth2: igb: eth2 NIC Link is Up
>>> 1000 Mbps Full Duplex, Flow Control: None [360543.873779] igb
>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Down [360546.701102] igb
>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Up 1000 Mbps Full Duplex, 
>>> Flow Control: RX [360547.204119] igb 0000:01:00.2 eth2: igb: eth2 
>>> NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None 
>>> [360564.547193] igb
>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Down [360567.404614] igb
>>> 0000:01:00.2 eth2: igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, 
>>> Flow Control: RX/TX [360567.973547] igb 0000:01:00.3 eth3: igb: eth3 
>>> N IC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX 
>>> [360597.366482] igb 0000:01:00.2: changing MTU from 1500 to 3800 
>>> [360598.098996] igb 0000:01:00.3
>>> eth3: igb: eth3 NIC Link is Down [360601.028214] igb 0000:01:00.2
>>> eth2: igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>>> RX/TX [360601.581234] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is 
>>> Up
>>> 1000 Mbps Full Duplex, Flow Control: RX/TX [360611.266742] igb
>>> 0000:01:00.3: changing MTU from 1500 to 3800 [360611.591268] igb
>>> 0000:01:00.2 eth2: igb: eth2 NIC Link is Down [360614.051481] igb
>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Up 1000 Mbps Full Duplex, 
>>> Flow
>>> Control: RX/TX [360614.605478] igb 0000:01:00.2 eth2: igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX [360632.902730] igb 0000:01:00.2:
>>> Set Speed: 10? dplx: 0? autoneg: 0? forced-speed-duplex: 1 
>>> [360633.276708] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is Down 
>>> [360635.584020] igb 0000:01:00.3
>>> eth3: igb: eth3 NIC Link is Up 10 Mbps Half Duplex , Flow Control:
>>> None [360635.584253] igb 0000:01:00.2 eth2: igb: eth2 NIC Link is Up 10 Mbps Half Duplex, Flow Control: None [360695.743292] igb 0000:01:00.3:
>>> Set Speed: 10? dplx: 0? autoneg: 0? forced-speed-duplex: 1 
>>> [360695.863858] igb 0000:01:00.2 eth2: igb: eth2 NIC Link is Down
>>>>
>>>> [360614.051481] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is Up
>>>> 1000 Mbps Full Duplex, Flow Control: RX/TX [360614.605478] igb
>>>> 0000:01:00.2 eth2: igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, 
>>>> Flow Control: RX/TX [360632.902730] igb 0000:01:00.2: Set Speed: 10
>>>> dplx: 0? autoneg: 0? forced-speed-duplex: 1 [360633.276708] igb
>>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Down [360635.584020] igb
>>>> 0000:01:00.3 eth3: igb: eth3 NIC Link is Up 10 Mbps Half Duplex, 
>>>> Flow
>>>> Control: None [360635.584253] igb 0000:01:00.2 eth2: igb: eth2 NIC 
>>>> Link is Up 10 Mbps Half Duplex, Flow Control: None [360695.743292] 
>>>> igb 0000:01:00.3: Set
>>>> Speed: 10? dplx: 0? autoneg: 0? forced-speed-duplex: 1 [360695.863858] igb 0000:01:00.2 eth2: igb: eth2 NIC Link is Down [361049.119412] igb 0000:01:00.2:
>>>> changing MTU from 3800 to 1500 [361064.275721] igb 0000:01:00.3:
>>>> changing MTU from 3800 to 1500 [361106.100172] igb 0000:01:00.2
>>>> eth2: igb: eth2 NIC Link is Up 10 Mbps Half Duplex, Flow Control:
>>>> None [361106.101351
>>> ] igb 0000:01:00.3 eth3: igb: eth3 NIC Link is Up 10 Mbps Half 
>>> Duplex, Flow Control: None [361120.462094] igb 0000:01:00.3: Set
>>> Speed: 10? dplx: 0? autoneg: 0
>>> forced-speed-duplex: 1 [361120.578506] igb 0000:01:00.2 eth2: igb:
>>> eth2 NIC Link is Down
>>>>
>>>>
>>>> Kernel is 4.20.17+ local hacks (no significant local patches 
>>>> applied to igb though)
>>>>
>>>>
>>>> lspci output:
>>>> 01:00.2 Ethernet controller: Intel Corporation I350 Gigabit Network 
>>>> Connection (rev 01)
>>>>  ????Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>>  ????Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>  ????Latency: 0
>>>>  ????Interrupt: pin C routed to IRQ 18
>>>>  ????Region 0: Memory at df720000 (32-bit, non-prefetchable) 
>>>> [size=128K]
>>>>  ????Region 2: I/O ports at e020 [size=32]
>>>>  ????Region 3: Memory at df784000 (32-bit, non-prefetchable) 
>>>> [size=16K]
>>>>  ????Capabilities: [40] Power Management version 3
>>>>  ??????? Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>  ??????? Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>>>>  ????Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>>>>  ??????? Address: 0000000000000000? Data: 0000
>>>>  ??????? Masking: 00000000? Pending: 00000000
>>>>  ????Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
>>>>  ??????? Vector table: BAR=3 offset=00000000
>>>>  ??????? PBA: BAR=3 offset=00002000
>>>>  ????Capabilities: [a0] Express (v2) Endpoint, MSI 00
>>>>  ??????? DevCap:??? MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
>>>> <512ns, L1 <64us
>>>>  ??????????? ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
>>>> SlotPowerLimit 0.000W
>>>>  ??????? DevCtl:??? Report errors: Correctable+ Non-Fatal+ Fatal+
>>>> Unsupported+
>>>>  ??????????? RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>>>>  ??????????? MaxPayload 256 bytes, MaxReadReq 512 bytes
>>>>  ??????? DevSta:??? CorrErr+ UncorrErr- FatalErr- UnsuppReq+
>>>> AuxPwr+
>>>> TransPend-
>>>>  ??????? LnkCap:??? Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, 
>>>> Exit Latency L0s <4us, L1 <32us
>>>>  ??????????? ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>>>>  ??????? LnkCtl:??? ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>>  ??????????? ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>>  ??????? LnkSta:??? Speed 5GT/s, Width x4, TrErr- Train- SlotClk+
>>>> DLActive- BWMgmt- ABWMgmt-
>>>>  ??????? DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
>>>> LTR+, OBFF Not Supported
>>>>  ???????????? AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>>>  ??????? DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
>>>> LTR-, OBFF Disabled
>>>>  ???????????? AtomicOpsCtl: ReqEn-
>>>>  ??????? LnkSta2: Current De-emphasis Level: -6dB, 
>>>> EqualizationComplete-, EqualizationPhase1-
>>>>  ???????????? EqualizationPhase2-, EqualizationPhase3-,
>>>> LinkEqualizationRequest-
>>>>  ????Capabilities: [100 v2] Advanced Error Reporting
>>>>  ??????? UESta:??? DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>> UnxCmplt-
>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>  ??????? UEMsk:??? DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>> UnxCmplt-
>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>  ??????? UESvrt:??? DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
>>>> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>>  ??????? CESta:??? RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>> NonFatalErr-
>>>>  ??????? CEMsk:??? RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>> NonFatalErr+
>>>>  ??????? AERCap:??? First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
>>>> ECRCChkCap+ ECRCChkEn-
>>>>  ??????????? MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>>>  ??????? HeaderLog: 00000000 00000000 00000000 00000000
>>>>  ????Capabilities: [140 v1] Device Serial Number
>>>> 00-30-18-ff-ff-01-64-77
>>>>  ????Capabilities: [150 v1] Alternative Routing-ID Interpretation
>>>> (ARI)
>>>>  ??????? ARICap:??? MFVC- ACS-, Next Function: 3
>>>>  ??????? ARICtl:??? MFVC- ACS-, Function Group: 0
>>>>  ????Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
>>>>  ??????? IOVCap:??? Migration-, Interrupt Message Number: 000
>>>>  ??????? IOVCtl:??? Enable- Migration- Interrupt- MSE-
>>>> ARIHierarchy-
>>>>  ??????? IOVSta:??? Migration-
>>>>  ??????? Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function 
>>>> Dependency Link: 02
>>>>  ??????? VF offset: 128, stride: 4, Device ID: 1520
>>>>  ??????? Supported Page Size: 00000553, System Page Size: 00000001
>>>>  ??????? Region 0: Memory at 000000008b080000 (64-bit,
>>>> prefetchable)
>>>>  ??????? Region 3: Memory at 000000008b0a0000 (64-bit,
>>>> prefetchable)
>>>>  ??????? VF Migration: offset: 00000000, BIR: 0
>>>>  ????Capabilities: [1a0 v1] Transaction Processing Hints
>>>>  ??????? Device specific mode supported
>>>>  ??????? Steering table in TPH capability structure
>>>>  ????Capabilities: [1d0 v1] Access Control Services
>>>>  ??????? ACSCap:??? SrcValid- TransBlk- ReqRedir- CmpltRedir-
>>>> UpstreamFwd- EgressCtrl- DirectTrans-
>>>>  ??????? ACSCtl:??? SrcValid- TransBlk- ReqRedir- CmpltRedir-
>>>> UpstreamFwd- EgressCtrl- DirectTrans-
>>>>  ????Kernel driver in use: igb
>>>>  ????Kernel modules: igb
>>>>
>>>> 01:00.3 Ethernet controller: Intel Corporation I350 Gigabit Network 
>>>> Connection (rev 01)
>>>>  ????Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>>  ????Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>  ????Latency: 0
>>>>  ????Interrupt: pin D routed to IRQ 19
>>>>  ????Region 0: Memory at df700000 (32-bit, non-prefetchable) 
>>>> [size=128K]
>>>>  ????Region 2: I/O ports at e000 [size=32]
>>>>  ????Region 3: Memory at df780000 (32-bit, non-prefetchable) 
>>>> [size=16K]
>>>>  ????Capabilities: [40] Power Management version 3
>>>>  ??????? Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>  ??????? Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>>>>  ????Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>>>>  ??????? Address: 0000000000000000? Data: 0000
>>>>  ??????? Masking: 00000000? Pending: 00000000
>>>>  ????Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
>>>>  ??????? Vector table: BAR=3 offset=00000000
>>>>  ??????? PBA: BAR=3 offset=00002000
>>>>  ????Capabilities: [a0] Express (v2) Endpoint, MSI 00
>>>>  ??????? DevCap:??? MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
>>>> <512ns, L1 <64us
>>>>  ??????????? ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
>>>> SlotPowerLimit 0.000W
>>>>  ??????? DevCtl:??? Report errors: Correctable+ Non-Fatal+ Fatal+
>>>> Unsupported+
>>>>  ??????????? RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>>>>  ??????????? MaxPayload 256 bytes, MaxReadReq 512 bytes
>>>>  ??????? DevSta:??? CorrErr+ UncorrErr- FatalErr- UnsuppReq+
>>>> AuxPwr+
>>>> TransPend-
>>>>  ??????? LnkCap:??? Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, 
>>>> Exit Latency L0s <4us, L1 <32us
>>>>  ??????????? ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>>>>  ??????? LnkCtl:??? ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>>  ??????????? ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>>  ??????? LnkSta:??? Speed 5GT/s, Width x4, TrErr- Train- SlotClk+
>>>> DLActive- BWMgmt- ABWMgmt-
>>>>  ??????? DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
>>>> LTR+, OBFF Not Supported
>>>>  ???????????? AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>>>  ??????? DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
>>>> LTR-, OBFF Disabled
>>>>  ???????????? AtomicOpsCtl: ReqEn-
>>>>  ??????? LnkSta2: Current De-emphasis Level: -6dB, 
>>>> EqualizationComplete-, EqualizationPhase1-
>>>>  ???????????? EqualizationPhase2-, EqualizationPhase3-,
>>>> LinkEqualizationRequest-
>>>>  ????Capabilities: [100 v2] Advanced Error Reporting
>>>>  ??????? UESta:??? DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>> UnxCmplt-
>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>  ??????? UEMsk:??? DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>> UnxCmplt-
>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>  ??????? UESvrt:??? DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
>>>> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>>  ??????? CESta:??? RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>> NonFatalErr-
>>>>  ??????? CEMsk:??? RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>> NonFatalErr+
>>>>  ??????? AERCap:??? First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
>>>> ECRCChkCap+ ECRCChkEn-
>>>>  ??????????? MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>>>  ??????? HeaderLog: 00000000 00000000 00000000 00000000
>>>>  ????Capabilities: [140 v1] Device Serial Number
>>>> 00-30-18-ff-ff-01-64-77
>>>>  ????Capabilities: [150 v1] Alternative Routing-ID Interpretation
>>>> (ARI)
>>>>  ??????? ARICap:??? MFVC- ACS-, Next Function: 0
>>>>  ??????? ARICtl:??? MFVC- ACS-, Function Group: 0
>>>>  ????Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
>>>>  ??????? IOVCap:??? Migration-, Interrupt Message Number: 000
>>>>  ??????? IOVCtl:??? Enable- Migration- Interrupt- MSE-
>>>> ARIHierarchy-
>>>>  ??????? IOVSta:??? Migration-
>>>>  ??????? Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function 
>>>> Dependency Link: 03
>>>>  ??????? VF offset: 128, stride: 4, Device ID: 1520
>>>>  ??????? Supported Page Size: 00000553, System Page Size: 00000001
>>>>  ??????? Region 0: Memory at 000000008b0c0000 (64-bit,
>>>> prefetchable)
>>>>  ??????? Region 3: Memory at 000000008b0e0000 (64-bit,
>>>> prefetchable)
>>>>  ??????? VF Migration: offset: 00000000, BIR: 0
>>>>  ????Capabilities: [1a0 v1] Transaction Processing Hints
>>>>  ??????? Device specific mode supported
>>>>  ??????? Steering table in TPH capability structure
>>>>  ????Capabilities: [1d0 v1] Access Control Services
>>>>  ??????? ACSCap:??? SrcValid- TransBlk- ReqRedir- CmpltRedir-
>>>> UpstreamFwd- EgressCtrl- DirectTrans-
>>>>  ??????? ACSCtl:??? SrcValid- TransBlk- ReqRedir- CmpltRedir-
>>>> UpstreamFwd- EgressCtrl- DirectTrans-
>>>>  ????Kernel driver in use: igb
>>>>  ????Kernel modules: igb
>>>>
>>>>
>>>> I will be happy to try patches or provide other debugging.? The problem is fully reproducible.
>>>>
>>>> Thanks,
>>>> Ben
>>>>
>>>> --
>>>> Ben Greear <greearb@candelatech.com> Candela Technologies Inc 
>>>> http://www.candelatech.com
>>>>
>>>> _______________________________________________
>>>> Intel-wired-lan mailing list
>>>> Intel-wired-lan at osuosl.org
>>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>>>
>>>
>>>
>>
>>
> 
> 
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
> 


--
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
