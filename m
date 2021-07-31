From: Graeme Merrall <dasfreak@gmail.com>
Date: Sat, 31 Jul 2021 17:48:03 +0800
Subject: [Intel-wired-lan] Flapping e1000e on Intel NUC with Ubuntu/with
 kernel 5.8.0
Message-ID: <CAG5_Ya0QiRUfu85SQeZJ6toqLq6NKKL1pnggQU7DJc-tOowbng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Apologies if I've reached out to an incorrect list but not sure where to
ask about this issue.

Disclaimer: This might be due to physical damage but I'm trying to
establish other causes before I have to purchase a new NUC. Unfortunately
I'm not sure when this started happening. It's not been my primary computer
due to WFH since March 2020.

I discovered that my e100e integrated NIC is going up and down on a
seemingly regular cycle. The NIC goes down for 4 seconds, comes up for 12,
then goes down for 4 seconds and so on.

I inserted the module with
$ modprobe e1000e debug=16
and enabled logging on the module with
$ echo "module e1000e +flmpt" > /sys/kernel/debug/dynamic_debug/control

I've taken the liberty of attaching a section of kern.log file here. This
is my first foray into gathering this info from the kernel and I seem
unable to capture what's going on at the moment the module is loaded, so
I'm unsure if I've missed some information.

Some relevant information:
- I've updated my NUC BIOS to latest
- Swapped cables and ports. There may be a physical issue with the hub I'm
using but other devices don't appear to be affected
- I've removed the device from any network GUI settings. No IP is being
assigned. I'm just loading the module and bringing the interface up and
down AFAIK

Ubuntu: 20.04 LTS
NUC model: 8i7BEH
CPU: Intel(R) Core(TM) i7-8559U CPU @ 2.70GHz

Output from lspci
$ lspci -vvs 00:1F.6
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (6)
I219-V (rev 30)
        DeviceName:  LAN
        Subsystem: Intel Corporation Ethernet Connection (6) I219-V
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 128
        Region 0: Memory@c0a00000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee002f8  Data: 0000
        Kernel driver in use: e1000e
        Kernel modules: e1000e

Finally a quick view of the output from the ip tool when the link is up and
down in case it's a clue.

NIC is up:
$ ip -d -s link show eno1
5: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP
mode DEFAULT group default qlen 1000
   link/ether 94:c6:91:a7:78:3f brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu
68 maxmtu 9000 addrgenmode none numtxqueues 1
numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
   RX: bytes  packets  errors  dropped overrun mcast
   14312      120      0       8       0       0
   TX: bytes  packets  errors  dropped carrier collsns
   0          0        0       0       0       0
   altname enp0s31f6


NIC is down:
$ ip -d -s link show eno1
5: eno1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state
DOWN mode DEFAULT group default qlen 1000
    link/ether 94:c6:91:a7:78:3f brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu
68 maxmtu 9000 addrgenmode none numtxqueues 1 numrxqueues 1 gso_max_size
65536 gso_max_segs 65535
    RX: bytes  packets  errors  dropped overrun mcast
    14933      126      0       8       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
    altname enp0s31f6

Thanks for any insight you may be able to offer.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210731/9da98700/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kern.log
Type: text/x-log
Size: 76257 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210731/9da98700/attachment-0001.bin>
