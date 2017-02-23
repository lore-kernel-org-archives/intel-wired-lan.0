From: Norbert Lange <nolange79@gmail.com>
Date: Thu, 23 Feb 2017 10:13:58 +0100
Subject: [Intel-wired-lan] i354 regularly has "unexpected SYS WRAP" error,
	messing up ptp
Message-ID: <CADYdroNuO5RAuMeJigWiLDKvngTNAOOZ07QHSBtWmExGiJA1-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

every ~18 minutes this error comes up, causing trouble to the linuxptp stack.
OS is Debian 9

Kind regards,
Norbert Lange


Linux: 4.9.0-1-amd64 #1 SMP Debian 4.9.6-3 (2017-01-28) x86_64 GNU/Linux

00:14.0 Ethernet controller [0200]: Intel Corporation Ethernet
Connection I354 [8086:1f41] (rev 03)
Subsystem: Super Micro Computer Inc Ethernet Connection I354 [15d9:1f41]
Flags: bus master, fast devsel, latency 0, IRQ 20
Memory at df260000 (64-bit, non-prefetchable) [size=128K]
I/O ports at e0c0 [size=32]
Memory at df2ec000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
Capabilities: [100] Advanced Error Reporting
Capabilities: [140] Device Serial Number 0c-c4-7a-ff-ff-68-bf-64
Capabilities: [1a0] Transaction Processing Hints
Capabilities: [1d0] Access Control Services
Kernel driver in use: igb
Kernel modules: igb

system log:

Feb 23 09:29:50 debianroute ptp4l[3924]: [51680.227] timed out while
polling for tx timestamp
Feb 23 09:29:50 debianroute ptp4l[3924]: [51680.227] increasing
tx_timestamp_timeout may correct this issue, but it is likely caused
by a driver bug
Feb 23 09:29:50 debianroute ptp4l[3924]: [51680.227] port 1: send sync failed
Feb 23 09:29:50 debianroute kernel: igb 0000:00:14.0: unexpected SYS WRAP
Feb 23 09:29:50 debianroute ptp4l[3924]: [51680.227] port 1: MASTER to
FAULTY on FAULT_DETECTED (FT_UNSPECIFIED)
Feb 23 09:30:06 debianroute ptp4l[3924]: [51696.228] driver changed
our HWTSTAMP options
Feb 23 09:30:06 debianroute ptp4l[3924]: [51696.228] tx_type   1 not 1
Feb 23 09:30:06 debianroute ptp4l[3924]: [51696.228] rx_filter 1 not 12
Feb 23 09:30:06 debianroute ptp4l[3924]: [51696.228] port 1: FAULTY to
LISTENING on FAULT_CLEARED
Feb 23 09:30:13 debianroute ptp4l[3924]: [51703.091] port 1: LISTENING
to MASTER on ANNOUNCE_RECEIPT_TIMEOUT_EXPIRES
Feb 23 09:30:13 debianroute ptp4l[3924]: [51703.091] selected best
master clock 0cc47a.fffe.68bf64
Feb 23 09:30:13 debianroute ptp4l[3924]: [51703.091] assuming the
grand master role
Feb 23 09:48:10 debianroute ptp4l[3924]: [52780.168] timed out while
polling for tx timestamp
Feb 23 09:48:10 debianroute ptp4l[3924]: [52780.168] increasing
tx_timestamp_timeout may correct this issue, but it is likely caused
by a driver bug
Feb 23 09:48:10 debianroute ptp4l[3924]: [52780.168] port 1: send sync failed
Feb 23 09:48:10 debianroute kernel: igb 0000:00:14.0: unexpected SYS WRAP
