From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 8 Oct 2019 15:46:10 +0800
Subject: [Intel-wired-lan] e1000e regression - 5.4rc1
In-Reply-To: <76fc2204-0786-03b3-773d-110912d48168@mni.thm.de>
References: <171f0c61-73a2-81c2-5c8a-7c140f548803@mni.thm.de>
 <56242322-D549-4E23-97AB-153CC392B107@canonical.com>
 <76fc2204-0786-03b3-773d-110912d48168@mni.thm.de>
Message-ID: <2994F2A2-D844-40B0-9971-C002E5EC49CD@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Tobias,

> On Oct 5, 2019, at 03:52, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
> 
> Hello,
> 
> On 04.10.19 19:36, Kai-Heng Feng wrote:
>> Hi Tobias
>> 
>>> On Oct 4, 2019, at 18:34, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
>>> 
>>> Hello all,
>>> 
>>> While testing the 5.4rc1 release, i noticed my Ethernet never coming fully up, seemingly having a timeout problem. While bisecting this i landed at the commit dee23594d587386e9fda76732aa5f5a487709510 ("e1000e: Make speed detection on hotplugging cable more reliable") as the first bad commit. And indeed just reverting the commit on top of 5.4rc1 resolves the problem. Let me know if you have further questions, or patches to test!
>> Is runtime PM enabled (i.e. "power/control" = auto)?
> 
> 
> Yes it is set to auto.

Is something like TLP or `powertop --auto-tune` is in use?

Do you still see the issue when "power/control" keeps at "on"?

Kai-Heng

> 
> 
>> Also please attach full dmesg, thanks!
> 
> Attached,
> 
> Tobias
> 
>> 
>> Kai-Heng
>> 
>>> Greetings,
>>> 
>>> Tobias
>>> 
>>> 
>>> lspci:
>>> 
>>> 00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network Connection (rev 06)
>>>         DeviceName:  Onboard LAN
>>>         Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
>>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>         Latency: 0
>>>         Interrupt: pin A routed to IRQ 56
>>>         Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=128K]
>>>         Region 1: Memory at fbf28000 (32-bit, non-prefetchable) [size=4K]
>>>         Region 2: I/O ports at f040 [size=32]
>>>         Capabilities: [c8] Power Management version 2
>>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>                 Address: 00000000fee00698  Data: 0000
>>>         Capabilities: [e0] PCI Advanced Features
>>>                 AFCap: TP+ FLR+
>>>                 AFCtrl: FLR-
>>>                 AFStatus: TP-
>>>         Kernel driver in use: e1000e
>>>         Kernel modules: e1000e
>>> 
> <dmesg.txt>

