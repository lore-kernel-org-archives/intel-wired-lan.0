From: Foster Snowhill <forst@forstwoof.ru>
Date: Wed, 18 May 2016 21:01:52 +0300
Subject: [Intel-wired-lan] [PROBLEM] igb transmit queue times out
Message-ID: <e13454e7-f27b-3ba9-a9fa-c51aac7a50b1@forstwoof.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

[1.] One line summary of the problem:

igb transmit queue times out


[2.] Full description of the problem/report:

Intel I210-AT NIC (igb module) running on the latest (4.6) kernel version suffers a "transmit queue 0 timed out" issue, which makes the NIC unusable. Each time this happens, the adapter is reset. The system runs on an ESXi 6.0 hypervisor and the NIC is attached to the VM via PCI passthrough. To trigger the bug, bring up the adapter and attempt to transmit something. In my case it was enough to configure IPv4 on it and ping something. The more data is attempted to be transmitted, the more often the abovementioned error occurs.

The following appears in the kernel log when the bug occurs (also appended relevant information, MAC addresses edited out).

igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
igb 0000:1b:00.0: enabling device (0000 -> 0002)
igb 0000:1b:00.0: added PHC on eth0
igb 0000:1b:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:1b:00.0: eth0: (PCIe:5.0Gb/s:unknown) XX:XX:XX:XX:XX:XX
igb 0000:1b:00.0: eth0: PBA No: 001300-000
igb 0000:1b:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 tx queue(s)
igb 0000:1b:00.0 eth-wan2: renamed from eth0
- -- snip --
- ------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at /home/kernel/COD/linux/net/sched/sch_generic.c:306 dev_watchdog+0x23e/0x240
NETDEV WATCHDOG: eth-wan2 (igb): transmit queue 0 timed out
Modules linked in: vmw_vsock_vmci_transport vsock hid_generic ppdev igb vmw_balloon usbhid coretemp nls_iso8859_1 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel ptp pps_core dca i2c_algo_bit psmouse hid input_leds serio_raw ahci vmxnet3 libahci parport_pc fjes parport 8250_fintek vmw_vmci pata_acpi i2c_piix4 mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_sa ib_mad ib_core ib_addr configfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 raid10 raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd vmwgfx ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm vmw_pvscsi shpchp
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-040600-generic #201605151930
Hardware name: VMware, Inc. VMware7,1/440BX Desktop Reference Platform, BIOS VMW71.00V.0.B64.1506250318 06/25/2015
 0000000000000286 0d6ae4d3e686a246 ffff88003a803d88 ffffffff813f1dd3
 ffff88003a803dd8 0000000000000000 ffff88003a803dc8 ffffffff810827eb
 0000013200000000 0000000000000000 0000000000000008 0000000000000000
Call Trace:
 <IRQ>  [<ffffffff813f1dd3>] dump_stack+0x63/0x90
 [<ffffffff810827eb>] __warn+0xcb/0xf0
 [<ffffffff8108286a>] warn_slowpath_fmt+0x5a/0x80
 [<ffffffff8175d35e>] dev_watchdog+0x23e/0x240
 [<ffffffff8175d120>] ? qdisc_rcu_free+0x40/0x40
 [<ffffffff810f06a5>] call_timer_fn+0x35/0x120
 [<ffffffff8175d120>] ? qdisc_rcu_free+0x40/0x40
 [<ffffffff810f1066>] run_timer_softirq+0x246/0x2f0
 [<ffffffff81844ca6>] __do_softirq+0xf6/0x27e
 [<ffffffff81088463>] irq_exit+0xa3/0xb0
 [<ffffffff81844ac2>] smp_apic_timer_interrupt+0x42/0x50
 [<ffffffff81842da2>] apic_timer_interrupt+0x82/0x90
 <EOI>  [<ffffffff81064a66>] ? native_safe_halt+0x6/0x10
 [<ffffffff81038fce>] default_idle+0x1e/0xd0
 [<ffffffff810397bf>] arch_cpu_idle+0xf/0x20
 [<ffffffff810c6fea>] default_idle_call+0x2a/0x40
 [<ffffffff810c72e7>] cpu_startup_entry+0x2e7/0x340
 [<ffffffff81835297>] rest_init+0x77/0x80
 [<ffffffff81f94011>] start_kernel+0x466/0x487
 [<ffffffff81f93120>] ? early_idt_handler_array+0x120/0x120
 [<ffffffff81f93354>] x86_64_start_reservations+0x38/0x3a
 [<ffffffff81f934a0>] x86_64_start_kernel+0x14a/0x16d
- ---[ end trace 7d52772030f95eac ]---
igb 0000:1b:00.0 eth-wan2: Reset adapter
igb 0000:1b:00.0 eth-wan2: igb: eth-wan2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX


[3.] Keywords (i.e., modules, networking, kernel):

networking, ethernet, intel, igb


[4.] Kernel information
[4.1.] Kernel version (from /proc/version):

Linux version 4.6.0-040600-generic (kernel at gomeisa) (gcc version 5.3.1 20160509 (Ubuntu 5.3.1-19ubuntu1) ) #201605151930 SMP Sun May 15 23:32:59 UTC 2016


[5.] Most recent kernel that did not have the bug:

Linux version 4.1.24-040124-generic (kernel at tangerine) (gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201605111232 SMP Web May 11 16:34:13 UTC 2016

Not tested with release candidates (such as 4.2-rcX), will do if necessary.


[8.] Environment
[8.5.] PCI information ('lspci -vvv' as root)

1b:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
    DeviceName: pciPassthru1
    Subsystem: ASUSTeK Computer Inc. I210 Gigabit Network Connection
    Physical Slot: 256
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at fd100000 (32-bit, non-prefetchable) [size=512K]
    Region 2: I/O ports at 3000 [disabled] [size=32]
    Region 3: Memory@fd180000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Address: 0000000000000000  Data: 0000
        Masking: 00000000  Pending: 00000000
    Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
        Vector table: BAR=3 offset=00000000
        PBA: BAR=3 offset=00002000
    Capabilities: [a0] Express (v2) Endpoint, MSI 00
        DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        LnkCap: Port #0, Speed 5GT/s, Width x32, ASPM L0s, Exit Latency L0s <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 5GT/s, Width x32, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v2] Advanced Error Reporting
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Device Serial Number XX-XX-XX-ff-ff-XX-XX-XX
    Capabilities: [1a0 v1] Transaction Processing Hints
        Device specific mode supported
        Steering table in TPH capability structure
    Kernel driver in use: igb
    Kernel modules: igb
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXPK4DAAoJECTakka9G8YA7KQP/R1/y+F0VM97871Ba29DW5uf
45lHq8uHG0duFTzV6EbrMvzvJ5qJm4IgYjb4qoNj/x3G0Ld3XhCab/KSX2qtcn9u
s5xq9EJHsKsPqtljrfAZjHJ8Be7wJCBcTxq34NYivLTfYo2Crv+reh1mrs7BWZT4
7rf9vyqstUOCzAH+qcPhmfqkeFL58I977RSZCmPSaxsLmktDHZEQzliJjac1kLyX
qe9LKRRXxl/XwT1OEbh1F0AY5/Y7aJhJA7XA7pdslKLBB0yk12NhqBWfWB1MjVYQ
J5WM8/hkVCb4WxhX1EcN0jsA6gqcbZfRnrsRwNYgi1S4czs6RzOmrWUirnLT46zv
duGVqS/bKJJzzP3fJjFO0Ql4RQNaaZFiLKCWTMLmF9caO3exhibfe4fgM/Jqg1aV
YuF3E27loZ20jpV1E+VzADyfXMvKQxy+gKezPI9qfno8xAD02u2a3qPqtA6RF2e9
b+kTqUoLpDZt79dYHpQP6NdP80NmE5xxtsJXlc99ccnQIFDgttzLaeHwuHTyo3vS
By3SQ7SWcVSWjmgSojCRIcExi6KJYXa6YZtIMYXJLHqMg7H5R7HMHd1iCJfBI6Oi
5Uf3WSCZqTtdo2N9cLu4IA4RYK7FSQrsnYq/IMGY2F1TW0uKDzKk6rqNAvNaoH0D
QSIkGcM5NxZ6QZrbBlLl
=ZqNi
-----END PGP SIGNATURE-----
