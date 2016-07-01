From: Patrick McLean <patrickm@gaikai.com>
Date: Thu, 30 Jun 2016 21:12:19 -0700
Subject: [Intel-wired-lan] [BUG] Panic on boot in ixgbe with Xeon D-1531
Message-ID: <CAE2NFgU+p3jq2ERHDBvZGc=nf0qqjmY0WKGT-oSteeTqmoMj7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

We are getting a panic on boot with Linus git as of this morning. I
have attached the boot log, it looks like the panic is in igbvf/ixgbe.
The machine is being netbooted via legacy PXE.

I have attached the full boot log from a kernel with igbvf enabled,
and one log of just the panic message with igbvf disabled. Please let
me know if you need any more information.
-------------- next part --------------
[    0.000000] Command line: BOOT_IMAGE=vmlinuz XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000099bff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000099c00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000079978fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079979000-0x0000000079b04fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079b05000-0x0000000079bf0fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079bf1000-0x000000007a0e8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007a0e9000-0x000000007bd96fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007bd97000-0x000000007bd97fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bd98000-0x000000007be1dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007be1e000-0x000000007bffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007c000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.0 present.
[    0.000000] e820: last_pfn = 0x1080 000 max_arch_pf0 00
[    0.0000tion [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0x7c000 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x78b1c000-0x79978fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x0000000079C3D0A8 0000D4 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x0000000079C6E038 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x0000000079C3D218 030E1B (v02 ALASKA A M I    01072009 INTL 20091013)
[    0.000000] ACPI: FACS 0x000000007A0E7F80 000040
[    0.000000] ACPI: APIC 0x0000000079C6E148 000100 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x0000000079C6E248 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x0000000079C6E290 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SPMI 0x0000000079C6E330 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: MCFG 0x0000000079C6E378 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.000000] ACPI: UEFI 0x0000000079C6E3B8 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: DBG2 0x0000000079C6E400 000072 (v00 ALASKA A M I    00000000 INTL 20091013)
[    0.000000] ACPI: HPET 0x0000000079C6E478 000038 (v01 ALASKA A M I    00000001 INTL 20091013) CPI: MSCT 0x0000000079C6E4B0 000090 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: SLIT 0x0000000079C6E540 00002D (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: SRAT 0x0000000079C6E570 001158 (v03 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: WDDT 0x0000000079C6F6C8 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.000000] ACPI: SSDT 0x0000000079C6F708 00EDE7 (v01 AMI    PmMgt    00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000079C7E4F0 0020CB (v02 ALASKA SpsNm    00000002 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000079C805C0 000064 (v02 ALASKA SpsNvs   00000002 INTL 20120913)
[    0.000000] ACPI: PRAD 0x0000000079C80628 000102 (v02 ALASKA A M I    00000002 INTL 20120913)
[    0.000000] ACPI: DMAR 0x0000000079C80730 0000BC (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: HEST 0x0000000079C807F0 0000A8 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.000000] ACPI: BERT 0x0000000079C80898 000030 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.000000] ACPI: ERST 0x0000000079C808C8 000230 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.000000] ACPI: EINJ 0x0000000079C80AF8 000130 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x107fffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x107fffffff] -> [mem 0x00000000-0x107fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x107fff3000-0x107fffcfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000098fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000079978fff]
[    0.000000]   node   0: [mem 0x0000000079b05000-0x0000000079bf0fff]
[    0.000000]   node   0: [mem 0x000000007bd97000-0x000000007bd97fff]
[    0.000000]   node   0: [mem 0x000000007be1e000-0x000000007bffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000107fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000107fffffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:12 nr_node_ids:1
[    0.000000] percpu: Embedded 34 pages/cpu @ffff88103f200000 s102104 r8192 d28968 u262144
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 16489817
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=vmlinuz XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 65859232K/67006336K available (7366K kernel code, 1176K rwdata, 2384K rodata, 1432K init, 864K bss, 1147104K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=12.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=12
[    0.000000] NR_IRQS:4352 nr_irqs:928 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS1] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2199.811 MHz processor
[    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 4399.62 BogoMIPS (lpj=21998110)
[    0.011125] pid_max: default: 32768 minimum: 301
[    0.015954] ACPI: Core revision 20160422
[    0.020123] Security Framework initialized
[    0.024427] AppArmor: AppArmor disabled by boot time parameter
[    0.033827] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.055113] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.068149] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.079277] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.087527] CPU: Physical Processor ID: 0
[    0.091752] CPU: Processor Core ID: 0
[    0.095623] mce: CPU supports 22 MCE banks
[    0.099938] CPU0: Thermal monitoring enabled (TM1)
[    0.104970] process: using mwait in idle threads
[    0.109801] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.115399] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.122012] Freeing SMP alternatives memory: 28K (ffffffff81e8e000 - ffffffff81e95000)
[    0.133902] ftrace: allocating 30738 entries in 121 pages
[    0.151782] smpboot: Max logical packages: 2
[    0.156256] smpboot: APIC(0) Converting physical 0 to logical package 0
[    0.163084] Switched APIC routing to physical flat.
[    0.168625] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.274844] smpboot: CPU0: Intel(R) Xeon(R) CPU D-1531 @ 2.20GHz (family: 0x6, model: 0x56, stepping: 0x3)
[    0.285067] Performance Events: PEBS fmt2+, 16-deep LBR, Broadwell events, full-width counters, Intel PMU driver.
[    0.296075] ... version:                3
[    0.300290] ... bit width:              48
[    0.304590] ... generic registers:      4
[    0.308801] ... value mask:             0000ffffffffffff
[    0.314314] ... max period:             0000ffffffffffff
[    0.319829] ... fixed-purpose events:   3
[    0.324038] ... event mask:             000000070000000f
[    0.329793] x86: Booting SMP configuration:
[    0.334183] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
[    1.986427] x86: Booted up 1 node, 12 CPUs
[    1.991117] smpboot: Total of 12 processors activated (52800.60 BogoMIPS)
[    2.012584] devtmpfs: initialized
[    2.016312] PM: Registering ACPI NVS region [mem 0x79bf1000-0x7a0e8fff] (5210112 bytes)
[    2.024771] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    2.034997] pinctrl core: initialized pinctrl subsystem
[    2.041390] NET: Registered protocol family 16
[    2.076053] cpuidle: using governor ladder
[    2.100370] cpuidle: using governor menu
[    2.104575] ACPI: bus type PCI registered
[    2.108844] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    2.118500] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    2.125501] PCI: Using configuration type 1 for base access
[    2.151482] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    2.158046] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.164812] ACPI: Added _OSI(Module Device)
[    2.169196] ACPI: Added _OSI(Processor Device)
[    2.173841] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.178751] ACPI: Added _OSI(Processor Aggregator Device)
[    2.219111] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    2.225743] 
[    2.288371] ACPI: Dynamic OEM Table Load:
[    2.292731] ACPI: PRAD 0x0000000000000000 000102 (v02 ALASKA A M I    00000002 INTL 20120913)
[    2.319449] ACPI: Interpreter enabled
[    2.323331] ACPI: (supports S0 S5)
[    2.326931] ACPI: Using IOAPIC for interrupt routing
[    2.332141] HEST: Table parsing has been initialized.
[    2.337399] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.376487] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
[    2.382611] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.393406] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    2.401786] PCI host bridge to bus 0000:ff
[    2.406085] pci_bus 0000:ff: root bus resource [bus ff]
[    2.416780] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    2.423164] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.431916] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    2.438584] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.446707] PCI host bridge to bus 0000:00
[    2.451008] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.458000] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
[    2.464994] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.472826] pci_bus 0000:00: root bus resource [mem 0x90000000-0xfbffbfff window]
[    2.480660] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.486563] pci 0000:00:01.0: System wakeup disabled by ACPI
[    2.492542] pci 0000:00:02.0: System wakeup disabled by ACPI
[    2.498523] pci 0000:00:02.2: System wakeup disabled by ACPI
[    2.504507] pci 0000:00:03.0: System wakeup disabled by ACPI
[    2.510498] pci 0000:00:03.2: System wakeup disabled by ACPI
[    2.517223] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    2.523228] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    2.529280] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    2.535855] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.541532] pci 0000:00:02.0: PCI bridge to [bus 02]
[    2.546904] pci 0000:03:00.0: VF(n) BAR0 space: [mem 0xfbd00000-0xfbdfffff 64bit] (contains BAR0 for 64 VFs)
[    2.557085] pci 0000:03:00.0: VF(n) BAR3 space: [mem 0xfbc00000-0xfbcfffff 64bit] (contains BAR3 for 64 VFs)
[    2.567436] pci 0000:03:00.1: VF(n) BAR0 space: [mem 0xfbb00000-0xfbbfffff 64bit] (contains BAR0 for 64 VFs)
[    2.577619] pci 0000:03:00.1: VF(n) BAR3 space: [mem 0xfba00000-0xfbafffff 64bit] (contains BAR3 for 64 VFs)
[    2.587901] pci 0000:00:02.2: PCI bridge to [bus 03-04]
[    2.593443] pci 0000:00:03.0: PCI bridge to [bus 05]
[    2.598727] pci 0000:00:03.2: PCI bridge to [bus 06]
[    2.603929] pci 0000:00:1c.0: PCI bridge to [bus 07]
[    2.609330] pci 0000:08:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.619687] pci 0000:00:1c.4: PCI bridge to [bus 08-09]
[    2.625429] pci 0000:08:00.0: PCI bridge to [bus 09]
[    2.631381] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
[    2.638926] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12)
[    2.646467] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12)
[    2.653756] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12)
[    2.661026] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
[    2.669990] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
[    2.678941] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
[    2.687878] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
[    2.696860] ACPI: Enabled 3 GPEs in block 00 to 3F
[    2.702102] vgaarb: setting as boot device: PCI:0000:09:00.0
[    2.707962] vgaarb: device added: PCI:0000:09:00.0,decodes=io+mem,owns=io+mem,locks=none
[    2.716397] vgaarb: loaded
[    2.719308] vgaarb: bridge control possible 0000:09:00.0
[    2.724862] SCSI subsystem initialized
[    2.728833] ACPI: bus type USB registered
[    2.733054] usbcore: registered new interface driver usbfs
[    2.738748] usbcore: registered new interface driver hub
[    2.744285] usbcore: registered new device driver usb
[    2.749549] pps_core: LinuxPPS API ver. 1 registered
[    2.754721] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.764197] PTP clock support registered
[    2.768383] PCI: Using ACPI for IRQ routing
[    2.778220] NetLabel: Initializing
[    2.781823] NetLabel:  domain hash size = 128
[    2.786382] NetLabel:  protocols = UNLABELED CIPSOv4
[    2.791556] NetLabel:  unlabeled traffic allowed by default
[    2.797406] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.804486] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    2.812554] clocksource: Switched to clocksource hpet
[    2.823253] pnp: PnP ACPI init
[    2.826959] system 00:01: [io  0x0500-0x057f] has been reserved
[    2.833091] system 00:01: [io  0x0400-0x047f] has been reserved
[    2.839212] system 00:01: [io  0x0580-0x059f] has been reserved
[    2.845338] system 00:01: [io  0x0600-0x061f] has been reserved
[    2.851459] system 00:01: [io  0x0ca2] has been reserved
[    2.856972] system 00:01: [io  0x0ca6] has been reserved
[    2.862492] system 00:01: [io  0x0ca8] has been reserved
[    2.868007] system 00:01: [io  0x0cac] has been reserved
[    2.873527] system 00:01: [io  0x0880-0x0883] has been reserved
[    2.879653] system 00:01: [io  0x0800-0x081f] has been reserved
[    2.885778] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
[    2.892948] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    2.899763] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    2.906589] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    2.913410] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    2.920227] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    2.927052] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    2.934047] system 00:02: [io  0x0a00-0x0a0f] has been reserved
[    2.940171] system 00:02: [io  0x0a10-0x0a1f] has been reserved
[    2.946301] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    2.952424] system 00:02: [io  0x0a30-0x0a3f] has been reserved
[    2.958547] system 00:02: [io  0x0a40-0x0a4f] has been reserved
[    2.964771] ACPI: IRQ 4 override to edge, high
[    2.969546] ACPI: IRQ 3 override to edge, high
[    2.974515] pnp: PnP ACPI: found 5 devices
[    2.984654] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.993948] pci 0000:00:1c.0: BAR 14: assigned [mem 0x90000000-0x901fffff]
[    3.001026] pci 0000:00:1c.0: BAR 15: assigned [mem 0x90200000-0x903fffff 64bit pref]
[    3.009209] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    3.015599] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.020771] pci 0000:00:02.0: PCI bridge to [bus 02]
[    3.025944] pci 0000:00:02.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    3.036793] pci 0000:00:02.2: PCI bridge to [bus 03-04]
[    3.042228] pci 0000:00:02.2:   bridge window [mem 0xfb900000-0xfbdfffff]
[    3.049230] pci 0000:00:02.2:   bridge window [mem 0xfaa00000-0xfaefffff 64bit pref]
[    3.057322] pci 0000:00:03.0: PCI bridge to [bus 05]
[    3.062495] pci 0000:00:03.2: PCI bridge to [bus 06]
[    3.067672] pci 0000:00:1c.0: PCI bridge to [bus 07]
[    3.072843] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    3.079144] pci 0000:00:1c.0:   bridge window [mem 0x90000000-0x901fffff]
[    3.086142] pci 0000:00:1c.0:   bridge window [mem 0x90200000-0x903fffff 64bit pref]
[    3.094235] pci 0000:08:00.0: PCI bridge to [bus 09]
[    3.099405] pci 0000:08:00.0:   bridge window [io  0xe000-0xefff]
[    3.105707] pci 0000:08:00.0:   bridge window [mem 0xfb000000-0xfb8fffff]
[    3.112718] pci 0000:00:1c.4: PCI bridge to [bus 08-09]
[    3.118144] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    3.124445] pci 0000:00:1c.4:   bridge window [mem 0xfb000000-0xfb8fffff]
[    3.131479] NET: Registered protocol family 2
[    3.136299] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    3.144750] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.151776] TCP: Hash tables configured (established 524288 bind 65536)
[    3.158651] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    3.165287] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    3.172371] NET: Registered protocol family 1
[    3.192800] pci 0000:09:00.0: Video device with shadowed ROM at [mem 0 x000c0000-0x00001535] Unpacking initramfs...
[    4.757094] Freeing initrd memory: 14708K (ffff880078b1c000 - ffff880079979000)
[    4.764762] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.771408] software IO TLB [mem 0x74b1c000-0x78b1c000] (64MB) mapped at [ffff880074b1c000-ffff880078b1bfff]
[    4.781653] Intel CQM monitoring enabled
[    4.785785] Intel MBM enabled
[    4.788959] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[    4.797230] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.803185] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.809048] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    4.815002] kvm: already loaded the other module
[    4.820290] Scanning for low memory corruption every 60 seconds
[    4.827407] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    4.833926] audit: initializing netlink subsys (disabled)
[    4.839548] audit: type=2000 audit(1467323304.760:1): initialized
[    4.846626] workingset: timestamp_bits=52 max_order=24 bucket_order=0
[    4.855292] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    4.863070] io scheduler noop registered
[    4.867196] io scheduler deadline registered
[    4.871690] io scheduler cfq registered (default)
[    4.877440] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    4.884623] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    4.891791] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    4.898525] pci 0000:02:00.1: Signaling PME through PCIe PME interrupt
[    4.905260] pci 0000:02:00.2: Signaling PME through PCIe PME interrupt
[    4.911993] pci 0000:02:00.3: Signaling PME through PCIe PME interrupt
[    4.918745] pcieport 0000:00:02.2: Signaling PME through PCIe PME interrupt
[    4.925917] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    4.932646] pci 0000:03:00.1: Signaling PME through PCIe PME interrupt
[    4.939397] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    4.946576] pcieport 0000:00:03.2: Signaling PME through PCIe PME interrupt
[    4.953764] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    4.960948] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    4.968117] pci 0000:08:00.0: Signaling PME through PCIe PME interrupt
[    4.974851] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    4.981916] ipmi message handler version 39.2
[    4.986479] ipmi device interface
[    4.990013] ipmi_si IPI0001:00: ipmi_si: probing via ACPI
[    4.995625] ipmi_si IPI0001:00: [io  0x0ca2] regsize 1 spacing 1 irq 0
[    5.002358] ipmi_si: Adding ACPI-specified kcs state machine
[    5.008304] IPMI System Interface driver.
[    5.012532] ipmi_si: probing via SMBIOS
[    5.016570] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[    5.022690] ipmi_si: Adding SMBIOS-specified kcs state machine duplicate interface
[    5.030677] ipmi_si: probing via SPMI
[    5.034545] ipmi_si: SPMI: io 0xca2 regsize 1 spacing 1 irq 0
[    5.040494] ipmi_si: Adding SPMI-specified kcs state machine duplicate interface
[    5.048314] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x0, irq 0
[    5.487580] ipmi_si IPI0001:00: Found new BMC (man_id: 0x001c4c, prod_id: 0x3151, dev_id: 0x20)
[    5.496685] ipmi_si IPI0001:00: IPMI kcs interface initialized
[    5.505235] IPMI Watchdog: driver initialized
[    5.509792] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
[    5.522673] IPMI poweroff: ATCA Detect mfg 0x1C4C prod 0x3151
[    5.528627] IPMI poweroff: Found a chassis style poweroff function
[    5.537976] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    5.546681] ACPI: Power Button [PWRB]
[    5.550572] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    5.558318] ACPI: Power Button [PWRF]
[    5.563811] ERST: Error Record Serialization Table (ERST) support is initialized.
[    5.571648] pstore: Registered erst as persistent store backend
[    5.577964] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    5.585803] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    5.612857] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    5.641133] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    5.649112] Non-volatile memory driver v1.3
[    5.653558] Linux agpgart interface v0.103
[    5.657910] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    5.668030] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[    5.674932] Loading iSCSI transport class v2.0-870.
[    5.680266] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x30 impl SATA mode
[    5.688800] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems apst 
[    5.713215] scsi host0: ahci
[    5.716398] scsi host1: ahci
[    5.719589] scsi host2: ahci
[    5.722847] scsi host3: ahci
[    5.726041] scsi host4: ahci
[    5.729232] scsi host5: ahci
[    5.732357] ata1: DUMMY
[    5.735017] ata2: DUMMY
[    5.737662] ata3: DUMMY
[    5.740313] ata4: DUMMY
[    5.742962] ata5: SATA max UDMA/133 abar m2048 at 0xfbf02000 port 0xfbf02300 irq 34
[    5.750704] ata6: SATA max UDMA/133 abar m2048 at 0xfbf02000 port 0xfbf02380 irq 34
[    5.758584] libphy: Fixed MDIO Bus: probed
[    5.762891] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.0.2-k
[    5.771064] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    5.777202] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.4.0-k
[    5.785210] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    5.791309] pmd_set_huge: Cannot satisfy [mem 0xfac00000-0xfae00000] with a huge-page mapping due to MTRR override.
[    5.812839] tsc: Refined TSC clocksource calibration: 2199.998 MHz
[    5.819225] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb63109b96, max_idle_ns: 440795265316 ns
[    6.074054] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    6.080451] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    6.086926] ata6.00: ATA-9: INTEL SSDSC2BB240G6, G2010140, max UDMA/133
[    6.093752] ata6.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 31/32)
[    6.100737] ata5.00: ATA-9: INTEL SSDSC2BB240G6, G2010140, max UDMA/133
[    6.107564] ata5.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 31/32)
[    6.114866] ata6.00: configured for UDMA/133
[    6.119374] ata5.00: configured for UDMA/133
[    6.123986] scsi 4:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB24 0140 PQ: 0 ANSI: 5
[    6.183206] ata5.00: Enabling discard_zeroes_data
[    6.188176] sd 4:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
[    6.188201] scsi 5:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB24 0140 PQ: 0 ANSI: 5
[    6.204452] sd 4:0:0:0: [sda] 4096-byte physical blocks
[    6.210111] sd 4:0:0:0: [sda] Write Protect is off
[    6.215188] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.224706] ata5.00: Enabling discard_zeroes_data
[    6.231177]  sda: sda1
[    6.233895] ata5.00: Enabling discard_zeroes_data
[    6.239059] sd 4:0:0:0: [sda] Attached SCSI disk
[    6.263061] ata6.00: Enabling discard_zeroes_data
[    6.268007] sd 5:0:0:0: [sdb] 468862128 512-byte logical blocks: (240 GB/224 GiB)
[    6.275848] sd 5:0:0:0: [sdb] 4096-byte physical blocks
[    6.281496] sd 5:0:0:0: [sdb] Write Protect is off
[    6.286550] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.296071] ata6.00: Enabling discard_zeroes_data
[    6.302332]  sdb: sdb1
[    6.305034] ata6.00: Enabling discard_zeroes_data
[    6.310181] sd 5:0:0:0: [sdb] Attached SCSI disk
[    6.379140] ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count = 12, Tx Queue count = 12
[    6.519502] ixgbe 0000:03:00.0: MAC: 5, PHY: 4, PBA No: 000100-000
[    6.525894] ixgbe 0000:03:00.0: 54:ab:3a:6f:14:b2
[    6.534765] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    6.543094] IP: [<          (null)>]           (null)
[    6.548425] PGD 0 
[    6.550715] Oops: 0010 [#1] SMP
[    6.554057] Modules linked in:
[    6.557389] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc5-vanilla-ams-1-00254-g1a0a02d #2
[    6.566433] Hardware name: Quanta Computer Inc. XXXXXXXXXX, BIOS XXXXXXXX 12/25/2015
[    6.574519] task: ffff881038bb8000 ti: ffff881038bc0000 task.ti: ffff881038bc0000
[    6.582345] RIP: 0010:[<0000000000000000>]  [<          (null)>]           (null)
[    6.590247] RSP: 0000:ffff881038bc3cd8  EFLAGS: 00010213
[    6.595761] RAX: 0000000000080000 RBX: ffff881034235640 RCX: 0000000000000000
[    6.603098] RDX: ffffc90006c00000 RSI: 0000000000000008 RDI: ffff881034235640
[    6.610438] RBP: 0000000000000014 R08: 0000000000000000 R09: 0000000000000000
[    6.617780] R10: 0000000000000198 R11: 000000000000028f R12: ffff881034235640
[    6.625122] R13: 0000000000000000 R14: ffff881034234000 R15: 0000000000000000
[    6.632462] FS:  0000000000000000(0000) GS:ffff88103f240000(0000) knlGS:0000000000000000
[    6.640904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.646857] CR2: 0000000000000000 CR3: 0000000001c07000 CR4: 00000000003406e0
[    6.654191] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.661532] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.668876] Stack:
[    6.671091]  ffffffff814d55bd ffff881034235640 ffffffff814e634e ffff881037cbc000
[    6.679122]  ffffffff814d427a ffff881034234800 ffff881034234a10 0000000137cbc0a0
[    6.687156]  000000ff37cbc150 30303000000000ff 003030302d303031 0000000071cc7ad6
[    6.695191] Call Trace:
[    6.697844]  [<ffffffff814d55bd>] ? ixgbe_start_hw_generic+0x5d/0x70
[    6.704405]  [<ffffffff814e634e>] ? ixgbe_start_hw_X540+0xe/0x20
[    6.710616]  [<ffffffff814d427a>] ? ixgbe_probe+0xf7a/0x1520
[    6.716486]  [<ffffffff8136d80d>] ? local_pci_probe+0x3d/0xa0
[    6.722437]  [<ffffffff8136e902>] ? pci_device_probe+0xd2/0x120
[    6.728566]  [<ffffffff81442d04>] ? driver_probe_device+0x1f4/0x2b0
[    6.735040]  [<ffffffff81442e4c>] ? __driver_attach+0x8c/0x90
[    6.740994]  [<ffffffff81442dc0>] ? driver_probe_device+0x2b0/0x2b0
[    6.747471]  [<ffffffff81440e0a>] ? bus_for_each_dev+0x5a/0x90
[    6.753511]  [<ffffffff814422c8>] ? bus_add_driver+0x1a8/0x220
[    6.759554]  [<ffffffff81d86830>] ? igbvf_init_module+0x46/0x46
[    6.765679]  [<ffffffff814437b7>] ? driver_register+0x57/0xd0
[    6.771633]  [<ffffffff81d868c6>] ? ixgbe_init_module+0x96/0xa7
[    6.777765]  [<ffffffff8100216c>] ? do_one_initcall+0x4c/0x180
[    6.783807]  [<ffffffff81d4208e>] ? kernel_init_freeable+0x172/0x1f7
[    6.790366]  [<ffffffff817230ca>] ? kernel_init+0xa/0x100
[    6.795970]  [<ffffffff8172917f>] ? ret_from_fork+0x1f/0x40
[    6.801741]  [<ffffffff817230c0>] ? rest_init+0x80/0x80
[    6.807167] Code:  Bad RIP value.
[    6.810838] RIP  [<          (null)>]           (null)
[    6.816255]  RSP <ffff881038bc3cd8>
[    6.819948] CR2: 0000000000000000
[    6.823469] ---[ end trace 0349fdf3adad6249 ]---
[    6.828874] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    6.828874] 
[    6.838531] Kernel Offset: disabled
[    6.845011] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    6.845011] 
[    6.855418] ------------[ cut here ]------------
[    6.860241] WARNING: CPU: 1 PID: 1 at arch/x86/kernel/smp.c:125 update_process_times+0x4a/0x60
[    6.869199] Modules linked in:
[    6.872526] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G      D         4.7.0-rc5-vanilla-ams-1-00254-g1a0a02d #2
[    6.882787] Hardware name: Quanta Computer Inc. S1Q/S1Q-MB, BIOS S1Q_3A02 12/25/2015
[    6.890875]  0000000000000000 ffffffff8132b76f 0000000000000000 0000000000000000
[    6.898909]  ffffffff81106d44 ffff881038bb8000 0000000000000000 ffff881038bc3a18
[    6.906943]  ffffffff8116d680 0000000000000001 ffff88103f250e00 ffffffff8115f1ea
[    6.914976] Call Trace:
[    6.917626]  <IRQ>  [<ffffffff8132b76f>] ? dump_stack+0x5c/0x7d
[    6.923837]  [<ffffffff81106d44>] ? __warn+0xc4/0xe0
[    6.929004]  [<ffffffff8116d680>] ? tick_sched_handle.isra.15+0x40/0x40
[    6.935819]  [<ffffffff8115f1ea>] ? update_process_times+0x4a/0x60
[    6.942207]  [<ffffffff8116d672>] ? tick_sched_handle.isra.15+0x32/0x40
[    6.949029]  [<ffffffff8116d6b8>] ? tick_sched_timer+0x38/0x70
[    6.955069]  [<ffffffff8115f788>] ? __hrtimer_run_queues+0xd8/0x240
[    6.961546]  [<ffffffff8115fff9>] ? hrtimer_interrupt+0x99/0x180
[    6.967760]  [<ffffffff8172b689>] ? smp_apic_timer_interrupt+0x39/0x50
[    6.974493]  [<ffffffff81729b62>] ? apic_timer_interrupt+0x82/0x90
[    6.980880]  <EOI>  [<ffffffff811e1c9e>] ? panic+0x1db/0x217
[    6.986830]  [<ffffffff811e1c97>] ? panic+0x1d4/0x217
[    6.992087]  [<ffffffff81109ecf>] ? do_exit+0xb5f/0xb60
[    6.997523]  [<ffffffff81083115>] ? oops_end+0x95/0xc0
[    7.002870]  [<ffffffff810b0c7c>] ? no_context+0x13c/0x390
[    7.008564]  [<ffffffff8172adc8>] ? page_fault+0x28/0x30
[    7.014083]  [<ffffffff814d55bd>] ? ixgbe_start_hw_generic+0x5d/0x70
[    7.020640]  [<ffffffff814e634e>] ? ixgbe_start_hw_X540+0xe/0x20
[    7.026852]  [<ffffffff814d427a>] ? ixgbe_probe+0xf7a/0x1520
[    7.032721]  [<ffffffff8136d80d>] ? local_pci_probe+0x3d/0xa0
[    7.038674]  [<ffffffff8136e902>] ? pci_device_probe+0xd2/0x120
[    7.044803]  [<ffffffff81442d04>] ? driver_probe_device+0x1f4/0x2b0
[    7.051278]  [<ffffffff81442e4c>] ? __driver_attach+0x8c/0x90
[    7.057231]  [<ffffffff81442dc0>] ? driver_probe_device+0x2b0/0x2b0
[    7.063707]  [<ffffffff81440e0a>] ? bus_for_each_dev+0x5a/0x90
[    7.069747]  [<ffffffff814422c8>] ? bus_add_driver+0x1a8/0x220
[    7.075787]  [<ffffffff81d86830>] ? igbvf_init_module+0x46/0x46
[    7.081907]  [<ffffffff814437b7>] ? driver_register+0x57/0xd0
[    7.087860]  [<ffffffff81d868c6>] ? ixgbe_init_module+0x96/0xa7
[    7.093980]  [<ffffffff8100216c>] ? do_one_initcall+0x4c/0x180
[    7.100023]  [<ffffffff81d4208e>] ? kernel_init_freeable+0x172/0x1f7
[    7.106583]  [<ffffffff817230ca>] ? kernel_init+0xa/0x100
[    7.112190]  [<ffffffff8172917f>] ? ret_from_fork+0x1f/0x40
[    7.117961]  [<ffffffff817230c0>] ? rest_init+0x80/0x80
[    7.123386] ---[ end trace 0349fdf3adad624a ]---
-------------- next part --------------
[    6.076009] ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count = 12, Tx Queue count = 12
[    6.216369] ixgbe 0000:03:00.0: MAC: 5, PHY: 4, PBA No: 000100-000
[    6.226598] ixgbe 0000:03:00.0: 54:ab:3a:6f:14:c1
[    6.231598] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    6.239915] IP: [<          (null)>]           (null)
[    6.245245] PGD 0 
[    6.247534] Oops: 0010 [#1] SMP
[    6.250878] Modules linked in:
[    6.254209] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc5-vanilla-ams-2-00254-g1a0a02d #4
[    6.263251] Hardware name: Quanta Computer Inc. S1Q/S1Q-MB, BIOS S1Q_3A02 12/25/2015
[    6.271333] task: ffff881038bc0000 ti: ffff881038bbc000 task.ti: ffff881038bbc000
[    6.279159] RIP: 0010:[<0000000000000000>]  [<          (null)>]           (null)
[    6.287064] RSP: 0000:ffff881038bbfcd8  EFLAGS: 00010213
[    6.292578] RAX: 0000000000080000 RBX: ffff881034919640 RCX: 0000000000000000
[    6.299912] RDX: ffffc90006c00000 RSI: 0000000000000008 RDI: ffff881034919640
[    6.307247] RBP: 0000000000000014 R08: 0000000000000000 R09: 0000000000000000
[    6.314585] R10: 0000000000000198 R11: 0000000000000291 R12: ffff881034919640
[    6.321927] R13: 0000000000000000 R14: ffff881034918000 R15: 0000000000000000
[    6.329267] FS:  0000000000000000(0000) GS:ffff88103f2c0000(0000) knlGS:0000000000000000
[    6.337703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.343651] CR2: 0000000000000000 CR3: 0000000001c07000 CR4: 00000000003406e0
[    6.350988] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.358326] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.365665] Stack:
[    6.367873]  ffffffff8150800d ffff881034919640 ffffffff81518d9e ffff881037ca4000
[    6.375904]  ffffffff81506cca ffff881034918800 ffff881034918a10 0000000137ca40a0
[    6.383939]  000000ff37ca4150 30303000000000ff 003030302d303031 000000004e3a5ab0
[    6.391972] Call Trace:
[    6.394627]  [<ffffffff8150800d>] ? ixgbe_start_hw_generic+0x5d/0x70
[    6.401184]  [<ffffffff81518d9e>] ? ixgbe_start_hw_X540+0xe/0x20
[    6.407396]  [<ffffffff81506cca>] ? ixgbe_probe+0xf7a/0x1520
[    6.413259]  [<ffffffff8136d80d>] ? local_pci_probe+0x3d/0xa0
[    6.419207]  [<ffffffff8136e902>] ? pci_device_probe+0xd2/0x120
[    6.425328]  [<ffffffff81442d04>] ? driver_probe_device+0x1f4/0x2b0
[    6.431802]  [<ffffffff81442e4c>] ? __driver_attach+0x8c/0x90
[    6.437753]  [<ffffffff81442dc0>] ? driver_probe_device+0x2b0/0x2b0
[    6.444221]  [<ffffffff81440e0a>] ? bus_for_each_dev+0x5a/0x90
[    6.450262]  [<ffffffff814422c8>] ? bus_add_driver+0x1a8/0x220
[    6.456303]  [<ffffffff81d87868>] ? igb_init_module+0x46/0x46
[    6.462254]  [<ffffffff814437b7>] ? driver_register+0x57/0xd0
[    6.468200]  [<ffffffff81d878fe>] ? ixgbe_init_module+0x96/0xa7
[    6.474321]  [<ffffffff8100216c>] ? do_one_initcall+0x4c/0x180
[    6.480361]  [<ffffffff81d4308e>] ? kernel_init_freeable+0x172/0x1f7
[    6.486923]  [<ffffffff8175681a>] ? kernel_init+0xa/0x100
[    6.492527]  [<ffffffff8175c8bf>] ? ret_from_fork+0x1f/0x40
[    6.498297]  [<ffffffff81756810>] ? rest_init+0x80/0x80
[    6.503722] Code:  Bad RIP value.
[    6.507392] RIP  [<          (null)>]           (null)
[    6.512809]  RSP <ffff881038bbfcd8>
[    6.516502] CR2: 0000000000000000
[    6.520024] ---[ end trace b508b9e36b57f8f4 ]---
[    6.525421] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    6.525421] 
[    6.535083] Kernel Offset: disabled
[    6.541555] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    6.541555] 
