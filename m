From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 6 Aug 2019 17:36:06 +0200
Subject: [Intel-wired-lan] MDI errors during resume from ACPI S3 (suspend to
 ram)
Message-ID: <81004059-6d91-d8be-c80e-70c52359350d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


Trying to decrease the resume time of Linux 5.3-rc3 on the Dell OptiPlex
5040 with the device below

    $ lspci -nn -s 00:1f.6
    00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2) I219-V [8086:15b8] (rev 31)

pm-graph?s script `sleepgraph.py` shows, that the driver *e1000e* takes
around 400 ms, which is quite a lot. The call graph trace shows that
`e1000e_read_phy_reg_mdic()` is responsible for a lot of those. From
`drivers/net/ethernet/intel/e1000e/phy.c` [1]:

        for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
                udelay(50);
                mdic = er32(MDIC);
                if (mdic & E1000_MDIC_READY)
                        break;
        }
        if (!(mdic & E1000_MDIC_READY)) {
                e_dbg("MDI Read did not complete\n");
                return -E1000_ERR_PHY;
        }
        if (mdic & E1000_MDIC_ERROR) {
                e_dbg("MDI Error\n");
                return -E1000_ERR_PHY;
        }

Unfortunately, errors are not logged if dynamic debug is disabled,
so rebuilding the Linux kernel with `CONFIG_DYNAMIC_DEBUG`, and

    echo "file drivers/net/ethernet/* +p" | sudo tee /sys/kernel/debug/dynamic_debug/control

I got the messages below.

    [ 4159.204192] e1000e 0000:00:1f.6 net00: MDI Error
    [ 4160.267950] e1000e 0000:00:1f.6 net00: MDI Write did not complete
    [ 4160.359855] e1000e 0000:00:1f.6 net00: MDI Error

Can you please shed a little more light into these errors? Please
find the full log attached.


Kind regards,

Paul


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/e1000e/phy.c#n206
-------------- next part --------------
[    0.607722] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.608268] system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.608813] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.609359] system 00:08: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.609905] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.610450] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    0.610994] system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.611567] system 00:08: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.612113] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.612138] system 00:09: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.612682] system 00:09: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.613228] system 00:09: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.613773] system 00:09: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.614347] system 00:09: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.614892] system 00:09: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.615437] system 00:09: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.615984] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.616165] system 00:0a: [io  0xff00-0xfffe] has been reserved
[    0.616656] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.617377] system 00:0b: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.617924] system 00:0b: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.618468] system 00:0b: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.619015] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.619567] pnp: PnP ACPI: found 12 devices
[    0.620626] thermal_sys: Registered thermal governor 'step_wise'
[    0.620627] thermal_sys: Registered thermal governor 'user_space'
[    0.625646] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.626880] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.627293] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.627796] pci 0000:00:01.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    0.628356] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.628995] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.629420] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    0.629859] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.630368] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.630879] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.631444] pci_bus 0000:00: resource 7 [mem 0xe0000000-0xf7ffffff window]
[    0.632010] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    0.632576] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.633037] pci_bus 0000:01: resource 1 [mem 0xf7e00000-0xf7efffff]
[    0.633554] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xefffffff 64bit pref]
[    0.634241] NET: Registered protocol family 2
[    0.634681] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.635406] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.636144] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.636922] TCP: Hash tables configured (established 65536 bind 65536)
[    0.637477] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.638058] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.639376] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.640089] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.640617] PCI: CLS 0 bytes, default 64
[    0.640980] Trying to unpack rootfs image as initramfs...
[    0.698966] Freeing initrd memory: 5136K
[    0.699300] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.699832] software IO TLB: mapped [mem 0xd2a46000-0xd6a46000] (64MB)
[    0.700453] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[    0.701105] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    0.701579] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.702048] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    0.702886] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    0.703515] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[    0.704226] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.704851] io scheduler mq-deadline registered
[    0.705228] io scheduler kyber registered
[    0.705854] efifb: probing for efifb
[    0.706161] efifb: framebuffer at 0xe0000000, using 3072k, total 3072k
[    0.706698] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    0.707194] efifb: scrolling: redraw
[    0.707494] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.708970] Console: switching to colour frame buffer device 128x48
[    0.710450] fb0: EFI VGA frame buffer device
[    0.710817] IPMI message handler: version 39.2
[    0.711199] ipmi device interface
[    0.711488] ipmi_si: IPMI System Interface driver
[    0.711907] ipmi_si: Unable to find any System Interface(s)
[    0.712379] IPMI Watchdog: driver initialized
[    0.712750] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
[    0.713551] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.714256] ACPI: Sleep Button [SLPB]
[    0.714588] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.715291] ACPI: Power Button [PWRB]
[    0.715624] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.716252] ACPI: Power Button [PWRF]
[    0.746206] Monitor-Mwait will be used to enter C-1 state
[    0.746210] Monitor-Mwait will be used to enter C-2 state
[    0.746213] Monitor-Mwait will be used to enter C-3 state
[    0.777203] thermal LNXTHERM:00: registered as thermal_zone0
[    0.777688] ACPI: Thermal Zone [TZ00] (28 C)
[    0.778172] thermal LNXTHERM:01: registered as thermal_zone1
[    0.778653] ACPI: Thermal Zone [TZ01] (30 C)
[    0.779168] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.800445] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.801827] lp: driver loaded but no devices found
[    0.802434] Linux agpgart interface v0.103
[    0.805494] brd: module loaded
[    0.807073] loop: module loaded
[    0.812653] drbd: initialized. Version: 8.4.11 (api:1/proto:86-101)
[    0.813672] drbd: built-in
[    0.814400] drbd: registered as block device major 147
[    0.815306] Uniform Multi-Platform E-IDE driver
[    0.816611] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
[    0.817928] legacy IDE will be removed in 2021, please switch to libata
               Report any missing HW support to linux-ide at vger.kernel.org
[    0.819932] Probing IDE interface ide0...
[    1.343108] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    1.343996] legacy IDE will be removed in 2021, please switch to libata
               Report any missing HW support to linux-ide at vger.kernel.org
[    1.346075] Probing IDE interface ide1...
[    1.722068] tsc: Refined TSC clocksource calibration: 3312.001 MHz
[    1.723099] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fbd9516ca9, max_idle_ns: 440795225028 ns
[    1.724491] clocksource: Switched to clocksource tsc
[    1.869107] ide1 at 0x170-0x177,0x376 on irq 15
[    1.870005] ide-gd driver 1.18
[    1.870767] ide-cd driver 5.00
[    1.871654] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
[    1.872841] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
[    1.873926] megasas: 07.710.50.00-rc1
[    1.874761] mpt3sas version 29.100.00.00 loaded
[    1.876365] ahci 0000:00:17.0: version 3.0
[    1.886754] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.887902] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[    1.898618] scsi host0: ahci
[    1.899658] scsi host1: ahci
[    1.900763] scsi host2: ahci
[    1.901781] scsi host3: ahci
[    1.902559] ata1: SATA max UDMA/133 abar m2048 at 0xf7f4b000 port 0xf7f4b100 irq 122
[    1.903684] ata2: SATA max UDMA/133 abar m2048 at 0xf7f4b000 port 0xf7f4b180 irq 122
[    1.904805] ata3: SATA max UDMA/133 abar m2048 at 0xf7f4b000 port 0xf7f4b200 irq 122
[    1.905921] ata4: SATA max UDMA/133 abar m2048 at 0xf7f4b000 port 0xf7f4b280 irq 122
[    1.907208] tun: Universal TUN/TAP device driver, 1.6
[    1.908260] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.713.36-0 (2014/02/10)
[    1.909740] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    1.910738] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.911683] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.912746] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.913716] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.914673] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.915757] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    2.216986] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.218004] ata3: SATA link down (SStatus 4 SControl 300)
[    2.218953] ata4: SATA link down (SStatus 4 SControl 300)
[    2.219894] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.220896] ata2.00: ATAPI: HL-DT-ST DVD+/-RW GU90N, A1C0, max UDMA/100
[    2.226145] ata2.00: configured for UDMA/100
[    2.250102] ata1.00: ATA-8: ST3250310NS, SN06, max UDMA/133
[    2.251061] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 32)
[    2.294556] ata1.00: configured for UDMA/133
[    2.295572] scsi 0:0:0:0: Direct-Access     ATA      ST3250310NS      SN06 PQ: 0 ANSI: 5
[    2.296867] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    2.296875] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    2.296888] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.298652] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GU90N    A1C0 PQ: 0 ANSI: 5
[    2.299100] sd 0:0:0:0: [sda] Write Protect is off
[    2.302056] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.302062] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.319398]  sda: sda1 sda2 sda3
[    2.320688] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.346628] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.347835] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.349001] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.349123] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    2.362252] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:00:6a:2c:10:c1
[    2.363397] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    2.364531] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    2.365604] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
[    2.366669] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.367630] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    2.368768] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.369776] sky2: driver version 1.30
[    2.370636] Fusion MPT base driver 3.04.20
[    2.371445] Copyright (c) 1999-2008 LSI Corporation
[    2.372309] Fusion MPT SPI Host driver 3.04.20
[    2.373146] Fusion MPT FC Host driver 3.04.20
[    2.373979] Fusion MPT SAS Host driver 3.04.20
[    2.374801] Fusion MPT misc device (ioctl) driver 3.04.20
[    2.375791] mptctl: Registered with Fusion MPT base driver
[    2.376724] mptctl: /dev/mptctl @ (major,minor=10,220)
[    2.377619] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.378639] ehci-pci: EHCI PCI platform driver
[    2.379489] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.380458] ohci-pci: OHCI PCI platform driver
[    2.381297] uhci_hcd: USB Universal Host Controller Interface driver
[    2.382401] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.383297] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.385416] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
[    2.386632] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.387969] hub 1-0:1.0: USB hub found
[    2.388714] hub 1-0:1.0: 16 ports detected
[    2.390316] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.391211] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.392278] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.393428] hub 2-0:1.0: USB hub found
[    2.394210] hub 2-0:1.0: 10 ports detected
[    2.395391] usb: port power management may be unreliable
[    2.396526] usbcore: registered new interface driver usb-storage
[    2.397491] usbcore: registered new interface driver ftdi_sio
[    2.398422] usbserial: USB Serial support registered for FTDI USB Serial Device
[    2.399479] usbcore: registered new interface driver omninet
[    2.400397] usbserial: USB Serial support registered for ZyXEL - omni.net lcd plus usb
[    2.401511] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    2.405499] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.406384] serio: i8042 AUX port@0x60,0x64 irq 12
[    2.407687] rtc_cmos 00:06: RTC can wake from S4
[    2.409062] rtc_cmos 00:06: registered as rtc0
[    2.409835] rtc_cmos 00:06: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    2.411045] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.411981] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.416233] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.417222] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[    2.418540] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    2.419490] iTCO_vendor_support: vendor-support=0
[    2.420310] nv_tco: NV TCO WatchDog Timer Driver v0.01
[    2.421429] intel_pstate: Intel P-state driver initializing
[    2.423437] intel_pstate: HWP enabled
[    2.424172] EFI Variables Facility v0.08 2004-May-17
[    2.432301] hidraw: raw HID events driver (C) Jiri Kosina
[    2.433266] usbcore: registered new interface driver usbhid
[    2.434144] usbhid: USB HID core driver
[    2.434941] Key type dns_resolver registered
[    2.436323] microcode: sig=0x506e3, pf=0x2, revision=0xc6
[    2.437263] microcode: Microcode Update Driver: v2.2.
[    2.437282] sched_clock: Marking stable (2363094852, 73741740)->(2453500722, -16664130)
[    2.439702] registered taskstats version 1
[    2.441147] rtc_cmos 00:06: setting system clock to 2019-08-06T13:50:01 UTC (1565099401)
[    2.442838] Freeing unused kernel image memory: 1612K
[    2.446082] Write protecting the kernel read-only data: 20480k
[    2.447468] Freeing unused kernel image memory: 2012K
[    2.448518] Freeing unused kernel image memory: 704K
[    2.449406] Run /init as init process
[    2.693542] random: fast init done
[    2.716082] usb 1-6: new low-speed USB device number 2 using xhci_hcd
[    2.796931] XFS (sda1): Mounting V5 Filesystem
[    2.857612] input: Fujitsu Fujitsu Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/0003:0BF8:101E.0001/input/input6
[    2.911351] hid-generic 0003:0BF8:101E.0001: input,hidraw0: USB HID v1.10 Keyboard [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-6/input0
[    2.920393] input: Fujitsu Fujitsu Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.1/0003:0BF8:101E.0002/input/input7
[    2.939336] XFS (sda1): Ending clean mount
[    2.974260] input: Fujitsu Fujitsu Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.1/0003:0BF8:101E.0002/input/input8
[    2.976569] hid-generic 0003:0BF8:101E.0002: input,hidraw1: USB HID v1.10 Device [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-6/input1
[    3.093082] usb 1-8: new low-speed USB device number 3 using xhci_hcd
[    3.227668] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:046D:C077.0003/input/input9
[    3.229978] hid-generic 0003:046D:C077.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-8/input0
[    3.346088] usb 1-10: new high-speed USB device number 4 using xhci_hcd
[    3.446058] random: crng init done
[    3.480425] usb-storage 1-10:1.0: USB Mass Storage device detected
[    3.481808] scsi host4: usb-storage 1-10:1.0
[    4.129869] systemd[1]: Inserted module 'autofs4'
[    4.388065] NET: Registered protocol family 10
[    4.389317] Segment Routing with IPv6
[    4.430772] NET: Registered protocol family 1
[    4.431792] systemd[1]: Inserted module 'unix'
[    4.540776] scsi 4:0:0:0: Direct-Access     Linux    File-CD Gadget   0000 PQ: 0 ANSI: 2
[    4.542441] sd 4:0:0:0: Attached scsi generic sg2 type 0
[    4.542715] sd 4:0:0:0: Power-on or device reset occurred
[    4.547092] sd 4:0:0:0: [sdb] Attached SCSI removable disk
[    4.759782] systemd[1]: systemd 242 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    4.775184] systemd[1]: Detected architecture x86-64.
[    4.811196] systemd[1]: Set hostname to <rabammel.molgen.mpg.de>.
[    5.532829] systemd[1]: Created slice User and Session Slice.
[    5.534840] systemd[1]: Created slice system-getty.slice.
[    5.536701] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    5.541224] systemd[1]: Listening on Process Core Dump Socket.
[    5.543098] systemd[1]: Listening on Journal Socket.
[    5.545245] systemd[1]: Mounting Kernel Debug File System...
[    5.547407] systemd[1]: Mounting POSIX Message Queue File System...
[    6.148228] RPC: Registered named UNIX socket transport module.
[    6.149172] RPC: Registered udp transport module.
[    6.150010] RPC: Registered tcp transport module.
[    6.150840] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    6.620888] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[    7.032390] systemd-journald[156]: Received request to flush runtime journal from PID 1
[    7.715845] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
[    9.023944] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    9.024965] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    9.166877] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input10
[    9.168459] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[    9.217600] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3234: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
[    9.218975] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[    9.220078] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    9.221144] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    9.222108] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    9.222995] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
[    9.223973] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[    9.465235] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    9.466646] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   12.387217] [drm] amdgpu kernel modesetting enabled.
[   12.388127] amdgpu 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 0: 0xe0000000 -> 0xefffffff
[   12.389338] amdgpu 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 2: 0xf7e00000 -> 0xf7e3ffff
[   12.390578] checking generic (e0000000 300000) vs hw (e0000000 10000000)
[   12.390579] fb0: switching to amdgpudrmfb from EFI VGA
[   12.391637] Console: switching to colour dummy device 80x25
[   12.392222] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
[   12.393163] [drm] initializing kernel modesetting (OLAND 0x1002:0x6610 0x1028:0x0081 0x81).
[   12.393870] [drm] register mmio base: 0xF7E00000
[   12.394297] [drm] register mmio size: 262144
[   12.394667] [drm] add ip block number 0 <si_common>
[   12.395110] [drm] add ip block number 1 <gmc_v6_0>
[   12.395506] [drm] add ip block number 2 <si_ih>
[   12.395912] [drm] add ip block number 3 <gfx_v6_0>
[   12.396308] [drm] add ip block number 4 <si_dma>
[   12.396690] [drm] add ip block number 5 <si_dpm>
[   12.397114] [drm] add ip block number 6 <dce_v6_0>
[   12.397511] amdgpu 0000:01:00.0: kfd not supported on this ASIC
[   12.402995] [drm] BIOS signature incorrect 0 0
[   12.403385] ATOM BIOS: 113-C8720100-101
[   12.403795] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[   12.464667] amdgpu 0000:01:00.0: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)
[   12.465439] amdgpu 0000:01:00.0: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
[   12.466124] [drm] Detected VRAM RAM=4096M, BAR=256M
[   12.466562] [drm] RAM width 128bits DDR3
[   12.467136] [TTM] Zone  kernel: Available graphics memory: 3907240 KiB
[   12.467698] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   12.468277] [TTM] Initializing pool allocator
[   12.468686] [TTM] Initializing DMA pool allocator
[   12.469756] [drm] amdgpu: 4096M of VRAM memory ready
[   12.470204] [drm] amdgpu: 4096M of GTT memory ready.
[   12.470660] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   12.471747] amdgpu 0000:01:00.0: PCIE GART of 1024M enabled (table at 0x000000F400300000).
[   12.472511] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   12.473118] [drm] Driver supports precise vblank timestamp query.
[   12.574730] [drm] Internal thermal controller with fan control
[   12.575252] [drm] amdgpu: dpm initialized
[   12.575697] [drm] AMDGPU Display Connectors
[   12.576093] [drm] Connector 0:
[   12.576397] [drm]   DP-1
[   12.576613] [drm]   HPD1
[   12.576829] [drm]   DDC: 0x194c 0x194c 0x194d 0x194d 0x194e 0x194e 0x194f 0x194f
[   12.577496] [drm]   Encoders:
[   12.577769] [drm]     DFP1: INTERNAL_UNIPHY
[   12.578156] [drm] Connector 1:
[   12.578459] [drm]   DVI-I-1
[   12.578695] [drm]   HPD2
[   12.578949] [drm]   DDC: 0x1950 0x1950 0x1951 0x1951 0x1952 0x1952 0x1953 0x1953
[   12.579579] [drm]   Encoders:
[   12.579829] [drm]     DFP2: INTERNAL_UNIPHY
[   12.580219] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   12.580789] [drm] PCIE gen 3 link speeds already enabled
[   12.829086] [drm] fb mappable at 0xE0503000
[   12.829447] [drm] vram apper at 0xE0000000
[   12.829788] [drm] size 33177600
[   12.830110] [drm] fb depth is 24
[   12.830416] [drm]    pitch is 15360
[   12.830826] fbcon: amdgpudrmfb (fb0) is primary device
[   12.901400] [drm:dce_v6_0_encoder_mode_set [amdgpu]] *ERROR* Couldn't read SADs: 0
[   12.944263] Console: switching to colour frame buffer device 240x67
[   12.978956] amdgpu 0000:01:00.0: fb0: amdgpudrmfb frame buffer device
[   13.268433] [drm] Initialized amdgpu 3.33.0 20150101 for 0000:01:00.0 on minor 0
[   16.799048] e1000e 0000:00:1f.6 net00: renamed from eth0
[   17.329151] 8021q: 802.1Q VLAN Support v1.8
[   19.212051] XFS (sda2): Mounting V5 Filesystem
[   19.746689] NFSD: Using UMH upcall client tracking operations.
[   19.746691] NFSD: starting 90-second grace period (net f0000098)
[   19.767399] XFS (sda2): Ending clean mount
[   22.471346] [drm:dce_v6_0_encoder_mode_set [amdgpu]] *ERROR* Couldn't read SADs: 0
[   23.052343] e1000e: net00 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   35.763916] FS-Cache: Netfs 'nfs' registered for caching
[   35.971028] NFS: Registering the id_resolver key type
[   35.971033] Key type id_resolver registered
[   35.971034] Key type id_legacy registered
[   38.491718] fuse: init (API version 7.31)
[  121.385739] PM: suspend entry (deep)
[  121.440822] Filesystems sync: 0.055 seconds
[  121.441014] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  121.442470] OOM killer disabled.
[  121.442474] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
[  121.443499] printk: Suspending console(s) (use no_console_suspend to debug)
[  121.479948] serial 00:01: disabled
[  121.481092] e1000e: EEE TX LPI TIMER: 00000011
[  121.488476] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  121.488908] sd 0:0:0:0: [sda] Stopping disk
[  122.089532] ACPI: Preparing to enter system sleep state S3
[  122.089892] PM: Saving platform NVS memory
[  122.089912] Disabling non-boot CPUs ...
[  122.091114] smpboot: CPU 1 is now offline
[  122.092681] smpboot: CPU 2 is now offline
[  122.094239] smpboot: CPU 3 is now offline
[  122.096153] ACPI: Low-level resume complete
[  122.096207] PM: Restoring platform NVS memory
[  122.096837] Enabling non-boot CPUs ...
[  122.097010] x86: Booting SMP configuration:
[  122.097010] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  122.097603] CPU1 is up
[  122.097756] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  122.098454] CPU2 is up
[  122.098620] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  122.099247] CPU3 is up
[  122.099858] ACPI: Waking up from system sleep state S3
[  122.230695] hpet: Lost 3662 RTC interrupts
[  122.262200] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [DRQL] at bit offset/length 136/8 exceeds size of target Buffer (128 bits) (20190703/dsopcode-203)
[  122.262203] ACPI Error: Aborting method \_SB.PCI0.LPCB.SIO1.DSRS due to previous error (AE_AML_BUFFER_LIMIT) (20190703/psparse-531)
[  122.262206] ACPI Error: Aborting method \_SB.PCI0.LPCB.UAR1._SRS due to previous error (AE_AML_BUFFER_LIMIT) (20190703/psparse-531)
[  122.262209] serial 00:01: activation failed
[  122.262212] PM: dpm_run_callback(): pnp_bus_resume+0x0/0x90 returns -5
[  122.262213] PM: Device 00:01 failed to resume: error -5
[  122.264670] [drm] PCIE gen 3 link speeds already enabled
[  122.266042] amdgpu 0000:01:00.0: PCIE GART of 1024M enabled (table at 0x000000F400000000).
[  122.297255] sd 0:0:0:0: [sda] Starting disk
[  122.608968] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  122.609008] ata4: SATA link down (SStatus 4 SControl 300)
[  122.609028] ata3: SATA link down (SStatus 4 SControl 300)
[  122.612979] ata2.00: configured for UDMA/100
[  122.731498] [drm:dce_v6_0_encoder_mode_set [amdgpu]] *ERROR* Couldn't read SADs: 0
[  124.425920] usb 1-10: reset high-speed USB device number 4 using xhci_hcd
[  124.557893] acpi LNXPOWER:16: Turning OFF
[  124.557930] acpi LNXPOWER:15: Turning OFF
[  124.557966] acpi LNXPOWER:14: Turning OFF
[  124.558001] acpi LNXPOWER:13: Turning OFF
[  124.558037] acpi LNXPOWER:12: Turning OFF
[  124.558072] acpi LNXPOWER:11: Turning OFF
[  124.558108] acpi LNXPOWER:10: Turning OFF
[  124.558143] acpi LNXPOWER:0f: Turning OFF
[  124.558178] acpi LNXPOWER:0e: Turning OFF
[  124.558213] acpi LNXPOWER:0d: Turning OFF
[  124.558249] acpi LNXPOWER:0c: Turning OFF
[  124.558284] acpi LNXPOWER:0b: Turning OFF
[  124.558319] acpi LNXPOWER:0a: Turning OFF
[  124.558391] acpi LNXPOWER:09: Turning OFF
[  124.558452] acpi LNXPOWER:08: Turning OFF
[  124.558488] acpi LNXPOWER:07: Turning OFF
[  124.558523] acpi LNXPOWER:06: Turning OFF
[  124.558558] acpi LNXPOWER:05: Turning OFF
[  124.558594] acpi LNXPOWER:04: Turning OFF
[  124.558629] acpi LNXPOWER:03: Turning OFF
[  124.558660] OOM killer enabled.
[  124.558660] Restarting tasks ... done.
[  124.562506] sd 4:0:0:0: Power-on or device reset occurred
[  124.590495] PM: suspend exit
[  124.679378] usb 1-10: USB disconnect, device number 4
[  127.653558] ata1: link is slow to respond, please be patient (ready=0)
[  127.705561] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  127.781059] ata1.00: configured for UDMA/133
[  128.046542] usb 1-10: new high-speed USB device number 5 using xhci_hcd
[  128.179766] usb-storage 1-10:1.0: USB Mass Storage device detected
[  128.180012] scsi host4: usb-storage 1-10:1.0
[  129.212390] scsi 4:0:0:0: Direct-Access     Linux    File-CD Gadget   0000 PQ: 0 ANSI: 2
[  129.212652] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  129.213192] sd 4:0:0:0: Power-on or device reset occurred
[  129.214308] sd 4:0:0:0: [sdb] Attached SCSI removable disk
[  131.597990] e1000e: net00 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[ 4159.049444] PM: suspend entry (deep)
[ 4159.133091] Filesystems sync: 0.083 seconds
[ 4159.133346] Freezing user space processes ... (elapsed 0.001 seconds) done.
[ 4159.135258] OOM killer disabled.
[ 4159.135258] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 4159.136424] printk: Suspending console(s) (use no_console_suspend to debug)
[ 4159.172606] serial 00:01: disabled
[ 4159.173320] e1000e: EEE TX LPI TIMER: 00000011
[ 4159.184641] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.184693] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4159.184750] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.184802] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4159.184895] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.184947] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4159.185003] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.185054] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4159.185110] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.185162] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x10
[ 4159.185219] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.185271] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x10
[ 4159.185327] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4159.185379] e1000e 0000:00:1f.6 net00: reading PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4159.185435] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4159.185486] e1000e 0000:00:1f.6 net00: writing PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4159.185542] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4159.185594] e1000e 0000:00:1f.6 net00: writing PHY page 776 (or 0x6100 shifted) reg 0x17
[ 4159.185650] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4159.185702] e1000e 0000:00:1f.6 net00: reading PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4159.185758] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4159.185810] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4159.185866] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.185918] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4159.186002] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x0
[ 4159.186058] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x0
[ 4159.186113] e1000e 0000:00:1f.6 net00: After fix-ups FlowControl is now = 3
[ 4159.186118] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.186170] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x16
[ 4159.186239] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.186291] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x16
[ 4159.186348] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.186399] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x12
[ 4159.186456] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.186507] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x12
[ 4159.186564] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4159.186620] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4159.186673] e1000e 0000:00:1f.6 net00: Reconfiguring auto-neg advertisement params
[ 4159.186676] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x4
[ 4159.186732] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4159.186786] e1000e 0000:00:1f.6 net00: autoneg_advertised 2f
[ 4159.186786] e1000e 0000:00:1f.6 net00: Advertise 10mb Half duplex
[ 4159.186787] e1000e 0000:00:1f.6 net00: Advertise 10mb Full duplex
[ 4159.186787] e1000e 0000:00:1f.6 net00: Advertise 100mb Half duplex
[ 4159.186788] e1000e 0000:00:1f.6 net00: Advertise 100mb Full duplex
[ 4159.186788] e1000e 0000:00:1f.6 net00: Advertise 1000mb Full duplex
[ 4159.186792] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x4
[ 4159.186845] e1000e 0000:00:1f.6 net00: Auto-Neg Advertising de1
[ 4159.186848] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4159.186901] e1000e 0000:00:1f.6 net00: Restarting Auto-Neg
[ 4159.186904] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x0
[ 4159.186961] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x0
[ 4159.187017] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187073] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187139] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187213] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187279] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187335] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187402] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187458] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187524] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187580] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187646] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187703] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187769] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187825] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187891] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.187947] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.188013] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.188070] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.188136] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.188192] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4159.188255] e1000e 0000:00:1f.6 net00: Unable to establish link!!!
[ 4159.188259] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.188311] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x1b
[ 4159.188371] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.188423] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4159.188474] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.188526] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x11
[ 4159.188580] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.188734] e1000e 0000:00:1f.6 net00: Setting page 0x6400
[ 4159.188786] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x46
[ 4159.188889] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.188992] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.189146] e1000e 0000:00:1f.6 net00: Setting page 0x6400
[ 4159.189214] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x46
[ 4159.189317] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.189420] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.189472] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x1c
[ 4159.189524] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.189576] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x1c
[ 4159.189628] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4159.189680] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x1a
[ 4159.189732] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4159.189784] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x1a
[ 4159.189835] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4159.189887] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x1d
[ 4159.189939] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4159.189991] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x1d
[ 4159.190051] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.190103] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x19
[ 4159.190156] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.190214] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x19
[ 4159.190272] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.190324] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4159.190376] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.190428] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4159.190484] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.190638] e1000e 0000:00:1f.6 net00: Setting page 0x6400
[ 4159.190692] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x10
[ 4159.190795] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x11
[ 4159.190899] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x12
[ 4159.191003] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x13
[ 4159.191108] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x14
[ 4159.191216] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x15
[ 4159.191320] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x16
[ 4159.191424] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x17
[ 4159.191528] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x18
[ 4159.191632] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x19
[ 4159.191737] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x1a
[ 4159.191840] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x1b
[ 4159.191944] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x1c
[ 4159.192047] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x1d
[ 4159.192152] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x1e
[ 4159.192265] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x1f
[ 4159.192369] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x20
[ 4159.192473] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x21
[ 4159.192577] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x22
[ 4159.192681] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x23
[ 4159.192785] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x24
[ 4159.192889] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x25
[ 4159.192993] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x26
[ 4159.193097] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x27
[ 4159.193218] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x28
[ 4159.193321] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x29
[ 4159.193426] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x2a
[ 4159.193529] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x2b
[ 4159.193634] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x2c
[ 4159.193737] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x2d
[ 4159.193842] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x2e
[ 4159.193945] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x2f
[ 4159.194050] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x30
[ 4159.194153] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x31
[ 4159.194266] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x32
[ 4159.194370] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x33
[ 4159.194474] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x34
[ 4159.194577] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x35
[ 4159.194682] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x36
[ 4159.194786] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x37
[ 4159.194890] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x38
[ 4159.194993] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x39
[ 4159.195099] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3a
[ 4159.195213] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3b
[ 4159.195318] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3c
[ 4159.195422] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3d
[ 4159.195526] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3e
[ 4159.195629] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3f
[ 4159.195732] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.195840] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.195995] e1000e 0000:00:1f.6 net00: Setting page 0x6400
[ 4159.196048] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x80
[ 4159.196152] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x81
[ 4159.196267] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x82
[ 4159.196370] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x83
[ 4159.196474] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x84
[ 4159.196578] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x85
[ 4159.196682] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x86
[ 4159.196786] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x87
[ 4159.196890] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x88
[ 4159.196994] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x89
[ 4159.197099] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x8a
[ 4159.197213] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x8b
[ 4159.197318] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x8c
[ 4159.197422] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x8d
[ 4159.197527] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x8e
[ 4159.197630] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x8f
[ 4159.197735] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x90
[ 4159.197838] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x91
[ 4159.197943] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x92
[ 4159.198046] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x93
[ 4159.198151] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x94
[ 4159.198262] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x95
[ 4159.198367] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x96
[ 4159.198470] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x97
[ 4159.198574] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x98
[ 4159.198677] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x99
[ 4159.198782] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x9a
[ 4159.198885] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x9b
[ 4159.198989] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x9c
[ 4159.199092] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x9d
[ 4159.199214] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x9e
[ 4159.199317] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x9f
[ 4159.199421] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa0
[ 4159.199524] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa1
[ 4159.199629] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa2
[ 4159.199732] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa3
[ 4159.199837] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa4
[ 4159.199940] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa5
[ 4159.200044] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa6
[ 4159.200147] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa7
[ 4159.200267] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa8
[ 4159.200370] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xa9
[ 4159.200474] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xaa
[ 4159.200577] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xab
[ 4159.200682] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xac
[ 4159.200785] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xad
[ 4159.200889] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xae
[ 4159.200992] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xaf
[ 4159.201097] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb0
[ 4159.201213] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb1
[ 4159.201318] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb2
[ 4159.201421] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb3
[ 4159.201526] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb4
[ 4159.201629] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb5
[ 4159.201733] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb6
[ 4159.201836] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb7
[ 4159.201941] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb8
[ 4159.202044] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xb9
[ 4159.202149] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xba
[ 4159.202264] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xbb
[ 4159.202369] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xbc
[ 4159.202472] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xbd
[ 4159.202577] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xbe
[ 4159.202680] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0xbf
[ 4159.202783] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x0
[ 4159.202889] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x0
[ 4159.202992] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x2
[ 4159.203095] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x1
[ 4159.203214] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.203323] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.203375] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4159.203427] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4159.203479] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4159.204192] e1000e 0000:00:1f.6 net00: MDI Error
[ 4159.204194] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.204449] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x19
[ 4159.204654] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4159.204858] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x19
[ 4159.205063] e1000e 0000:00:1f.6 net00: Setting page 0x6160
[ 4159.205268] e1000e 0000:00:1f.6 net00: reading PHY page 779 (or 0x6160 shifted) reg 0x10
[ 4159.205474] e1000e 0000:00:1f.6 net00: Setting page 0x6160
[ 4159.205679] e1000e 0000:00:1f.6 net00: writing PHY page 779 (or 0x6160 shifted) reg 0x10
[ 4159.205885] e1000e 0000:00:1f.6 net00: Setting page 0x6160
[ 4159.206089] e1000e 0000:00:1f.6 net00: writing PHY page 779 (or 0x6160 shifted) reg 0x10
[ 4159.214449] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 4159.214882] sd 0:0:0:0: [sda] Stopping disk
[ 4159.980530] ACPI: Preparing to enter system sleep state S3
[ 4159.980892] PM: Saving platform NVS memory
[ 4159.980909] Disabling non-boot CPUs ...
[ 4159.982103] smpboot: CPU 1 is now offline
[ 4159.983742] smpboot: CPU 2 is now offline
[ 4159.985250] smpboot: CPU 3 is now offline
[ 4159.987297] ACPI: Low-level resume complete
[ 4159.987353] PM: Restoring platform NVS memory
[ 4159.987993] Enabling non-boot CPUs ...
[ 4159.988174] x86: Booting SMP configuration:
[ 4159.988175] smpboot: Booting Node 0 Processor 1 APIC 0x2
[ 4159.988766] CPU1 is up
[ 4159.988925] smpboot: Booting Node 0 Processor 2 APIC 0x4
[ 4159.989554] CPU2 is up
[ 4159.989722] smpboot: Booting Node 0 Processor 3 APIC 0x6
[ 4159.990357] CPU3 is up
[ 4159.990954] ACPI: Waking up from system sleep state S3
[ 4160.132884] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [DRQL] at bit offset/length 136/8 exceeds size of target Buffer (128 bits) (20190703/dsopcode-203)
[ 4160.132887] ACPI Error: Aborting method \_SB.PCI0.LPCB.SIO1.DSRS due to previous error (AE_AML_BUFFER_LIMIT) (20190703/psparse-531)
[ 4160.132890] ACPI Error: Aborting method \_SB.PCI0.LPCB.UAR1._SRS due to previous error (AE_AML_BUFFER_LIMIT) (20190703/psparse-531)
[ 4160.132893] serial 00:01: activation failed
[ 4160.132896] PM: dpm_run_callback(): pnp_bus_resume+0x0/0x90 returns -5
[ 4160.132897] PM: Device 00:01 failed to resume: error -5
[ 4160.134919] [drm] PCIE gen 3 link speeds already enabled
[ 4160.136292] amdgpu 0000:01:00.0: PCIE GART of 1024M enabled (table at 0x000000F400000000).
[ 4160.143382] sd 0:0:0:0: [sda] Starting disk
[ 4160.169387] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.267950] e1000e 0000:00:1f.6 net00: MDI Write did not complete
[ 4160.319407] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.319663] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4160.319868] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.320072] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4160.359855] e1000e 0000:00:1f.6 net00: MDI Error
[ 4160.359856] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.359908] e1000e 0000:00:1f.6 net00: reading PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4160.359960] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.360012] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4160.360063] e1000e 0000:00:1f.6 net00: Setting page 0x6160
[ 4160.360115] e1000e 0000:00:1f.6 net00: reading PHY page 779 (or 0x6160 shifted) reg 0x10
[ 4160.360167] e1000e 0000:00:1f.6 net00: Setting page 0x6160
[ 4160.360218] e1000e 0000:00:1f.6 net00: writing PHY page 779 (or 0x6160 shifted) reg 0x10
[ 4160.360270] e1000e 0000:00:1f.6 net00: Setting page 0x6160
[ 4160.360322] e1000e 0000:00:1f.6 net00: writing PHY page 779 (or 0x6160 shifted) reg 0x10
[ 4160.381769] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.381821] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x11
[ 4160.381880] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.381932] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x11
[ 4160.381994] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.382046] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4160.382098] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.382149] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4160.382202] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.382254] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x1e
[ 4160.382501] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.382553] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x10
[ 4160.382761] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.382812] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4160.382941] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.382993] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x12
[ 4160.383199] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.383250] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.383424] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.383476] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.383604] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.383656] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.383789] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.383841] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.383969] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.384021] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.384150] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.384202] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.384330] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.384395] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.384524] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.384576] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.384704] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.384756] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.384885] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.384937] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.385065] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.385117] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.385246] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.385297] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.385457] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.385508] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.385646] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.385697] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.385826] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.385878] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.386006] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.386058] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.386117] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.386169] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x19
[ 4160.386222] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.386273] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x19
[ 4160.437386] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x2
[ 4160.437438] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x3
[ 4160.437491] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.437544] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4160.437596] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.437648] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4160.448623] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.448676] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x12
[ 4160.448728] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.448779] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x12
[ 4160.448833] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.448884] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x1a
[ 4160.448936] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.448988] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x1a
[ 4160.449039] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.449193] e1000e 0000:00:1f.6 net00: Setting page 0x6400
[ 4160.449245] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x46
[ 4160.449348] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.449451] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.449502] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x1d
[ 4160.449554] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.449606] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x1d
[ 4160.449662] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x0
[ 4160.449718] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x0
[ 4160.449772] e1000e 0000:00:1f.6 net00: After fix-ups FlowControl is now = 3
[ 4160.449777] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.449829] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x16
[ 4160.449885] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.449936] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x16
[ 4160.449992] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.450044] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x12
[ 4160.450100] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.450152] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x12
[ 4160.450208] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.450264] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.450317] e1000e 0000:00:1f.6 net00: Reconfiguring auto-neg advertisement params
[ 4160.450320] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x4
[ 4160.450376] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.450429] e1000e 0000:00:1f.6 net00: autoneg_advertised 2f
[ 4160.450430] e1000e 0000:00:1f.6 net00: Advertise 10mb Half duplex
[ 4160.450430] e1000e 0000:00:1f.6 net00: Advertise 10mb Full duplex
[ 4160.450431] e1000e 0000:00:1f.6 net00: Advertise 100mb Half duplex
[ 4160.450431] e1000e 0000:00:1f.6 net00: Advertise 100mb Full duplex
[ 4160.450432] e1000e 0000:00:1f.6 net00: Advertise 1000mb Full duplex
[ 4160.450435] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x4
[ 4160.450488] e1000e 0000:00:1f.6 net00: Auto-Neg Advertising de1
[ 4160.450491] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.450544] e1000e 0000:00:1f.6 net00: Restarting Auto-Neg
[ 4160.450547] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x0
[ 4160.450603] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x0
[ 4160.450659] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.450715] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.450781] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.450837] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.450903] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.450959] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451025] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451082] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451148] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451204] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451270] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451326] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451396] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451452] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451518] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451574] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451640] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451696] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451762] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451818] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.451881] e1000e 0000:00:1f.6 net00: Unable to establish link!!!
[ 4160.451885] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.451937] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x1b
[ 4160.451993] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.452147] e1000e 0000:00:1f.6 net00: Setting page 0x6400
[ 4160.452199] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3
[ 4160.452302] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.452424] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.452578] e1000e 0000:00:1f.6 net00: Setting page 0x6400
[ 4160.452630] e1000e 0000:00:1f.6 net00: Accessing PHY page 800 reg 0x3
[ 4160.452732] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.453065] e1000e 0000:00:1f.6 net00: Masking off all interrupts
[ 4160.457906] ata4: SATA link down (SStatus 4 SControl 300)
[ 4160.457957] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 4160.458026] ata3: SATA link down (SStatus 4 SControl 300)
[ 4160.462005] ata2.00: configured for UDMA/100
[ 4160.463344] e1000e 0000:00:1f.6 net00: Issuing a global reset to ich8lan
[ 4160.506386] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.506439] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x11
[ 4160.506503] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.506555] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x11
[ 4160.506617] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.506668] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4160.506720] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.506772] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4160.506825] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.506877] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x1e
[ 4160.507083] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4160.507135] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x10
[ 4160.507343] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.507395] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4160.507527] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.507578] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x12
[ 4160.507784] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.507836] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.507965] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.508016] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.508147] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.508199] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.508328] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.508379] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.508521] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.508573] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.508701] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.508753] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.508882] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.508933] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.509062] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.509114] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.509243] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.509294] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.509467] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.509519] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.509647] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.509699] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.509827] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.509879] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.510008] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.510060] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.510189] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.510240] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.510397] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.510449] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.510578] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.510629] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.510688] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.510740] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x19
[ 4160.510793] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.510845] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x19
[ 4160.510957] e1000e 0000:00:1f.6 net00: Programming MAC Address into RAR[0]
[ 4160.510960] e1000e 0000:00:1f.6 net00: Clearing RAR[1-11]
[ 4160.511091] e1000e 0000:00:1f.6 net00: Zeroing the MTA
[ 4160.511101] e1000e 0000:00:1f.6 net00: After fix-ups FlowControl is now = 3
[ 4160.511106] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.511158] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x16
[ 4160.511214] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.511265] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x16
[ 4160.511321] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.511373] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x12
[ 4160.511429] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.511481] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x12
[ 4160.511537] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.511593] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.511646] e1000e 0000:00:1f.6 net00: Reconfiguring auto-neg advertisement params
[ 4160.511649] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x4
[ 4160.511705] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.511758] e1000e 0000:00:1f.6 net00: autoneg_advertised 2f
[ 4160.511759] e1000e 0000:00:1f.6 net00: Advertise 10mb Half duplex
[ 4160.511759] e1000e 0000:00:1f.6 net00: Advertise 10mb Full duplex
[ 4160.511760] e1000e 0000:00:1f.6 net00: Advertise 100mb Half duplex
[ 4160.511760] e1000e 0000:00:1f.6 net00: Advertise 100mb Full duplex
[ 4160.511761] e1000e 0000:00:1f.6 net00: Advertise 1000mb Full duplex
[ 4160.511764] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x4
[ 4160.511817] e1000e 0000:00:1f.6 net00: Auto-Neg Advertising de1
[ 4160.511820] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4160.511873] e1000e 0000:00:1f.6 net00: Restarting Auto-Neg
[ 4160.511876] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x0
[ 4160.511932] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x0
[ 4160.511988] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512045] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512111] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512167] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512233] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512289] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512369] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512425] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512491] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512547] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512613] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512669] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512735] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512791] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512857] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512914] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.512980] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.513036] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.513102] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.513158] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.513221] e1000e 0000:00:1f.6 net00: Unable to establish link!!!
[ 4160.513225] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.513277] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x1b
[ 4160.513445] e1000e 0000:00:1f.6 net00: Setting page 0x6140
[ 4160.513497] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x10
[ 4160.513548] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x11
[ 4160.513600] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x12
[ 4160.513652] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x13
[ 4160.513703] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x14
[ 4160.513755] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x15
[ 4160.513807] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x17
[ 4160.513858] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x18
[ 4160.513910] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x19
[ 4160.513962] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1a
[ 4160.514014] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1b
[ 4160.514065] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1c
[ 4160.514117] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1d
[ 4160.514169] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1e
[ 4160.514245] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.514297] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4160.514348] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4160.514400] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4160.514456] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.514512] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.514566] e1000e 0000:00:1f.6 net00: Phy info is only valid if link is up
[ 4160.514669] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.514721] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4160.514777] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.514828] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4160.514920] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.514972] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4160.515028] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.515080] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4160.515136] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.515188] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x10
[ 4160.515244] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.515295] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x10
[ 4160.515369] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4160.515420] e1000e 0000:00:1f.6 net00: reading PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4160.515476] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4160.515528] e1000e 0000:00:1f.6 net00: writing PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4160.515584] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4160.515636] e1000e 0000:00:1f.6 net00: writing PHY page 776 (or 0x6100 shifted) reg 0x17
[ 4160.515692] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.515744] e1000e 0000:00:1f.6 net00: reading PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4160.515800] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4160.515852] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4160.515908] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4160.515959] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4160.528399] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.528455] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4160.602510] [drm:dce_v6_0_encoder_mode_set [amdgpu]] *ERROR* Couldn't read SADs: 0
[ 4162.395960] usb 1-10: reset high-speed USB device number 5 using xhci_hcd
[ 4162.527711] acpi LNXPOWER:16: Turning OFF
[ 4162.527748] acpi LNXPOWER:15: Turning OFF
[ 4162.527784] acpi LNXPOWER:14: Turning OFF
[ 4162.527820] acpi LNXPOWER:13: Turning OFF
[ 4162.527856] acpi LNXPOWER:12: Turning OFF
[ 4162.527891] acpi LNXPOWER:11: Turning OFF
[ 4162.527927] acpi LNXPOWER:10: Turning OFF
[ 4162.527962] acpi LNXPOWER:0f: Turning OFF
[ 4162.527998] acpi LNXPOWER:0e: Turning OFF
[ 4162.528033] acpi LNXPOWER:0d: Turning OFF
[ 4162.528069] acpi LNXPOWER:0c: Turning OFF
[ 4162.528105] acpi LNXPOWER:0b: Turning OFF
[ 4162.528140] acpi LNXPOWER:0a: Turning OFF
[ 4162.528176] acpi LNXPOWER:09: Turning OFF
[ 4162.528211] acpi LNXPOWER:08: Turning OFF
[ 4162.528247] acpi LNXPOWER:07: Turning OFF
[ 4162.528282] acpi LNXPOWER:06: Turning OFF
[ 4162.528317] acpi LNXPOWER:05: Turning OFF
[ 4162.528390] acpi LNXPOWER:04: Turning OFF
[ 4162.528439] acpi LNXPOWER:03: Turning OFF
[ 4162.528467] OOM killer enabled.
[ 4162.528467] Restarting tasks ... done.
[ 4162.532198] sd 4:0:0:0: Power-on or device reset occurred
[ 4162.533344] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.533400] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.544542] e1000e 0000:00:1f.6 net00: Masking off all interrupts
[ 4162.555330] e1000e 0000:00:1f.6 net00: Issuing a global reset to ich8lan
[ 4162.560478] PM: suspend exit
[ 4162.599447] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.599500] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x11
[ 4162.599556] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.599608] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x11
[ 4162.599668] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.599720] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4162.599772] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.599823] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4162.599876] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.599928] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x1e
[ 4162.600135] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4162.600187] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x10
[ 4162.600457] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4162.600509] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4162.600661] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4162.600713] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x12
[ 4162.600919] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.600971] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.601098] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.601150] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.601282] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.601334] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.601473] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.601530] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.601661] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.601713] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.601840] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.601892] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.602022] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.602074] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.602211] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.602263] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.602435] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.602487] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.602613] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.602677] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.602833] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.602885] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.603012] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.603068] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.603199] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.603251] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.603416] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.603468] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.603619] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.603671] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.603798] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.603850] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.603908] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.603959] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x19
[ 4162.604012] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.604064] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x19
[ 4162.604177] e1000e 0000:00:1f.6 net00: Programming MAC Address into RAR[0]
[ 4162.604181] e1000e 0000:00:1f.6 net00: Clearing RAR[1-11]
[ 4162.604298] e1000e 0000:00:1f.6 net00: Zeroing the MTA
[ 4162.604309] e1000e 0000:00:1f.6 net00: After fix-ups FlowControl is now = 3
[ 4162.604314] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.604365] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x16
[ 4162.604424] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.604475] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x16
[ 4162.604531] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.604583] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x12
[ 4162.604639] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.604691] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x12
[ 4162.604746] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4162.604802] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4162.604861] e1000e 0000:00:1f.6 net00: Reconfiguring auto-neg advertisement params
[ 4162.604864] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x4
[ 4162.604920] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4162.604973] e1000e 0000:00:1f.6 net00: autoneg_advertised 2f
[ 4162.604973] e1000e 0000:00:1f.6 net00: Advertise 10mb Half duplex
[ 4162.604974] e1000e 0000:00:1f.6 net00: Advertise 10mb Full duplex
[ 4162.604974] e1000e 0000:00:1f.6 net00: Advertise 100mb Half duplex
[ 4162.604975] e1000e 0000:00:1f.6 net00: Advertise 100mb Full duplex
[ 4162.604975] e1000e 0000:00:1f.6 net00: Advertise 1000mb Full duplex
[ 4162.604978] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x4
[ 4162.605031] e1000e 0000:00:1f.6 net00: Auto-Neg Advertising de1
[ 4162.605034] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x9
[ 4162.605087] e1000e 0000:00:1f.6 net00: Restarting Auto-Neg
[ 4162.605090] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x0
[ 4162.605146] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x0
[ 4162.605202] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605258] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605324] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605380] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605472] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605527] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605593] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605649] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605715] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605770] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605836] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605892] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.605958] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606014] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606079] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606135] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606201] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606257] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606323] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606379] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.606461] e1000e 0000:00:1f.6 net00: Unable to establish link!!!
[ 4162.606465] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.606516] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x1b
[ 4162.606639] e1000e 0000:00:1f.6 net00: Setting page 0x6140
[ 4162.606690] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x10
[ 4162.606742] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x11
[ 4162.606794] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x12
[ 4162.606846] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x13
[ 4162.606897] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x14
[ 4162.606949] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x15
[ 4162.607001] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x17
[ 4162.607053] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x18
[ 4162.607119] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x19
[ 4162.607170] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1a
[ 4162.607222] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1b
[ 4162.607274] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1c
[ 4162.607326] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1d
[ 4162.607377] e1000e 0000:00:1f.6 net00: reading PHY page 778 (or 0x6140 shifted) reg 0x1e
[ 4162.607464] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.607520] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4162.607571] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4162.607623] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4162.607679] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.607735] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.607788] e1000e 0000:00:1f.6 net00: Phy info is only valid if link is up
[ 4162.607913] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.607965] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4162.608021] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.608073] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4162.608164] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.608216] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4162.608272] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.608323] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x17
[ 4162.608379] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.608443] e1000e 0000:00:1f.6 net00: reading PHY page 769 (or 0x6020 shifted) reg 0x10
[ 4162.608499] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.608551] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x10
[ 4162.608607] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4162.608658] e1000e 0000:00:1f.6 net00: reading PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4162.608714] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4162.608766] e1000e 0000:00:1f.6 net00: writing PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4162.608822] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4162.608874] e1000e 0000:00:1f.6 net00: writing PHY page 776 (or 0x6100 shifted) reg 0x17
[ 4162.608929] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4162.608981] e1000e 0000:00:1f.6 net00: reading PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4162.609037] e1000e 0000:00:1f.6 net00: Setting page 0x6040
[ 4162.609089] e1000e 0000:00:1f.6 net00: writing PHY page 770 (or 0x6040 shifted) reg 0x11
[ 4162.609144] e1000e 0000:00:1f.6 net00: Setting page 0x6020
[ 4162.609196] e1000e 0000:00:1f.6 net00: writing PHY page 769 (or 0x6020 shifted) reg 0x14
[ 4162.621345] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.621402] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4162.678614] usb 1-10: USB disconnect, device number 5
[ 4164.644462] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4164.644531] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4165.502355] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 4165.613627] ata1.00: configured for UDMA/133
[ 4165.883462] usb 1-10: new high-speed USB device number 6 using xhci_hcd
[ 4166.015186] usb-storage 1-10:1.0: USB Mass Storage device detected
[ 4166.015605] scsi host4: usb-storage 1-10:1.0
[ 4166.692461] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4166.692518] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4166.692573] e1000e 0000:00:1f.6 net00: 1000 Mbps, Full Duplex
[ 4166.692577] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.692629] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4166.692681] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.692733] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x11
[ 4166.692784] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4166.692836] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x1c
[ 4166.692888] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4166.692939] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x1c
[ 4166.692995] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4166.693047] e1000e 0000:00:1f.6 net00: reading PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4166.693099] e1000e 0000:00:1f.6 net00: Setting page 0x6100
[ 4166.693150] e1000e 0000:00:1f.6 net00: writing PHY page 776 (or 0x6100 shifted) reg 0x14
[ 4166.693206] e1000e 0000:00:1f.6 net00: 1000 Mbps, Full Duplex
[ 4166.693216] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4166.693268] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x14
[ 4166.693325] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.693377] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4166.693429] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.693496] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x11
[ 4166.693547] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.693599] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4166.693651] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.693702] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x11
[ 4166.693754] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.693806] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4166.693858] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4166.693909] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x11
[ 4166.693961] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4166.694013] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x14
[ 4166.694070] e1000e 0000:00:1f.6 net00: hw->fc.current_mode = 3
[ 4166.694073] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4166.694129] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4166.694185] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x4
[ 4166.694241] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x5
[ 4166.694295] e1000e 0000:00:1f.6 net00: Flow Control = NONE.
[ 4166.694297] e1000e 0000:00:1f.6 net00: 1000 Mbps, Full Duplex
[ 4166.694299] e1000e 0000:00:1f.6 net00: hw->fc.current_mode = 0
[ 4167.077213] scsi 4:0:0:0: Direct-Access     Linux    File-CD Gadget   0000 PQ: 0 ANSI: 2
[ 4167.077658] sd 4:0:0:0: Attached scsi generic sg2 type 0
[ 4167.078152] sd 4:0:0:0: Power-on or device reset occurred
[ 4167.079721] sd 4:0:0:0: [sdb] Attached SCSI removable disk
[ 4168.694508] e1000e 0000:00:1f.6 net00: Error in exiting dmoff
[ 4168.694527] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x0
[ 4168.694588] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4168.694644] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x4
[ 4168.694700] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x5
[ 4168.694756] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x6
[ 4168.694812] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x9
[ 4168.694867] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0xa
[ 4168.694923] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0xf
[ 4168.694978] e1000e 0000:00:1f.6 net00: 1000 Mbps, Full Duplex
[ 4168.694980] e1000e: net00 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[ 4170.916550] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4170.916607] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1
[ 4170.916663] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.916715] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4170.916770] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.916822] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1a
[ 4170.916878] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.916929] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x1f
[ 4170.916985] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0xa
[ 4170.917041] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4170.917093] e1000e 0000:00:1f.6 net00: reading PHY page 772 (or 0x6080 shifted) reg 0x14
[ 4170.917145] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.917196] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4170.917248] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.917307] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x11
[ 4170.917372] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.917425] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4170.917477] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.917528] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x11
[ 4170.917585] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.917636] e1000e 0000:00:1f.6 net00: writing PHY page 0 (or 0x0 shifted) reg 0x10
[ 4170.917688] e1000e 0000:00:1f.6 net00: Setting page 0x0
[ 4170.917740] e1000e 0000:00:1f.6 net00: reading PHY page 0 (or 0x0 shifted) reg 0x11
[ 4170.917792] e1000e 0000:00:1f.6 net00: Setting page 0x6080
[ 4170.917843] e1000e 0000:00:1f.6 net00: writing PHY page 772 (or 0x6080 shifted) reg 0x14
[ 4770.441271] TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190806/34f33aa7/attachment-0001.p7s>
