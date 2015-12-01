From: Chris Friesen <chris.friesen@windriver.com>
Date: Tue, 1 Dec 2015 13:31:30 -0600
Subject: [Intel-wired-lan] PCI ACS quirk for X710/XL710?
In-Reply-To: <1448992637.15753.8.camel@redhat.com>
References: <565DC5D4.70300@windriver.com> <565DC875.1020902@windriver.com>
 <1448992637.15753.8.camel@redhat.com>
Message-ID: <565DF592.7090606@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/01/2015 11:57 AM, Alex Williamson wrote:
> On Tue, 2015-12-01 at 10:19 -0600, Chris Friesen wrote:
>> On 12/01/2015 10:07 AM, Chris Friesen wrote:
>>> Hi all,
>>>
>>> The three of you in the "to" list were involved with adding commits d748804 and
>>> 100ebb2 to address the fact that these multi-port NICs will not do peer-to-peer
>>> between functions, but do not report this via ACS.
>>>
>>> We've got an X710 device (PCI device 0x1572, driver version 1.3.1-k, firmware
>>> 4.40) and we're seeing all the ports being assigned to the same IOMMU group.
>>>
>>> I'm guessing that this is due to a lack of ACS, and that it would be valid to
>>> add the X710/XL710 PCI IDs to the pci_dev_acs_enabled table.  Could someone from
>>> Intel confirm this?
>>
>> Looking at the datasheet (I suppose I should have done that first, sorry) it
>> looks like this device supports ACS.  However, we're still seeing all the ports
>> being placed into the same IOMMU group.
>>
>> Is there a way to prevent/disable this behaviour?  We want to be able to assign
>> each port to a separate VM, and thus for our purposes they need to be in
>> separate IOMMU groups.
> 
> Are you sure the grouping isn't caused by the root port and not the X710
> endpoints?  Please provide:
> 
> $ find /sys/kernel/iommu_groups/ -type l
> 
> $ sudo lspci -vvv
> 


Now that you mention it, no I'm not sure it's not caused by the root port. 
Can you describe what to look for?

I've got the data that you asked for.  The raw results are quite large,
so I trimmed the lspci output somewhat.  IOMMU groups 11 and 13 correspond
to the 0x1572 devices.

I should mention that this is a 3.10-based kernel.

Chris


[root at compute-0 ~(keystone_admin)]# find /sys/kernel/iommu_groups/ -type l
/sys/kernel/iommu_groups/0/devices/0000:00:00.0
/sys/kernel/iommu_groups/1/devices/0000:00:01.0
/sys/kernel/iommu_groups/2/devices/0000:00:02.0
/sys/kernel/iommu_groups/3/devices/0000:00:03.0
/sys/kernel/iommu_groups/4/devices/0000:00:05.0
/sys/kernel/iommu_groups/4/devices/0000:00:05.1
/sys/kernel/iommu_groups/4/devices/0000:00:05.2
/sys/kernel/iommu_groups/4/devices/0000:00:05.4
/sys/kernel/iommu_groups/5/devices/0000:00:11.0
/sys/kernel/iommu_groups/5/devices/0000:00:11.4
/sys/kernel/iommu_groups/6/devices/0000:00:16.0
/sys/kernel/iommu_groups/6/devices/0000:00:16.1
/sys/kernel/iommu_groups/7/devices/0000:00:1a.0
/sys/kernel/iommu_groups/8/devices/0000:00:1c.0
/sys/kernel/iommu_groups/8/devices/0000:00:1c.4
/sys/kernel/iommu_groups/8/devices/0000:00:1c.7
/sys/kernel/iommu_groups/8/devices/0000:05:00.0
/sys/kernel/iommu_groups/8/devices/0000:05:00.1
/sys/kernel/iommu_groups/8/devices/0000:06:00.0
/sys/kernel/iommu_groups/8/devices/0000:07:00.0
/sys/kernel/iommu_groups/8/devices/0000:08:00.0
/sys/kernel/iommu_groups/8/devices/0000:09:00.0
/sys/kernel/iommu_groups/9/devices/0000:00:1d.0
/sys/kernel/iommu_groups/10/devices/0000:00:1f.0
/sys/kernel/iommu_groups/10/devices/0000:00:1f.2
/sys/kernel/iommu_groups/11/devices/0000:01:00.0
/sys/kernel/iommu_groups/11/devices/0000:01:00.1
/sys/kernel/iommu_groups/12/devices/0000:02:00.0
/sys/kernel/iommu_groups/13/devices/0000:03:00.0
/sys/kernel/iommu_groups/13/devices/0000:03:00.1
/sys/kernel/iommu_groups/13/devices/0000:03:00.2
/sys/kernel/iommu_groups/13/devices/0000:03:00.3
/sys/kernel/iommu_groups/14/devices/0000:7f:08.0
/sys/kernel/iommu_groups/14/devices/0000:7f:08.2
/sys/kernel/iommu_groups/14/devices/0000:7f:08.3
/sys/kernel/iommu_groups/15/devices/0000:7f:09.0
/sys/kernel/iommu_groups/15/devices/0000:7f:09.2
/sys/kernel/iommu_groups/15/devices/0000:7f:09.3
/sys/kernel/iommu_groups/16/devices/0000:7f:0b.0
/sys/kernel/iommu_groups/16/devices/0000:7f:0b.1
/sys/kernel/iommu_groups/16/devices/0000:7f:0b.2
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.0
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.1
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.2
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.3
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.4
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.5
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.6
/sys/kernel/iommu_groups/17/devices/0000:7f:0c.7
/sys/kernel/iommu_groups/18/devices/0000:7f:0d.0
/sys/kernel/iommu_groups/18/devices/0000:7f:0d.1
/sys/kernel/iommu_groups/18/devices/0000:7f:0d.2
/sys/kernel/iommu_groups/18/devices/0000:7f:0d.3
/sys/kernel/iommu_groups/19/devices/0000:7f:0f.0
/sys/kernel/iommu_groups/19/devices/0000:7f:0f.1
/sys/kernel/iommu_groups/19/devices/0000:7f:0f.2
/sys/kernel/iommu_groups/19/devices/0000:7f:0f.3
/sys/kernel/iommu_groups/19/devices/0000:7f:0f.4
/sys/kernel/iommu_groups/19/devices/0000:7f:0f.5
/sys/kernel/iommu_groups/19/devices/0000:7f:0f.6
/sys/kernel/iommu_groups/20/devices/0000:7f:10.0
/sys/kernel/iommu_groups/20/devices/0000:7f:10.1
/sys/kernel/iommu_groups/20/devices/0000:7f:10.5
/sys/kernel/iommu_groups/20/devices/0000:7f:10.6
/sys/kernel/iommu_groups/20/devices/0000:7f:10.7
/sys/kernel/iommu_groups/21/devices/0000:7f:12.0
/sys/kernel/iommu_groups/21/devices/0000:7f:12.1
/sys/kernel/iommu_groups/21/devices/0000:7f:12.2
/sys/kernel/iommu_groups/21/devices/0000:7f:12.4
/sys/kernel/iommu_groups/21/devices/0000:7f:12.5
/sys/kernel/iommu_groups/21/devices/0000:7f:12.6
/sys/kernel/iommu_groups/22/devices/0000:7f:13.0
/sys/kernel/iommu_groups/22/devices/0000:7f:13.1
/sys/kernel/iommu_groups/22/devices/0000:7f:13.2
/sys/kernel/iommu_groups/22/devices/0000:7f:13.3
/sys/kernel/iommu_groups/22/devices/0000:7f:13.6
/sys/kernel/iommu_groups/22/devices/0000:7f:13.7
/sys/kernel/iommu_groups/23/devices/0000:7f:14.0
/sys/kernel/iommu_groups/23/devices/0000:7f:14.1
/sys/kernel/iommu_groups/23/devices/0000:7f:14.2
/sys/kernel/iommu_groups/23/devices/0000:7f:14.3
/sys/kernel/iommu_groups/23/devices/0000:7f:14.4
/sys/kernel/iommu_groups/23/devices/0000:7f:14.5
/sys/kernel/iommu_groups/23/devices/0000:7f:14.6
/sys/kernel/iommu_groups/23/devices/0000:7f:14.7
/sys/kernel/iommu_groups/24/devices/0000:7f:16.0
/sys/kernel/iommu_groups/24/devices/0000:7f:16.1
/sys/kernel/iommu_groups/24/devices/0000:7f:16.2
/sys/kernel/iommu_groups/24/devices/0000:7f:16.3
/sys/kernel/iommu_groups/24/devices/0000:7f:16.6
/sys/kernel/iommu_groups/24/devices/0000:7f:16.7
/sys/kernel/iommu_groups/25/devices/0000:7f:17.0
/sys/kernel/iommu_groups/25/devices/0000:7f:17.1
/sys/kernel/iommu_groups/25/devices/0000:7f:17.2
/sys/kernel/iommu_groups/25/devices/0000:7f:17.3
/sys/kernel/iommu_groups/25/devices/0000:7f:17.4
/sys/kernel/iommu_groups/25/devices/0000:7f:17.5
/sys/kernel/iommu_groups/25/devices/0000:7f:17.6
/sys/kernel/iommu_groups/25/devices/0000:7f:17.7
/sys/kernel/iommu_groups/26/devices/0000:7f:1e.0
/sys/kernel/iommu_groups/26/devices/0000:7f:1e.1
/sys/kernel/iommu_groups/26/devices/0000:7f:1e.2
/sys/kernel/iommu_groups/26/devices/0000:7f:1e.3
/sys/kernel/iommu_groups/26/devices/0000:7f:1e.4
/sys/kernel/iommu_groups/27/devices/0000:7f:1f.0
/sys/kernel/iommu_groups/27/devices/0000:7f:1f.2
/sys/kernel/iommu_groups/28/devices/0000:80:02.0
/sys/kernel/iommu_groups/29/devices/0000:80:05.0
/sys/kernel/iommu_groups/29/devices/0000:80:05.1
/sys/kernel/iommu_groups/29/devices/0000:80:05.2
/sys/kernel/iommu_groups/29/devices/0000:80:05.4
/sys/kernel/iommu_groups/30/devices/0000:ff:08.0
/sys/kernel/iommu_groups/30/devices/0000:ff:08.2
/sys/kernel/iommu_groups/30/devices/0000:ff:08.3
/sys/kernel/iommu_groups/31/devices/0000:ff:09.0
/sys/kernel/iommu_groups/31/devices/0000:ff:09.2
/sys/kernel/iommu_groups/31/devices/0000:ff:09.3
/sys/kernel/iommu_groups/32/devices/0000:ff:0b.0
/sys/kernel/iommu_groups/32/devices/0000:ff:0b.1
/sys/kernel/iommu_groups/32/devices/0000:ff:0b.2
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.0
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.1
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.2
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.3
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.4
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.5
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.6
/sys/kernel/iommu_groups/33/devices/0000:ff:0c.7
/sys/kernel/iommu_groups/34/devices/0000:ff:0d.0
/sys/kernel/iommu_groups/34/devices/0000:ff:0d.1
/sys/kernel/iommu_groups/34/devices/0000:ff:0d.2
/sys/kernel/iommu_groups/34/devices/0000:ff:0d.3
/sys/kernel/iommu_groups/35/devices/0000:ff:0f.0
/sys/kernel/iommu_groups/35/devices/0000:ff:0f.1
/sys/kernel/iommu_groups/35/devices/0000:ff:0f.2
/sys/kernel/iommu_groups/35/devices/0000:ff:0f.3
/sys/kernel/iommu_groups/35/devices/0000:ff:0f.4
/sys/kernel/iommu_groups/35/devices/0000:ff:0f.5
/sys/kernel/iommu_groups/35/devices/0000:ff:0f.6
/sys/kernel/iommu_groups/36/devices/0000:ff:10.0
/sys/kernel/iommu_groups/36/devices/0000:ff:10.1
/sys/kernel/iommu_groups/36/devices/0000:ff:10.5
/sys/kernel/iommu_groups/36/devices/0000:ff:10.6
/sys/kernel/iommu_groups/36/devices/0000:ff:10.7
/sys/kernel/iommu_groups/37/devices/0000:ff:12.0
/sys/kernel/iommu_groups/37/devices/0000:ff:12.1
/sys/kernel/iommu_groups/37/devices/0000:ff:12.2
/sys/kernel/iommu_groups/37/devices/0000:ff:12.4
/sys/kernel/iommu_groups/37/devices/0000:ff:12.5
/sys/kernel/iommu_groups/37/devices/0000:ff:12.6
/sys/kernel/iommu_groups/38/devices/0000:ff:13.0
/sys/kernel/iommu_groups/38/devices/0000:ff:13.1
/sys/kernel/iommu_groups/38/devices/0000:ff:13.2
/sys/kernel/iommu_groups/38/devices/0000:ff:13.3
/sys/kernel/iommu_groups/38/devices/0000:ff:13.6
/sys/kernel/iommu_groups/38/devices/0000:ff:13.7
/sys/kernel/iommu_groups/39/devices/0000:ff:14.0
/sys/kernel/iommu_groups/39/devices/0000:ff:14.1
/sys/kernel/iommu_groups/39/devices/0000:ff:14.2
/sys/kernel/iommu_groups/39/devices/0000:ff:14.3
/sys/kernel/iommu_groups/39/devices/0000:ff:14.4
/sys/kernel/iommu_groups/39/devices/0000:ff:14.5
/sys/kernel/iommu_groups/39/devices/0000:ff:14.6
/sys/kernel/iommu_groups/39/devices/0000:ff:14.7
/sys/kernel/iommu_groups/40/devices/0000:ff:16.0
/sys/kernel/iommu_groups/40/devices/0000:ff:16.1
/sys/kernel/iommu_groups/40/devices/0000:ff:16.2
/sys/kernel/iommu_groups/40/devices/0000:ff:16.3
/sys/kernel/iommu_groups/40/devices/0000:ff:16.6
/sys/kernel/iommu_groups/40/devices/0000:ff:16.7
/sys/kernel/iommu_groups/41/devices/0000:ff:17.0
/sys/kernel/iommu_groups/41/devices/0000:ff:17.1
/sys/kernel/iommu_groups/41/devices/0000:ff:17.2
/sys/kernel/iommu_groups/41/devices/0000:ff:17.3
/sys/kernel/iommu_groups/41/devices/0000:ff:17.4
/sys/kernel/iommu_groups/41/devices/0000:ff:17.5
/sys/kernel/iommu_groups/41/devices/0000:ff:17.6
/sys/kernel/iommu_groups/41/devices/0000:ff:17.7
/sys/kernel/iommu_groups/42/devices/0000:ff:1e.0
/sys/kernel/iommu_groups/42/devices/0000:ff:1e.1
/sys/kernel/iommu_groups/42/devices/0000:ff:1e.2
/sys/kernel/iommu_groups/42/devices/0000:ff:1e.3
/sys/kernel/iommu_groups/42/devices/0000:ff:1e.4
/sys/kernel/iommu_groups/43/devices/0000:ff:1f.0
/sys/kernel/iommu_groups/43/devices/0000:ff:1f.2


partial lspci -t output:

 |           +-1f.0
 |           \-1f.2
 \-[0000:00]-+-00.0
             +-01.0-[02]----00.0
             +-02.0-[03]--+-00.0
             |            +-00.1
             |            +-00.2
             |            \-00.3
             +-03.0-[01]--+-00.0
             |            \-00.1
             +-05.0
             +-05.1
             +-05.2



[root at compute-0 ~(keystone_admin)]# lspci -vvv
00:00.0 Host bridge: Intel Corporation Haswell-E DMI2 (rev 02)
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 0
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Latency L0 <512ns, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
	Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>

00:02.0 PCI bridge: Intel Corporation Haswell-E PCI Express Root Port 2 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 94200000-943fffff
        Prefetchable memory behind bridge: 0000000090000000-00000000940fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: Intel Corporation Device 0000
        Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
                Address: fee00338  Data: 0000
                Masking: 00000002  Pending: 00000000
        Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #3, Speed 8GT/s, Width x16, ASPM L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #2, PowerLimit 25.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
        Capabilities: [e0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
        Capabilities: [110 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
                ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
        Capabilities: [148 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol+
                UESvrt: DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
        Capabilities: [250 v1] #19
        Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
        Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
        Kernel driver in use: pcieport

00:03.0 PCI bridge: Intel Corporation Haswell-E PCI Express Root Port 3 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 94400000-944fffff
        Prefetchable memory behind bridge: 0000000095000000-00000000970fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: Intel Corporation Device 0000
        Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
                Address: fee00358  Data: 0000
                Masking: 00000002  Pending: 00000000
        Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #7, Speed 8GT/s, Width x8, ASPM L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
        Capabilities: [e0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
        Capabilities: [110 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
                ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
        Capabilities: [148 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol+
                UESvrt: DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
        Capabilities: [250 v1] #19
        Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
        Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
        Kernel driver in use: pcieport

01:00.0 Ethernet controller: Intel Corporation Device 1572 (rev 01)
	Subsystem: Dell Device 1f99
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at 96000000 (64-bit, prefetchable) [size=16M]
	Region 3: Memory at 97008000 (64-bit, prefetchable) [size=32K]
	Expansion ROM@97080000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
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
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: X710 10GbE Controller
		Read-only fields:
			[V0] Vendor specific: FFV16.5.20
			[PN] Part number: 6VDPG
			[MN] Manufacture ID: 31 30 32 38
			[V1] Vendor specific: DSV1028VPDR.VER2.0
			[V3] Vendor specific: DTINIC
			[V4] Vendor specific: DCM10010395C521010395C512020395C523020395C514030395C525030395C516040395C527040395C518050395C529050395C51A060395C52B060395C51C070395C52D070395C51E080395C52F080395C5
			[V5] Vendor specific: NPY2
			[V6] Vendor specific: PMT7
			[V7] Vendor specific: NMVIntel Corp
			[V8] Vendor specific: L1D0
			[RV] Reserved: checksum good, 1 byte(s) reserved
		Read/write fields:
			[Y1] System specific: CCF1
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [140 v1] Device Serial Number a0-5b-0a-ff-ff-12-bc-f8
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [1d0 v1] #19
	Kernel driver in use: vfio-pci
	Kernel modules: i40e

01:00.1 Ethernet controller: Intel Corporation Device 1572 (rev 01)
	Subsystem: Dell Device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at 95000000 (64-bit, prefetchable) [size=16M]
	Region 3: Memory at 97000000 (64-bit, prefetchable) [size=32K]
	Expansion ROM@94400000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable- Count=129 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00001000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: X710 10GbE Controller
		Read-only fields:
			[V0] Vendor specific: FFV16.5.20
			[PN] Part number: 6VDPG
			[MN] Manufacture ID: 31 30 32 38
			[V1] Vendor specific: DSV1028VPDR.VER2.0
			[V3] Vendor specific: DTINIC
			[V4] Vendor specific: DCM10010395C521010395C512020395C523020395C514030395C525030395C516040395C527040395C518050395C529050395C51A060395C52B060395C51C070395C52D070395C51E080395C52F080395C5
			[V5] Vendor specific: NPY2
			[V6] Vendor specific: PMT7
			[V7] Vendor specific: NMVIntel Corp
			[V8] Vendor specific: L1D0
			[RV] Reserved: checksum good, 1 byte(s) reserved
		Read/write fields:
			[Y1] System specific: CCF1
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [140 v1] Device Serial Number a0-5b-0a-ff-ff-12-bc-f8
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: vfio-pci
	Kernel modules: i40e

03:00.0 Ethernet controller: Intel Corporation Device 1572 (rev 01)
	Subsystem: Intel Corporation Device 0005
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at 93000000 (64-bit, prefetchable) [size=16M]
	Region 3: Memory at 94018000 (64-bit, prefetchable) [size=32K]
	Expansion ROM@94080000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=8 DScale=1 PME-
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
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: X710 10GbE Controller
		Read-only fields:
			[V0] Vendor specific: FFV16.5.20
			[PN] Part number: DDJKY
			[MN] Manufacture ID: 31 30 32 38
			[V1] Vendor specific: DSV1028VPDR.VER2.0
			[V3] Vendor specific: DTINIC
			[V4] Vendor specific: DCM10010391C521010391C532010391C543010391C514020391C525020391C536020391C547020391C518030391C529030391C53A030391C54B030391C51C040391C52D040391C53E040391C54F040391C5
			[V5] Vendor specific: NPY4
			[V6] Vendor specific: PMTA
			[V7] Vendor specific: NMVIntel Corp
			[V8] Vendor specific: L1D0
			[RV] Reserved: checksum good, 1 byte(s) reserved
		Read/write fields:
			[Y1] System specific: CCF1
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [140 v1] Device Serial Number 60-04-03-ff-ff-fe-fd-3c
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [1d0 v1] #19
	Kernel driver in use: i40e
	Kernel modules: i40e

03:00.1 Ethernet controller: Intel Corporation Device 1572 (rev 01)
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at 92000000 (64-bit, prefetchable) [size=16M]
	Region 3: Memory at 94010000 (64-bit, prefetchable) [size=32K]
	Expansion ROM@94200000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
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
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: X710 10GbE Controller
		Read-only fields:
			[V0] Vendor specific: FFV16.5.20
			[PN] Part number: DDJKY
			[MN] Manufacture ID: 31 30 32 38
			[V1] Vendor specific: DSV1028VPDR.VER2.0
			[V3] Vendor specific: DTINIC
			[V4] Vendor specific: DCM10010391C521010391C532010391C543010391C514020391C525020391C536020391C547020391C518030391C529030391C53A030391C54B030391C51C040391C52D040391C53E040391C54F040391C5
			[V5] Vendor specific: NPY4
			[V6] Vendor specific: PMTA
			[V7] Vendor specific: NMVIntel Corp
			[V8] Vendor specific: L1D0
			[RV] Reserved: checksum good, 1 byte(s) reserved
		Read/write fields:
			[Y1] System specific: CCF1
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [140 v1] Device Serial Number 60-04-03-ff-ff-fe-fd-3c
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 2
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: i40e
	Kernel modules: i40e

03:00.2 Ethernet controller: Intel Corporation Device 1572 (rev 01)
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at 91000000 (64-bit, prefetchable) [size=16M]
	Region 3: Memory at 94008000 (64-bit, prefetchable) [size=32K]
	Expansion ROM@94280000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
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
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: X710 10GbE Controller
		Read-only fields:
			[V0] Vendor specific: FFV16.5.20
			[PN] Part number: DDJKY
			[MN] Manufacture ID: 31 30 32 38
			[V1] Vendor specific: DSV1028VPDR.VER2.0
			[V3] Vendor specific: DTINIC
			[V4] Vendor specific: DCM10010391C521010391C532010391C543010391C514020391C525020391C536020391C547020391C518030391C529030391C53A030391C54B030391C51C040391C52D040391C53E040391C54F040391C5
			[V5] Vendor specific: NPY4
			[V6] Vendor specific: PMTA
			[V7] Vendor specific: NMVIntel Corp
			[V8] Vendor specific: L1D0
			[RV] Reserved: checksum good, 1 byte(s) reserved
		Read/write fields:
			[Y1] System specific: CCF1
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [140 v1] Device Serial Number 60-04-03-ff-ff-fe-fd-3c
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 3
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: i40e
	Kernel modules: i40e

03:00.3 Ethernet controller: Intel Corporation Device 1572 (rev 01)
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at 90000000 (64-bit, prefetchable) [size=16M]
	Region 3: Memory at 94000000 (64-bit, prefetchable) [size=32K]
	Expansion ROM@94300000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
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
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Vital Product Data
		Product Name: X710 10GbE Controller
		Read-only fields:
			[V0] Vendor specific: FFV16.5.20
			[PN] Part number: DDJKY
			[MN] Manufacture ID: 31 30 32 38
			[V1] Vendor specific: DSV1028VPDR.VER2.0
			[V3] Vendor specific: DTINIC
			[V4] Vendor specific: DCM10010391C521010391C532010391C543010391C514020391C525020391C536020391C547020391C518030391C529030391C53A030391C54B030391C51C040391C52D040391C53E040391C54F040391C5
			[V5] Vendor specific: NPY4
			[V6] Vendor specific: PMTA
			[V7] Vendor specific: NMVIntel Corp
			[V8] Vendor specific: L1D0
			[RV] Reserved: checksum good, 1 byte(s) reserved
		Read/write fields:
			[Y1] System specific: CCF1
		End
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [140 v1] Device Serial Number 60-04-03-ff-ff-fe-fd-3c
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available
	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: i40e
	Kernel modules: i40e


