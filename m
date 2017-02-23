From: Norbert Lange <nolange79@gmail.com>
Date: Thu, 23 Feb 2017 10:07:28 +0100
Subject: [Intel-wired-lan] Intel 82579LM has totally wrong PTP timer
Message-ID: <CADYdroOv+pqO=wHbSPXaKt61iS0im2ra_j85NFigukys+5QAVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I recently tried linuxptp with a 82579LM Ethernet controller (as clock
master), with the slave displaying alot nonsensical numbers. I watched
the packets with wireshark, and the frequency seems of by almost a
factor 4.
The "Followup" packets are sent very precisely every second, but the
contained timestamp increases almost by 4 seconds.

Can a driver issue be ruled out?

Kind regards,
Norbert Lange


Linux: 4.9.0-1-amd64 #1 SMP Debian 4.9.6-3 (2017-01-28) x86_64 GNU/Linux

00:19.0 Ethernet controller [0200]: Intel Corporation 82579LM Gigabit
Network Connection [8086:1502] (rev 06)
Subsystem: Dell 82579LM Gigabit Network Connection [1028:05d2]
Flags: bus master, fast devsel, latency 0, IRQ 33, NUMA node 0
Memory at fb400000 (32-bit, non-prefetchable) [size=128K]
Memory at fb428000 (32-bit, non-prefetchable) [size=4K]
I/O ports at f040 [size=32]
Capabilities: [c8] Power Management version 2
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Capabilities: [e0] PCI Advanced Features
Kernel driver in use: e1000e
Kernel modules: e1000e


Time stamping parameters for enp0s25:
Capabilities:
hardware-transmit     (SOF_TIMESTAMPING_TX_HARDWARE)
software-transmit     (SOF_TIMESTAMPING_TX_SOFTWARE)
hardware-receive      (SOF_TIMESTAMPING_RX_HARDWARE)
software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
hardware-raw-clock    (SOF_TIMESTAMPING_RAW_HARDWARE)
PTP Hardware Clock: 0
Hardware Transmit Timestamp Modes:
off                   (HWTSTAMP_TX_OFF)
on                    (HWTSTAMP_TX_ON)
Hardware Receive Filter Modes:
none                  (HWTSTAMP_FILTER_NONE)
all                   (HWTSTAMP_FILTER_ALL)
ptpv1-l4-sync         (HWTSTAMP_FILTER_PTP_V1_L4_SYNC)
ptpv1-l4-delay-req    (HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ)
ptpv2-l4-sync         (HWTSTAMP_FILTER_PTP_V2_L4_SYNC)
ptpv2-l4-delay-req    (HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ)
ptpv2-l2-sync         (HWTSTAMP_FILTER_PTP_V2_L2_SYNC)
ptpv2-l2-delay-req    (HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ)
ptpv2-event           (HWTSTAMP_FILTER_PTP_V2_EVENT)
ptpv2-sync            (HWTSTAMP_FILTER_PTP_V2_SYNC)
ptpv2-delay-req       (HWTSTAMP_FILTER_PTP_V2_DELAY_REQ)
