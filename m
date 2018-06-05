From: Marco Berizzi <pupilla@libero.it>
Date: Tue, 5 Jun 2018 10:12:37 +0200 (CEST)
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to 4.17
Message-ID: <528200032.321946.1528186357567@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Folks,

after upgrading from 4.16.13 to 4.17 I got this error message.

Any feedback are welcome.

Marco Berizzi

PS: this system is running oracle virtualbox 5.2.12

[    0.000000] Linux version 4.17.0 (root at Kaa) (gcc version 5.5.0 (GCC)) #1 SMP Mon Jun 4 13:51:52 CEST 2018
[    0.000000] Command line: auto BOOT_IMAGE=Linux ro root=802 vt.default_utf8=0
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e4000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf69ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf6a0000-0x00000000bf6b9fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bf6ba000-0x00000000bf6bafff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf6bb000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fecfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffa00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000103fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: FUJITSU                          PRIMERGY RX300 S6             /D2619, BIOS 6.00 Rev. 1.13.2619.N1           01/19/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1040000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00C0000000 mask FFC0000000 uncachable
[    0.000000]   1 base 0000000000 mask F000000000 write-back
[    0.000000]   2 base 1000000000 mask FFC0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xbf6a0 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [        (ptrval)] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01f6c000, 0x01f6cfff] PGTABLE
[    0.000000] BRK [0x01f6d000, 0x01f6dfff] PGTABLE
[    0.000000] BRK [0x01f6e000, 0x01f6efff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7EB0 000024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 0x00000000BF6AF6FF 00021C (v01 PTLTD  ? XSDT   00060000  LTP 00000000)
[    0.000000] ACPI: FACP 0x00000000BF6B5883 0000F4 (v03 FSC    TYLERBRG 00060000 PTL  000F4240)
[    0.000000] ACPI: DSDT 0x00000000BF6AF91B 005EE4 (v01 FSC    D2619    00060000 MSFT 03000001)
[    0.000000] ACPI: FACS 0x00000000BF6BAFC0 000040
[    0.000000] ACPI: FACS 0x00000000BF6BAFC0 000040
[    0.000000] ACPI: TCPA 0x00000000BF6B5977 000032 (v01 Phoeni x        00060000 TL   00000000)
[    0.000000] ACPI: SLIT 0x00000000BF6B59A9 000030 (v01 FSC             00060000      0000005A)
[    0.000000] ACPI: SRAT 0x00000000BF6B59D9 000228 (v01 Intel  Tylerbrg 00060000 PHX. 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B5C01 0000D8 (v01 FSC    CST_PR00 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B5CD9 0000D8 (v01 FSC    CST_PR01 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B5DB1 0000D8 (v01 FSC    CST_PR02 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B5E89 0000D8 (v01 FSC    CST_PR03 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B5F61 0000D8 (v01 FSC    CST_PR04 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6039 0000D8 (v01 FSC    CST_PR05 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6111 0000D8 (v01 FSC    CST_PR10 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B61E9 0000D8 (v01 FSC    CST_PR11 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B62C1 0000D8 (v01 FSC    CST_PR12 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6399 0000D8 (v01 FSC    CST_PR13 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6471 0000D8 (v01 FSC    CST_PR14 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6549 0000D8 (v01 FSC    CST_PR15 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6621 0000D8 (v01 FSC    CST_PR20 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B66F9 0000D8 (v01 FSC    CST_PR21 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B67D1 0000D8 (v01 FSC    CST_PR22 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B68A9 0000D8 (v01 FSC    CST_PR23 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6981 0000D8 (v01 FSC    CST_PR24 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6A59 0000D8 (v01 FSC    CST_PR25 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6B31 0000D8 (v01 FSC    CST_PR30 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6C09 0000D8 (v01 FSC    CST_PR31 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6CE1 0000D8 (v01 FSC    CST_PR32 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6DB9 0000D8 (v01 FSC    CST_PR33 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6E91 0000D8 (v01 FSC    CST_PR34 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B6F69 0000D8 (v01 FSC    CST_PR35 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7041 00017C (v01 FSC    PST_PR00 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B71BD 00017C (v01 FSC    PST_PR01 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7339 00017C (v01 FSC    PST_PR02 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B74B5 00017C (v01 FSC    PST_PR03 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7631 00017C (v01 FSC    PST_PR04 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B77AD 00017C (v01 FSC    PST_PR05 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7929 00017C (v01 FSC    PST_PR10 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7AA5 00017C (v01 FSC    PST_PR11 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7C21 00017C (v01 FSC    PST_PR12 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7D9D 00017C (v01 FSC    PST_PR13 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B7F19 00017C (v01 FSC    PST_PR14 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8095 00017C (v01 FSC    PST_PR15 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8211 00017C (v01 FSC    PST_PR20 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B838D 00017C (v01 FSC    PST_PR21 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8509 00017C (v01 FSC    PST_PR22 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8685 00017C (v01 FSC    PST_PR23 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8801 00017C (v01 FSC    PST_PR24 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B897D 00017C (v01 FSC    PST_PR25 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8AF9 00017C (v01 FSC    PST_PR30 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8C75 00017C (v01 FSC    PST_PR31 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8DF1 00017C (v01 FSC    PST_PR32 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B8F6D 00017C (v01 FSC    PST_PR33 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B90E9 00017C (v01 FSC    PST_PR34 00060000  CSF 00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B9265 00017C (v01 FSC    PST_PR35 00060000  CSF 00000001)
[    0.000000] ACPI: EINJ 0x00000000BF6B93E1 0001B0 (v01 PTL    WHEAPTL  00060000 PTL  00000001)
[    0.000000] ACPI: HEST 0x00000000BF6B9591 000268 (v01 PTL    WHEAPTL  00060000 PTL  00000001)
[    0.000000] ACPI: BERT 0x00000000BF6B97F9 000030 (v01 PTL    WHEAPTL  00060000 PTL  00000001)
[    0.000000] ACPI: SSDT 0x00000000BF6B9829 0000EB (v01 wheaos wheaosc  00060000 MSFT 03000001)
[    0.000000] ACPI: ERST 0x00000000BF6B9914 000270 (v01 PTL    WHEAPTL  00060000 PTL  00000001)
[    0.000000] ACPI: SPCR 0x00000000BF6B9B84 000050 (v01 PTLTD  $UCRTBL$ 00060000 PTL  00000001)
[    0.000000] ACPI: DMAR 0x00000000BF6B9BD4 0001E8 (v01 Intel  OEMDMAR  00060000 LOHR 00000001)
[    0.000000] ACPI: MCFG 0x00000000BF6B9DBC 00003C (v01 PTLTD    MCFG   00060000  LTP 00000000)
[    0.000000] ACPI: HPET 0x00000000BF6B9DF8 000038 (v01 PTLTD  HPETTBL  00060000  LTP 00000001)
[    0.000000] ACPI: APIC 0x00000000BF6B9E30 0001A8 (v01 PTLTD  ? APIC   00060000  LTP 00000000)
[    0.000000] ACPI: BOOT 0x00000000BF6B9FD8 000028 (v01 PTLTD  $SBFTBL$ 00060000  LTP 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000103fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bf69ffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000103fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000103fffffff]
[    0.000000] On node 0 totalpages: 16774715
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12187 pages used for memmap
[    0.000000]   DMA32 zone: 779936 pages, LIFO batch:31
[    0.000000]   Normal zone: 249856 pages used for memmap
[    0.000000]   Normal zone: 15990784 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 101 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 6, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 7, version 32, address 0xfec80000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] ACPI: SPCR: SPCR table version 1
[    0.000000] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.000000] smpboot: Allowing 24 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0xc0000000-0xdfffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:24 nr_cpumask_bits:24 nr_cpu_ids:24 nr_node_ids:1
[    0.000000] percpu: Embedded 41 pages/cpu @        (ptrval) s130520 r8192 d29224 u262144
[    0.000000] pcpu-alloc: s130520 r8192 d29224 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16512587
[    0.000000] Kernel command line: auto BOOT_IMAGE=Linux ro root=802 vt.default_utf8=0
[    0.000000] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.000000] Memory: 65866116K/67098860K available (8200K kernel code, 339K rwdata, 1464K rodata, 780K init, 452K bss, 1232744K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180313
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] DMAR-IR: This system BIOS has enabled interrupt remapping
               on a chipset that contains an erratum making that
               feature unstable.  To maintain system stability
               interrupt remapping is being disabled.  Please
               contact your BIOS vendor for an update
[    0.000000] Switched APIC routing to physical flat.
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.005000] tsc: Fast TSC calibration using PIT
[    0.006000] tsc: Detected 2399.809 MHz processor
[    0.007000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22978334789, max_idle_ns: 440795320838 ns
[    0.007000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4799.61 BogoMIPS (lpj=2399809)
[    0.007000] pid_max: default: 32768 minimum: 301
[    0.007000] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.008228] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.008491] CPU: Physical Processor ID: 0
[    0.008585] CPU: Processor Core ID: 0
[    0.008681] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.008781] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.008888] process: using mwait in idle threads
[    0.008985] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.009001] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.009103] Spectre V2 : Mitigation: Full generic retpoline
[    0.009202] Speculative Store Bypass: Vulnerable
[    0.009381] Freeing SMP alternatives memory: 20K
[    0.011000] smpboot: CPU0: Intel(R) Xeon(R) CPU           E5645  @ 2.40GHz (family: 0x6, model: 0x2c, stepping: 0x2)
[    0.011000] Performance Events: PEBS fmt1+, Westmere events, 16-deep LBR, Intel PMU driver.
[    0.011000] core: CPUID marked event: 'bus cycles' unavailable
[    0.011000] ... version:                3
[    0.011000] ... bit width:              48
[    0.011000] ... generic registers:      4
[    0.011000] ... value mask:             0000ffffffffffff
[    0.011000] ... max period:             000000007fffffff
[    0.011000] ... fixed-purpose events:   3
[    0.011002] ... event mask:             000000070000000f
[    0.011149] Hierarchical SRCU implementation.
[    0.011534] smp: Bringing up secondary CPUs ...
[    0.011707] x86: Booting SMP configuration:
[    0.011801] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.113045] smp: Brought up 1 node, 24 CPUs
[    0.113245] smpboot: Max logical packages: 2
[    0.113341] smpboot: Total of 24 processors activated (115194.00 BogoMIPS)
[    0.116208] devtmpfs: initialized
[    0.116211] random: get_random_u32 called from bucket_table_alloc+0x7a/0x1a0 with crng_init=0
[    0.116367] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.116367] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    0.117117] xor: measuring software checksum speed
[    0.127002]    prefetch64-sse: 12904.000 MB/sec
[    0.137001]    generic_sse: 10980.000 MB/sec
[    0.137095] xor: using function: prefetch64-sse (12904.000 MB/sec)
[    0.138758] NET: Registered protocol family 16
[    0.139027] cpuidle: using governor ladder
[    0.139107] cpuidle: using governor menu
[    0.139114] Simple Boot Flag at 0x7c set to 0x1
[    0.139218] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.139323] ACPI: bus type PCI registered
[    0.139427] PCI: MMCONFIG for domain 0000 [bus 00-0a] at [mem 0xe0000000-0xe0afffff] (base 0xe0000000)
[    0.139565] PCI: MMCONFIG at [mem 0xe0000000-0xe0afffff] reserved in E820
[    0.139674] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a huge-page mapping due to MTRR override.
[    0.139827] PCI: Using configuration type 1 for base access
[    0.158003] raid6: sse2x1   gen()  5929 MB/s
[    0.175006] raid6: sse2x1   xor()  4669 MB/s
[    0.192007] raid6: sse2x2   gen()  6996 MB/s
[    0.209004] raid6: sse2x2   xor()  5533 MB/s
[    0.226006] raid6: sse2x4   gen()  7667 MB/s
[    0.243001] raid6: sse2x4   xor()  6218 MB/s
[    0.243096] raid6: using algorithm sse2x4 gen() 7667 MB/s
[    0.243195] raid6: .... xor() 6218 MB/s, rmw enabled
[    0.243291] raid6: using ssse3x2 recovery algorithm
[    0.243461] ACPI: Added _OSI(Module Device)
[    0.243556] ACPI: Added _OSI(Processor Device)
[    0.243651] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.243746] ACPI: Added _OSI(Processor Aggregator Device)
[    0.243845] ACPI: Added _OSI(Linux-Dell-Video)
[    0.248322] ACPI: 50 ACPI AML tables successfully acquired and loaded
[    0.262488] ACPI: Interpreter enabled
[    0.262586] ACPI: (supports S0 S5)
[    0.262677] ACPI: Using IOAPIC for interrupt routing
[    0.263000] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.263063] ACPI: Enabled 10 GPEs in block 00 to 3F
[    0.267011] ACPI: PCI Root Bridge [CPU0] (domain 0000 [bus ff])
[    0.267011] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.267116] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.267220] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.267392] PCI host bridge to bus 0000:ff
[    0.267488] pci_bus 0000:ff: root bus resource [bus ff]
[    0.267591] pci 0000:ff:00.0: [8086:2c70] type 00 class 0x060000
[    0.268012] pci 0000:ff:00.1: [8086:2d81] type 00 class 0x060000
[    0.268012] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000
[    0.268012] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000
[    0.268012] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000
[    0.268012] pci 0000:ff:02.3: [8086:2d93] type 00 class 0x060000
[    0.268012] pci 0000:ff:02.4: [8086:2d94] type 00 class 0x060000
[    0.268012] pci 0000:ff:02.5: [8086:2d95] type 00 class 0x060000
[    0.268012] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
[    0.268012] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000
[    0.268032] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000
[    0.268069] pci 0000:ff:03.4: [8086:2d9c] type 00 class 0x060000
[    0.268107] pci 0000:ff:04.0: [8086:2da0] type 00 class 0x060000
[    0.268144] pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000
[    0.268181] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000
[    0.268218] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000
[    0.268257] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060000
[    0.268293] pci 0000:ff:05.1: [8086:2da9] type 00 class 0x060000
[    0.268330] pci 0000:ff:05.2: [8086:2daa] type 00 class 0x060000
[    0.268367] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000
[    0.268406] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000
[    0.269008] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000
[    0.269008] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x060000
[    0.269009] pci 0000:ff:06.3: [8086:2db3] type 00 class 0x060000
[    0.269009] pci_bus 0000:ff: on NUMA node 0
[    0.269009] ACPI: PCI Root Bridge [CPU1] (domain 0000 [bus fe])
[    0.269009] acpi PNP0A03:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.269009] acpi PNP0A03:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.269009] acpi PNP0A03:01: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.269024] PCI host bridge to bus 0000:fe
[    0.269119] pci_bus 0000:fe: root bus resource [bus fe]
[    0.269221] pci 0000:fe:00.0: [8086:2c70] type 00 class 0x060000
[    0.269264] pci 0000:fe:00.1: [8086:2d81] type 00 class 0x060000
[    0.269311] pci 0000:fe:02.0: [8086:2d90] type 00 class 0x060000
[    0.269351] pci 0000:fe:02.1: [8086:2d91] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.2: [8086:2d92] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.3: [8086:2d93] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.4: [8086:2d94] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.5: [8086:2d95] type 00 class 0x060000
[    0.270009] pci 0000:fe:03.0: [8086:2d98] type 00 class 0x060000
[    0.270009] pci 0000:fe:03.1: [8086:2d99] type 00 class 0x060000
[    0.270009] pci 0000:fe:03.2: [8086:2d9a] type 00 class 0x060000
[    0.270009] pci 0000:fe:03.4: [8086:2d9c] type 00 class 0x060000
[    0.270010] pci 0000:fe:04.0: [8086:2da0] type 00 class 0x060000
[    0.270013] pci 0000:fe:04.1: [8086:2da1] type 00 class 0x060000
[    0.270013] pci 0000:fe:04.2: [8086:2da2] type 00 class 0x060000
[    0.270013] pci 0000:fe:04.3: [8086:2da3] type 00 class 0x060000
[    0.270013] pci 0000:fe:05.0: [8086:2da8] type 00 class 0x060000
[    0.270013] pci 0000:fe:05.1: [8086:2da9] type 00 class 0x060000
[    0.270013] pci 0000:fe:05.2: [8086:2daa] type 00 class 0x060000
[    0.270045] pci 0000:fe:05.3: [8086:2dab] type 00 class 0x060000
[    0.270086] pci 0000:fe:06.0: [8086:2db0] type 00 class 0x060000
[    0.270126] pci 0000:fe:06.1: [8086:2db1] type 00 class 0x060000
[    0.270166] pci 0000:fe:06.2: [8086:2db2] type 00 class 0x060000
[    0.270206] pci 0000:fe:06.3: [8086:2db3] type 00 class 0x060000
[    0.270257] pci_bus 0000:fe: on NUMA node 0
[    0.270323] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3d])
[    0.270428] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.270538] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.270642] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-0a] only partially covers this bridge
[    0.271000] PCI host bridge to bus 0000:00
[    0.271000] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.271002] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.271106] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.271212] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000dffff window]
[    0.271317] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff window]
[    0.271423] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfebfffff window]
[    0.271529] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfedfffff window]
[    0.271635] pci_bus 0000:00: root bus resource [mem 0xfef00000-0xffbfffff window]
[    0.271740] pci_bus 0000:00: root bus resource [bus 00-3d]
[    0.271848] pci 0000:00:00.0: [8086:3406] type 00 class 0x060000
[    0.271880] pci 0000:00:00.0: enabling Extended Tags
[    0.272033] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.272109] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    0.272138] pci 0000:00:01.0: enabling Extended Tags
[    0.272269] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.272344] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    0.272373] pci 0000:00:03.0: enabling Extended Tags
[    0.272504] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.273000] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
[    0.273000] pci 0000:00:05.0: enabling Extended Tags
[    0.273000] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.273008] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    0.273008] pci 0000:00:07.0: enabling Extended Tags
[    0.273008] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.273074] pci 0000:00:08.0: [8086:340f] type 01 class 0x060400
[    0.273101] pci 0000:00:08.0: enabling Extended Tags
[    0.273230] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
[    0.273304] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    0.273332] pci 0000:00:09.0: enabling Extended Tags
[    0.273462] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.273536] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
[    0.273563] pci 0000:00:0a.0: enabling Extended Tags
[    0.273692] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.274009] pci 0000:00:10.0: [8086:3425] type 00 class 0x080000
[    0.274009] pci 0000:00:10.1: [8086:3426] type 00 class 0x080000
[    0.274009] pci 0000:00:11.0: [8086:3427] type 00 class 0x080000
[    0.274051] pci 0000:00:11.1: [8086:3428] type 00 class 0x080000
[    0.274144] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    0.274252] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    0.274357] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    0.274461] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    0.275008] pci 0000:00:15.0: [8086:342f] type 00 class 0x080020
[    0.275012] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    0.275012] pci 0000:00:1a.0: reg 0x20: [io  0x1820-0x183f]
[    0.275012] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    0.275012] pci 0000:00:1a.1: reg 0x20: [io  0x1840-0x185f]
[    0.275012] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    0.275012] pci 0000:00:1a.2: reg 0x20: [io  0x1860-0x187f]
[    0.275058] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    0.275079] pci 0000:00:1a.7: reg 0x10: [mem 0xce000000-0xce0003ff]
[    0.275158] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.275228] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    0.275300] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.275377] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    0.275450] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.275527] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    0.275569] pci 0000:00:1d.0: reg 0x20: [io  0x1880-0x189f]
[    0.276010] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    0.276010] pci 0000:00:1d.1: reg 0x20: [io  0x18a0-0x18bf]
[    0.276010] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    0.276010] pci 0000:00:1d.2: reg 0x20: [io  0x18c0-0x18df]
[    0.276010] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    0.276010] pci 0000:00:1d.7: reg 0x10: [mem 0xce001000-0xce0013ff]
[    0.276048] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.276115] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.276222] pci 0000:00:1f.0: [8086:3a18] type 00 class 0x060100
[    0.276379] pci 0000:00:1f.2: [8086:3a20] type 00 class 0x01018f
[    0.276395] pci 0000:00:1f.2: reg 0x10: [io  0x1c50-0x1c57]
[    0.276402] pci 0000:00:1f.2: reg 0x14: [io  0x1c44-0x1c47]
[    0.276410] pci 0000:00:1f.2: reg 0x18: [io  0x1c48-0x1c4f]
[    0.276416] pci 0000:00:1f.2: reg 0x1c: [io  0x1c40-0x1c43]
[    0.276424] pci 0000:00:1f.2: reg 0x20: [io  0x1c10-0x1c1f]
[    0.276431] pci 0000:00:1f.2: reg 0x24: [io  0x1c00-0x1c0f]
[    0.276520] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    0.276538] pci 0000:00:1f.3: reg 0x10: [mem 0xce002000-0xce0020ff 64bit]
[    0.276557] pci 0000:00:1f.3: reg 0x20: [io  0x18e0-0x18ff]
[    0.277009] pci 0000:00:1f.5: [8086:3a26] type 00 class 0x010185
[    0.277009] pci 0000:00:1f.5: reg 0x10: [io  0x1c68-0x1c6f]
[    0.277009] pci 0000:00:1f.5: reg 0x14: [io  0x1c5c-0x1c5f]
[    0.277009] pci 0000:00:1f.5: reg 0x18: [io  0x1c60-0x1c67]
[    0.277009] pci 0000:00:1f.5: reg 0x1c: [io  0x1c58-0x1c5b]
[    0.277009] pci 0000:00:1f.5: reg 0x20: [io  0x1c30-0x1c3f]
[    0.277009] pci 0000:00:1f.5: reg 0x24: [io  0x1c20-0x1c2f]
[    0.277009] pci 0000:01:00.0: [1000:0079] type 00 class 0x010400
[    0.277009] pci 0000:01:00.0: reg 0x10: [io  0x2000-0x20ff]
[    0.277009] pci 0000:01:00.0: reg 0x14: [mem 0xce100000-0xce103fff 64bit]
[    0.277009] pci 0000:01:00.0: reg 0x1c: [mem 0xce180000-0xce1bffff 64bit]
[    0.277009] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.277009] pci 0000:01:00.0: enabling Extended Tags
[    0.277009] pci 0000:01:00.0: supports D1 D2
[    0.277044] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.277143] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.277146] pci 0000:00:01.0:   bridge window [mem 0xce100000-0xce1fffff]
[    0.277179] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.277309] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.277440] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.278009] pci 0000:00:08.0: PCI bridge to [bus 05]
[    0.278009] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.278009] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.278010] pci 0000:08:00.0: [8086:10a7] type 00 class 0x020000
[    0.278010] pci 0000:08:00.0: reg 0x10: [mem 0xce260000-0xce27ffff]
[    0.278016] pci 0000:08:00.0: reg 0x14: [mem 0xce240000-0xce25ffff]
[    0.278026] pci 0000:08:00.0: reg 0x18: [io  0x3000-0x301f]
[    0.278037] pci 0000:08:00.0: reg 0x1c: [mem 0xce200000-0xce203fff]
[    0.278067] pci 0000:08:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.278134] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    0.278209] pci 0000:08:00.1: [8086:10a7] type 00 class 0x020000
[    0.278234] pci 0000:08:00.1: reg 0x10: [mem 0xce2c0000-0xce2dffff]
[    0.278245] pci 0000:08:00.1: reg 0x14: [mem 0xce2a0000-0xce2bffff]
[    0.278256] pci 0000:08:00.1: reg 0x18: [io  0x3020-0x303f]
[    0.278267] pci 0000:08:00.1: reg 0x1c: [mem 0xce204000-0xce207fff]
[    0.278296] pci 0000:08:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.278363] pci 0000:08:00.1: PME# supported from D0 D3hot D3cold
[    0.278454] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    0.278554] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.278557] pci 0000:00:1c.0:   bridge window [mem 0xce200000-0xce2fffff]
[    0.279009] pci 0000:09:00.0: [102b:0522] type 00 class 0x030000
[    0.279009] pci 0000:09:00.0: reg 0x10: [mem 0xcf000000-0xcfffffff pref]
[    0.279009] pci 0000:09:00.0: reg 0x14: [mem 0xce300000-0xce303fff]
[    0.279009] pci 0000:09:00.0: reg 0x18: [mem 0xce800000-0xceffffff]
[    0.279014] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    0.279014] pci 0000:00:1c.4:   bridge window [mem 0xce300000-0xceffffff]
[    0.279014] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.279033] pci 0000:00:1e.0: PCI bridge to [bus 0a] (subtractive decode)
[    0.279144] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.279146] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.279148] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.279149] pci 0000:00:1e.0:   bridge window [mem 0x000c8000-0x000dffff window] (subtractive decode)
[    0.279151] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff window] (subtractive decode)
[    0.279152] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfebfffff window] (subtractive decode)
[    0.279154] pci 0000:00:1e.0:   bridge window [mem 0xfed00000-0xfedfffff window] (subtractive decode)
[    0.279155] pci 0000:00:1e.0:   bridge window [mem 0xfef00000-0xffbfffff window] (subtractive decode)
[    0.279202] pci_bus 0000:00: on NUMA node 0
[    0.279358] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.279518] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.279675] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.279832] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.279982] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.280050] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.280207] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.280366] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.281019] pci 0000:09:00.0: vgaarb: setting as boot VGA device
[    0.282000] pci 0000:09:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.283017] pci 0000:09:00.0: vgaarb: bridge control possible
[    0.283117] vgaarb: loaded
[    0.283320] SCSI subsystem initialized
[    0.283434] PCI: Using ACPI for IRQ routing
[    0.283434] PCI: pci_cache_line_size set to 64 bytes
[    0.283434] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    0.283434] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
[    0.283434] e820: reserve RAM buffer [mem 0xbf6a0000-0xbfffffff]
[    0.284015] clocksource: Switched to clocksource tsc-early
[    0.284175] pnp: PnP ACPI init
[    0.284388] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.284504] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.284801] system 00:01: [io  0x0200-0x020f] has been reserved
[    0.284904] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.285005] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.285105] system 00:01: [io  0x0800-0x080f] has been reserved
[    0.285206] system 00:01: [io  0x0810-0x081f] has been reserved
[    0.285307] system 00:01: [io  0x0ca0-0x0ca1] has been reserved
[    0.285407] system 00:01: [io  0x0ca4-0x0ca7] has been reserved
[    0.285510] system 00:01: [io  0x0ca8-0x0cab] has been reserved
[    0.285611] system 00:01: [io  0x0cae-0x0caf] has been reserved
[    0.285712] system 00:01: [io  0x0e00-0x0e7f] has been reserved
[    0.285812] system 00:01: [io  0x1000-0x107f] has been reserved
[    0.285913] system 00:01: [io  0x1100-0x110f] has been reserved
[    0.286014] system 00:01: [io  0x1180-0x11ff] has been reserved
[    0.286115] system 00:01: [io  0xfe00] has been reserved
[    0.286214] system 00:01: [io  0xff00] has been reserved
[    0.286313] system 00:01: [mem 0xfec00000-0xfecfffff] could not be reserved
[    0.286417] system 00:01: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.286523] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.286632] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.286670] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.286874] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.287025] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.287081] pnp: PnP ACPI: found 5 devices
[    0.292879] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.293066] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 08] add_size 200000 add_align 100000
[    0.293074] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
[    0.293094] pci 0000:00:1c.0: BAR 9: assigned [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.293203] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0x4fff]
[    0.293305] pci 0000:01:00.0: BAR 6: assigned [mem 0xce140000-0xce17ffff pref]
[    0.293410] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.293510] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.293613] pci 0000:00:01.0:   bridge window [mem 0xce100000-0xce1fffff]
[    0.293720] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.293823] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.293927] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.294029] pci 0000:00:08.0: PCI bridge to [bus 05]
[    0.294132] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.294235] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.294339] pci 0000:08:00.0: BAR 6: assigned [mem 0xce220000-0xce23ffff pref]
[    0.294445] pci 0000:08:00.1: BAR 6: assigned [mem 0xce280000-0xce29ffff pref]
[    0.294551] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    0.294649] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.294752] pci 0000:00:1c.0:   bridge window [mem 0xce200000-0xce2fffff]
[    0.294857] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.294967] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    0.295064] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.295168] pci 0000:00:1c.4:   bridge window [mem 0xce300000-0xceffffff]
[    0.295272] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.295382] pci 0000:00:1e.0: PCI bridge to [bus 0a]
[    0.295489] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.295490] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.295492] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.295493] pci_bus 0000:00: resource 7 [mem 0x000c8000-0x000dffff window]
[    0.295495] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff window]
[    0.295496] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfebfffff window]
[    0.295498] pci_bus 0000:00: resource 10 [mem 0xfed00000-0xfedfffff window]
[    0.295500] pci_bus 0000:00: resource 11 [mem 0xfef00000-0xffbfffff window]
[    0.295501] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.295503] pci_bus 0000:01: resource 1 [mem 0xce100000-0xce1fffff]
[    0.295505] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.295506] pci_bus 0000:08: resource 1 [mem 0xce200000-0xce2fffff]
[    0.295508] pci_bus 0000:08: resource 2 [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.295509] pci_bus 0000:09: resource 0 [io  0x4000-0x4fff]
[    0.295511] pci_bus 0000:09: resource 1 [mem 0xce300000-0xceffffff]
[    0.295512] pci_bus 0000:09: resource 2 [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.295514] pci_bus 0000:0a: resource 4 [io  0x0000-0x0cf7 window]
[    0.295516] pci_bus 0000:0a: resource 5 [io  0x0d00-0xffff window]
[    0.295517] pci_bus 0000:0a: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.295519] pci_bus 0000:0a: resource 7 [mem 0x000c8000-0x000dffff window]
[    0.295520] pci_bus 0000:0a: resource 8 [mem 0xc0000000-0xdfffffff window]
[    0.295522] pci_bus 0000:0a: resource 9 [mem 0xf0000000-0xfebfffff window]
[    0.295523] pci_bus 0000:0a: resource 10 [mem 0xfed00000-0xfedfffff window]
[    0.295525] pci_bus 0000:0a: resource 11 [mem 0xfef00000-0xffbfffff window]
[    0.295589] NET: Registered protocol family 2
[    0.295807] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes)
[    0.296043] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.297126] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.297470] TCP: Hash tables configured (established 524288 bind 65536)
[    0.297646] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.297997] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.298419] NET: Registered protocol family 1
[    0.301521] pci 0000:08:00.0: Disabling L0s
[    0.301616] pci 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM control
[    0.301723] pci 0000:08:00.1: Disabling L0s
[    0.301818] pci 0000:08:00.1: can't disable ASPM; OS doesn't have ASPM control
[    0.301934] pci 0000:09:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.302044] PCI: CLS 64 bytes, default 64
[    0.302067] DMAR: Host address width 40
[    0.302161] DMAR: DRHD base: 0x000000fed14000 flags: 0x1
[    0.302266] DMAR: dmar0: reg_base_addr fed14000 ver 1:0 cap c90780106f0462 ecap f02076
[    0.302372] DMAR: RMRR base: 0x000000bf6d0000 end: 0x000000bf6e7fff
[    0.302476] DMAR: RMRR base: 0x000000bf6f0000 end: 0x000000bf6f0fff
[    0.302577] DMAR: RMRR base: 0x000000bf6f1000 end: 0x000000bf6f1fff
[    0.302678] DMAR: RMRR base: 0x000000bf6f2000 end: 0x000000bf6f2fff
[    0.302779] DMAR: RMRR base: 0x000000bf6fa000 end: 0x000000bf6fafff
[    0.302880] DMAR: RMRR base: 0x000000bf6f3000 end: 0x000000bf6f3fff
[    0.302982] DMAR: RMRR base: 0x000000bf6f4000 end: 0x000000bf6f4fff
[    0.303083] DMAR: RMRR base: 0x000000bf6f5000 end: 0x000000bf6f5fff
[    0.303184] DMAR: RMRR base: 0x000000bf6fb000 end: 0x000000bf6fbfff
[    0.303285] DMAR: ATSR flags: 0x0
[    0.303627] DMAR: dmar0: Using Queued invalidation
[    0.303741] DMAR: Setting RMRR:
[    0.304098] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf6fb000 - 0xbf6fbfff]
[    0.304488] DMAR: Setting identity map for device 0000:00:1d.2 [0xbf6f5000 - 0xbf6f5fff]
[    0.304949] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf6f4000 - 0xbf6f4fff]
[    0.305344] DMAR: Setting identity map for device 0000:00:1d.0 [0xbf6f3000 - 0xbf6f3fff]
[    0.305745] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf6fa000 - 0xbf6fafff]
[    0.306138] DMAR: Setting identity map for device 0000:00:1a.2 [0xbf6f2000 - 0xbf6f2fff]
[    0.306538] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf6f1000 - 0xbf6f1fff]
[    0.306934] DMAR: Setting identity map for device 0000:00:1a.0 [0xbf6f0000 - 0xbf6f0fff]
[    0.307070] DMAR: Setting identity map for device 0000:00:1a.0 [0xbf6d0000 - 0xbf6e7fff]
[    0.307178] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf6d0000 - 0xbf6e7fff]
[    0.307287] DMAR: Setting identity map for device 0000:00:1a.2 [0xbf6d0000 - 0xbf6e7fff]
[    0.307395] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf6d0000 - 0xbf6e7fff]
[    0.307506] DMAR: Setting identity map for device 0000:00:1d.0 [0xbf6d0000 - 0xbf6e7fff]
[    0.307615] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf6d0000 - 0xbf6e7fff]
[    0.307723] DMAR: Setting identity map for device 0000:00:1d.2 [0xbf6d0000 - 0xbf6e7fff]
[    0.307832] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf6d0000 - 0xbf6e7fff]
[    0.307944] DMAR: Prepare 0-16MiB unity mapping for LPC
[    0.308303] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    0.308628] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.308799] iommu: Adding device 0000:ff:00.0 to group 0
[    0.308912] iommu: Adding device 0000:ff:00.1 to group 0
[    0.309077] iommu: Adding device 0000:ff:02.0 to group 1
[    0.309188] iommu: Adding device 0000:ff:02.1 to group 1
[    0.309299] iommu: Adding device 0000:ff:02.2 to group 1
[    0.309410] iommu: Adding device 0000:ff:02.3 to group 1
[    0.309523] iommu: Adding device 0000:ff:02.4 to group 1
[    0.309634] iommu: Adding device 0000:ff:02.5 to group 1
[    0.309781] iommu: Adding device 0000:ff:03.0 to group 2
[    0.309894] iommu: Adding device 0000:ff:03.1 to group 2
[    0.310007] iommu: Adding device 0000:ff:03.2 to group 2
[    0.310118] iommu: Adding device 0000:ff:03.4 to group 2
[    0.310265] iommu: Adding device 0000:ff:04.0 to group 3
[    0.310376] iommu: Adding device 0000:ff:04.1 to group 3
[    0.310491] iommu: Adding device 0000:ff:04.2 to group 3
[    0.310602] iommu: Adding device 0000:ff:04.3 to group 3
[    0.310751] iommu: Adding device 0000:ff:05.0 to group 4
[    0.310862] iommu: Adding device 0000:ff:05.1 to group 4
[    0.310975] iommu: Adding device 0000:ff:05.2 to group 4
[    0.311087] iommu: Adding device 0000:ff:05.3 to group 4
[    0.311234] iommu: Adding device 0000:ff:06.0 to group 5
[    0.311347] iommu: Adding device 0000:ff:06.1 to group 5
[    0.311462] iommu: Adding device 0000:ff:06.2 to group 5
[    0.311575] iommu: Adding device 0000:ff:06.3 to group 5
[    0.311705] iommu: Adding device 0000:fe:00.0 to group 6
[    0.311818] iommu: Adding device 0000:fe:00.1 to group 6
[    0.311983] iommu: Adding device 0000:fe:02.0 to group 7
[    0.312096] iommu: Adding device 0000:fe:02.1 to group 7
[    0.312210] iommu: Adding device 0000:fe:02.2 to group 7
[    0.312323] iommu: Adding device 0000:fe:02.3 to group 7
[    0.312435] iommu: Adding device 0000:fe:02.4 to group 7
[    0.312551] iommu: Adding device 0000:fe:02.5 to group 7
[    0.312699] iommu: Adding device 0000:fe:03.0 to group 8
[    0.312811] iommu: Adding device 0000:fe:03.1 to group 8
[    0.312926] iommu: Adding device 0000:fe:03.2 to group 8
[    0.313040] iommu: Adding device 0000:fe:03.4 to group 8
[    0.313187] iommu: Adding device 0000:fe:04.0 to group 9
[    0.313300] iommu: Adding device 0000:fe:04.1 to group 9
[    0.313414] iommu: Adding device 0000:fe:04.2 to group 9
[    0.313530] iommu: Adding device 0000:fe:04.3 to group 9
[    0.313676] iommu: Adding device 0000:fe:05.0 to group 10
[    0.313792] iommu: Adding device 0000:fe:05.1 to group 10
[    0.313908] iommu: Adding device 0000:fe:05.2 to group 10
[    0.314023] iommu: Adding device 0000:fe:05.3 to group 10
[    0.314171] iommu: Adding device 0000:fe:06.0 to group 11
[    0.314286] iommu: Adding device 0000:fe:06.1 to group 11
[    0.314400] iommu: Adding device 0000:fe:06.2 to group 11
[    0.314518] iommu: Adding device 0000:fe:06.3 to group 11
[    0.314631] iommu: Adding device 0000:00:00.0 to group 12
[    0.314745] iommu: Adding device 0000:00:01.0 to group 13
[    0.314857] iommu: Adding device 0000:00:03.0 to group 14
[    0.314970] iommu: Adding device 0000:00:05.0 to group 15
[    0.315082] iommu: Adding device 0000:00:07.0 to group 16
[    0.315194] iommu: Adding device 0000:00:08.0 to group 17
[    0.315306] iommu: Adding device 0000:00:09.0 to group 18
[    0.315418] iommu: Adding device 0000:00:0a.0 to group 19
[    0.315552] iommu: Adding device 0000:00:10.0 to group 20
[    0.315668] iommu: Adding device 0000:00:10.1 to group 20
[    0.315799] iommu: Adding device 0000:00:11.0 to group 21
[    0.315916] iommu: Adding device 0000:00:11.1 to group 21
[    0.316066] iommu: Adding device 0000:00:14.0 to group 22
[    0.316184] iommu: Adding device 0000:00:14.1 to group 22
[    0.316303] iommu: Adding device 0000:00:14.2 to group 22
[    0.316420] iommu: Adding device 0000:00:14.3 to group 22
[    0.316544] iommu: Adding device 0000:00:15.0 to group 23
[    0.316692] iommu: Adding device 0000:00:1a.0 to group 24
[    0.316808] iommu: Adding device 0000:00:1a.1 to group 24
[    0.316927] iommu: Adding device 0000:00:1a.2 to group 24
[    0.317051] iommu: Adding device 0000:00:1a.7 to group 24
[    0.317184] iommu: Adding device 0000:00:1c.0 to group 25
[    0.317305] iommu: Adding device 0000:00:1c.4 to group 25
[    0.317454] iommu: Adding device 0000:00:1d.0 to group 26
[    0.317575] iommu: Adding device 0000:00:1d.1 to group 26
[    0.317693] iommu: Adding device 0000:00:1d.2 to group 26
[    0.317812] iommu: Adding device 0000:00:1d.7 to group 26
[    0.317925] iommu: Adding device 0000:00:1e.0 to group 27
[    0.318073] iommu: Adding device 0000:00:1f.0 to group 28
[    0.318191] iommu: Adding device 0000:00:1f.2 to group 28
[    0.318309] iommu: Adding device 0000:00:1f.3 to group 28
[    0.319679] iommu: Adding device 0000:00:1f.5 to group 28
[    0.319795] iommu: Adding device 0000:01:00.0 to group 29
[    0.319900] iommu: Adding device 0000:08:00.0 to group 25
[    0.320003] iommu: Adding device 0000:08:00.1 to group 25
[    0.320105] iommu: Adding device 0000:09:00.0 to group 25
[    0.322623] workingset: timestamp_bits=62 max_order=24 bucket_order=0
[    0.324531] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.324639] io scheduler noop registered
[    0.324732] io scheduler deadline registered
[    0.324868] io scheduler cfq registered (default)
[    0.324964] io scheduler mq-deadline registered
[    0.325060] io scheduler kyber registered
[    0.330470] megasas: 07.704.04.00-rc1
[    0.330812] megaraid_sas 0000:01:00.0: FW now in Ready state
[    0.330916] megaraid_sas 0000:01:00.0: 64 bit DMA mask and 32 bit consistent mask
[    0.331518] megaraid_sas 0000:01:00.0: firmware supports msix        : (0)
[    0.331621] megaraid_sas 0000:01:00.0: current msix/online cpus      : (1/24)
[    0.331726] megaraid_sas 0000:01:00.0: RDPQ mode     : (disabled)
[    0.420555] megaraid_sas 0000:01:00.0: controller type       : MR(512MB)
[    0.420661] megaraid_sas 0000:01:00.0: Online Controller Reset(OCR)  : Enabled
[    0.420769] megaraid_sas 0000:01:00.0: Secure JBOD support   : No
[    0.420874] megaraid_sas 0000:01:00.0: NVMe passthru support : No
[    0.420984] megaraid_sas 0000:01:00.0: megasas_init_mfi: fw_support_ieee=0
[    0.421105] megaraid_sas 0000:01:00.0: INIT adapter done
[    0.421207] megaraid_sas 0000:01:00.0: Jbod map is not supported megasas_setup_jbod_map 5132
[    0.465569] megaraid_sas 0000:01:00.0: pci id                : (0x1000)/(0x0079)/(0x1734)/(0x1176)
[    0.465680] megaraid_sas 0000:01:00.0: unevenspan support    : no
[    0.465788] megaraid_sas 0000:01:00.0: firmware crash dump   : no
[    0.465888] megaraid_sas 0000:01:00.0: jbod sync map         : no
[    0.465997] scsi host0: Avago SAS based MegaRAID driver
[    0.471310] scsi 0:2:0:0: Direct-Access     LSI      RAID 5/6 SAS 6G  2.90 PQ: 0 ANSI: 5
[    0.472134] scsi 0:2:1:0: Direct-Access     LSI      RAID 5/6 SAS 6G  2.90 PQ: 0 ANSI: 5
[    0.482013] rtc_cmos 00:02: RTC can wake from S4
[    0.482260] rtc_cmos 00:02: registered as rtc0
[    0.482309] random: fast init done
[    0.482375] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.482470] sd 0:2:1:0: [sdb] 1171062784 512-byte logical blocks: (600 GB/558 GiB)
[    0.482489] sd 0:2:0:0: [sda] 285671424 512-byte logical blocks: (146 GB/136 GiB)
[    0.482512] sd 0:2:0:0: [sda] Write Protect is off
[    0.482514] sd 0:2:0:0: [sda] Mode Sense: 1f 00 10 08
[    0.482552] sd 0:2:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    0.483120] sd 0:2:1:0: [sdb] Write Protect is off
[    0.483219] sd 0:2:1:0: [sdb] Mode Sense: 1f 00 10 08
[    0.483334] NET: Registered protocol family 17
[    0.483340] sd 0:2:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    0.483451] sched_clock: Marking stable (482565454, 0)->(653518254, -170952800)
[    0.483936] registered taskstats version 1
[    0.484100]  sdb: sdb1
[    0.484365] Btrfs loaded, crc32c=crc32c-generic
[    0.484583] sd 0:2:1:0: [sdb] Attached SCSI disk
[    0.485533] rtc_cmos 00:02: setting system clock to 2018-06-04 19:11:27 UTC (1528139487)
[    0.488769]  sda: sda1 sda2 sda3
[    0.489634] sd 0:2:0:0: [sda] Attached SCSI disk
[    0.495058] BTRFS: device fsid 473b3d83-48a1-4653-b073-5b55b600badd devid 1 transid 356978 /dev/root
[    0.496298] BTRFS info (device sda2): disk space caching is enabled
[    0.496406] BTRFS info (device sda2): has skinny extents
[    0.587549] VFS: Mounted root (btrfs filesystem) readonly on device 0:13.
[    0.592606] devtmpfs: mounted
[    0.595520] Freeing unused kernel memory: 780K
[    0.597164] Write protecting the kernel read-only data: 12288k
[    0.602558] Freeing unused kernel memory: 2020K
[    0.606105] Freeing unused kernel memory: 584K
[    1.025019] loop: module loaded
[    1.246147] random: udevd: uninitialized urandom read (16 bytes read)
[    1.248759] random: udevd: uninitialized urandom read (16 bytes read)
[    1.248871] random: udevd: uninitialized urandom read (16 bytes read)
[    1.375044] tsc: Refined TSC clocksource calibration: 2400.084 MHz
[    1.376222] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229886f1f14, max_idle_ns: 440795306808 ns
[    1.376964] clocksource: Switched to clocksource tsc
[    1.453486] random: crng init done
[    1.453580] random: 2 urandom warning(s) missed due to ratelimiting
[    1.462527] udevd[1014]: starting eudev-3.1.5
[    1.518277] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.524864] ACPI: bus type USB registered
[    1.524976] usbcore: registered new interface driver usbfs
[    1.525096] usbcore: registered new interface driver hub
[    1.525265] usbcore: registered new device driver usb
[    1.529476] pps_core: LinuxPPS API ver. 1 registered
[    1.529574] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.549376] PTP clock support registered
[    1.557032] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.577827] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.598633] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.598999] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.599522] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.599633] ACPI: Power Button [PWRB]
[    1.599789] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.599895] ACPI: Power Button [PWRF]
[    1.601852] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    1.601956] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.651427] ehci-pci: EHCI PCI platform driver
[    1.651765] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.651867] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    1.651981] ehci-pci 0000:00:1a.7: debug port 1
[    1.656014] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    1.656028] ehci-pci 0000:00:1a.7: irq 18, io mem 0xce000000
[    1.663054] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.663975] hub 1-0:1.0: USB hub found
[    1.664158] hub 1-0:1.0: 6 ports detected
[    1.664946] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.665064] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    1.665179] ehci-pci 0000:00:1d.7: debug port 1
[    1.669199] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    1.669210] ehci-pci 0000:00:1d.7: irq 23, io mem 0xce001000
[    1.676048] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.676356] hub 2-0:1.0: USB hub found
[    1.676467] hub 2-0:1.0: 6 ports detected
[    1.713887] uhci_hcd: USB Universal Host Controller Interface driver
[    1.714242] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.714346] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    1.714482] uhci_hcd 0000:00:1a.0: irq 19, io base 0x00001820
[    1.715163] hub 3-0:1.0: USB hub found
[    1.715270] hub 3-0:1.0: 2 ports detected
[    1.715798] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.715901] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    1.716034] uhci_hcd 0000:00:1a.1: irq 18, io base 0x00001840
[    1.716520] hub 4-0:1.0: USB hub found
[    1.716629] hub 4-0:1.0: 2 ports detected
[    1.717059] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    1.717164] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    1.717290] uhci_hcd 0000:00:1a.2: irq 18, io base 0x00001860
[    1.717733] hub 5-0:1.0: USB hub found
[    1.717910] hub 5-0:1.0: 2 ports detected
[    1.718597] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.718700] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    1.718826] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001880
[    1.719276] hub 6-0:1.0: USB hub found
[    1.719440] hub 6-0:1.0: 2 ports detected
[    1.719845] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.719947] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    1.720089] uhci_hcd 0000:00:1d.1: irq 22, io base 0x000018a0
[    1.720446] hub 7-0:1.0: USB hub found
[    1.720554] hub 7-0:1.0: 2 ports detected
[    1.720973] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.721082] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    1.721213] uhci_hcd 0000:00:1d.2: irq 21, io base 0x000018c0
[    1.721828] hub 8-0:1.0: USB hub found
[    1.721935] hub 8-0:1.0: 2 ports detected
[    1.804077] igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network Connection
[    1.804182] igb 0000:08:00.0: eth0: (PCIe:2.5Gb/s:Width x4) 00:19:99:ab:0b:38
[    1.804288] igb 0000:08:00.0: eth0: PBA No: Unknown
[    1.804385] igb 0000:08:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[    2.012115] igb 0000:08:00.1: Intel(R) Gigabit Ethernet Network Connection
[    2.012225] igb 0000:08:00.1: eth1: (PCIe:2.5Gb/s:Width x4) 00:19:99:ab:0b:39
[    2.012331] igb 0000:08:00.1: eth1: PBA No: Unknown
[    2.012429] igb 0000:08:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[    2.067108] BTRFS: device fsid 77ad40e4-d53c-4b3b-b135-7c3db9ee21fb devid 1 transid 507181 /dev/sdb1
[    2.164642] Adding 10451964k swap on /dev/sda3.  Priority:-2 extents:1 across:10451964k FS
[    2.309297] BTRFS info (device sda2): disk space caching is enabled
[    5.437118] BTRFS info (device sdb1): disk space caching is enabled
[    5.437222] BTRFS info (device sdb1): has skinny extents
[   10.763865] igb 0000:08:00.0: changing MTU from 1500 to 9000
[   13.214576] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   15.112934] vboxdrv: loading out-of-tree module taints kernel.
[   15.125946] vboxdrv: Found 24 processor cores
[   15.144502] vboxdrv: TSC mode is Invariant, tentative frequency 2400052042 Hz
[   15.144503] vboxdrv: Successfully loaded version 5.2.12 (interface 0x00290001)
[   15.192821] VBoxNetAdp: Successfully started.
[   15.229984] VBoxNetFlt: Successfully started.
[   15.240730] VBoxPciLinuxInit
[   15.240735] vboxpci: pci-stub module not available, cannot detach PCI devices
[   15.240735] vboxpci: IOMMU found
[   15.562552] SUPR0GipMap: fGetGipCpu=0xb
[   17.415903] vboxdrv: 00000000cdbcec4c VMMR0.r0
[   17.763782] vboxdrv: 000000001fc9bd6e VBoxDDR0.r0
[   17.786780] VBoxNetFlt: attached to 'eth0' / 00:19:99:ab:0b:38
[   17.810493] vboxpci: created IOMMU domain 00000000f60d2819
[   17.812470] vboxpci: created IOMMU domain 00000000c0a3f6d2
[   17.812472] vboxpci: created IOMMU domain 00000000ee100703
[   17.903856] vboxdrv: 000000001bfdcf4c VBoxEhciR0.r0
[   18.839240] vboxpci: created IOMMU domain 00000000564b0fae
[   21.755305] device eth0 entered promiscuous mode
[   21.974019] vboxpci: created IOMMU domain 000000004a72e381
[   23.063862] vboxpci: created IOMMU domain 000000000de0fce8
[   24.374749] vboxpci: created IOMMU domain 00000000d77817f8
[   27.821775] vboxpci: created IOMMU domain 00000000ea90c630
[   28.364920] vboxpci: created IOMMU domain 0000000007423792
[   28.450067] vboxpci: created IOMMU domain 00000000e22c8b48
[   29.033369] vboxpci: created IOMMU domain 0000000007f903f8
[   34.729839] vboxpci: created IOMMU domain 000000000e7e23cd
[19389.458286] igb 0000:08:00.0: Detected Tx Unit Hang
                 Tx Queue             <1>
                 TDH                  <3f>
                 TDT                  <3f>
                 next_to_use          <41>
                 next_to_clean        <3f>
               buffer_info[next_to_clean]
                 time_stamp           <101234494>
                 next_to_watch        <00000000930717e8>
                 jiffies              <101234940>
                 desc.status          <160210>
[19391.442150] igb 0000:08:00.0: Detected Tx Unit Hang
                 Tx Queue             <1>
                 TDH                  <3f>
                 TDT                  <3f>
                 next_to_use          <41>
                 next_to_clean        <3f>
               buffer_info[next_to_clean]
                 time_stamp           <101234494>
                 next_to_watch        <00000000930717e8>
                 jiffies              <101235100>
                 desc.status          <160210>
[19393.426033] igb 0000:08:00.0: Detected Tx Unit Hang
                 Tx Queue             <1>
                 TDH                  <3f>
                 TDT                  <3f>
                 next_to_use          <41>
                 next_to_clean        <3f>
               buffer_info[next_to_clean]
                 time_stamp           <101234494>
                 next_to_watch        <00000000930717e8>
                 jiffies              <1012358c0>
                 desc.status          <160210>
[19394.769755] ------------[ cut here ]------------
[19394.769779] NETDEV WATCHDOG: eth0 (igb): transmit queue 1 timed out
[19394.769804] WARNING: CPU: 10 PID: 0 at net/sched/sch_generic.c:473 dev_watchdog+0x1d9/0x1e0
[19394.769806] Modules linked in: vboxpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(O) uhci_hcd evdev ehci_pci igb button ehci_hcd 8250 ptp 8250_base pps_core usbcore i2c_i801 i2c_algo_bit usb_common serial_core i2c_core loop
[19394.769827] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G          IO      4.17.0 #1
[19394.769829] Hardware name: FUJITSU                          PRIMERGY RX300 S6             /D2619, BIOS 6.00 Rev. 1.13.2619.N1           01/19/2012
[19394.769832] RIP: 0010:dev_watchdog+0x1d9/0x1e0
[19394.769834] RSP: 0018:ffff880fff283ed0 EFLAGS: 00010282
[19394.769839] RAX: 0000000000000037 RBX: 0000000000000001 RCX: ffffffff81c2aa58
[19394.769843] RDX: 0000000000000001 RSI: 0000000000000092 RDI: ffffffff81f0cfec
[19394.769849] RBP: ffff880ff23683b0 R08: 0000000000000001 R09: 000000000000036d
[19394.769853] R10: ffffffff81c05100 R11: 000000000000036d R12: ffff880ff2368000
[19394.769856] R13: 000000000000000a R14: 0000000000000002 R15: ffffffff81c05108
[19394.769861] FS:  0000000000000000(0000) GS:ffff880fff280000(0000) knlGS:0000000000000000
[19394.769864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19394.769868] CR2: 0000000002f20000 CR3: 0000000001c0a005 CR4: 00000000000226a0
[19394.769871] Call Trace:
[19394.769875]  <IRQ>
[19394.769879]  ? qdisc_reset+0xe0/0xe0
[19394.769885]  call_timer_fn+0x13/0x80
[19394.769891]  expire_timers+0x70/0x80
[19394.769893]  run_timer_softirq+0x6e/0x120
[19394.769896]  ? __hrtimer_run_queues+0xfd/0x190
[19394.769900]  ? recalibrate_cpu_khz+0x10/0x10
[19394.769902]  ? ktime_get+0x33/0x90
[19394.769905]  ? default_inquire_remote_apic+0x10/0x10
[19394.769908]  ? lapic_next_event+0x17/0x20
[19394.769911]  ? clockevents_program_event+0x7e/0xf0
[19394.769914]  __do_softirq+0xd4/0x1c9
[19394.769917]  irq_exit+0xa3/0xb0
[19394.769919]  smp_apic_timer_interrupt+0x59/0x90
[19394.769921]  apic_timer_interrupt+0xf/0x20
[19394.769922]  </IRQ>
[19394.769927] RIP: 0010:cpuidle_enter_state+0x127/0x200
[19394.769928] RSP: 0018:ffffc900000c3ed0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[19394.769930] RAX: ffff880fff29edc0 RBX: 0000000000000003 RCX: 000000000000001f
[19394.769931] RDX: 20c49ba5e353f7cf RSI: 000000003554db01 RDI: 0000000000000000
[19394.769932] RBP: ffff880ff7da7600 R08: 000000000000000f R09: 0000000000000002
[19394.769933] R10: 0000000000000000 R11: 0000000000000040 R12: 000011a3b25c6d63
[19394.769934] R13: 000011a3b19adb11 R14: 0000000000000003 R15: ffff880ff8c9d200
[19394.769942]  do_idle+0x103/0x1d0
[19394.769945]  cpu_startup_entry+0x14/0x20
[19394.769948]  secondary_startup_64+0xa5/0xb0
[19394.769950] Code: 41 00 48 63 4d f0 eb 97 4c 89 e7 c6 05 8b 24 86 00 01 e8 2b 19 fe ff 89 d9 4c 89 e6 48 c7 c7 f8 fc b2 81 48 89 c2 e8 17 4f c5 ff <0f> 0b eb c0 0f 1f 00 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 
[19394.769990] ---[ end trace 3092c0fa7af64591 ]---
[19394.770010] igb 0000:08:00.0 eth0: Reset adapter
[19397.940296] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX

root at Kaa:~# ethtool -k eth0
Features for eth0:
Cannot get device udp-fragmentation-offload settings: Operation not supported
rx-checksumming: on
tx-checksumming: on
        tx-checksum-ipv4: off [fixed]
        tx-checksum-ip-generic: on
        tx-checksum-ipv6: off [fixed]
        tx-checksum-fcoe-crc: off [fixed]
        tx-checksum-sctp: off [fixed]
scatter-gather: on
        tx-scatter-gather: on
        tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
        tx-tcp-segmentation: on
        tx-tcp-ecn-segmentation: off [fixed]
        tx-tcp-mangleid-segmentation: off
        tx-tcp6-segmentation: on
udp-fragmentation-offload: off
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off [fixed]
rx-vlan-offload: on
tx-vlan-offload: on
ntuple-filters: off [fixed]
receive-hashing: on
highdma: on [fixed]
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: on
tx-gre-csum-segmentation: on
tx-ipxip4-segmentation: on
tx-ipxip6-segmentation: on
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on
tx-gso-partial: on
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off [fixed]
rx-fcs: off [fixed]
rx-all: off
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]
l2-fwd-offload: off [fixed]
hw-tc-offload: off [fixed]
esp-hw-offload: off [fixed]
esp-tx-csum-hw-offload: off [fixed]
rx-udp_tunnel-port-offload: off [fixed]
rx-gro-hw: off [fixed]
tls-hw-record: off [fixed]
root at Kaa:~# ethtool eth0
Settings for eth0:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
                                1000baseT/Full 
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
                                1000baseT/Full 
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Speed: 1000Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: off (auto)
        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes
