From: Jack Suter <jack@suter.io>
Date: Thu, 03 Nov 2016 07:48:33 -0400
Subject: [Intel-wired-lan] Kernel regression introduced by "e1000e: Do
 not write lsc to ics in msi-x mode" and/or "e1000e: Do not read ICR in
 Other interrupt"
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81FC067C@ORSMSX101.amr.corp.intel.com>
References: <1478044618.14119.774423193.0F79737A@webmail.messagingengine.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81FC067C@ORSMSX101.amr.corp.intel.com>
Message-ID: <1478173713.438028.776039273.598FEFE7@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > Reverting these two commits resolves the Link is Down/Link is Up
> > messages. This has been tested on about six servers so far and all have
> > stopped reporting these link flaps.
> 
> Are you able to revert either of the patches independently, I don't
> recall if they were stand alone or not.

I can try this shortly.

> Are they all 82574L or does it affect others?

All are 82574L. If the server has an 82574L it has seen a flap at least
once in the past two weeks when kernel upgrades began, though some are
much more frequent than others. 

Except for one, the affected servers are all HP DL120 G7s. The NIC has
firmware 2.1-2 as reported by `ethtool -i`.

The one is a Supermicro server with NIC firmware 1.8-0. Link flaps occur
most frequently on this server; 3963 such instances compared to at most
429 on an HP. It also has more network/disk activity than the affected
HPs.

> Is there any particular traffic pattern involved?  Sitting idle, moderate
> use, heavy constant flow? 

All are being used as file servers, so heavy network traffic and disk
I/O can be expected at times. `vnstat -d` shows the servers averaging
100 - 200 Mbit/s per day. The Supermicro averages closer to 300 Mbit/s
per day.

> Which kernel tree are you using?  Linus's upstream kernel from
> kernel.org, a distribution provided one or?  I'm generally working off of
> David Miller's net-next, but can try to repro the issue on my boxes if I
> know the exact kernel to work from.

I'm using a Gentoo Hardened kernel; specifically 4.7.9. It follows
grsecurity's patch so a 4.8 / 4.9 kernel is not available yet. 

> Perhaps a power saving state trying to kick in?  Bad cables or
> speed/duplex mismatches are common causes of link flap, but they seem
> unlikely given reverting the patches resolves the issue.

I'm not aware of any power save settings that should be trying to kick
in but I can investigate this angle further if you think it may be
related.

One of the HP servers was upgraded to (Gentoo Hardened) 4.5.7 back in
August and began experiencing these flaps shortly after. At the time it
was one of only a few servers on a 4.5+ series kernel and the first to
experience this issue, so it was treated as a physical layer issue. No
interface errors were seen switch-side[1], but the network cable was
replaced regardless. The link flaps on that server still continued. 

[1] As reported to me. I am not sure if the switch saw the link flaps
occurring.

> Those patches are interrupt related, what kind of interrupts are in use? 
> What is interrupt moderation (coalescing set to)?  What is the link
> partner?  Same type switch for all problem machines or a mix?
> 
> cat /proc/interrupts
> ethtool -c enp2s0

Mostly the same type of switch; either Juniper EX3200 or EX3300. All
single connections to the switch, no LACP or anything fancy.

`cat /proc/interrupts` from two HP servers are below. One server is
still experiencing flaps; the other was rebooted ~30 hours ago into the
patched kernel. I can provide /proc/interrupts for the Supermicro server
too, but there isn't a similar server to compare it to. It also has many
more CPUs so its output is a bit messier.

From ethtool -c; all other values are zero and available in full below.
Applies to both HP and Supermicro.
    Adaptive RX: off  TX: off
    rx-usecs: 3

> maybe an `lspci` dump could help shed some more light.

From the HPs:
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor
Family DRAM Controller (rev 09)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
Processor Family PCI Express Root Port (rev 09)
00:06.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
Processor Family PCI Express Root Port (rev 09)
00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #2 (rev 05)
00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 1 (rev b5)
00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 5 (rev b5)
00:1c.5 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 6 (rev b5)
00:1c.6 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 7 (rev b5)
00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 8 (rev b5)
00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #1 (rev 05)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5)
00:1f.0 ISA bridge: Intel Corporation C204 Chipset Family LPC Controller
(rev 05)
00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset
Family SATA AHCI Controller (rev 05)
01:00.0 System peripheral: Hewlett-Packard Company Integrated Lights-Out
Standard Slave Instrumentation & System Support (rev 05)
01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA
G200EH
01:00.2 System peripheral: Hewlett-Packard Company Integrated Lights-Out
Standard Management Processor Support and Messaging (rev 05)
01:00.4 USB controller: Hewlett-Packard Company Integrated Lights-Out
Standard Virtual USB Controller (rev 02)
02:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection
03:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection

And the Supermicro: 
00:00.0 Host bridge: Intel Corporation 5500 I/O Hub to ESI Port (rev 22)
00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express
Root Port 1 (rev 22)
00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express
Root Port 3 (rev 22)
00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express
Root Port 7 (rev 22)
00:09.0 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
Express Root Port 9 (rev 22)
00:13.0 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub I/OxAPIC
Interrupt Controller (rev 22)
00:14.0 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub System
Management Registers (rev 22)
00:14.1 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO and
Scratch Pad Registers (rev 22)
00:14.2 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Control Status
and RAS Registers (rev 22)
00:14.3 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Throttle
Registers (rev 22)
00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset
QuickData Technology Device (rev 22)
00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #4
00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #5
00:1a.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #6
00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2
EHCI Controller #2
00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
Root Port 1
00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
Root Port 5
00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
Root Port 6
00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #1
00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #2
00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #3
00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2
EHCI Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface
Controller
00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA
AHCI Controller
00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
05:00.0 RAID bus controller: 3ware Inc 9650SE SATA-II RAID PCIe (rev 01)
06:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection
07:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection
08:01.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA
G200eW WPCM450 (rev 0a)
fe:00.0 Host bridge: Intel Corporation Xeon 5600 Series QuickPath
Architecture Generic Non-core Registers (rev 02)
fe:00.1 Host bridge: Intel Corporation Xeon 5600 Series QuickPath
Architecture System Address Decoder (rev 02)
fe:02.0 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 0 (rev
02)
fe:02.1 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 0
(rev 02)
fe:02.2 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link
0 (rev 02)
fe:02.3 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link
1 (rev 02)
fe:02.4 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 1 (rev
02)
fe:02.5 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 1
(rev 02)
fe:03.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Registers (rev 02)
fe:03.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Target Address Decoder (rev 02)
fe:03.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller RAS Registers (rev 02)
fe:03.4 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Test Registers (rev 02)
fe:04.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Control (rev 02)
fe:04.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Address (rev 02)
fe:04.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Rank (rev 02)
fe:04.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Thermal Control (rev 02)
fe:05.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Control (rev 02)
fe:05.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Address (rev 02)
fe:05.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Rank (rev 02)
fe:05.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Thermal Control (rev 02)
fe:06.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Control (rev 02)
fe:06.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Address (rev 02)
fe:06.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Rank (rev 02)
fe:06.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Thermal Control (rev 02)
ff:00.0 Host bridge: Intel Corporation Xeon 5600 Series QuickPath
Architecture Generic Non-core Registers (rev 02)
ff:00.1 Host bridge: Intel Corporation Xeon 5600 Series QuickPath
Architecture System Address Decoder (rev 02)
ff:02.0 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 0 (rev
02)
ff:02.1 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 0
(rev 02)
ff:02.2 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link
0 (rev 02)
ff:02.3 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link
1 (rev 02)
ff:02.4 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 1 (rev
02)
ff:02.5 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 1
(rev 02)
ff:03.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Registers (rev 02)
ff:03.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Target Address Decoder (rev 02)
ff:03.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller RAS Registers (rev 02)
ff:03.4 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Test Registers (rev 02)
ff:04.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Control (rev 02)
ff:04.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Address (rev 02)
ff:04.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Rank (rev 02)
ff:04.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 0 Thermal Control (rev 02)
ff:05.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Control (rev 02)
ff:05.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Address (rev 02)
ff:05.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Rank (rev 02)
ff:05.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 1 Thermal Control (rev 02)
ff:06.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Control (rev 02)
ff:06.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Address (rev 02)
ff:06.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Rank (rev 02)
ff:06.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated
Memory Controller Channel 2 Thermal Control (rev 02)


From an HP server without the two reverted commits, still experiencing
flaps:
# dmesg | grep 'Link is Down' | wc -l
160
# cat /proc/interrupts 
           CPU0       CPU1       
  0:         71          0   IO-APIC   2-edge      timer
  1:          9          0   IO-APIC   1-edge      i8042
  8:         26          0   IO-APIC   8-edge      rtc0
  9:          0          0   IO-APIC   9-fasteoi   acpi
 12:          5          0   IO-APIC  12-edge      i8042
 16:        101          0   IO-APIC  16-fasteoi   uhci_hcd:usb3
 20:         29          0   IO-APIC  20-fasteoi   ehci_hcd:usb2
 21:         31          0   IO-APIC  21-fasteoi   ehci_hcd:usb1
 26:  466035195          0   PCI-MSI 512000-edge      ahci[0000:00:1f.2]
 27: 4011416578          0   PCI-MSI 1048576-edge      enp2s0-rx-0
 28: 2635120533          0   PCI-MSI 1048577-edge      enp2s0-tx-0
 29:      21247          0   PCI-MSI 1048578-edge      enp2s0
NMI:      32827      13374   Non-maskable interrupts
LOC:  639865868  608834533   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:      32827      13374   Performance monitoring interrupts
IWI:          6          0   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:   53178810  784807944   Rescheduling interrupts
CAL:      47602      16104   Function call interrupts
TLB:   14655054    5994312   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
DFR:          0          0   Deferred Error APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:       3134       3134   Machine check polls
ERR:          0
MIS:          0
PIN:          0          0   Posted-interrupt notification event
PIW:          0          0   Posted-interrupt wakeup event

From an HP server that was previously affected but now has the patched
kernel:
# cat /proc/interrupts 
           CPU0       CPU1       
  0:         27          0   IO-APIC   2-edge      timer
  1:          9          0   IO-APIC   1-edge      i8042
  8:         63          0   IO-APIC   8-edge      rtc0
  9:          0          0   IO-APIC   9-fasteoi   acpi
 12:          5          0   IO-APIC  12-edge      i8042
 16:          0          0   IO-APIC  16-fasteoi   uhci_hcd:usb3
 20:         29          0   IO-APIC  20-fasteoi   ehci_hcd:usb2
 21:         31          0   IO-APIC  21-fasteoi   ehci_hcd:usb1
 26:   10222204          0   PCI-MSI 512000-edge      ahci[0000:00:1f.2]
 27:  260871340          0   PCI-MSI 1048576-edge      enp2s0-rx-0
 28:  320328246          0   PCI-MSI 1048577-edge      enp2s0-tx-0
 29:          2          0   PCI-MSI 1048578-edge      enp2s0
NMI:       1023        520   Non-maskable interrupts
LOC:   55824119   46253516   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:       1023        520   Performance monitoring interrupts
IWI:          4          0   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:     963280   23369703   Rescheduling interrupts
CAL:        711        450   Function call interrupts
TLB:     104153      57497   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
DFR:          0          0   Deferred Error APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:        381        381   Machine check polls
ERR:          0
MIS:          0
PIN:          0          0   Posted-interrupt notification event
PIW:          0          0   Posted-interrupt wakeup event

# ethtool -c enp2s0
Coalesce parameters for enp2s0:
Adaptive RX: off  TX: off
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 3
rx-frames: 0
rx-usecs-irq: 0
rx-frames-irq: 0

tx-usecs: 0
tx-frames: 0
tx-usecs-irq: 0
tx-frames-irq: 0

rx-usecs-low: 0
rx-frame-low: 0
tx-usecs-low: 0
tx-frame-low: 0

rx-usecs-high: 0
rx-frame-high: 0
tx-usecs-high: 0
tx-frame-high: 0
