From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 7 Feb 2022 17:08:11 +0100
Subject: [Intel-wired-lan] BUG: KCSAN: data-race in
 e1000_clean_rx_irq+0x330/0x870
Message-ID: <e3926433-d05c-92b1-a37d-204cf54e270c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


Running Linux 5.17-rc2+ with KCSAN in QEMU, it reports the race below:

```
[    0.000000] Linux version 5.17.0-rc2-00353-g90c9e950c0de 
(pmenzel at invidia.molgen.mpg.de) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 
2.37) #34 SMP PREEMPT Sun Feb 6 13:11:13 CET 2022
[    0.000000] Command line: root=/dev/vda1 rw quiet
[?]
[  410.295890] 
==================================================================
[  410.297475] BUG: KCSAN: data-race in e1000_clean_rx_irq+0x330/0x870

[  410.299722] race at unknown origin, with read to 0xffff8a554584d3ec 
of 1 bytes by interrupt on cpu 0:
[  410.301524]  e1000_clean_rx_irq+0x330/0x870
[  410.301534]  e1000_clean+0x4a5/0xc40
[  410.301541]  __napi_poll+0x5c/0x280
[  410.301550]  net_rx_action+0x4ff/0x5b0
[  410.301559]  __do_softirq+0xe4/0x2d9
[  410.301567]  run_ksoftirqd+0x21/0x30
[  410.301577]  smpboot_thread_fn+0x26b/0x360
[  410.301595]  kthread+0x16d/0x1a0
[  410.301604]  ret_from_fork+0x22/0x30

[  410.302478] value changed: 0x00 -> 0x07

[  410.304564] Reported by Kernel Concurrency Sanitizer on:
[  410.305757] CPU: 0 PID: 12 Comm: ksoftirqd/0 Not tainted 
5.17.0-rc2-00353-g90c9e950c0de #34
[  410.305776] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.15.0-1 04/01/2014
[  410.305788] 
==================================================================
```

Please find the output of `dmesg` attached.


Kind regards,

Paul
-------------- next part --------------
[    0.000000] Linux version 5.17.0-rc2-00353-g90c9e950c0de (pmenzel at invidia.molgen.mpg.de) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.37) #34 SMP PREEMPT Sun Feb 6 13:11:13 CET 2022
[    0.000000] Command line: root=/dev/vda1 rw quiet
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdafff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffdb000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2593.988 MHz processor
[    0.003631] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003648] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.003661] last_pfn = 0x7ffdb max_arch_pfn = 0x400000000
[    0.003788] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.011584] found SMP MP-table at [mem 0x000f5b90-0x000f5b9f]
[    0.012137] Using GB pages for direct mapping
[    0.012854] ACPI: Early table checksum verification disabled
[    0.012978] ACPI: RSDP 0x00000000000F59D0 000014 (v00 BOCHS )
[    0.013009] ACPI: RSDT 0x000000007FFE190C 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.013055] ACPI: FACP 0x000000007FFE17C0 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.013075] ACPI: DSDT 0x000000007FFE0040 001780 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.013097] ACPI: FACS 0x000000007FFE0000 000040
[    0.013110] ACPI: APIC 0x000000007FFE1834 000078 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.013126] ACPI: HPET 0x000000007FFE18AC 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.013142] ACPI: WAET 0x000000007FFE18E4 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.013157] ACPI: Reserving FACP table memory at [mem 0x7ffe17c0-0x7ffe1833]
[    0.013163] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17bf]
[    0.013170] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.013176] ACPI: Reserving APIC table memory at [mem 0x7ffe1834-0x7ffe18ab]
[    0.013182] ACPI: Reserving HPET table memory at [mem 0x7ffe18ac-0x7ffe18e3]
[    0.013188] ACPI: Reserving WAET table memory at [mem 0x7ffe18e4-0x7ffe190b]
[    0.013362] ACPI: CEDT not present
[    0.013949] No NUMA configuration found
[    0.013952] Faking a node at [mem 0x0000000000000000-0x000000007ffdafff]
[    0.013967] NODE_DATA(0) allocated [mem 0x7ffd7000-0x7ffdafff]
[    0.014055] Zone ranges:
[    0.014058]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.014066]   DMA32    [mem 0x0000000001000000-0x000000007ffdafff]
[    0.014074]   Normal   empty
[    0.014079] Movable zone start for each node
[    0.014082] Early memory node ranges
[    0.014085]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.014097]   node   0: [mem 0x0000000000100000-0x000000007ffdafff]
[    0.014111] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdafff]
[    0.014597] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.014633] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.021660] On node 0, zone DMA32: 37 pages in unavailable ranges
[    0.022665] ACPI: PM-Timer IO Port: 0x608
[    0.022697] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.022824] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.022835] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.022842] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.022849] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.022864] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.022871] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.022900] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.022905] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.022927] TSC deadline timer available
[    0.022951] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.023025] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.023034] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.023039] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.023045] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.023053] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.023102] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.031093] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
[    0.031828] percpu: Embedded 53 pages/cpu s176984 r8192 d31912 u2097152
[    0.031865] pcpu-alloc: s176984 r8192 d31912 u2097152 alloc=1*2097152
[    0.031876] pcpu-alloc: [0] 0 
[    0.031992] Fallback order for Node 0: 0 
[    0.032007] Built 1 zonelists, mobility grouping on.  Total pages: 515803
[    0.032013] Policy zone: DMA32
[    0.032029] Kernel command line: root=/dev/vda1 rw quiet
[    0.032625] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.032743] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.032918] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.038052] Memory: 2014480K/2096612K available (24588K kernel code, 2637K rwdata, 5136K rodata, 1444K init, 1372K bss, 81872K reserved, 0K cma-reserved)
[    0.038215] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.038259] Kernel/User page tables isolation: enabled
[    0.045130] Dynamic Preempt: voluntary
[    0.045524] rcu: Preemptible hierarchical RCU implementation.
[    0.045529] rcu: 	RCU event tracing is enabled.
[    0.045537] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[    0.045543] 	Trampoline variant of Tasks RCU enabled.
[    0.045546] 	Rude variant of Tasks RCU enabled.
[    0.045550] 	Tracing variant of Tasks RCU enabled.
[    0.045569] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.045574] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.051928] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
[    0.052575] random: get_random_bytes called from start_kernel+0x57c/0x82a with crng_init=0
[    0.072399] Console: colour VGA+ 80x25
[    0.072465] printk: console [tty0] enabled
[    0.072536] ACPI: Core revision 20211217
[    0.072988] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.073376] APIC: Switch to symmetric I/O mode setup
[    0.077705] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.082334] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25640cb3a67, max_idle_ns: 440795258696 ns
[    0.082381] Calibrating delay loop (skipped), value calculated using timer frequency.. 5187.97 BogoMIPS (lpj=2593988)
[    0.082399] pid_max: default: 32768 minimum: 301
[    0.082458] LSM: Security Framework initializing
[    0.082488] SELinux:  Initializing.
[    0.082558] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.082574] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.084599] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.085800] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.085812] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.085926] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.085937] Spectre V2 : Mitigation: Full generic retpoline
[    0.085941] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.085950] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.085967] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.085972] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.085989] TAA: Mitigation: Clear CPU buffers
[    0.085996] SRBDS: Unknown: Dependent on hypervisor status
[    0.086000] MDS: Mitigation: Clear CPU buffers
[    0.114767] Freeing SMP alternatives memory: 44K
[    0.114929] kcsan: enabled early
[    0.114936] kcsan: non-strict mode configured - use CONFIG_KCSAN_STRICT=y to see all data races
[    0.115626] smpboot: CPU0: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz (family: 0x6, model: 0x3d, stepping: 0x4)
[    0.116042] cblist_init_generic: Setting adjustable number of callback queues.
[    0.116053] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.116104] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.116138] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.116197] Performance Events: Broadwell events, full-width counters, Intel PMU driver.
[    0.116368] ... version:                2
[    0.116368] ... bit width:              48
[    0.116368] ... generic registers:      4
[    0.116368] ... value mask:             0000ffffffffffff
[    0.116368] ... max period:             00007fffffffffff
[    0.116368] ... fixed-purpose events:   3
[    0.116368] ... event mask:             000000070000000f
[    0.116899] rcu: Hierarchical SRCU implementation.
[    0.118958] smp: Bringing up secondary CPUs ...
[    0.118963] smp: Brought up 1 node, 1 CPU
[    0.118969] smpboot: Max logical packages: 1
[    0.118973] smpboot: Total of 1 processors activated (5187.97 BogoMIPS)
[    0.119786] devtmpfs: initialized
[    0.121585] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.121621] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.121976] PM: RTC time: 12:42:53, date: 2022-02-06
[    0.122535] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.123300] audit: initializing netlink subsys (disabled)
[    0.124206] thermal_sys: Registered thermal governor 'step_wise'
[    0.124211] thermal_sys: Registered thermal governor 'user_space'
[    0.124273] audit: type=2000 audit(1644151373.047:1): state=initialized audit_enabled=0 res=1
[    0.124311] cpuidle: using governor menu
[    0.124877] PCI: Using configuration type 1 for base access
[    0.162011] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.162358] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.162870] ACPI: Added _OSI(Module Device)
[    0.162887] ACPI: Added _OSI(Processor Device)
[    0.162892] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.162977] ACPI: Added _OSI(Processor Aggregator Device)
[    0.162987] ACPI: Added _OSI(Linux-Dell-Video)
[    0.162996] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.163005] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.168949] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.172610] ACPI: Interpreter enabled
[    0.172776] ACPI: PM: (supports S0 S3 S4 S5)
[    0.172781] ACPI: Using IOAPIC for interrupt routing
[    0.172892] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.173845] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.192096] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.192153] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.192163] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.192201] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.192519] PCI host bridge to bus 0000:00
[    0.192598] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.192606] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.192614] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.192623] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    0.192632] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.192670] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.192802] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.197314] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.199159] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.202881] pci 0000:00:01.1: reg 0x20: [io  0xc0e0-0xc0ef]
[    0.204879] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.204914] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.204921] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.204929] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.205492] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
[    0.209381] pci 0000:00:01.2: reg 0x20: [io  0xc0c0-0xc0df]
[    0.211746] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.212911] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.212940] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.213695] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.215045] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.216989] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.221013] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.221368] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.224991] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.225904] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.226870] pci 0000:00:03.0: reg 0x14: [io  0xc080-0xc0bf]
[    0.232967] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.236067] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.236877] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc07f]
[    0.237377] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.240056] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
[    0.249219] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.249722] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.250291] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.250887] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.251299] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.252530] iommu: Default domain type: Translated 
[    0.252536] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.252907] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.252915] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.252925] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.252930] vgaarb: loaded
[    0.253456] SCSI subsystem initialized
[    0.253911] libata version 3.00 loaded.
[    0.254096] ACPI: bus type USB registered
[    0.254270] usbcore: registered new interface driver usbfs
[    0.254360] usbcore: registered new interface driver hub
[    0.254390] usbcore: registered new device driver usb
[    0.254475] pps_core: LinuxPPS API ver. 1 registered
[    0.254479] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.254511] PTP clock support registered
[    0.254897] Advanced Linux Sound Architecture Driver Initialized.
[    0.255967] Bluetooth: Core ver 2.22
[    0.256043] NET: Registered PF_BLUETOOTH protocol family
[    0.256048] Bluetooth: HCI device and connection manager initialized
[    0.256065] Bluetooth: HCI socket layer initialized
[    0.256070] Bluetooth: L2CAP socket layer initialized
[    0.256092] Bluetooth: SCO socket layer initialized
[    0.256188] NetLabel: Initializing
[    0.256191] NetLabel:  domain hash size = 128
[    0.256195] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.256313] NetLabel:  unlabeled traffic allowed by default
[    0.256548] PCI: Using ACPI for IRQ routing
[    0.256564] PCI: pci_cache_line_size set to 64 bytes
[    0.256946] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.256960] e820: reserve RAM buffer [mem 0x7ffdb000-0x7fffffff]
[    0.257196] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.257213] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.258702] clocksource: Switched to clocksource tsc-early
[    0.335926] VFS: Disk quotas dquot_6.6.0
[    0.336019] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.336267] pnp: PnP ACPI init
[    0.336869] pnp 00:02: [dma 2]
[    0.338201] pnp: PnP ACPI: found 6 devices
[    2.072484] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.072707] NET: Registered PF_INET protocol family
[    2.072923] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    2.079172] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    2.079286] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    2.080153] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    2.082101] TCP: Hash tables configured (established 16384 bind 16384)
[    2.082287] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    2.082459] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    2.082998] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.083425] RPC: Registered named UNIX socket transport module.
[    2.083431] RPC: Registered udp transport module.
[    2.083440] RPC: Registered tcp transport module.
[    2.083444] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.087206] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.087218] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.087233] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.087241] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    2.087250] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    2.087664] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    2.087732] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    2.087770] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    2.271290] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    2.451006] pci 0000:00:01.2: quirk_usb_early_handoff+0x0/0x7e0 took 354562 usecs
[    2.451362] PCI: CLS 0 bytes, default 64
[    2.451693] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    2.452602] rcu-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
[    2.458243] rcu:  Start-test grace-period state: g-1059 f0x2
[    2.460477] rcu_torture_write_types: Testing conditional GPs.
[    2.460485] rcu_torture_write_types: Testing expedited GPs.
[    2.460489] rcu_torture_write_types: Testing asynchronous GPs.
[    2.460493] rcu_torture_write_types: Testing polling GPs.
[    2.460504] rcu_torture_write_types: Testing normal GPs.
[    2.460509] rcu-torture: Creating rcu_torture_writer task
[    2.462069] rcu-torture: Creating rcu_torture_fakewriter task
[    2.463632] rcu-torture: rcu_torture_writer task started
[    2.464850] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    2.466457] rcu-torture: Creating rcu_torture_fakewriter task
[    2.467751] rcu-torture: rcu_torture_fakewriter task started
[    2.468908] rcu-torture: Creating rcu_torture_fakewriter task
[    2.470114] rcu-torture: rcu_torture_fakewriter task started
[    2.471812] rcu-torture: Creating rcu_torture_fakewriter task
[    2.474036] rcu-torture: rcu_torture_fakewriter task started
[    2.475504] rcu-torture: Creating rcu_torture_reader task
[    2.480650] rcu-torture: rcu_torture_fakewriter task started
[    2.482123] rcu-torture: Creating rcu_torture_stats task
[    2.484044] rcu-torture: rcu_torture_reader task started
[    2.485204] rcu-torture: Creating torture_shuffle task
[    2.486442] rcu-torture: rcu_torture_stats task started
[    2.487531] rcu-torture: Creating torture_stutter task
[    2.488653] rcu-torture: torture_shuffle task started
[    2.489806] rcu-torture: rcu_torture_fwd_prog_init: Limiting fwd_progress to # CPUs.

[    2.492262] rcu-torture: torture_stutter task started
[    2.495494] rcu-torture: Creating rcu_torture_fwd_prog task
[    2.496796] rcu-torture: Creating rcu_torture_read_exit task
[    2.498152] rcu-torture: rcu_torture_fwd_progress task started
[    2.499294] torture_init_begin: Refusing rcu init: rcu running.
[    2.500432] torture_init_begin: One torture test at a time!
[    2.501659] rcu-torture: rcu_torture_read_exit: Start of test
[    2.502804] torture_init_begin: Refusing rcu init: rcu running.
[    2.503989] torture_init_begin: One torture test at a time!
[    2.506798] Initialise system trusted keyrings
[    2.506958] workingset: timestamp_bits=56 max_order=19 bucket_order=0
[    2.525650] NFS: Registering the id_resolver key type
[    2.525684] Key type id_resolver registered
[    2.525692] Key type id_legacy registered
[    2.536722] Key type asymmetric registered
[    2.536741] Asymmetric key parser 'x509' registered
[    2.536785] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    2.536802] io scheduler mq-deadline registered
[    2.536806] io scheduler kyber registered
[    2.537143] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.537267] ACPI: button: Power Button [PWRF]
[    2.584658] rcu_torture_rea (47) used greatest stack depth: 15448 bytes left
[    2.619468] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.619888] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.621128] Non-volatile memory driver v1.3
[    2.621184] Linux agpgart interface v0.103
[    2.621419] ACPI: bus type drm_connector registered
[    2.630895] loop: module loaded
[    2.632808] virtio_blk virtio0: [vda] 6291456 512-byte logical blocks (3.22 GB/3.00 GiB)
[    2.635345]  vda: vda1
[    2.636242] ata_piix 0000:00:01.1: version 2.13
[    2.638871] scsi host0: ata_piix
[    2.639537] scsi host1: ata_piix
[    2.639762] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0e0 irq 14
[    2.639786] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0e8 irq 15
[    2.641798] e100: Intel(R) PRO/100 Network Driver
[    2.641807] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.641890] e1000: Intel(R) PRO/1000 Network Driver
[    2.641895] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.796879] ata2: found unknown device (class 0)
[    2.798365] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.800839] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.817878] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    2.817911] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.833161] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.833508] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    2.838888] ACPI: \_SB_.LNKC: Enabled at IRQ 10
[    3.272088] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    3.272123] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.272291] e1000e: Intel(R) PRO/1000 Network Driver
[    3.272296] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.272568] sky2: driver version 1.30
[    3.273142] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.273148] ehci-pci: EHCI PCI platform driver
[    3.273259] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.273270] ohci-pci: OHCI PCI platform driver
[    3.273411] uhci_hcd: USB Universal Host Controller Interface driver
[    3.455455] uhci_hcd 0000:00:01.2: UHCI Host Controller
[    3.455707] uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
[    3.456216] uhci_hcd 0000:00:01.2: irq 11, io port 0x0000c0c0
[    3.456536] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    3.456557] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.456570] usb usb1: Product: UHCI Host Controller
[    3.456577] usb usb1: Manufacturer: Linux 5.17.0-rc2-00353-g90c9e950c0de uhci_hcd
[    3.456584] usb usb1: SerialNumber: 0000:00:01.2
[    3.457430] hub 1-0:1.0: USB hub found
[    3.457458] hub 1-0:1.0: 2 ports detected
[    3.458636] usbcore: registered new interface driver usblp
[    3.458756] usbcore: registered new interface driver usb-storage
[    3.458909] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.462628] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.462657] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.464681] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    3.465921] rtc_cmos 00:05: RTC can wake from S4
[    3.471724] rtc_cmos 00:05: registered as rtc0
[    3.471785] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    3.472316] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel at redhat.com
[    3.472334] Bluetooth: HCI UART driver ver 2.3
[    3.472344] Bluetooth: HCI UART protocol H4 registered
[    3.472426] usbcore: registered new interface driver btusb
[    3.472434] intel_pstate: CPU model not supported
[    3.472618] hid: raw HID events driver (C) Jiri Kosina
[    3.473764] usbcore: registered new interface driver usbhid
[    3.473835] usbhid: USB HID core driver
[    3.478813] Initializing XFRM netlink socket
[    3.479624] NET: Registered PF_INET6 protocol family
[    3.481748] Segment Routing with IPv6
[    3.481773] In-situ OAM (IOAM) with IPv6
[    3.482350] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.483731] NET: Registered PF_PACKET protocol family
[    3.483785] Bluetooth: RFCOMM socket layer initialized
[    3.483800] Bluetooth: RFCOMM ver 1.11
[    3.483876] Key type dns_resolver registered
[    3.484433] IPI shorthand broadcast: enabled
[    3.484537] sched_clock: Marking stable (3460414264, 23971516)->(3508082366, -23696586)
[    3.485034] registered taskstats version 1
[    3.485077] Loading compiled-in X.509 certificates
[    3.485691] cryptomgr_test (56) used greatest stack depth: 15416 bytes left
[    3.489242] PM:   Magic number: 10:381:733
[    3.489351] printk: console [netcon0] enabled
[    3.489356] netconsole: network logging started
[    3.489696] Bluetooth: Starting self testing
[    3.507301] tsc: Refined TSC clocksource calibration: 2594.023 MHz
[    3.507317] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25642dcf959, max_idle_ns: 440795318027 ns
[    3.507361] clocksource: Switched to clocksource tsc
[    3.507582] cryptomgr_test (80) used greatest stack depth: 15248 bytes left
[    3.603578] Bluetooth: ECDH test passed in 111205 usecs
[    3.604120] kworker/u2:2 (81) used greatest stack depth: 14432 bytes left
[    3.643711] Bluetooth: SMP test passed in 38300 usecs
[    3.643828] Bluetooth: Finished self testing
[    3.643848] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.646937] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.647123] ALSA device list:
[    3.647130]   No soundcards found.
[    3.647505] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.647520] cfg80211: failed to load regulatory.db
[    4.129657] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    4.130960] md: Waiting for all devices to be available before autodetect
[    4.130996] md: If you don't use raid, use raid=noautodetect
[    4.131075] md: Autodetecting RAID arrays.
[    4.131097] md: autorun ...
[    4.131152] md: ... autorun DONE.
[    4.152832] EXT4-fs (vda1): mounted filesystem with ordered data mode. Quota mode: none.
[    4.153189] VFS: Mounted root (ext4 filesystem) on device 253:1.
[    4.154855] devtmpfs: mounted
[    4.162912] Freeing unused kernel image (initmem) memory: 1444K
[    4.163774] Write protecting the kernel read-only data: 32768k
[    4.185079] Freeing unused kernel image (text/rodata gap) memory: 2032K
[    4.187126] Freeing unused kernel image (rodata/data gap) memory: 1008K
[    4.187572] Run /sbin/init as init process
[    4.187581]   with arguments:
[    4.187630]     /sbin/init
[    4.187637]   with environment:
[    4.187643]     HOME=/
[    4.187649]     TERM=linux
[    4.232536] random: fast init done
[    4.329457] systemd[1]: systemd 250.3-2 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[    4.329973] systemd[1]: Detected virtualization kvm.
[    4.330000] systemd[1]: Detected architecture x86-64.
[    4.330361] systemd[1]: Detected first boot.
[    4.331082] systemd[1]: Hostname set to <ersatz>.
[    4.334222] systemd[1]: Initializing machine ID from D-Bus machine ID.
[    4.489292] mkdir (103) used greatest stack depth: 12632 bytes left
[    4.734543] random: lvmconfig: uninitialized urandom read (4 bytes read)
[    5.469017] systemd[1]: Populated /etc with preset unit settings.
[    5.577629] systemd[1]: Queued start job for default target Graphical Interface.
[    5.579459] systemd[1]: Created slice Slice /system/getty.
[    5.580436] systemd[1]: Created slice Slice /system/modprobe.
[    5.581182] systemd[1]: Created slice Slice /system/postfix.
[    5.581642] systemd[1]: Created slice User and Session Slice.
[    5.581873] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    5.582083] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    5.582764] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    5.582807] systemd[1]: Reached target Local Encrypted Volumes.
[    5.582841] systemd[1]: Reached target Local Integrity Protected Volumes.
[    5.582876] systemd[1]: Reached target Remote Encrypted Volumes.
[    5.582891] systemd[1]: Reached target Remote File Systems.
[    5.582904] systemd[1]: Reached target Remote Verity Protected Volumes.
[    5.582922] systemd[1]: Reached target Slice Units.
[    5.582941] systemd[1]: Reached target Swaps.
[    5.582958] systemd[1]: Reached target Local Verity Protected Volumes.
[    5.583334] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    5.583783] systemd[1]: Listening on LVM2 poll daemon socket.
[    5.584139] systemd[1]: Listening on Syslog Socket.
[    5.584570] systemd[1]: Listening on fsck to fsckd communication Socket.
[    5.584761] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    5.585244] systemd[1]: Listening on Journal Audit Socket.
[    5.585568] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.585961] systemd[1]: Listening on Journal Socket.
[    5.586443] systemd[1]: Listening on Network Service Netlink Socket.
[    5.587041] systemd[1]: Listening on udev Control Socket.
[    5.587311] systemd[1]: Listening on udev Kernel Socket.
[    5.590067] systemd[1]: Mounting Huge Pages File System...
[    5.592813] systemd[1]: Mounting POSIX Message Queue File System...
[    5.602614] systemd[1]: Mounting Kernel Debug File System...
[    5.613690] systemd[1]: Mounting Kernel Trace File System...
[    5.614294] systemd[1]: Finished Availability of block devices.
[    5.630847] systemd[1]: Starting Wait for network to be configured by ifupdown...
[    5.635931] systemd[1]: Create List of Static Device Nodes was skipped because of a failed condition check (ConditionFileNotEmpty=/lib/modules/5.17.0-rc2-00353-g90c9e950c0de/modules.devname).
[    5.639774] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    5.652697] systemd[1]: Starting Load Kernel Module configfs...
[    5.662187] systemd[1]: Starting Load Kernel Module drm...
[    5.670736] systemd[1]: Starting Load Kernel Module fuse...
[    5.690909] systemd[1]: Starting nftables...
[    5.691066] systemd[1]: File System Check on Root Device was skipped because of a failed condition check (ConditionPathIsReadWrite=!/).
[    5.691325] systemd[1]: systemd-journald.service: unit configures an IP firewall, but the local system does not support BPF/cgroup firewalling.
[    5.691462] systemd[1]: (This warning is only shown for the first unit using IP firewalling.)
[    5.711414] systemd[1]: Starting Journal Service...
[    5.739160] systemd[1]: Starting Load Kernel Modules...
[    5.743498] random: lvm: uninitialized urandom read (4 bytes read)
[    5.750217] systemd[1]: Starting Generate network units from Kernel command line...
[    5.773247] systemd[1]: Starting Remount Root and Kernel File Systems...
[    5.773546] systemd[1]: Repartition Root Disk was skipped because all trigger condition checks failed.
[    5.789906] systemd[1]: Starting Coldplug All udev Devices...
[    5.838015] systemd[1]: Mounted Huge Pages File System.
[    5.838339] systemd[1]: Mounted POSIX Message Queue File System.
[    5.844955] systemd[1]: Mounted Kernel Debug File System.
[    5.845325] systemd[1]: Mounted Kernel Trace File System.
[    5.850306] systemd[1]: modprobe at configfs.service: Deactivated successfully.
[    5.866036] systemd[1]: Finished Load Kernel Module configfs.
[    5.867116] systemd[1]: modprobe at drm.service: Deactivated successfully.
[    5.880199] systemd[1]: Finished Load Kernel Module drm.
[    5.881283] systemd[1]: modprobe at fuse.service: Deactivated successfully.
[    5.893975] systemd[1]: Finished Load Kernel Module fuse.
[    5.895253] systemd[1]: FUSE Control File System was skipped because of a failed condition check (ConditionPathExists=/sys/fs/fuse/connections).
[    5.903106] systemd[1]: Kernel Configuration File System was skipped because of a failed condition check (ConditionPathExists=/sys/kernel/config).
[    5.904035] systemd[1]: Finished Load Kernel Modules.
[    5.904784] systemd[1]: Finished Generate network units from Kernel command line.
[    5.930816] systemd[1]: Starting Apply Kernel Variables...
[    5.978793] EXT4-fs (vda1): re-mounted. Quota mode: none.
[    5.990989] systemd[1]: Finished Remount Root and Kernel File Systems.
[    5.991287] systemd[1]: Platform Persistent Storage Archival was skipped because of a failed condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
[    5.997112] systemd[1]: Starting Load/Save Random Seed...
[    6.010856] systemd[1]: Starting Create System Users...
[    6.073596] systemd[1]: Finished Apply Kernel Variables.
[    6.161776] systemd[1]: Finished Create System Users.
[    6.163739] systemd[1]: Starting Create Static Device Nodes in /dev...
[    6.277768] systemd[1]: Finished Create Static Device Nodes in /dev.
[    6.281653] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    6.367533] systemd[1]: nftables.service: Main process exited, code=exited, status=1/FAILURE
[    6.368117] systemd[1]: nftables.service: Failed with result 'exit-code'.
[    6.368532] systemd[1]: Failed to start nftables.
[    6.619800] systemd[1]: Started Journal Service.
[    6.695553] systemd-journald[125]: Received client request to flush runtime journal.
[    7.481908] e1000 0000:00:03.0 enp0s3: renamed from eth0
[    7.643064] cdrom_id (165) used greatest stack depth: 12512 bytes left
[    7.784463] random: crng init done
[    7.907533] rcu-torture: rcu_torture_read_exit: End of episode
[    8.271359] ==================================================================
[    8.273034] BUG: KCSAN: data-race in virtqueue_get_buf_ctx_split+0x5d/0x240

[    8.286299] race at unknown origin, with read to 0xffff8a5541f29242 of 2 bytes by interrupt on cpu 0:
[    8.288152]  virtqueue_get_buf_ctx_split+0x5d/0x240
[    8.288165]  virtqueue_get_buf+0x2e/0x40
[    8.288185]  virtblk_done+0xbe/0x150
[    8.288197]  vring_interrupt+0xb3/0xf0
[    8.288204]  __handle_irq_event_percpu+0x72/0x230
[    8.288214]  handle_irq_event+0x6f/0xe0
[    8.288223]  handle_edge_irq+0x136/0x410
[    8.288234]  __common_interrupt+0x64/0x100
[    8.288241]  common_interrupt+0x9f/0xc0
[    8.288249]  asm_common_interrupt+0x1e/0x40
[    8.288257]  kcsan_setup_watchpoint+0x272/0x3d0
[    8.288267]  ___bpf_prog_run+0x28/0x3330
[    8.288274]  __bpf_prog_run32+0x52/0x80
[    8.288281]  __seccomp_filter+0x10a/0x7b0
[    8.288291]  __secure_computing+0x56/0x110
[    8.288301]  syscall_trace_enter.constprop.0+0xd2/0x320
[    8.288312]  syscall_enter_from_user_mode+0x35/0x40
[    8.288321]  do_syscall_64+0x16/0x80
[    8.288328]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[    8.289141] value changed: 0x048f -> 0x0493

[    8.292021] Reported by Kernel Concurrency Sanitizer on:
[    8.293878] CPU: 0 PID: 200 Comm: systemd-sysctl Not tainted 5.17.0-rc2-00353-g90c9e950c0de #34
[    8.293895] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    8.293904] ==================================================================
[    8.510046] systemd-update- (205) used greatest stack depth: 11912 bytes left
[   22.252794] rcu-torture: rcu_torture_read_exit: Start of episode
[   22.264486] rcu-torture: rcu_torture_read_exit: End of episode
[   29.589597] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 113980ns
[   29.589650] clocksource: wd-tsc-wd read-back delay of 101310ns, clock-skew test skipped!
[   30.085019] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92920ns
[   30.085060] clocksource: wd-tsc-wd read-back delay of 105660ns, clock-skew test skipped!
[   31.084995] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92480ns
[   31.085056] clocksource: wd-tsc-wd read-back delay of 101250ns, clock-skew test skipped!
[   35.981944] rcu-torture: rcu_torture_read_exit: Start of episode
[   35.999047] rcu-torture: rcu_torture_read_exit: End of episode
[   49.324436] rcu-torture: rcu_torture_read_exit: Start of episode
[   49.339839] rcu-torture: rcu_torture_read_exit: End of episode
[   56.588908] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 106770ns
[   56.589644] clocksource: wd-tsc-wd read-back delay of 146070ns, clock-skew test skipped!
[   57.588840] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 56480ns
[   57.588881] clocksource: wd-tsc-wd read-back delay of 150890ns, clock-skew test skipped!
[   58.084858] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 54820ns
[   58.084897] clocksource: wd-tsc-wd read-back delay of 141880ns, clock-skew test skipped!
[   58.589038] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 89510ns
[   58.589444] clocksource: wd-tsc-wd read-back delay of 104850ns, clock-skew test skipped!
[   59.588859] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 75680ns
[   59.588913] clocksource: wd-tsc-wd read-back delay of 137650ns, clock-skew test skipped!
[   62.508430] rcu-torture: rtc: 000000001f04b065 ver: 8272 tfle: 0 rta: 8273 rtaf: 0 rtf: 8263 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 18516 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 67 nocb-toggles: 0:0
[   62.510954] rcu-torture: Reader Pipe:  3368734 38 0 0 0 0 0 0 0 0 0
[   62.511930] rcu-torture: Reader Batch:  3368653 119 0 0 0 0 0 0 0 0 0
[   62.512959] rcu-torture: Free-Block Circulation:  8272 8271 8270 8269 8268 8267 8266 8265 8264 8263 0
[   62.514401] rcu_torture_fwd_prog: Starting forward-progress test 0
[   62.537700] rcu_torture_fwd_prog_cr Duration 14 barrier: 3 pending 1661 n_launders: 3934 n_launders_sa: 3019 n_max_gps: 100 n_max_cbs: 2922 cver 2 gps 13
[   62.540075] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 19 jiffies): 1s/10: 6856:15
[   62.828398] rcu-torture: rcu_torture_read_exit: Start of episode
[   62.844179] rcu-torture: rcu_torture_read_exit: End of episode
[   76.140442] rcu-torture: rcu_torture_read_exit: Start of episode
[   76.155021] rcu-torture: rcu_torture_read_exit: End of episode
[   79.381085] rcu_torture_fwd_prog_nr: 0 Duration 15777 cver 3214 gps 13123
[   81.084883] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92870ns
[   81.084940] clocksource: wd-tsc-wd read-back delay of 138090ns, clock-skew test skipped!
[   82.085045] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 101160ns
[   82.085102] clocksource: wd-tsc-wd read-back delay of 104010ns, clock-skew test skipped!
[   82.588842] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 69930ns
[   82.588881] clocksource: wd-tsc-wd read-back delay of 145960ns, clock-skew test skipped!
[   85.084865] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92300ns
[   85.084911] clocksource: wd-tsc-wd read-back delay of 128960ns, clock-skew test skipped!
[   89.964687] rcu-torture: rcu_torture_read_exit: Start of episode
[   89.976328] rcu-torture: rcu_torture_read_exit: End of episode
[  103.468396] rcu-torture: rcu_torture_read_exit: Start of episode
[  103.480993] rcu-torture: rcu_torture_read_exit: End of episode
[  107.086508] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 55450ns
[  107.086564] clocksource: wd-tsc-wd read-back delay of 121840ns, clock-skew test skipped!
[  107.588851] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 58270ns
[  107.588891] clocksource: wd-tsc-wd read-back delay of 152770ns, clock-skew test skipped!
[  108.086263] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 61280ns
[  108.086316] clocksource: wd-tsc-wd read-back delay of 129020ns, clock-skew test skipped!
[  109.084995] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 90630ns
[  109.085056] clocksource: wd-tsc-wd read-back delay of 104020ns, clock-skew test skipped!
[  116.780459] rcu-torture: rcu_torture_read_exit: Start of episode
[  116.792927] rcu-torture: rcu_torture_read_exit: End of episode
[  123.948420] rcu-torture: rtc: 00000000bb356c5f ver: 17905 tfle: 0 rta: 17906 rtaf: 0 rtf: 17896 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 39959 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 152 nocb-toggles: 0:0
[  123.953053] rcu-torture: Reader Pipe:  6822003 202 0 0 0 0 0 0 0 0 0
[  123.954699] rcu-torture: Reader Batch:  6821716 489 0 0 0 0 0 0 0 0 0
[  123.956046] rcu-torture: Free-Block Circulation:  17905 17904 17903 17902 17901 17900 17899 17898 17897 17896 0
[  130.412419] rcu-torture: rcu_torture_read_exit: Start of episode
[  130.423205] rcu-torture: rcu_torture_read_exit: End of episode
[  140.332531] rcu_torture_fwd_prog n_max_cbs: 2922
[  140.333833] rcu_torture_fwd_prog: Starting forward-progress test 0
[  140.354036] rcu_torture_fwd_prog_cr Duration 8 barrier: 3 pending 340 n_launders: 2297 n_launders_sa: 339 n_max_gps: 100 n_max_cbs: 1628 cver 0 gps 8
[  140.357561] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 15 jiffies): 1s/10: 3925:9
[  143.724388] rcu-torture: rcu_torture_read_exit: Start of episode
[  143.738910] rcu-torture: rcu_torture_read_exit: End of episode
[  157.164386] rcu-torture: rcu_torture_read_exit: Start of episode
[  157.179503] rcu-torture: rcu_torture_read_exit: End of episode
[  161.341448] rcu_torture_fwd_prog_nr: 0 Duration 19919 cver 3492 gps 14610
[  170.668532] rcu-torture: rcu_torture_read_exit: Start of episode
[  170.681238] rcu-torture: rcu_torture_read_exit: End of episode
[  183.980427] rcu-torture: rcu_torture_read_exit: Start of episode
[  183.993274] rcu-torture: rcu_torture_read_exit: End of episode
[  185.388758] rcu-torture: rtc: 000000006f2036d6 ver: 27658 tfle: 0 rta: 27658 rtaf: 0 rtf: 27649 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 61742 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 237 nocb-toggles: 0:0
[  185.408095] rcu-torture: Reader Pipe:  10356662 370 0 0 0 0 0 0 0 0 0
[  185.414608] rcu-torture: Reader Batch:  10356134 898 0 0 0 0 0 0 0 0 0
[  185.423309] rcu-torture: Free-Block Circulation:  27657 27657 27656 27655 27654 27653 27652 27651 27650 27649 0
[  186.086617] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 90610ns
[  186.086681] clocksource: wd-tsc-wd read-back delay of 156500ns, clock-skew test skipped!
[  187.087542] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 719500ns
[  187.087600] clocksource: wd-tsc-wd read-back delay of 205840ns, clock-skew test skipped!
[  188.087821] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 135380ns
[  188.087880] clocksource: wd-tsc-wd read-back delay of 1002980ns, clock-skew test skipped!
[  189.086899] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 59890ns
[  189.086957] clocksource: wd-tsc-wd read-back delay of 161380ns, clock-skew test skipped!
[  197.292459] rcu-torture: rcu_torture_read_exit: Start of episode
[  197.305149] rcu-torture: rcu_torture_read_exit: End of episode
[  210.604462] rcu-torture: rcu_torture_read_exit: Start of episode
[  210.618916] rcu-torture: rcu_torture_read_exit: End of episode
[  211.085239] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 89640ns
[  211.085656] clocksource: wd-tsc-wd read-back delay of 103230ns, clock-skew test skipped!
[  211.590713] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 54960ns
[  211.591123] clocksource: wd-tsc-wd read-back delay of 101040ns, clock-skew test skipped!
[  212.588906] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 90860ns
[  212.588968] clocksource: wd-tsc-wd read-back delay of 104190ns, clock-skew test skipped!
[  213.085734] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 90520ns
[  213.085791] clocksource: wd-tsc-wd read-back delay of 101800ns, clock-skew test skipped!
[  213.590274] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 76610ns
[  213.590336] clocksource: wd-tsc-wd read-back delay of 134260ns, clock-skew test skipped!
[  214.084854] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 91700ns
[  214.084915] clocksource: wd-tsc-wd read-back delay of 101600ns, clock-skew test skipped!
[  224.172408] rcu-torture: rcu_torture_read_exit: Start of episode
[  224.183549] rcu-torture: rcu_torture_read_exit: End of episode
[  226.519337] rcu_torture_fwd_prog n_max_cbs: 1628
[  226.520606] rcu_torture_fwd_prog: Starting forward-progress test 0
[  226.558235] rcu_torture_fwd_prog_cr Duration 28 barrier: 3 pending 132 n_launders: 8963 n_launders_sa: 8963 n_max_gps: 100 n_max_cbs: 4432 cver 4 gps 27
[  226.560471] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 34 jiffies): 1s/10: 13395:29
[  233.624344] e1000: enp0s3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  233.643650] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s3: link becomes ready
[  235.780400] rcu_torture_fwd_prog_nr: 0 Duration 8214 cver 1513 gps 4998
[  237.804579] rcu-torture: rcu_torture_read_exit: Start of episode
[  238.084908] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92520ns
[  238.084955] clocksource: wd-tsc-wd read-back delay of 102990ns, clock-skew test skipped!
[  241.085107] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 86550ns
[  241.085434] clocksource: wd-tsc-wd read-back delay of 103720ns, clock-skew test skipped!
[  241.635918] rcu-torture: rcu_torture_read_exit: End of episode
[  246.859092] rcu-torture: rtc: 000000004d185a45 ver: 36148 tfle: 0 rta: 36148 rtaf: 0 rtf: 36134 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 78622 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 305 nocb-toggles: 0:0
[  246.863821] rcu-torture: Reader Pipe:  13434666 420 0 0 0 0 0 0 0 0 0
[  246.865211] rcu-torture: Reader Batch:  13434076 1010 0 0 0 0 0 0 0 0 0
[  246.866456] rcu-torture: Free-Block Circulation:  36147 36147 36145 36144 36141 36140 36139 36136 36135 36134 0
[  255.148393] rcu-torture: rcu_torture_read_exit: Start of episode
[  255.157670] rcu-torture: rcu_torture_read_exit: End of episode
[  266.085478] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 184080ns
[  266.085764] clocksource: wd-tsc-wd read-back delay of 148410ns, clock-skew test skipped!
[  268.628795] rcu-torture: rcu_torture_read_exit: Start of episode
[  268.644541] rcu-torture: rcu_torture_read_exit: End of episode
[  282.220449] rcu-torture: rcu_torture_read_exit: Start of episode
[  282.234940] rcu-torture: rcu_torture_read_exit: End of episode
[  295.660642] rcu-torture: rcu_torture_read_exit: Start of episode
[  295.674793] rcu-torture: rcu_torture_read_exit: End of episode
[  295.980548] rcu_torture_fwd_prog n_max_cbs: 4432
[  295.981607] rcu_torture_fwd_prog: Starting forward-progress test 0
[  296.007812] rcu_torture_fwd_prog_cr Duration 20 barrier: 3 pending 2031 n_launders: 8953 n_launders_sa: 8953 n_max_gps: 100 n_max_cbs: 4427 cver 2 gps 16
[  296.010068] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 25 jiffies): 1s/10: 13380:17
[  302.520422] rcu_torture_fwd_prog_nr: 0 Duration 5450 cver 1024 gps 3422
[  308.268376] rcu-torture: rtc: 000000006bc6b8f5 ver: 45885 tfle: 0 rta: 45886 rtaf: 0 rtf: 45876 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 99138 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 373 nocb-toggles: 0:0
[  308.273201] rcu-torture: Reader Pipe:  17214188 469 0 0 0 0 0 0 0 0 0
[  308.274476] rcu-torture: Reader Batch:  17213481 1176 0 0 0 0 0 0 0 0 0
[  308.275855] rcu-torture: Free-Block Circulation:  45885 45884 45883 45882 45881 45880 45879 45878 45877 45876 0
[  309.271467] rcu-torture: rcu_torture_read_exit: Start of episode
[  309.282088] rcu-torture: rcu_torture_read_exit: End of episode
[  322.668387] rcu-torture: rcu_torture_read_exit: Start of episode
[  322.681812] rcu-torture: rcu_torture_read_exit: End of episode
[  336.172488] rcu-torture: rcu_torture_read_exit: Start of episode
[  336.181597] rcu-torture: rcu_torture_read_exit: End of episode
[  344.085094] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 94670ns
[  344.085600] clocksource: wd-tsc-wd read-back delay of 122420ns, clock-skew test skipped!
[  345.086444] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 98410ns
[  345.086519] clocksource: wd-tsc-wd read-back delay of 309000ns, clock-skew test skipped!
[  349.740444] rcu-torture: rcu_torture_read_exit: Start of episode
[  349.755699] rcu-torture: rcu_torture_read_exit: End of episode
[  363.244721] rcu-torture: rcu_torture_read_exit: Start of episode
[  363.256101] rcu-torture: rcu_torture_read_exit: End of episode
[  365.612406] rcu_torture_fwd_prog n_max_cbs: 4427
[  365.613461] rcu_torture_fwd_prog: Starting forward-progress test 0
[  365.629039] rcu_torture_fwd_prog_cr Duration 9 barrier: 3 pending 1156 n_launders: 3553 n_launders_sa: 1156 n_max_gps: 100 n_max_cbs: 2452 cver 1 gps 10
[  365.632874] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 16 jiffies): 1s/10: 6005:12
[  369.708389] rcu-torture: rtc: 00000000ce0ac0ff ver: 54627 tfle: 0 rta: 54627 rtaf: 0 rtf: 54618 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 119890 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 458 nocb-toggles: 0:0
[  369.712157] rcu-torture: Reader Pipe:  21002985 499 0 0 0 0 0 0 0 0 0
[  369.713427] rcu-torture: Reader Batch:  21002172 1312 0 0 0 0 0 0 0 0 0
[  369.714781] rcu-torture: Free-Block Circulation:  54626 54626 54625 54624 54623 54622 54621 54620 54619 54618 0
[  376.559396] rcu-torture: rcu_torture_read_exit: Start of episode
[  376.712434] rcu-torture: rcu_torture_read_exit: End of episode
[  381.829363] rcu_torture_fwd_prog_nr: 0 Duration 15127 cver 1984 gps 8161
[  390.528276] rcu-torture: rcu_torture_read_exit: Start of episode
[  390.538568] rcu-torture: rcu_torture_read_exit: End of episode
[  403.884493] rcu-torture: rcu_torture_read_exit: Start of episode
[  403.893733] rcu-torture: rcu_torture_read_exit: End of episode
[  410.295890] ==================================================================
[  410.297475] BUG: KCSAN: data-race in e1000_clean_rx_irq+0x330/0x870

[  410.299722] race at unknown origin, with read to 0xffff8a554584d3ec of 1 bytes by interrupt on cpu 0:
[  410.301524]  e1000_clean_rx_irq+0x330/0x870
[  410.301534]  e1000_clean+0x4a5/0xc40
[  410.301541]  __napi_poll+0x5c/0x280
[  410.301550]  net_rx_action+0x4ff/0x5b0
[  410.301559]  __do_softirq+0xe4/0x2d9
[  410.301567]  run_ksoftirqd+0x21/0x30
[  410.301577]  smpboot_thread_fn+0x26b/0x360
[  410.301595]  kthread+0x16d/0x1a0
[  410.301604]  ret_from_fork+0x22/0x30

[  410.302478] value changed: 0x00 -> 0x07

[  410.304564] Reported by Kernel Concurrency Sanitizer on:
[  410.305757] CPU: 0 PID: 12 Comm: ksoftirqd/0 Not tainted 5.17.0-rc2-00353-g90c9e950c0de #34
[  410.305776] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  410.305788] ==================================================================
[  417.388415] rcu-torture: rcu_torture_read_exit: Start of episode
[  417.454517] rcu-torture: rcu_torture_read_exit: End of episode
[  430.828601] rcu-torture: rcu_torture_read_exit: Start of episode
[  430.852462] rcu-torture: rcu_torture_read_exit: End of episode
[  431.148654] rcu-torture: rtc: 00000000bb356c5f ver: 63668 tfle: 0 rta: 63669 rtaf: 0 rtf: 63659 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 132348 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 543 nocb-toggles: 0:0
[  431.154592] rcu-torture: Reader Pipe:  22910757 571 0 0 0 0 0 0 0 0 0
[  431.156056] rcu-torture: Reader Batch:  22909930 1398 0 0 0 0 0 0 0 0 0
[  431.157414] rcu-torture: Free-Block Circulation:  63668 63667 63666 63665 63664 63663 63662 63661 63660 63659 0
[  443.436370] rcu_torture_fwd_prog n_max_cbs: 2452
[  443.437511] rcu_torture_fwd_prog: Starting forward-progress test 0
[  443.453070] rcu_torture_fwd_prog_cr Duration 10 barrier: 2 pending 506 n_launders: 3526 n_launders_sa: 2524 n_max_gps: 100 n_max_cbs: 2424 cver 1 gps 13
[  443.457691] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 17 jiffies): 1s/10: 5950:14
[  444.204445] rcu-torture: rcu_torture_read_exit: Start of episode
[  444.217166] rcu-torture: rcu_torture_read_exit: End of episode
[  457.516613] rcu-torture: rcu_torture_read_exit: Start of episode
[  457.667427] rcu-torture: rcu_torture_read_exit: End of episode
[  463.784371] rcu_torture_fwd_prog_nr: 0 Duration 19322 cver 2637 gps 10216
[  471.084575] rcu-torture: rcu_torture_read_exit: Start of episode
[  471.588996] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 91850ns
[  471.589056] clocksource: wd-tsc-wd read-back delay of 105770ns, clock-skew test skipped!
[  472.588959] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 90940ns
[  472.589385] clocksource: wd-tsc-wd read-back delay of 102500ns, clock-skew test skipped!
[  473.588916] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 94320ns
[  473.588975] clocksource: wd-tsc-wd read-back delay of 102030ns, clock-skew test skipped!
[  474.084910] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92720ns
[  474.085504] clocksource: wd-tsc-wd read-back delay of 103230ns, clock-skew test skipped!
[  475.589217] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 76090ns
[  475.589524] clocksource: wd-tsc-wd read-back delay of 141930ns, clock-skew test skipped!
[  475.938817] rcu-torture: rcu_torture_read_exit: End of episode
[  489.644594] rcu-torture: rcu_torture_read_exit: Start of episode
[  489.656863] rcu-torture: rcu_torture_read_exit: End of episode
[  492.588998] rcu-torture: rtc: 00000000d49e1347 ver: 73181 tfle: 0 rta: 73182 rtaf: 0 rtf: 73171 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 148795 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 611 nocb-toggles: 0:0
[  492.593268] rcu-torture: Reader Pipe:  25929739 647 0 0 0 0 0 0 0 0 0
[  492.595501] rcu-torture: Reader Batch:  25928854 1532 0 0 0 0 0 0 0 0 0
[  492.597149] rcu-torture: Free-Block Circulation:  73181 73180 73178 73177 73176 73175 73174 73173 73172 73171 0
[  500.085027] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 98550ns
[  500.085072] clocksource: wd-tsc-wd read-back delay of 210790ns, clock-skew test skipped!
[  502.956709] rcu-torture: rcu_torture_read_exit: Start of episode
[  502.970685] rcu-torture: rcu_torture_read_exit: End of episode
[  517.292748] rcu-torture: rcu_torture_read_exit: Start of episode
[  517.300672] rcu-torture: rcu_torture_read_exit: End of episode
[  525.356511] rcu_torture_fwd_prog n_max_cbs: 2424
[  525.357828] rcu_torture_fwd_prog: Starting forward-progress test 0
[  525.377109] rcu_torture_fwd_prog_cr Duration 14 barrier: 2 pending 461 n_launders: 4823 n_launders_sa: 747 n_max_gps: 100 n_max_cbs: 3278 cver 0 gps 14
[  525.379526] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 19 jiffies): 1s/10: 8101:16
[  530.669421] rcu-torture: rcu_torture_read_exit: Start of episode
[  530.814527] rcu-torture: rcu_torture_read_exit: End of episode
[  532.085380] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 55690ns
[  532.085397] clocksource: wd-tsc-wd read-back delay of 779690ns, clock-skew test skipped!
[  544.236541] rcu-torture: rcu_torture_read_exit: Start of episode
[  544.419538] rcu-torture: rcu_torture_read_exit: End of episode
[  544.464408] rcu_torture_fwd_prog_nr: 0 Duration 18020 cver 3137 gps 10810
[  554.028495] rcu-torture: rtc: 0000000053d9aed8 ver: 81570 tfle: 0 rta: 81570 rtaf: 0 rtf: 81561 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 161829 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 679 nocb-toggles: 0:0
[  554.032417] rcu-torture: Reader Pipe:  28315595 702 0 0 0 0 0 0 0 0 0
[  554.033867] rcu-torture: Reader Batch:  28314667 1630 0 0 0 0 0 0 0 0 0
[  554.035101] rcu-torture: Free-Block Circulation:  81569 81569 81568 81567 81566 81565 81564 81563 81562 81561 0
[  557.804426] rcu-torture: rcu_torture_read_exit: Start of episode
[  557.815692] rcu-torture: rcu_torture_read_exit: End of episode
[  571.678675] rcu-torture: rcu_torture_read_exit: Start of episode
[  571.688237] rcu-torture: rcu_torture_read_exit: End of episode
[  579.588975] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 109500ns
[  579.589243] clocksource: wd-tsc-wd read-back delay of 230390ns, clock-skew test skipped!
[  580.085027] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 119020ns
[  580.085088] clocksource: wd-tsc-wd read-back delay of 294480ns, clock-skew test skipped!
[  585.196561] rcu-torture: rcu_torture_read_exit: Start of episode
[  585.207435] rcu-torture: rcu_torture_read_exit: End of episode
[  598.956395] rcu-torture: rcu_torture_read_exit: Start of episode
[  598.966414] rcu-torture: rcu_torture_read_exit: End of episode
[  605.589090] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 93300ns
[  605.589485] clocksource: wd-tsc-wd read-back delay of 122980ns, clock-skew test skipped!
[  607.276359] rcu_torture_fwd_prog n_max_cbs: 3278
[  607.277478] rcu_torture_fwd_prog: Starting forward-progress test 0
[  607.304564] rcu_torture_fwd_prog_cr Duration 21 barrier: 3 pending 397 n_launders: 7669 n_launders_sa: 7669 n_max_gps: 100 n_max_cbs: 3785 cver 5 gps 27
[  607.309483] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 29 jiffies): 1s/10: 11454:29
[  612.268902] rcu-torture: rcu_torture_read_exit: Start of episode
[  612.417882] rcu-torture: rcu_torture_read_exit: End of episode
[  615.468428] rcu-torture: rtc: 00000000f85e5f4c ver: 90965 tfle: 0 rta: 90966 rtaf: 0 rtf: 90955 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 181222 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 764 nocb-toggles: 0:0
[  615.474056] rcu-torture: Reader Pipe:  31875555 741 0 0 0 0 0 0 0 0 0
[  615.475352] rcu-torture: Reader Batch:  31874552 1744 0 0 0 0 0 0 0 0 0
[  615.476738] rcu-torture: Free-Block Circulation:  90965 90964 90963 90962 90961 90959 90958 90957 90956 90955 0
[  625.964359] rcu-torture: rcu_torture_read_exit: Start of episode
[  626.095454] rcu-torture: rcu_torture_read_exit: End of episode
[  627.113347] rcu_torture_fwd_prog_nr: 0 Duration 18747 cver 3504 gps 11508
[  629.588936] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 96980ns
[  629.589032] clocksource: wd-tsc-wd read-back delay of 105550ns, clock-skew test skipped!
[  639.532543] rcu-torture: rcu_torture_read_exit: Start of episode
[  639.543709] rcu-torture: rcu_torture_read_exit: End of episode
[  652.972368] rcu-torture: rcu_torture_read_exit: Start of episode
[  652.987190] rcu-torture: rcu_torture_read_exit: End of episode
[  661.085560] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 52300ns
[  661.085579] clocksource: wd-tsc-wd read-back delay of 417730ns, clock-skew test skipped!
[  663.085704] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 66520ns
[  663.085722] clocksource: wd-tsc-wd read-back delay of 1181940ns, clock-skew test skipped!
[  666.412440] rcu-torture: rcu_torture_read_exit: Start of episode
[  666.426479] rcu-torture: rcu_torture_read_exit: End of episode
[  677.037699] rcu-torture: rtc: 000000004d185a45 ver: 100791 tfle: 0 rta: 100792 rtaf: 0 rtf: 100781 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 199613 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 832 nocb-toggles: 0:0
[  677.041441] rcu-torture: Reader Pipe:  35227370 795 0 0 0 0 0 0 0 0 0
[  677.042758] rcu-torture: Reader Batch:  35226295 1870 0 0 0 0 0 0 0 0 0
[  677.044114] rcu-torture: Free-Block Circulation:  100791 100790 100789 100788 100787 100786 100785 100784 100783 100781 0
[  680.084967] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92430ns
[  680.085390] clocksource: wd-tsc-wd read-back delay of 106400ns, clock-skew test skipped!
[  680.108488] rcu-torture: rcu_torture_read_exit: Start of episode
[  684.080167] rcu-torture: rcu_torture_read_exit: End of episode
[  693.292414] rcu_torture_fwd_prog n_max_cbs: 3785
[  693.293495] rcu_torture_fwd_prog: Starting forward-progress test 0
[  693.321115] rcu_torture_fwd_prog_cr Duration 20 barrier: 3 pending 902 n_launders: 7971 n_launders_sa: 4289 n_max_gps: 100 n_max_cbs: 4190 cver 4 gps 20
[  693.323602] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 26 jiffies): 1s/10: 12161:23
[  697.388343] rcu-torture: rcu_torture_read_exit: Start of episode
[  697.520373] rcu-torture: rcu_torture_read_exit: End of episode
[  704.659575] rcu_torture_fwd_prog_nr: 0 Duration 10277 cver 1931 gps 6273
[  710.956373] rcu-torture: rcu_torture_read_exit: Start of episode
[  710.967757] rcu-torture: rcu_torture_read_exit: End of episode
[  724.780365] rcu-torture: rcu_torture_read_exit: Start of episode
[  724.791037] rcu-torture: rcu_torture_read_exit: End of episode
[  738.096529] rcu-torture: rcu_torture_read_exit: Start of episode
[  738.117286] rcu-torture: rcu_torture_read_exit: End of episode
[  738.349149] rcu-torture: rtc: 00000000ce0ac0ff ver: 109229 tfle: 0 rta: 109230 rtaf: 0 rtf: 109219 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 215600 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 917 nocb-toggles: 0:0
[  738.357890] rcu-torture: Reader Pipe:  38176936 837 0 0 0 0 0 0 0 0 0
[  738.361038] rcu-torture: Reader Batch:  38175780 1993 0 0 0 0 0 0 0 0 0
[  738.371113] rcu-torture: Free-Block Circulation:  109229 109228 109226 109225 109224 109223 109222 109221 109220 109219 0
[  751.468390] rcu-torture: rcu_torture_read_exit: Start of episode
[  751.481718] rcu-torture: rcu_torture_read_exit: End of episode
[  752.172385] kworker/dying (7) used greatest stack depth: 11536 bytes left
[  761.589826] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 95180ns
[  761.590262] clocksource: wd-tsc-wd read-back delay of 105940ns, clock-skew test skipped!
[  764.780540] rcu-torture: rcu_torture_read_exit: Start of episode
[  764.791042] rcu-torture: rcu_torture_read_exit: End of episode
[  767.020346] rcu_torture_fwd_prog n_max_cbs: 4190
[  767.021387] rcu_torture_fwd_prog: Starting forward-progress test 0
[  767.052616] rcu_torture_fwd_prog_cr Duration 23 barrier: 4 pending 1587 n_launders: 11331 n_launders_sa: 11331 n_max_gps: 100 n_max_cbs: 5616 cver 7 gps 27
[  767.057840] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 32 jiffies): 1s/10: 16947:30
[  777.857408] rcu_torture_fwd_prog_nr: 0 Duration 9747 cver 1809 gps 5784
[  778.092345] rcu-torture: rcu_torture_read_exit: Start of episode
[  778.107460] rcu-torture: rcu_torture_read_exit: End of episode
[  791.532447] rcu-torture: rcu_torture_read_exit: Start of episode
[  791.544515] rcu-torture: rcu_torture_read_exit: End of episode
[  799.788382] rcu-torture: rtc: 000000002dfc3cfc ver: 118446 tfle: 0 rta: 118447 rtaf: 0 rtf: 118437 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 233695 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 985 nocb-toggles: 0:0
[  799.792253] rcu-torture: Reader Pipe:  41417110 893 0 0 0 0 0 0 0 0 0
[  799.793537] rcu-torture: Reader Batch:  41415899 2104 0 0 0 0 0 0 0 0 0
[  799.794852] rcu-torture: Free-Block Circulation:  118446 118445 118444 118443 118442 118441 118440 118439 118438 118437 0
[  805.356397] rcu-torture: rcu_torture_read_exit: Start of episode
[  805.367490] rcu-torture: rcu_torture_read_exit: End of episode
[  818.668373] rcu-torture: rcu_torture_read_exit: Start of episode
[  818.680773] rcu-torture: rcu_torture_read_exit: End of episode
[  832.236376] rcu-torture: rcu_torture_read_exit: Start of episode
[  832.245735] rcu-torture: rcu_torture_read_exit: End of episode
[  840.748381] rcu_torture_fwd_prog n_max_cbs: 5616
[  840.749633] rcu_torture_fwd_prog: Starting forward-progress test 0
[  840.829841] rcu_torture_fwd_prog_cr Duration 57 barrier: 19 pending 13897 n_launders: 2766 n_launders_sa: 380 n_max_gps: 100 n_max_cbs: 46517 cver 4 gps 10
[  840.833245] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 79 jiffies): 1s/10: 49283:12
[  845.614391] rcu-torture: rcu_torture_read_exit: Start of episode
[  845.744499] rcu-torture: rcu_torture_read_exit: End of episode
[  854.709332] rcu_torture_fwd_prog_nr: 0 Duration 12871 cver 2512 gps 8188
[  859.180434] rcu-torture: rcu_torture_read_exit: Start of episode
[  859.190204] rcu-torture: rcu_torture_read_exit: End of episode
[  861.228349] rcu-torture: rtc: 000000002616d25b ver: 128078 tfle: 0 rta: 128079 rtaf: 0 rtf: 128068 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 251052 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 1070 nocb-toggles: 0:0
[  861.232081] rcu-torture: Reader Pipe:  44544950 952 0 0 0 0 0 0 0 0 0
[  861.233346] rcu-torture: Reader Batch:  44543674 2228 0 0 0 0 0 0 0 0 0
[  861.235086] rcu-torture: Free-Block Circulation:  128078 128077 128075 128074 128073 128072 128071 128070 128069 128068 0
[  862.588809] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 95250ns
[  862.589253] clocksource: wd-tsc-wd read-back delay of 106050ns, clock-skew test skipped!
[  872.940368] rcu-torture: rcu_torture_read_exit: Start of episode
[  872.950380] rcu-torture: rcu_torture_read_exit: End of episode
[  886.572333] rcu-torture: rcu_torture_read_exit: Start of episode
[  886.585894] rcu-torture: rcu_torture_read_exit: End of episode
[  899.884350] rcu-torture: rcu_torture_read_exit: Start of episode
[  899.894587] rcu-torture: rcu_torture_read_exit: End of episode
[  913.388453] rcu-torture: rcu_torture_read_exit: Start of episode
[  914.086165] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 56070ns
[  914.086485] clocksource: wd-tsc-wd read-back delay of 122620ns, clock-skew test skipped!
[  915.086114] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 96040ns
[  915.086173] clocksource: wd-tsc-wd read-back delay of 161360ns, clock-skew test skipped!
[  918.277736] rcu-torture: rcu_torture_read_exit: End of episode
[  918.751206] rcu_torture_fwd_prog n_max_cbs: 46517
[  918.752288] rcu_torture_fwd_prog: Starting forward-progress test 0
[  918.961184] rcu_torture_fwd_prog_cr Duration 181 barrier: 22 pending 1813 n_launders: 82462 n_launders_sa: 76522 n_max_gps: 100 n_max_cbs: 76422 cver 17 gps 70
[  918.965381] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 208 jiffies): 1s/10: 63913:12 2s/10: 94971:60
[  922.668325] rcu-torture: rtc: 00000000d49e1347 ver: 136499 tfle: 0 rta: 136500 rtaf: 0 rtf: 136490 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 270036 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 1138 nocb-toggles: 0:0
[  922.672204] rcu-torture: Reader Pipe:  48093102 979 0 0 0 0 0 0 0 0 0
[  922.673679] rcu-torture: Reader Batch:  48091739 2342 0 0 0 0 0 0 0 0 0
[  922.674929] rcu-torture: Free-Block Circulation:  136499 136498 136497 136496 136495 136494 136493 136492 136491 136490 0
[  930.031388] rcu_torture_fwd_prog_nr: 0 Duration 10048 cver 1882 gps 6140
[  931.628333] rcu-torture: rcu_torture_read_exit: Start of episode
[  931.638877] rcu-torture: rcu_torture_read_exit: End of episode
[  940.084813] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 53700ns
[  940.085067] clocksource: wd-tsc-wd read-back delay of 103910ns, clock-skew test skipped!
[  945.260344] rcu-torture: rcu_torture_read_exit: Start of episode
[  945.272180] rcu-torture: rcu_torture_read_exit: End of episode
[  958.700391] rcu-torture: rcu_torture_read_exit: Start of episode
[  958.712665] rcu-torture: rcu_torture_read_exit: End of episode
[  972.204385] rcu-torture: rcu_torture_read_exit: Start of episode
[  972.217976] rcu-torture: rcu_torture_read_exit: End of episode
[  984.290110] rcu-torture: rtc: 00000000b4599c78 ver: 146029 tfle: 0 rta: 146029 rtaf: 0 rtf: 146019 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 289755 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 1206 nocb-toggles: 0:0
[  984.294401] rcu-torture: Reader Pipe:  51699437 1016 0 0 0 0 0 0 0 0 0
[  984.298607] rcu-torture: Reader Batch:  51697988 2465 0 0 0 0 0 0 0 0 0
[  984.300087] rcu-torture: Free-Block Circulation:  146028 146028 146027 146026 146025 146024 146023 146021 146020 146019 0
[  985.836383] rcu-torture: rcu_torture_read_exit: Start of episode
[  985.848613] rcu-torture: rcu_torture_read_exit: End of episode
[  992.085660] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 51430ns
[  992.085688] clocksource: wd-tsc-wd read-back delay of 254240ns, clock-skew test skipped!
[  992.300352] rcu_torture_fwd_prog n_max_cbs: 76422
[  992.301463] rcu_torture_fwd_prog: Starting forward-progress test 0
[  992.322531] rcu_torture_fwd_prog_cr Duration 16 barrier: 3 pending 1948 n_launders: 7143 n_launders_sa: 7143 n_max_gps: 100 n_max_cbs: 3522 cver 0 gps 15
[  992.324769] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 21 jiffies): 1s/10: 10665:16
[  999.277329] rcu-torture: rcu_torture_read_exit: Start of episode
[  999.413562] rcu-torture: rcu_torture_read_exit: End of episode
[ 1002.615429] rcu_torture_fwd_prog_nr: 0 Duration 9227 cver 1163 gps 4852
[ 1013.445243] rcu-torture: rcu_torture_read_exit: Start of episode
[ 1013.453272] ==================================================================
[ 1013.454817] BUG: KCSAN: data-race in virtqueue_get_buf_ctx_split+0x5d/0x240

[ 1013.456838] race at unknown origin, with read to 0xffff8a5541f29242 of 2 bytes by interrupt on cpu 0:
[ 1013.458564]  virtqueue_get_buf_ctx_split+0x5d/0x240
[ 1013.458574]  virtqueue_get_buf+0x2e/0x40
[ 1013.458581]  virtblk_done+0xbe/0x150
[ 1013.458590]  vring_interrupt+0xb3/0xf0
[ 1013.458597]  __handle_irq_event_percpu+0x72/0x230
[ 1013.458607]  handle_irq_event+0x6f/0xe0
[ 1013.458615]  handle_edge_irq+0x136/0x410
[ 1013.458625]  __common_interrupt+0x64/0x100
[ 1013.458632]  common_interrupt+0x9f/0xc0
[ 1013.458639]  asm_common_interrupt+0x1e/0x40
[ 1013.458647]  _raw_write_unlock_irq+0x12/0x30
[ 1013.458654]  release_task+0x8c7/0xb20
[ 1013.458663]  do_exit+0xc0b/0x1240
[ 1013.458671]  kthread_exit+0x43/0x50
[ 1013.458680]  kthread+0x141/0x1a0
[ 1013.458688]  ret_from_fork+0x22/0x30

[ 1013.459437] value changed: 0x4af8 -> 0x4afc

[ 1013.461329] Reported by Kernel Concurrency Sanitizer on:
[ 1013.462764] CPU: 0 PID: 3170 Comm: rcu_torture_rea Not tainted 5.17.0-rc2-00353-g90c9e950c0de #34
[ 1013.462783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[ 1013.462789] ==================================================================
[ 1013.467568] rcu-torture: rcu_torture_read_exit: End of episode
[ 1019.590629] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 55850ns
[ 1019.590704] clocksource: wd-tsc-wd read-back delay of 118620ns, clock-skew test skipped!
[ 1020.085504] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 76930ns
[ 1020.085542] clocksource: wd-tsc-wd read-back delay of 122490ns, clock-skew test skipped!
[ 1020.590402] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 95170ns
[ 1020.590827] clocksource: wd-tsc-wd read-back delay of 136570ns, clock-skew test skipped!
[ 1021.084862] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 92630ns
[ 1021.084921] clocksource: wd-tsc-wd read-back delay of 102960ns, clock-skew test skipped!
[ 1021.590581] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 93050ns
[ 1021.591006] clocksource: wd-tsc-wd read-back delay of 141260ns, clock-skew test skipped!
[ 1022.085020] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 153580ns
[ 1022.085070] clocksource: wd-tsc-wd read-back delay of 166800ns, clock-skew test skipped!
[ 1022.589937] clocksource: timekeeping watchdog on CPU0: hpet wd-wd read-back delay of 69810ns
[ 1022.589983] clocksource: wd-tsc-wd read-back delay of 129150ns, clock-skew test skipped!
[ 1026.796360] rcu-torture: rcu_torture_read_exit: Start of episode
[ 1026.806158] rcu-torture: rcu_torture_read_exit: End of episode
[ 1041.068319] rcu-torture: rcu_torture_read_exit: Start of episode
[ 1041.081969] rcu-torture: rcu_torture_read_exit: End of episode
[ 1045.548449] rcu-torture: rtc: 0000000029a40662 ver: 154490 tfle: 0 rta: 154490 rtaf: 0 rtf: 154481 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 307284 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 1291 nocb-toggles: 0:0
[ 1045.565830] rcu-torture: Reader Pipe:  54923892 1058 0 0 0 0 0 0 0 0 0
[ 1045.569143] rcu-torture: Reader Batch:  54922359 2591 0 0 0 0 0 0 0 0 0
[ 1045.574217] rcu-torture: Free-Block Circulation:  154489 154489 154488 154487 154486 154485 154484 154483 154482 154481 0
[ 1054.380376] rcu-torture: rcu_torture_read_exit: Start of episode
[ 1054.393731] rcu-torture: rcu_torture_read_exit: End of episode
