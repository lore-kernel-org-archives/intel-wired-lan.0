From: Dan Siemon <dan@coverfire.com>
Date: Tue, 09 Feb 2021 15:59:34 -0500
Subject: [Intel-wired-lan] 710/i40e, RSS and 802.1ad (double vlan)
In-Reply-To: <20210209120223.000041ca@intel.com>
References: <fc55ca6fb012c9e36e53d2ab80d47894c38e85a8.camel@coverfire.com>
 <AB117487-C2C3-47EF-A3C4-FDCED9304282@intel.com>
 <8c7d255047890290948cf51450b1f860e013b48c.camel@coverfire.com>
 <d3f0614118192ba0df5ec0e845f61e092f187744.camel@coverfire.com>
 <20210209120223.000041ca@intel.com>
Message-ID: <5ff376e94c76a9b475242d829ca7b7d2e1786620.camel@coverfire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-02-09 at 12:02 -0800, Jesse Brandeburg wrote:
> Please provide us with which driver/kernel/firmware you're running,
> uname -a
> ethtool -i ethx
> lspci -vvv -s < your pci bus:dev.fn>

We are ok to update to the latest 710 firmware and we follow the kernel
releases closely.

As we haven't had problems related to firmware, we still have many 710s
in the field that are on 6.01 firmware. Below are dumps from a couple
of our test boxes where I have upgraded the firmware.

-----

root at lab-5000 ~# /sbin/ethtool -i enp2s0f2
driver: i40e
version: 5.9.9-200.fc33.x86_64
firmware-version: 7.20 0x80007a01 0.0.0
expansion-rom-version: 
bus-info: 0000:02:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
root at lab-5000 ~# lspci -vvv -s 0000:02:00.2
02:00.2 Ethernet controller: Intel Corporation Ethernet Controller X710
for 10GbE SFP+ (rev 02)
	Subsystem: Intel Corporation Ethernet Converged Network
Adapter X710
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at dd000000 (64-bit, prefetchable) [size=8M]
	Region 3: Memory at de808000 (64-bit, prefetchable) [size=32K]
	Expansion ROM at df880000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-
,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=129 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00001000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0,
Latency L0s <512ns, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 0.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+
UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr-
UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM
L1, Exit Latency L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x8 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt-
ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO-
CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres-
HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 0c-1e-78-ff-ff-0b-
90-00
	Capabilities: [150 v1] Alternative Routing-ID Interpretation
(ARI)
		ARICap:	MFVC- ACS-, Next Function: 3
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number:
000
		IOVCtl:	Enable- Migration- Interrupt- MSE-
ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 32, Total VFs: 32, Number of VFs: 0,
Function Dependency Link: 02
		VF offset: 334, stride: 1, Device ID: 154c
		Supported Page Size: 00000553, System Page Size:
00000001
		Region 0: Memory at 0000000000000000 (64-bit,
prefetchable)
		Region 3: Memory at 0000000000000000 (64-bit,
prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir-
CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir-
CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: i40e
	Kernel modules: i40e

------

[root at lab20k ~]# /sbin/ethtool -i enp23s0f0
driver: i40e
version: 5.10.13-200.fc33.x86_64
firmware-version: 8.10 0x8000940b 0.0.0
expansion-rom-version: 
bus-info: 0000:17:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
[root@lab20k ~]# lspci -vvv -s 0000:17:00.0
17:00.0 Ethernet controller: Intel Corporation Ethernet Controller
XL710 for 40GbE QSFP+ (rev 02)
	Subsystem: Intel Corporation Ethernet Converged Network
Adapter XL710-Q2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 40
	NUMA node: 0
	IOMMU group: 38
	Region 0: Memory at c4800000 (64-bit, prefetchable) [size=8M]
	Region 3: Memory at c5808000 (64-bit, prefetchable) [size=32K]
	Expansion ROM at c5e80000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-
,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=129 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00001000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0,
Latency L0s <512ns, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr-
UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr-
UnsupReq+ AuxPwr- TransPend+
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM
L1, Exit Latency L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x8 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt-
ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO-
CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres-
HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 8b-71-5c-ff-ff-0b-
90-00
	Capabilities: [150 v1] Alternative Routing-ID Interpretation
(ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number:
000
		IOVCtl:	Enable- Migration- Interrupt- MSE-
ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 0,
Function Dependency Link: 00
		VF offset: 16, stride: 1, Device ID: 154c
		Supported Page Size: 00000553, System Page Size:
00000001
		Region 0: Memory at 00000000c5400000 (64-bit,
prefetchable)
		Region 3: Memory@00000000c5910000 (64-bit,
prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir-
CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir-
CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [1d0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: i40e
	Kernel modules: i40e



