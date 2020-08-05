From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Wed, 5 Aug 2020 02:42:54 +0200
Subject: [Intel-wired-lan] Deep package C-states cannot be reached on e1000e
 after resume from suspend
Message-ID: <CADS+iDVjpGVQifg+RtNEQKJw4ePe6+ViUpto8U1v0Xv1HwN2-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello! I've found that my laptop (T460s) cannot reach Package C-states
deeper than PC2. After some research, I've found that unplugging cable
from my laptop and plugging it back fixes that, until the laptop is
suspended. After resume, this problem returns, but unplugging and
plugging fix it again.
I'm using kernel 5.8.0, but I've seen the same behavior on previous
kernel as well.

Here is a lspci -n -vv excerpt:
00:1f.6 0200: 8086:156f (rev 21)
    Subsystem: 17aa:2233
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 129
    Region 0: Memory@e1100000 (32-bit, non-prefetchable) [size=128K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee002f8  Data: 0000
    Capabilities: [e0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: e1000e
    Kernel modules: e1000e

/sys/bus/pci/devices/0000:00:1f.6/power/control = on (I've changed it
to auto, but no change in behavoir)
