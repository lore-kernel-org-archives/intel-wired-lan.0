From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Date: Tue, 14 Mar 2017 09:28:09 +0100
Subject: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
 (Aaron F. Brown's message of "Tue, 14 Mar 2017 01:20:27 +0000")
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic>
 <20170312122621.GA2823@nazgul.tnic>
 <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
 <20170312222333.hm54nl2ul5iuixap@pd.tnic>
 <87shmhjfap.fsf@miraculix.mork.no>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
Message-ID: <87varci7om.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:
>> From: Bj?rn Mork [mailto:bjorn at mork.no]
>>
>> Already did that a week ago:
>> https://www.spinics.net/lists/netdev/msg423379.html
>> 
>> Haven't heard anything back yet.  Wondering if they are waiting for
>> someone else to submit the pretty obvious revert?  Don't understand why
>> that should take more than a minute to figure out.  It's not like they
>> are testing these changes anyway...
>
> Believe it or not we actually do test these changes.

Yes, I know you did. Sorry. I should stop throwing such comments around.

>This one was tested by me and I did not have the same results you and
>the other people reporting this trace did.  I made it back in the lab
>today and have spent a good part of the day attempting to reproduce
>this bug without success.  Freeze / resume works for me on all the
>systems I have tried, which includes a sampling of all the current
>parts and many older ones.  Given there are several other reports of
>this it is obviously an issue and I would like to be able to reproduce
>it in case another patch to resolve the issue this attempts to fix
>comes back in another form.  So I want to know what's different between
>the systems that hit this and my bank of systems that don't.
>
> What exact part (or parts) are we looking at (lspci|grep -i eth) that
> trigger this?  Could it be a difference in .config files?  The trace
> says it is falling back to legacy interrupts, does the system continue
> to work and does the network continue to function in that mode?  In
> case it's related to user space what is the base distro?  Any other
> information you think can help me reproduce the issue would be
> appreciated.

I have a somewhat newer laptop than Borislav. But mine is also a Lenovo
Thinkpad, so that might be a thing.  My system is a Lenovo Thinkpad X1
Carbon Gen4, which is a Skylake generation laptop.  lspci output as
configured in v4.9:

root at miraculix:/tmp# lspci -vvvnnxxxs 1f.6
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection I219-LM [8086:156f] (rev 21)
        Subsystem: Lenovo Ethernet Connection I219-LM [17aa:2233]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 134
        Region 0: Memory@e1300000 (32-bit, non-prefetchable) [disabled] [size=128K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00378  Data: 0000
        Capabilities: [e0] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: e1000e
        Kernel modules: e1000e
00: 86 80 6f 15 00 04 10 00 21 00 00 02 00 00 00 00
10: 00 00 30 e1 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 33 22
30: 00 00 00 00 c8 00 00 00 00 00 00 00 ff 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 28 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 01 00 00 00 03 10 03 10 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 23 c8 0b 21 00 00
d0: 05 e0 81 00 78 03 e0 fe 00 00 00 00 00 00 00 00
e0: 13 00 06 03 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



Attaching the .config. The laptop is running Debian sid, which is more
or less "stretch" now.  But I usually build my kernels on a Debian
stable ("jessie") system if that matters.

As for whether it works or not, I must admit that I haven't tested.
Wired ethernet is not something I use on a daily basis on this laptop.
Will test it when I find time, but sending this now so you have
something to start working with.

Thanks



Bj?rn
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-v4.11.0-rc1.gz
Type: application/gzip
Size: 29480 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170314/3c50e9d2/attachment-0001.bin>
