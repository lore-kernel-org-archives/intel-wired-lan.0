From: Borislav Petkov <bp@alien8.de>
Date: Tue, 14 Mar 2017 02:43:36 +0100
Subject: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic>
 <20170312122621.GA2823@nazgul.tnic>
 <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
 <20170312222333.hm54nl2ul5iuixap@pd.tnic>
 <87shmhjfap.fsf@miraculix.mork.no>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
Message-ID: <20170314014249.renvu35ne7uhwwaq@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 14, 2017 at 01:20:27AM +0000, Brown, Aaron F wrote:
> Believe it or not we actually do test these changes. This one was
> tested by me and I did not have the same results you and the other
> people reporting this trace did. I made it back in the lab today and
> have spent a good part of the day attempting to reproduce this bug
> without success. Freeze / resume works for me on all the systems I
> have tried, which includes a sampling of all the current parts and
> many older ones.

Yeah, tell me about it.

> Given there are several other reports of this it is obviously an issue
> and I would like to be able to reproduce it in case another patch to
> resolve the issue this attempts to fix comes back in another form. So
> I want to know what's different between the systems that hit this and
> my bank of systems that don't.

So mine is not the newest anymore: thinkpad x230.

> What exact part (or parts) are we looking at (lspci|grep -i eth)

Lemme give you the gory details (PCI cfg space etc):

$ lspci -xxx -vvvv | grep -i eth -A 36
00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)
        Subsystem: Lenovo 82579LM Gigabit Network Connection
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 30
        Region 0: Memory at f1500000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at f153b000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports@4080 [size=32]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee002d8  Data: 0000
        Capabilities: [e0] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: e1000e
        Kernel modules: e1000e
00: 86 80 02 15 07 04 10 00 04 00 00 02 00 00 00 00
10: 00 00 50 f1 00 b0 53 f1 81 40 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 f3 21
30: 00 00 00 00 c8 00 00 00 00 00 00 00 07 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 c8 00 20 00 07
d0: 05 e0 81 00 d8 02 e0 fe 00 00 00 00 00 00 00 00
e0: 13 00 06 03 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

> that trigger this? Could it be a difference in .config files? The

.config attached.

> trace says it is falling back to legacy interrupts, does the system
> continue to work and does the network continue to function in that
> mode?

Not really. I tried halting it after the splat but it started powering
down and deadlocked on something. Had to cold-reset.

> Any other information you think can help me reproduce the issue would
> be appreciated.

So the real question is why does it fail setting up MSI interrupts. I'd
look into that part of the driver...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-4.10.0+.gz
Type: application/gzip
Size: 26216 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170314/9e9871ab/attachment-0001.bin>
