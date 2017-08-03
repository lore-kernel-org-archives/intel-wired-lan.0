From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 3 Aug 2017 12:59:32 +0800
Subject: [Intel-wired-lan] Runtime PM enabled I210 does not respond on
 cable plug event
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD681D8E337@ORSMSX114.amr.corp.intel.com>
References: <CAAd53p68i_mmt-gj1vL4ar+sh5-mtWg9V9Jiw_azq67+12zPxw@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD681D8E337@ORSMSX114.amr.corp.intel.com>
Message-ID: <CAAd53p6WkpQGCpXSTpw7cpBiMsu4fRx-UuU5CQmSfEE__qB+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 3, 2017 at 5:48 AM, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
> Sorry it took so long to get back to you. This is a high volume list of commits and you really should be using e1000-devel at sourceforge.net or linux-nics at intel.com for questions.

Sorry about that. It's because [1] lists here for "in-kernel support".
If it's not the best place for that, probably the page should be
updated...

> What are you trying to do? There's a good chance the PME bits are overridden by the NVM. Please check the i210 data sheet for more information. You should be able to find it on the intel.com web site and the easiest way to find it is to use google.

What I tried to do is to make i210 (igb) responses to ethernet cable
plug event when it's runtime suspended, i.e. igb_runtime_resume() not
being called.

Can you provide more information on when the NVM overrides the PME
bits, and how to disable this behavior? Also, the sheet mentioned a
"flash-less" mode - how do I enable it?

[1] https://sourceforge.net/projects/e1000/

>
> Todd Fujinaka
> Software Application Engineer
> Datacenter Engineering Group
> Intel Corporation
> todd.fujinaka at intel.com
> (503) 712-4565
>
>
> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Kai-Heng Feng
> Sent: Sunday, July 23, 2017 9:05 PM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] Runtime PM enabled I210 does not respond on cable plug event
>
> Hi,
>
> The device in question uses igb driver, the latest commit from jkirsher/next-queue.git does not help.
> I found a defined but not used variable, E1000_CTRL_EN_PHY_PWR_MGMT, and add the additional flag to ctrl doesn't help, either.
>
> I can provide more logs if needed.
> Below is the output from `lspci -vvv`, PME is suspiciously not enabled:
>
> 02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
>         Subsystem: Dell I210 Gigabit Network Connection
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 19
>         Region 0: Memory at 90100000 (32-bit, non-prefetchable) [size=512K]
>         Region 2: I/O ports at 2000 [size=32]
>         Region 3: Memory at 90180000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>                 Address: 0000000000000000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
>                 Vector table: BAR=3 offset=00000000
>                 PBA: BAR=3 offset=00002000
>         Capabilities: [a0] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
> AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <16us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Capabilities: [140 v1] Device Serial Number 48-4d-7e-ff-ff-e9-d7-35
>         Capabilities: [1a0 v1] Transaction Processing Hints
>                 Device specific mode supported
>                 Steering table in TPH capability structure
>         Kernel driver in use: igb
>         Kernel modules: igb
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
