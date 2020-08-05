From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Wed, 5 Aug 2020 21:18:09 +0200
Subject: [Intel-wired-lan] Deep package C-states cannot be reached on
 e1000e after resume from suspend
In-Reply-To: <013f9961-a7fc-0d60-eea3-30b5171a27e1@intel.com>
References: <CADS+iDVjpGVQifg+RtNEQKJw4ePe6+ViUpto8U1v0Xv1HwN2-Q@mail.gmail.com>
 <013f9961-a7fc-0d60-eea3-30b5171a27e1@intel.com>
Message-ID: <CADS+iDVfMUHYrhWvs5SmjKiH6wCp3M34kP80Apzaq9DspVrU5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vitaly,
Thank you, I've tried, but no change in C-states. I do not understand
why unplugging and plugging cable back fix my issue...
I've also found that if I plug cable immediately after unplugging, it
also doesn't fix my problem. I should unplug cable, wait until there
are numbers in RC6+ columns in turbostat, and only then I can insert
the cable back.

??, 5 ???. 2020 ?. ? 13:34, Vitaly Lifshits <vitaly.lifshits@intel.com>:
>
> Hello Yatoslav,
>
> On 8/5/2020 03:42, Yaroslav Isakov wrote:
> > Hello! I've found that my laptop (T460s) cannot reach Package C-states
> > deeper than PC2. After some research, I've found that unplugging cable
> > from my laptop and plugging it back fixes that, until the laptop is
> > suspended. After resume, this problem returns, but unplugging and
> > plugging fix it again.
> > I'm using kernel 5.8.0, but I've seen the same behavior on previous
> > kernel as well.
> >
> > Here is a lspci -n -vv excerpt:
> > 00:1f.6 0200: 8086:156f (rev 21)
> >      Subsystem: 17aa:2233
> >      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx+
> >      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >      Latency: 0
> >      Interrupt: pin A routed to IRQ 129
> >      Region 0: Memory at e1100000 (32-bit, non-prefetchable) [size=128K]
> >      Capabilities: [c8] Power Management version 3
> >          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
> >      Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >          Address: 00000000fee002f8  Data: 0000
> >      Capabilities: [e0] PCI Advanced Features
> >          AFCap: TP+ FLR+
> >          AFCtrl: FLR-
> >          AFStatus: TP-
> >      Kernel driver in use: e1000e
> >      Kernel modules: e1000e
> >
> > /sys/bus/pci/devices/0000:00:1f.6/power/control = on (I've changed it
> > to auto, but no change in behavoir)
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> >
>
> In order to be able to reach the lowest power state with connected cable
> you need to set pmc to ignore ltr from the GBE.
>
> You can do it by executing:
> echo 3 > /sys/kernel/debug/pmc_core/ltr_ignore
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
