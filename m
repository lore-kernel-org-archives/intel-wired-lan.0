From: Ryan Goodfellow <rgoodfel@isi.edu>
Date: Tue, 31 May 2016 15:32:41 -0700
Subject: [Intel-wired-lan] fm10k driver questions
In-Reply-To: <1464732122.2599.50.camel@intel.com>
References: <CABnJGMiPnNDNyNX-=6J1QjxR=wjC09rN3qdJDzW2_Nq0fH4wCw@mail.gmail.com>
 <1464732122.2599.50.camel@intel.com>
Message-ID: <CABnJGMggAg0pp22f8JwrdGgSPn06zD2-k9AxzCP7SY3hCPSD-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 31, 2016 at 3:02 PM, Jeff Kirsher <jeffrey.t.kirsher@intel.com>
wrote:

> In kernel drivers do not have the module parameters option because the
> Linux community is not able to come to a standard, so have opted to use
> existing tools (i.e. ethtool, sysfs, etc.) for enabling/disabling/modifying
> features.  Our out-of-tree drivers, found on http://e1000.sf.net have the
> ability to load module parameters on load.
>
> In most cases, the in-kernel and out-of-tree versions are very close in
> functionality.  In the case of FM10K, the in-kernel version is the most up-
> to-date (unless you are using an older kernel, anything older than 4.6).
>
> We distribute the out-of-tree version for two reasons, one to give users
> the ability to do module parameters on module load and second is to provide
> our latest driver with the ability to load on older kernels (due to kcompat
> bundled with the out-of-tree driver).
>

Thank you very much, this is extremely useful information! We would
definitely like to use the in-tree version of the driver, so if there is
any documentation or pointers on how to use ethtool, sysfs and other tools
to control the card that would be great. Even just a pointer to the
relevant part of the code is fine. In this case relevant = initializing the
on-board switch so dpdk can use the card. Given that starting point I think
I should be able to figure things out more or less from reading the code.


> I will make sure that the FM10K developers review your issue and respond
> accordingly.  To help them, please provide what the kernel versions you are
> using as well as what driver versions you may have installed.  Since
> ethtool is not help report any info, you can use modinfo and lspci to
> report the driver and hardware information.


Thanks! Here is the requested info:

# uname -a
Linux mrtb0 4.4.0-22-generic #40-Ubuntu SMP Thu May 12 22:03:46 UTC 2016
x86_64 x86_64 x86_64 GNU/Linux

# modinfo fm10k
filename:
/lib/modules/4.4.0-22-generic/kernel/drivers/net/ethernet/intel/fm10k/fm10k.ko
version:        0.19.3-k
license:        GPL
description:    Intel(R) Ethernet Switch Host Interface Driver
author:         Intel Corporation, <linux.nics@intel.com>
srcversion:     2FC847E4AA68E2C08B4B274
alias:          pci:v00008086d000015A5sv*sd*bc*sc*i*
alias:          pci:v00008086d000015A4sv*sd*bc*sc*i*
depends:        ptp,vxlan
intree:         Y
vermagic:       4.4.0-22-generic SMP mod_unload modversions

# lspci -vvv
[...]
08:00.0 Ethernet controller: Intel Corporation Ethernet Switch FM10000 Host
Interface
        Subsystem: Intel Corporation Ethernet Switch FM10000 Host Interface
        Physical Slot: 1
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Region 0: Memory at f6000000 (64-bit, prefetchable) [size=4M]
        Region 2: Memory at f5ff0000 (64-bit, prefetchable) [size=8K]
        Region 4: Memory at f0000000 (64-bit, prefetchable) [size=64M]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
FLReset-
                        MaxPayload 256 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit
Latency L0s <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-,
OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-
SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+,
LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable+ Count=256 Masked-
                Vector table: BAR=2 offset=00000000
                PBA: BAR=2 offset=00001000
        Capabilities: [d0] Vital Product Data
                Product Name: FM10000
                Read-only fields:
                        [VS] Vendor specific: 0
                        [VP] Vendor specific: 2
                        [RV] Reserved: checksum good, 0 byte(s) reserved
                End
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr-
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
ChkEn-
        Capabilities: [148 v1] Device Serial Number a0-36-9f-ff-ff-60-b5-42
        Capabilities: [158 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 0
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [168 v1] #19
        Capabilities: [188 v1] Single Root I/O Virtualization (SR-IOV)
                IOVCap: Migration-, Interrupt Message Number: 000
                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
                IOVSta: Migration-
                Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function
Dependency Link: 00
                VF offset: 1, stride: 1, Device ID: 15a5
                Supported Page Size: 00000553, System Page Size: 00000001
                Region 0: Memory at 00000000e8000000 (64-bit, prefetchable)
                Region 2: Memory@00000000e7f80000 (64-bit, prefetchable)
                VF Migration: offset: 00000000, BIR: 0
        Kernel driver in use: fm10k
        Kernel modules: fm10k
[...]


-- 
*Ryan Goodfellow*
*Computer Scientist*
USC Information Sciences Institute
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160531/932500e3/attachment-0001.html>
