From: =?unknown-8bit?q?Micha=C5=82_Miros=C5=82aw?= <michal.miroslaw@atendesoftware.pl>
Date: Thu, 21 Apr 2016 14:45:12 +0200
Subject: [Intel-wired-lan] i40e: Deadly GRE packet
Message-ID: <CAFzSZ++22adGYpR09vpx2rTh=bu1jgBz7wpB762Ampu0eEcVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Developers,

I have a setup of a pair of SuperMicro-branded XL710s connected with
passive crossover cable, one (eth4) is using firmware 5.0, the other (eth7)
is using fw 4.33. When I send couple of packets with no payload in GRE over
IP over ETH from eth7 to eth4, the receiving card stops processing further
packets. It seems that 4 empty-GRE packets in succession are enough to kill
the card's receivers (all ports stop working), more if there are other
packets inbetween. Transmit direction is not affected. After reboot, the
card comes back, reloading the driver (or unbind/bind) is not enough to fix
the problem.

14:31:24.299203 00:00:00:00:00:00 > ff:ff:ff:ff:ff:ff, ethertype IPv4
(0x0800), length 60: (tos 0x0, ttl 64, id 1, offset 0, flags [none], proto
GRE (47), length 24)
    127.0.0.1 > 127.0.0.1: GREv0, Flags [none], proto unknown (0x0000),
length 4
        gre-proto-0x0
        0x0000:  4500 0018 0001 0000 402f 7cb4 7f00 0001  E.......@/|.....
        0x0010:  7f00 0001 0000 0000 0000 0000 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............

scapy 2.2.0 generates this packet from: Ether()/IP()/GRE()

Tested on stock Debian kernel, with in-kernel driver and one from DPDK-2.2.
Linux lab1 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt25-2 (2016-04-08) x86_64
GNU/Linux

Best Regards,
Micha? Miros?aw
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160421/904d2af4/attachment-0001.html>
-------------- next part --------------
# ethtool -i eth4
driver: i40e
version: 0.4.10-k
firmware-version: f5.0 a1.5 n05.02 e80002283
bus-info: 0000:01:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no
# lspci -vvvs 0000:01:00.2
01:00.2 Ethernet controller: Intel Corporation Ethernet Controller X710 for 10GbE SFP+ (rev 01)
	Subsystem: Intel Corporation Ethernet Converged Network Adapter X710
	Physical Slot: 0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 26
	Region 0: Memory at 91800000 (64-bit, prefetchable) [size=8M]
	Region 3: Memory at 92c10000 (64-bit, prefetchable) [size=32K]
	Expansion ROM at fb380000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=129 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00001000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L0s <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: Supermicro Network Adapter
		Read-only fields:
			[PN] Part number: AOC-STG-i4S\x00\x00\x00\x00
			[V0] Vendor specific: 0100
			[V1] Vendor specific: 1.01\x00
			[SN] Serial number: VA158S014437\x00\x00\x00\x00\x00\x00\x00
			[VA] Vendor specific: 4
			[V2] Vendor specific: 0CC47ABCA188
			[V3] Vendor specific: 0CC47ABCA189
			[V4] Vendor specific: 0CC47ABCA18A
			[V5] Vendor specific: 0CC47ABCA18B
			[RV] Reserved: checksum good, 0 byte(s) reserved
		Read/write fields:
			[VB] Vendor specific: \x00
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number 88-a1-bc-ff-ff-7a-c4-0c
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 3
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 32, Total VFs: 32, Number of VFs: 0, Function Dependency Link: 02
		VF offset: 78, stride: 1, Device ID: 154c
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 0000000092800000 (64-bit, prefetchable)
		Region 3: Memory@0000000092d20000 (64-bit, prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: i40e

[    0.955651] pci 0000:01:00.2: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.955653] pci 0000:01:00.2: BAR 10: can't assign mem pref (size 0x80000)
[    0.956500] pci 0000:01:00.2: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.956507] pci 0000:01:00.2: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.956775] pci 0000:01:00.2: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.956797] pci 0000:01:00.2: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.956818] pci 0000:01:00.2: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.956861] pci 0000:01:00.2: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.956896] pci 0000:01:00.2: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.956924] pci 0000:01:00.2: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.956952] pci 0000:01:00.2: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.956967] pci 0000:01:00.2: BAR 0: assigned [mem 0x91800000-0x91ffffff 64bit pref]
[    0.957011] pci 0000:01:00.2: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957013] pci 0000:01:00.2: BAR 7: assigned [mem 0x92800000-0x929fffff 64bit pref]
[    0.957044] pci 0000:01:00.2: BAR 3: assigned [mem 0x92c10000-0x92c17fff 64bit pref]
[    0.957087] pci 0000:01:00.2: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.957089] pci 0000:01:00.2: BAR 10: assigned [mem 0x92d20000-0x92d9ffff 64bit pref]
[    3.085343] i40e 0000:01:00.2: f5.0 a1.5 n05.02 e80002283
[    3.309611] i40e 0000:01:00.2: MAC address: 0c:c4:7a:bc:a1:8a
[    3.309925] i40e 0000:01:00.2: irq 167 for MSI/MSI-X
[    3.309933] i40e 0000:01:00.2: irq 168 for MSI/MSI-X
[    3.309939] i40e 0000:01:00.2: irq 169 for MSI/MSI-X
[    3.309946] i40e 0000:01:00.2: irq 170 for MSI/MSI-X
[    3.309952] i40e 0000:01:00.2: irq 171 for MSI/MSI-X
[    3.309959] i40e 0000:01:00.2: irq 172 for MSI/MSI-X
[    3.309965] i40e 0000:01:00.2: irq 173 for MSI/MSI-X
[    3.309971] i40e 0000:01:00.2: irq 174 for MSI/MSI-X
[    3.309978] i40e 0000:01:00.2: irq 175 for MSI/MSI-X
[    3.309984] i40e 0000:01:00.2: irq 176 for MSI/MSI-X
[    3.309990] i40e 0000:01:00.2: irq 177 for MSI/MSI-X
[    3.309997] i40e 0000:01:00.2: irq 178 for MSI/MSI-X
[    3.310003] i40e 0000:01:00.2: irq 179 for MSI/MSI-X
[    3.310010] i40e 0000:01:00.2: irq 180 for MSI/MSI-X
[    3.310016] i40e 0000:01:00.2: irq 181 for MSI/MSI-X
[    3.310023] i40e 0000:01:00.2: irq 182 for MSI/MSI-X
[    3.310029] i40e 0000:01:00.2: irq 183 for MSI/MSI-X
[    3.310035] i40e 0000:01:00.2: irq 184 for MSI/MSI-X
[    3.310042] i40e 0000:01:00.2: irq 185 for MSI/MSI-X
[    3.310048] i40e 0000:01:00.2: irq 186 for MSI/MSI-X
[    3.310054] i40e 0000:01:00.2: irq 187 for MSI/MSI-X
[    3.310061] i40e 0000:01:00.2: irq 188 for MSI/MSI-X
[    3.310068] i40e 0000:01:00.2: irq 189 for MSI/MSI-X
[    3.310074] i40e 0000:01:00.2: irq 190 for MSI/MSI-X
[    3.310081] i40e 0000:01:00.2: irq 191 for MSI/MSI-X
[    3.310087] i40e 0000:01:00.2: irq 192 for MSI/MSI-X
[    3.310094] i40e 0000:01:00.2: irq 193 for MSI/MSI-X
[    3.310100] i40e 0000:01:00.2: irq 194 for MSI/MSI-X
[    3.310107] i40e 0000:01:00.2: irq 195 for MSI/MSI-X
[    3.310113] i40e 0000:01:00.2: irq 196 for MSI/MSI-X
[    3.310120] i40e 0000:01:00.2: irq 197 for MSI/MSI-X
[    3.310126] i40e 0000:01:00.2: irq 198 for MSI/MSI-X
[    3.310132] i40e 0000:01:00.2: irq 199 for MSI/MSI-X
[    3.310138] i40e 0000:01:00.2: irq 200 for MSI/MSI-X
[    3.310145] i40e 0000:01:00.2: irq 201 for MSI/MSI-X
[    3.310151] i40e 0000:01:00.2: irq 202 for MSI/MSI-X
[    3.310158] i40e 0000:01:00.2: irq 203 for MSI/MSI-X
[    3.310164] i40e 0000:01:00.2: irq 204 for MSI/MSI-X
[    3.310170] i40e 0000:01:00.2: irq 205 for MSI/MSI-X
[    3.310177] i40e 0000:01:00.2: irq 206 for MSI/MSI-X
[    3.310183] i40e 0000:01:00.2: irq 207 for MSI/MSI-X
[    3.310189] i40e 0000:01:00.2: irq 208 for MSI/MSI-X
[    3.310195] i40e 0000:01:00.2: irq 209 for MSI/MSI-X
[    3.310202] i40e 0000:01:00.2: irq 210 for MSI/MSI-X
[    3.310209] i40e 0000:01:00.2: irq 211 for MSI/MSI-X
[    3.310215] i40e 0000:01:00.2: irq 212 for MSI/MSI-X
[    3.310221] i40e 0000:01:00.2: irq 213 for MSI/MSI-X
[    3.310228] i40e 0000:01:00.2: irq 214 for MSI/MSI-X
[    3.310234] i40e 0000:01:00.2: irq 215 for MSI/MSI-X
[    3.310240] i40e 0000:01:00.2: irq 216 for MSI/MSI-X
[    3.311109] i40e 0000:01:00.2: Could not remove default MAC-VLAN
[    3.313200] i40e 0000:01:00.2: i40e_ptp_init: added PHC on eth2
[    3.313450] i40e 0000:01:00.2: PCI-Express: Speed 8.0GT/s Width x8
[    3.313454] i40e 0000:01:00.2: Features: PF-id[2] VFs: 32 VSIs: 34 QP: 32 RSS FD_ATR FD_SB NTUPLE DCB PTP 
[    4.864531] i40e 0000:01:00.2: add filter failed, err -53, aq_err 14
[  494.232980] i40e 0000:01:00.2 eth4: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None

# ethtool -i eth7
driver: i40e
version: 0.4.10-k
firmware-version: f4.33 a1.2 n04.42 e8000191c
bus-info: 0000:02:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no
# lspci -vvvs 0000:02:00.1
02:00.1 Ethernet controller: Intel Corporation Ethernet Controller X710 for 10GbE SFP+ (rev 01)
	Subsystem: Super Micro Computer Inc Device 0000
	Physical Slot: 2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at 93800000 (64-bit, prefetchable) [size=8M]
	Region 3: Memory at 95808000 (64-bit, prefetchable) [size=32K]
	Expansion ROM at fb200000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=129 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00001000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L0s <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: Supermicro Network Adapter
		Read-only fields:
			[PN] Part number: AOC-STG-i4S\x00\x00\x00\x00
			[V0] Vendor specific: 0100
			[V1] Vendor specific: 1.01\x00
			[SN] Serial number: VA157S008336\x00\x00\x00\x00\x00\x00\x00
			[VA] Vendor specific: 4
			[V2] Vendor specific: 0CC47ABC4138
			[V3] Vendor specific: 0CC47ABC4139
			[V4] Vendor specific: 0CC47ABC413A
			[V5] Vendor specific: 0CC47ABC413B
			[RV] Reserved: checksum good, 0 byte(s) reserved
		Read/write fields:
			[VB] Vendor specific: \x00
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number 38-41-bc-ff-ff-7a-c4-0c
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 2
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 32, Total VFs: 32, Number of VFs: 0, Function Dependency Link: 01
		VF offset: 47, stride: 1, Device ID: 154c
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 0000000095200000 (64-bit, prefetchable)
		Region 3: Memory@00000000958a0000 (64-bit, prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: i40e

[    0.955700] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.955721] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.955735] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.955763] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.955791] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.955811] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.955833] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.955868] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.955896] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.955919] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.955922] pci 0000:02:00.1: BAR 7: can't assign mem pref (size 0x200000)
[    0.955978] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.955980] pci 0000:02:00.1: BAR 10: can't assign mem pref (size 0x80000)
[    0.956545] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.956552] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.957163] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957177] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.957191] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957219] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957247] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957268] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957289] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.957310] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957345] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957373] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957401] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.957416] pci 0000:02:00.1: BAR 0: assigned [mem 0x93800000-0x93ffffff 64bit pref]
[    0.957453] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit pref]
[    0.957455] pci 0000:02:00.1: BAR 7: assigned [mem 0x95200000-0x953fffff 64bit pref]
[    0.957492] pci 0000:02:00.1: BAR 3: assigned [mem 0x95808000-0x9580ffff 64bit pref]
[    0.957529] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[    0.957531] pci 0000:02:00.1: BAR 10: assigned [mem 0x958a0000-0x9591ffff 64bit pref]
[    3.832996] i40e 0000:02:00.1: f4.33 a1.2 n04.42 e8000191c
[    4.054413] i40e 0000:02:00.1: MAC address: 0c:c4:7a:bc:41:39
[    4.054674] i40e 0000:02:00.1: irq 368 for MSI/MSI-X
[    4.054691] i40e 0000:02:00.1: irq 369 for MSI/MSI-X
[    4.054707] i40e 0000:02:00.1: irq 370 for MSI/MSI-X
[    4.054723] i40e 0000:02:00.1: irq 371 for MSI/MSI-X
[    4.054740] i40e 0000:02:00.1: irq 372 for MSI/MSI-X
[    4.054756] i40e 0000:02:00.1: irq 373 for MSI/MSI-X
[    4.054772] i40e 0000:02:00.1: irq 374 for MSI/MSI-X
[    4.054789] i40e 0000:02:00.1: irq 375 for MSI/MSI-X
[    4.054805] i40e 0000:02:00.1: irq 376 for MSI/MSI-X
[    4.054821] i40e 0000:02:00.1: irq 377 for MSI/MSI-X
[    4.054838] i40e 0000:02:00.1: irq 378 for MSI/MSI-X
[    4.054854] i40e 0000:02:00.1: irq 379 for MSI/MSI-X
[    4.054871] i40e 0000:02:00.1: irq 380 for MSI/MSI-X
[    4.054887] i40e 0000:02:00.1: irq 381 for MSI/MSI-X
[    4.054904] i40e 0000:02:00.1: irq 382 for MSI/MSI-X
[    4.054920] i40e 0000:02:00.1: irq 383 for MSI/MSI-X
[    4.054937] i40e 0000:02:00.1: irq 384 for MSI/MSI-X
[    4.054953] i40e 0000:02:00.1: irq 385 for MSI/MSI-X
[    4.054969] i40e 0000:02:00.1: irq 386 for MSI/MSI-X
[    4.054986] i40e 0000:02:00.1: irq 387 for MSI/MSI-X
[    4.055002] i40e 0000:02:00.1: irq 388 for MSI/MSI-X
[    4.055017] i40e 0000:02:00.1: irq 389 for MSI/MSI-X
[    4.055033] i40e 0000:02:00.1: irq 390 for MSI/MSI-X
[    4.055049] i40e 0000:02:00.1: irq 391 for MSI/MSI-X
[    4.055065] i40e 0000:02:00.1: irq 392 for MSI/MSI-X
[    4.055081] i40e 0000:02:00.1: irq 393 for MSI/MSI-X
[    4.055097] i40e 0000:02:00.1: irq 394 for MSI/MSI-X
[    4.055114] i40e 0000:02:00.1: irq 395 for MSI/MSI-X
[    4.055130] i40e 0000:02:00.1: irq 396 for MSI/MSI-X
[    4.055147] i40e 0000:02:00.1: irq 397 for MSI/MSI-X
[    4.055163] i40e 0000:02:00.1: irq 398 for MSI/MSI-X
[    4.055179] i40e 0000:02:00.1: irq 399 for MSI/MSI-X
[    4.055195] i40e 0000:02:00.1: irq 400 for MSI/MSI-X
[    4.055211] i40e 0000:02:00.1: irq 401 for MSI/MSI-X
[    4.055227] i40e 0000:02:00.1: irq 402 for MSI/MSI-X
[    4.055244] i40e 0000:02:00.1: irq 403 for MSI/MSI-X
[    4.055260] i40e 0000:02:00.1: irq 404 for MSI/MSI-X
[    4.055275] i40e 0000:02:00.1: irq 405 for MSI/MSI-X
[    4.055292] i40e 0000:02:00.1: irq 406 for MSI/MSI-X
[    4.055308] i40e 0000:02:00.1: irq 407 for MSI/MSI-X
[    4.055323] i40e 0000:02:00.1: irq 408 for MSI/MSI-X
[    4.055340] i40e 0000:02:00.1: irq 409 for MSI/MSI-X
[    4.055355] i40e 0000:02:00.1: irq 410 for MSI/MSI-X
[    4.055372] i40e 0000:02:00.1: irq 411 for MSI/MSI-X
[    4.055387] i40e 0000:02:00.1: irq 412 for MSI/MSI-X
[    4.055403] i40e 0000:02:00.1: irq 413 for MSI/MSI-X
[    4.055419] i40e 0000:02:00.1: irq 414 for MSI/MSI-X
[    4.055435] i40e 0000:02:00.1: irq 415 for MSI/MSI-X
[    4.055451] i40e 0000:02:00.1: irq 416 for MSI/MSI-X
[    4.055467] i40e 0000:02:00.1: irq 417 for MSI/MSI-X
[    4.056329] i40e 0000:02:00.1: Could not remove default MAC-VLAN
[    4.069671] i40e 0000:02:00.1: i40e_ptp_init: added PHC on eth8
[    4.081099] i40e 0000:02:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    4.081104] i40e 0000:02:00.1: Features: PF-id[1] VFs: 32 VSIs: 34 QP: 32 RSS FD_ATR FD_SB NTUPLE DCB PTP 
[  495.752345] i40e 0000:02:00.1 eth7: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None

