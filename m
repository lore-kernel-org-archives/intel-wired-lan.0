From: Marco Berizzi <pupilla@libero.it>
Date: Thu, 26 Jul 2018 13:56:13 +0200 (CEST)
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <963322856.1365958.1530796944033@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
Message-ID: <931347915.758706.1532606173777@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Il 5 luglio 2018 alle 15.22 Marco Berizzi <pupilla@libero.it> ha scritto:
> 
> > Il 5 giugno 2018 alle 10.12 Marco Berizzi <pupilla@libero.it> ha scritto:
> > 
> > Hi Folks,
> > 
> > after upgrading from 4.16.13 to 4.17 I got this error message.
> > 
> > Any feedback are welcome.
> > 
> > Marco Berizzi
> > 
> > PS: this system is running oracle virtualbox 5.2.12
> 
> Hi Folks,
> 
> I'm getting the same error also with 4.17.3:

Hi Folks,

I'm getting the same error also with 4.18-r6 (this system is
running oracle virtualbox 5.2.16):

[    0.000000] Linux version 4.18.0-rc6 (root at Kaa) (gcc version 5.5.0 (GCC)) #1 SMP Mon Jul 23 10:55:30 CEST 2018
[    0.000000] Command line: auto BOOT_IMAGE=Linux ro root=802 vt.default_utf8=0
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
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
[    0.000000] last_pfn = 0x1040000 max_arch_pfn = 0x400000000
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
[    0.000000] last_pfn = 0xbf6a0 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [(____ptrval____)] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01f5e000, 0x01f5efff] PGTABLE
[    0.000000] BRK [0x01f5f000, 0x01f5ffff] PGTABLE
[    0.000000] BRK [0x01f60000, 0x01f60fff] PGTABLE
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
[    0.000000] Reserved but unavailable: 2501 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000103fffffff]
[    0.000000] On node 0 totalpages: 16774715
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12187 pages used for memmap
[    0.000000]   DMA32 zone: 779936 pages, LIFO batch:31
[    0.000000]   Normal zone: 249856 pages used for memmap
[    0.000000]   Normal zone: 15990784 pages, LIFO batch:31
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
[    0.000000] [mem 0xc0000000-0xdfffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x86/0x39f with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:24 nr_cpumask_bits:24 nr_cpu_ids:24 nr_node_ids:1
[    0.000000] percpu: Embedded 41 pages/cpu @(____ptrval____) s130776 r8192 d28968 u262144
[    0.000000] pcpu-alloc: s130776 r8192 d28968 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16512587
[    0.000000] Kernel command line: auto BOOT_IMAGE=Linux ro root=802 vt.default_utf8=0
[    0.000000] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.000000] Memory: 65866172K/67098860K available (8200K kernel code, 343K rwdata, 1484K rodata, 780K init, 452K bss, 1232688K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180531
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
[    0.006000] tsc: Detected 2400.204 MHz processor
[    0.007000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2298f808ae0, max_idle_ns: 440795257023 ns
[    0.007000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4800.40 BogoMIPS (lpj=2400204)
[    0.007000] pid_max: default: 32768 minimum: 301
[    0.007000] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.008232] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.008497] CPU: Physical Processor ID: 0
[    0.008590] CPU: Processor Core ID: 0
[    0.008687] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.008787] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.008894] process: using mwait in idle threads
[    0.008991] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.009001] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.009103] Spectre V2 : Mitigation: Full generic retpoline
[    0.009202] Speculative Store Bypass: Vulnerable
[    0.009374] Freeing SMP alternatives memory: 20K
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
[    0.011530] smp: Bringing up secondary CPUs ...
[    0.011695] x86: Booting SMP configuration:
[    0.011790] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.113047] smp: Brought up 1 node, 24 CPUs
[    0.113249] smpboot: Max logical packages: 2
[    0.113344] smpboot: Total of 24 processors activated (115203.72 BogoMIPS)
[    0.115449] devtmpfs: initialized
[    0.115449] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.115449] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    0.116124] xor: measuring software checksum speed
[    0.126002]    prefetch64-sse: 12920.000 MB/sec
[    0.136001]    generic_sse: 10992.000 MB/sec
[    0.136095] xor: using function: prefetch64-sse (12920.000 MB/sec)
[    0.137558] NET: Registered protocol family 16
[    0.137774] cpuidle: using governor ladder
[    0.137774] cpuidle: using governor menu
[    0.138116] Simple Boot Flag at 0x7c set to 0x1
[    0.138220] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.138326] ACPI: bus type PCI registered
[    0.138430] PCI: MMCONFIG for domain 0000 [bus 00-0a] at [mem 0xe0000000-0xe0afffff] (base 0xe0000000)
[    0.138568] PCI: MMCONFIG at [mem 0xe0000000-0xe0afffff] reserved in E820
[    0.138678] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a huge-page mapping due to MTRR override.
[    0.138833] PCI: Using configuration type 1 for base access
[    0.157003] raid6: sse2x1   gen()  5921 MB/s
[    0.174004] raid6: sse2x1   xor()  4660 MB/s
[    0.191007] raid6: sse2x2   gen()  6988 MB/s
[    0.208006] raid6: sse2x2   xor()  5527 MB/s
[    0.225008] raid6: sse2x4   gen()  7851 MB/s
[    0.242006] raid6: sse2x4   xor()  6214 MB/s
[    0.242100] raid6: using algorithm sse2x4 gen() 7851 MB/s
[    0.242199] raid6: .... xor() 6214 MB/s, rmw enabled
[    0.242296] raid6: using ssse3x2 recovery algorithm
[    0.242463] ACPI: Added _OSI(Module Device)
[    0.242557] ACPI: Added _OSI(Processor Device)
[    0.242652] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.242748] ACPI: Added _OSI(Processor Aggregator Device)
[    0.242846] ACPI: Added _OSI(Linux-Dell-Video)
[    0.247285] ACPI: 50 ACPI AML tables successfully acquired and loaded
[    0.261673] ACPI: Interpreter enabled
[    0.261770] ACPI: (supports S0 S5)
[    0.261862] ACPI: Using IOAPIC for interrupt routing
[    0.261981] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.262131] ACPI: Enabled 10 GPEs in block 00 to 3F
[    0.266253] ACPI: PCI Root Bridge [CPU0] (domain 0000 [bus ff])
[    0.266357] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.266469] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.266573] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.266743] PCI host bridge to bus 0000:ff
[    0.266839] pci_bus 0000:ff: root bus resource [bus ff]
[    0.266943] pci 0000:ff:00.0: [8086:2c70] type 00 class 0x060000
[    0.267009] pci 0000:ff:00.1: [8086:2d81] type 00 class 0x060000
[    0.267038] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000
[    0.267076] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000
[    0.267113] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000
[    0.267152] pci 0000:ff:02.3: [8086:2d93] type 00 class 0x060000
[    0.267190] pci 0000:ff:02.4: [8086:2d94] type 00 class 0x060000
[    0.267228] pci 0000:ff:02.5: [8086:2d95] type 00 class 0x060000
[    0.267266] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
[    0.267304] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000
[    0.267347] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000
[    0.267386] pci 0000:ff:03.4: [8086:2d9c] type 00 class 0x060000
[    0.267426] pci 0000:ff:04.0: [8086:2da0] type 00 class 0x060000
[    0.268008] pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000
[    0.268008] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000
[    0.268008] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000
[    0.268009] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060000
[    0.268011] pci 0000:ff:05.1: [8086:2da9] type 00 class 0x060000
[    0.268011] pci 0000:ff:05.2: [8086:2daa] type 00 class 0x060000
[    0.268011] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000
[    0.268011] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000
[    0.268011] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000
[    0.268011] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x060000
[    0.268011] pci 0000:ff:06.3: [8086:2db3] type 00 class 0x060000
[    0.268011] pci_bus 0000:ff: on NUMA node 0
[    0.268011] ACPI: PCI Root Bridge [CPU1] (domain 0000 [bus fe])
[    0.268011] acpi PNP0A03:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.268115] acpi PNP0A03:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.268218] acpi PNP0A03:01: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.268387] PCI host bridge to bus 0000:fe
[    0.268482] pci_bus 0000:fe: root bus resource [bus fe]
[    0.268584] pci 0000:fe:00.0: [8086:2c70] type 00 class 0x060000
[    0.269009] pci 0000:fe:00.1: [8086:2d81] type 00 class 0x060000
[    0.269009] pci 0000:fe:02.0: [8086:2d90] type 00 class 0x060000
[    0.269010] pci 0000:fe:02.1: [8086:2d91] type 00 class 0x060000
[    0.269010] pci 0000:fe:02.2: [8086:2d92] type 00 class 0x060000
[    0.269010] pci 0000:fe:02.3: [8086:2d93] type 00 class 0x060000
[    0.269010] pci 0000:fe:02.4: [8086:2d94] type 00 class 0x060000
[    0.269010] pci 0000:fe:02.5: [8086:2d95] type 00 class 0x060000
[    0.269010] pci 0000:fe:03.0: [8086:2d98] type 00 class 0x060000
[    0.269010] pci 0000:fe:03.1: [8086:2d99] type 00 class 0x060000
[    0.269018] pci 0000:fe:03.2: [8086:2d9a] type 00 class 0x060000
[    0.269060] pci 0000:fe:03.4: [8086:2d9c] type 00 class 0x060000
[    0.269101] pci 0000:fe:04.0: [8086:2da0] type 00 class 0x060000
[    0.269142] pci 0000:fe:04.1: [8086:2da1] type 00 class 0x060000
[    0.269183] pci 0000:fe:04.2: [8086:2da2] type 00 class 0x060000
[    0.269223] pci 0000:fe:04.3: [8086:2da3] type 00 class 0x060000
[    0.269265] pci 0000:fe:05.0: [8086:2da8] type 00 class 0x060000
[    0.269306] pci 0000:fe:05.1: [8086:2da9] type 00 class 0x060000
[    0.269347] pci 0000:fe:05.2: [8086:2daa] type 00 class 0x060000
[    0.269392] pci 0000:fe:05.3: [8086:2dab] type 00 class 0x060000
[    0.269435] pci 0000:fe:06.0: [8086:2db0] type 00 class 0x060000
[    0.270008] pci 0000:fe:06.1: [8086:2db1] type 00 class 0x060000
[    0.270009] pci 0000:fe:06.2: [8086:2db2] type 00 class 0x060000
[    0.270009] pci 0000:fe:06.3: [8086:2db3] type 00 class 0x060000
[    0.270010] pci_bus 0000:fe: on NUMA node 0
[    0.270010] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3d])
[    0.270010] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.270010] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.270010] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-0a] only partially covers this bridge
[    0.270069] PCI host bridge to bus 0000:00
[    0.270165] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.270269] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.270373] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.270478] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000dffff window]
[    0.270584] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff window]
[    0.270690] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfebfffff window]
[    0.270796] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfedfffff window]
[    0.271002] pci_bus 0000:00: root bus resource [mem 0xfef00000-0xffbfffff window]
[    0.271108] pci_bus 0000:00: root bus resource [bus 00-3d]
[    0.271216] pci 0000:00:00.0: [8086:3406] type 00 class 0x060000
[    0.271248] pci 0000:00:00.0: enabling Extended Tags
[    0.271376] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.271453] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    0.271482] pci 0000:00:01.0: enabling Extended Tags
[    0.271613] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.272012] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    0.272012] pci 0000:00:03.0: enabling Extended Tags
[    0.272012] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.272012] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
[    0.272012] pci 0000:00:05.0: enabling Extended Tags
[    0.272034] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.272110] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    0.272139] pci 0000:00:07.0: enabling Extended Tags
[    0.272269] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.272347] pci 0000:00:08.0: [8086:340f] type 01 class 0x060400
[    0.272374] pci 0000:00:08.0: enabling Extended Tags
[    0.272503] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
[    0.273009] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    0.273009] pci 0000:00:09.0: enabling Extended Tags
[    0.273009] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.273010] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
[    0.273010] pci 0000:00:0a.0: enabling Extended Tags
[    0.273034] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.273111] pci 0000:00:10.0: [8086:3425] type 00 class 0x080000
[    0.273209] pci 0000:00:10.1: [8086:3426] type 00 class 0x080000
[    0.273302] pci 0000:00:11.0: [8086:3427] type 00 class 0x080000
[    0.273403] pci 0000:00:11.1: [8086:3428] type 00 class 0x080000
[    0.274011] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    0.274011] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    0.274011] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    0.274011] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    0.274013] pci 0000:00:15.0: [8086:342f] type 00 class 0x080020
[    0.274032] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    0.274075] pci 0000:00:1a.0: reg 0x20: [io  0x1820-0x183f]
[    0.274170] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    0.274212] pci 0000:00:1a.1: reg 0x20: [io  0x1840-0x185f]
[    0.274308] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    0.274350] pci 0000:00:1a.2: reg 0x20: [io  0x1860-0x187f]
[    0.274454] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    0.274475] pci 0000:00:1a.7: reg 0x10: [mem 0xce000000-0xce0003ff]
[    0.274554] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.275009] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    0.275009] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.275011] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    0.275011] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.275011] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    0.275011] pci 0000:00:1d.0: reg 0x20: [io  0x1880-0x189f]
[    0.275066] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    0.275109] pci 0000:00:1d.1: reg 0x20: [io  0x18a0-0x18bf]
[    0.275205] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    0.275248] pci 0000:00:1d.2: reg 0x20: [io  0x18c0-0x18df]
[    0.275350] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    0.275371] pci 0000:00:1d.7: reg 0x10: [mem 0xce001000-0xce0013ff]
[    0.275451] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.275521] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.276010] pci 0000:00:1f.0: [8086:3a18] type 00 class 0x060100
[    0.276010] pci 0000:00:1f.2: [8086:3a20] type 00 class 0x01018f
[    0.276010] pci 0000:00:1f.2: reg 0x10: [io  0x1c50-0x1c57]
[    0.276010] pci 0000:00:1f.2: reg 0x14: [io  0x1c44-0x1c47]
[    0.276010] pci 0000:00:1f.2: reg 0x18: [io  0x1c48-0x1c4f]
[    0.276010] pci 0000:00:1f.2: reg 0x1c: [io  0x1c40-0x1c43]
[    0.276010] pci 0000:00:1f.2: reg 0x20: [io  0x1c10-0x1c1f]
[    0.276010] pci 0000:00:1f.2: reg 0x24: [io  0x1c00-0x1c0f]
[    0.276011] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    0.276011] pci 0000:00:1f.3: reg 0x10: [mem 0xce002000-0xce0020ff 64bit]
[    0.276011] pci 0000:00:1f.3: reg 0x20: [io  0x18e0-0x18ff]
[    0.276055] pci 0000:00:1f.5: [8086:3a26] type 00 class 0x010185
[    0.276071] pci 0000:00:1f.5: reg 0x10: [io  0x1c68-0x1c6f]
[    0.276078] pci 0000:00:1f.5: reg 0x14: [io  0x1c5c-0x1c5f]
[    0.276085] pci 0000:00:1f.5: reg 0x18: [io  0x1c60-0x1c67]
[    0.276092] pci 0000:00:1f.5: reg 0x1c: [io  0x1c58-0x1c5b]
[    0.276099] pci 0000:00:1f.5: reg 0x20: [io  0x1c30-0x1c3f]
[    0.276106] pci 0000:00:1f.5: reg 0x24: [io  0x1c20-0x1c2f]
[    0.276229] pci 0000:01:00.0: [1000:0079] type 00 class 0x010400
[    0.276244] pci 0000:01:00.0: reg 0x10: [io  0x2000-0x20ff]
[    0.276253] pci 0000:01:00.0: reg 0x14: [mem 0xce100000-0xce103fff 64bit]
[    0.276263] pci 0000:01:00.0: reg 0x1c: [mem 0xce180000-0xce1bffff 64bit]
[    0.276275] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.276281] pci 0000:01:00.0: enabling Extended Tags
[    0.276414] pci 0000:01:00.0: supports D1 D2
[    0.276465] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.276564] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.276567] pci 0000:00:01.0:   bridge window [mem 0xce100000-0xce1fffff]
[    0.277012] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.277012] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.277012] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.277012] pci 0000:00:08.0: PCI bridge to [bus 05]
[    0.277035] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.277165] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.277316] pci 0000:08:00.0: [8086:10a7] type 00 class 0x020000
[    0.277342] pci 0000:08:00.0: reg 0x10: [mem 0xce260000-0xce27ffff]
[    0.277353] pci 0000:08:00.0: reg 0x14: [mem 0xce240000-0xce25ffff]
[    0.277363] pci 0000:08:00.0: reg 0x18: [io  0x3000-0x301f]
[    0.277374] pci 0000:08:00.0: reg 0x1c: [mem 0xce200000-0xce203fff]
[    0.277403] pci 0000:08:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.277470] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    0.277544] pci 0000:08:00.1: [8086:10a7] type 00 class 0x020000
[    0.277569] pci 0000:08:00.1: reg 0x10: [mem 0xce2c0000-0xce2dffff]
[    0.277580] pci 0000:08:00.1: reg 0x14: [mem 0xce2a0000-0xce2bffff]
[    0.277591] pci 0000:08:00.1: reg 0x18: [io  0x3020-0x303f]
[    0.277602] pci 0000:08:00.1: reg 0x1c: [mem 0xce204000-0xce207fff]
[    0.277631] pci 0000:08:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.277696] pci 0000:08:00.1: PME# supported from D0 D3hot D3cold
[    0.278009] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    0.278009] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.278009] pci 0000:00:1c.0:   bridge window [mem 0xce200000-0xce2fffff]
[    0.278033] pci 0000:09:00.0: [102b:0522] type 00 class 0x030000
[    0.278065] pci 0000:09:00.0: reg 0x10: [mem 0xcf000000-0xcfffffff pref]
[    0.278079] pci 0000:09:00.0: reg 0x14: [mem 0xce300000-0xce303fff]
[    0.278093] pci 0000:09:00.0: reg 0x18: [mem 0xce800000-0xceffffff]
[    0.278287] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    0.278389] pci 0000:00:1c.4:   bridge window [mem 0xce300000-0xceffffff]
[    0.278394] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.278411] pci_bus 0000:0a: extended config space not accessible
[    0.278557] pci 0000:00:1e.0: PCI bridge to [bus 0a] (subtractive decode)
[    0.278667] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.278669] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.278671] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.278672] pci 0000:00:1e.0:   bridge window [mem 0x000c8000-0x000dffff window] (subtractive decode)
[    0.278674] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff window] (subtractive decode)
[    0.278675] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfebfffff window] (subtractive decode)
[    0.278677] pci 0000:00:1e.0:   bridge window [mem 0xfed00000-0xfedfffff window] (subtractive decode)
[    0.278678] pci 0000:00:1e.0:   bridge window [mem 0xfef00000-0xffbfffff window] (subtractive decode)
[    0.278725] pci_bus 0000:00: on NUMA node 0
[    0.278886] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.279049] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.279205] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.279362] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.279513] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.279674] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.279831] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.279988] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.281019] pci 0000:09:00.0: vgaarb: setting as boot VGA device
[    0.282000] pci 0000:09:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.282004] pci 0000:09:00.0: vgaarb: bridge control possible
[    0.282103] vgaarb: loaded
[    0.282309] SCSI subsystem initialized
[    0.283014] PCI: Using ACPI for IRQ routing
[    0.283014] PCI: pci_cache_line_size set to 64 bytes
[    0.283014] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    0.283014] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
[    0.283014] e820: reserve RAM buffer [mem 0xbf6a0000-0xbfffffff]
[    0.283026] clocksource: Switched to clocksource tsc-early
[    0.283168] pnp: PnP ACPI init
[    0.283369] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.283478] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.283768] system 00:01: [io  0x0200-0x020f] has been reserved
[    0.283870] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.283971] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.284071] system 00:01: [io  0x0800-0x080f] has been reserved
[    0.284176] system 00:01: [io  0x0810-0x081f] has been reserved
[    0.284277] system 00:01: [io  0x0ca0-0x0ca1] has been reserved
[    0.284377] system 00:01: [io  0x0ca4-0x0ca7] has been reserved
[    0.284478] system 00:01: [io  0x0ca8-0x0cab] has been reserved
[    0.284579] system 00:01: [io  0x0cae-0x0caf] has been reserved
[    0.284680] system 00:01: [io  0x0e00-0x0e7f] has been reserved
[    0.284780] system 00:01: [io  0x1000-0x107f] has been reserved
[    0.284881] system 00:01: [io  0x1100-0x110f] has been reserved
[    0.284982] system 00:01: [io  0x1180-0x11ff] has been reserved
[    0.285084] system 00:01: [io  0xfe00] has been reserved
[    0.285183] system 00:01: [io  0xff00] has been reserved
[    0.285282] system 00:01: [mem 0xfec00000-0xfecfffff] could not be reserved
[    0.285386] system 00:01: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.285491] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.285598] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.285628] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.285825] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.285966] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.286016] pnp: PnP ACPI: found 5 devices
[    0.291583] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.291769] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 08] add_size 200000 add_align 100000
[    0.291776] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
[    0.291797] pci 0000:00:1c.0: BAR 9: assigned [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.291905] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0x4fff]
[    0.292008] pci 0000:01:00.0: BAR 6: assigned [mem 0xce140000-0xce17ffff pref]
[    0.292115] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.292213] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.292316] pci 0000:00:01.0:   bridge window [mem 0xce100000-0xce1fffff]
[    0.292423] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.292526] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.292629] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.292732] pci 0000:00:08.0: PCI bridge to [bus 05]
[    0.292835] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.292938] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.293042] pci 0000:08:00.0: BAR 6: assigned [mem 0xce220000-0xce23ffff pref]
[    0.293150] pci 0000:08:00.1: BAR 6: assigned [mem 0xce280000-0xce29ffff pref]
[    0.293254] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    0.293352] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.293457] pci 0000:00:1c.0:   bridge window [mem 0xce200000-0xce2fffff]
[    0.293562] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.293672] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    0.293769] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.293873] pci 0000:00:1c.4:   bridge window [mem 0xce300000-0xceffffff]
[    0.293978] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.294089] pci 0000:00:1e.0: PCI bridge to [bus 0a]
[    0.294194] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.294196] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.294197] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.294199] pci_bus 0000:00: resource 7 [mem 0x000c8000-0x000dffff window]
[    0.294200] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff window]
[    0.294202] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfebfffff window]
[    0.294203] pci_bus 0000:00: resource 10 [mem 0xfed00000-0xfedfffff window]
[    0.294205] pci_bus 0000:00: resource 11 [mem 0xfef00000-0xffbfffff window]
[    0.294206] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.294208] pci_bus 0000:01: resource 1 [mem 0xce100000-0xce1fffff]
[    0.294210] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.294211] pci_bus 0000:08: resource 1 [mem 0xce200000-0xce2fffff]
[    0.294213] pci_bus 0000:08: resource 2 [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.294214] pci_bus 0000:09: resource 0 [io  0x4000-0x4fff]
[    0.294216] pci_bus 0000:09: resource 1 [mem 0xce300000-0xceffffff]
[    0.294217] pci_bus 0000:09: resource 2 [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.294219] pci_bus 0000:0a: resource 4 [io  0x0000-0x0cf7 window]
[    0.294220] pci_bus 0000:0a: resource 5 [io  0x0d00-0xffff window]
[    0.294222] pci_bus 0000:0a: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.294223] pci_bus 0000:0a: resource 7 [mem 0x000c8000-0x000dffff window]
[    0.294225] pci_bus 0000:0a: resource 8 [mem 0xc0000000-0xdfffffff window]
[    0.294226] pci_bus 0000:0a: resource 9 [mem 0xf0000000-0xfebfffff window]
[    0.294228] pci_bus 0000:0a: resource 10 [mem 0xfed00000-0xfedfffff window]
[    0.294229] pci_bus 0000:0a: resource 11 [mem 0xfef00000-0xffbfffff window]
[    0.294293] NET: Registered protocol family 2
[    0.294507] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes)
[    0.294736] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.295822] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.296166] TCP: Hash tables configured (established 524288 bind 65536)
[    0.296346] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.296688] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.297104] NET: Registered protocol family 1
[    0.300223] pci 0000:08:00.0: Disabling L0s
[    0.300319] pci 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM control
[    0.300426] pci 0000:08:00.1: Disabling L0s
[    0.300521] pci 0000:08:00.1: can't disable ASPM; OS doesn't have ASPM control
[    0.300636] pci 0000:09:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.300746] PCI: CLS 64 bytes, default 64
[    0.300772] DMAR: Host address width 40
[    0.300865] DMAR: DRHD base: 0x000000fed14000 flags: 0x1
[    0.300970] DMAR: dmar0: reg_base_addr fed14000 ver 1:0 cap c90780106f0462 ecap f02076
[    0.301079] DMAR: RMRR base: 0x000000bf6d0000 end: 0x000000bf6e7fff
[    0.301181] DMAR: RMRR base: 0x000000bf6f0000 end: 0x000000bf6f0fff
[    0.301282] DMAR: RMRR base: 0x000000bf6f1000 end: 0x000000bf6f1fff
[    0.301383] DMAR: RMRR base: 0x000000bf6f2000 end: 0x000000bf6f2fff
[    0.301484] DMAR: RMRR base: 0x000000bf6fa000 end: 0x000000bf6fafff
[    0.301586] DMAR: RMRR base: 0x000000bf6f3000 end: 0x000000bf6f3fff
[    0.301686] DMAR: RMRR base: 0x000000bf6f4000 end: 0x000000bf6f4fff
[    0.301787] DMAR: RMRR base: 0x000000bf6f5000 end: 0x000000bf6f5fff
[    0.301888] DMAR: RMRR base: 0x000000bf6fb000 end: 0x000000bf6fbfff
[    0.301989] DMAR: ATSR flags: 0x0
[    0.302337] DMAR: dmar0: Using Queued invalidation
[    0.302451] DMAR: Setting RMRR:
[    0.302808] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf6fb000 - 0xbf6fbfff]
[    0.303262] DMAR: Setting identity map for device 0000:00:1d.2 [0xbf6f5000 - 0xbf6f5fff]
[    0.303663] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf6f4000 - 0xbf6f4fff]
[    0.304057] DMAR: Setting identity map for device 0000:00:1d.0 [0xbf6f3000 - 0xbf6f3fff]
[    0.304461] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf6fa000 - 0xbf6fafff]
[    0.304877] DMAR: Setting identity map for device 0000:00:1a.2 [0xbf6f2000 - 0xbf6f2fff]
[    0.305279] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf6f1000 - 0xbf6f1fff]
[    0.305682] DMAR: Setting identity map for device 0000:00:1a.0 [0xbf6f0000 - 0xbf6f0fff]
[    0.305820] DMAR: Setting identity map for device 0000:00:1a.0 [0xbf6d0000 - 0xbf6e7fff]
[    0.305929] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf6d0000 - 0xbf6e7fff]
[    0.306038] DMAR: Setting identity map for device 0000:00:1a.2 [0xbf6d0000 - 0xbf6e7fff]
[    0.306149] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf6d0000 - 0xbf6e7fff]
[    0.306258] DMAR: Setting identity map for device 0000:00:1d.0 [0xbf6d0000 - 0xbf6e7fff]
[    0.306367] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf6d0000 - 0xbf6e7fff]
[    0.306476] DMAR: Setting identity map for device 0000:00:1d.2 [0xbf6d0000 - 0xbf6e7fff]
[    0.306585] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf6d0000 - 0xbf6e7fff]
[    0.306697] DMAR: Prepare 0-16MiB unity mapping for LPC
[    0.307062] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    0.307389] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.307553] iommu: Adding device 0000:ff:00.0 to group 0
[    0.307666] iommu: Adding device 0000:ff:00.1 to group 0
[    0.307832] iommu: Adding device 0000:ff:02.0 to group 1
[    0.307943] iommu: Adding device 0000:ff:02.1 to group 1
[    0.308053] iommu: Adding device 0000:ff:02.2 to group 1
[    0.308167] iommu: Adding device 0000:ff:02.3 to group 1
[    0.308278] iommu: Adding device 0000:ff:02.4 to group 1
[    0.308389] iommu: Adding device 0000:ff:02.5 to group 1
[    0.308541] iommu: Adding device 0000:ff:03.0 to group 2
[    0.308652] iommu: Adding device 0000:ff:03.1 to group 2
[    0.308763] iommu: Adding device 0000:ff:03.2 to group 2
[    0.308874] iommu: Adding device 0000:ff:03.4 to group 2
[    0.309022] iommu: Adding device 0000:ff:04.0 to group 3
[    0.309136] iommu: Adding device 0000:ff:04.1 to group 3
[    0.309249] iommu: Adding device 0000:ff:04.2 to group 3
[    0.309361] iommu: Adding device 0000:ff:04.3 to group 3
[    0.309509] iommu: Adding device 0000:ff:05.0 to group 4
[    0.309622] iommu: Adding device 0000:ff:05.1 to group 4
[    0.309734] iommu: Adding device 0000:ff:05.2 to group 4
[    0.309846] iommu: Adding device 0000:ff:05.3 to group 4
[    0.309997] iommu: Adding device 0000:ff:06.0 to group 5
[    0.310112] iommu: Adding device 0000:ff:06.1 to group 5
[    0.310225] iommu: Adding device 0000:ff:06.2 to group 5
[    0.310338] iommu: Adding device 0000:ff:06.3 to group 5
[    0.310468] iommu: Adding device 0000:fe:00.0 to group 6
[    0.310583] iommu: Adding device 0000:fe:00.1 to group 6
[    0.310750] iommu: Adding device 0000:fe:02.0 to group 7
[    0.310863] iommu: Adding device 0000:fe:02.1 to group 7
[    0.310976] iommu: Adding device 0000:fe:02.2 to group 7
[    0.311092] iommu: Adding device 0000:fe:02.3 to group 7
[    0.311205] iommu: Adding device 0000:fe:02.4 to group 7
[    0.311318] iommu: Adding device 0000:fe:02.5 to group 7
[    0.311468] iommu: Adding device 0000:fe:03.0 to group 8
[    0.311583] iommu: Adding device 0000:fe:03.1 to group 8
[    0.311696] iommu: Adding device 0000:fe:03.2 to group 8
[    0.311810] iommu: Adding device 0000:fe:03.4 to group 8
[    0.311957] iommu: Adding device 0000:fe:04.0 to group 9
[    0.312074] iommu: Adding device 0000:fe:04.1 to group 9
[    0.312188] iommu: Adding device 0000:fe:04.2 to group 9
[    0.312303] iommu: Adding device 0000:fe:04.3 to group 9
[    0.312451] iommu: Adding device 0000:fe:05.0 to group 10
[    0.312567] iommu: Adding device 0000:fe:05.1 to group 10
[    0.312682] iommu: Adding device 0000:fe:05.2 to group 10
[    0.312797] iommu: Adding device 0000:fe:05.3 to group 10
[    0.312946] iommu: Adding device 0000:fe:06.0 to group 11
[    0.313063] iommu: Adding device 0000:fe:06.1 to group 11
[    0.313181] iommu: Adding device 0000:fe:06.2 to group 11
[    0.313296] iommu: Adding device 0000:fe:06.3 to group 11
[    0.313410] iommu: Adding device 0000:00:00.0 to group 12
[    0.313524] iommu: Adding device 0000:00:01.0 to group 13
[    0.313637] iommu: Adding device 0000:00:03.0 to group 14
[    0.313749] iommu: Adding device 0000:00:05.0 to group 15
[    0.313862] iommu: Adding device 0000:00:07.0 to group 16
[    0.313974] iommu: Adding device 0000:00:08.0 to group 17
[    0.314089] iommu: Adding device 0000:00:09.0 to group 18
[    0.314203] iommu: Adding device 0000:00:0a.0 to group 19
[    0.314333] iommu: Adding device 0000:00:10.0 to group 20
[    0.314449] iommu: Adding device 0000:00:10.1 to group 20
[    0.314581] iommu: Adding device 0000:00:11.0 to group 21
[    0.314698] iommu: Adding device 0000:00:11.1 to group 21
[    0.314849] iommu: Adding device 0000:00:14.0 to group 22
[    0.314967] iommu: Adding device 0000:00:14.1 to group 22
[    0.315088] iommu: Adding device 0000:00:14.2 to group 22
[    0.315206] iommu: Adding device 0000:00:14.3 to group 22
[    0.315328] iommu: Adding device 0000:00:15.0 to group 23
[    0.315479] iommu: Adding device 0000:00:1a.0 to group 24
[    0.315597] iommu: Adding device 0000:00:1a.1 to group 24
[    0.315720] iommu: Adding device 0000:00:1a.2 to group 24
[    0.315838] iommu: Adding device 0000:00:1a.7 to group 24
[    0.315971] iommu: Adding device 0000:00:1c.0 to group 25
[    0.316095] iommu: Adding device 0000:00:1c.4 to group 25
[    0.316245] iommu: Adding device 0000:00:1d.0 to group 26
[    0.316364] iommu: Adding device 0000:00:1d.1 to group 26
[    0.316483] iommu: Adding device 0000:00:1d.2 to group 26
[    0.316602] iommu: Adding device 0000:00:1d.7 to group 26
[    0.316714] iommu: Adding device 0000:00:1e.0 to group 27
[    0.316862] iommu: Adding device 0000:00:1f.0 to group 28
[    0.316982] iommu: Adding device 0000:00:1f.2 to group 28
[    0.317103] iommu: Adding device 0000:00:1f.3 to group 28
[    0.318469] iommu: Adding device 0000:00:1f.5 to group 28
[    0.318585] iommu: Adding device 0000:01:00.0 to group 29
[    0.318689] iommu: Adding device 0000:08:00.0 to group 25
[    0.318792] iommu: Adding device 0000:08:00.1 to group 25
[    0.318895] iommu: Adding device 0000:09:00.0 to group 25
[    0.321371] workingset: timestamp_bits=62 max_order=24 bucket_order=0
[    0.322977] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.323089] io scheduler noop registered
[    0.323182] io scheduler deadline registered
[    0.323317] io scheduler cfq registered (default)
[    0.323413] io scheduler mq-deadline registered
[    0.323508] io scheduler kyber registered
[    0.328677] megasas: 07.705.02.00-rc1
[    0.328923] megaraid_sas 0000:01:00.0: FW now in Ready state
[    0.329026] megaraid_sas 0000:01:00.0: 64 bit DMA mask and 32 bit consistent mask
[    0.329668] megaraid_sas 0000:01:00.0: firmware supports msix        : (0)
[    0.329773] megaraid_sas 0000:01:00.0: current msix/online cpus      : (1/24)
[    0.329877] megaraid_sas 0000:01:00.0: RDPQ mode     : (disabled)
[    0.419127] megaraid_sas 0000:01:00.0: controller type       : MR(512MB)
[    0.419237] megaraid_sas 0000:01:00.0: Online Controller Reset(OCR)  : Enabled
[    0.419346] megaraid_sas 0000:01:00.0: Secure JBOD support   : No
[    0.419449] megaraid_sas 0000:01:00.0: NVMe passthru support : No
[    0.419556] megaraid_sas 0000:01:00.0: megasas_init_mfi: fw_support_ieee=0
[    0.419681] megaraid_sas 0000:01:00.0: INIT adapter done
[    0.419782] megaraid_sas 0000:01:00.0: Jbod map is not supported megasas_setup_jbod_map 5128
[    0.464135] megaraid_sas 0000:01:00.0: pci id                : (0x1000)/(0x0079)/(0x1734)/(0x1176)
[    0.464245] megaraid_sas 0000:01:00.0: unevenspan support    : no
[    0.464352] megaraid_sas 0000:01:00.0: firmware crash dump   : no
[    0.464459] megaraid_sas 0000:01:00.0: jbod sync map         : no
[    0.464563] scsi host0: Avago SAS based MegaRAID driver
[    0.469703] scsi 0:2:0:0: Direct-Access     LSI      RAID 5/6 SAS 6G  2.90 PQ: 0 ANSI: 5
[    0.470709] scsi 0:2:1:0: Direct-Access     LSI      RAID 5/6 SAS 6G  2.90 PQ: 0 ANSI: 5
[    0.481335] rtc_cmos 00:02: RTC can wake from S4
[    0.481531] random: fast init done
[    0.481703] rtc_cmos 00:02: registered as rtc0
[    0.481705] sd 0:2:1:0: [sdb] 1171062784 512-byte logical blocks: (600 GB/558 GiB)
[    0.481789] sd 0:2:0:0: [sda] 285671424 512-byte logical blocks: (146 GB/136 GiB)
[    0.481817] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.481819] sd 0:2:0:0: [sda] Write Protect is off
[    0.481821] sd 0:2:0:0: [sda] Mode Sense: 1f 00 10 08
[    0.481956] sd 0:2:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    0.481956] sd 0:2:1:0: [sdb] Write Protect is off
[    0.481958] sd 0:2:1:0: [sdb] Mode Sense: 1f 00 10 08
[    0.482005] sd 0:2:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    0.482988] NET: Registered protocol family 17
[    0.483102] sched_clock: Marking stable (482934334, 0)->(655335020, -172400686)
[    0.483480] registered taskstats version 1
[    0.483843] Btrfs loaded, crc32c=crc32c-generic
[    0.484914] rtc_cmos 00:02: setting system clock to 2018-07-23 13:18:43 UTC (1532351923)
[    0.487014]  sdb: sdb1
[    0.487413]  sda: sda1 sda2 sda3
[    0.487605] sd 0:2:1:0: [sdb] Attached SCSI disk
[    0.487953] sd 0:2:0:0: [sda] Attached SCSI disk
[    0.497996] BTRFS: device fsid 473b3d83-48a1-4653-b073-5b55b600badd devid 1 transid 446116 /dev/root
[    0.499154] BTRFS info (device sda2): disk space caching is enabled
[    0.499262] BTRFS info (device sda2): has skinny extents
[    0.808979] VFS: Mounted root (btrfs filesystem) readonly on device 0:13.
[    0.814435] devtmpfs: mounted
[    0.817214] Freeing unused kernel memory: 780K
[    0.820452] Write protecting the kernel read-only data: 12288k
[    0.825724] Freeing unused kernel memory: 2020K
[    0.828954] Freeing unused kernel memory: 564K
[    1.250040] loop: module loaded
[    1.375141] tsc: Refined TSC clocksource calibration: 2400.084 MHz
[    1.376258] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229886f1f14, max_idle_ns: 440795306808 ns
[    1.377084] clocksource: Switched to clocksource tsc
[    1.505161] random: crng init done
[    1.694934] udevd[1014]: starting eudev-3.1.5
[    1.756741] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.775069] ACPI: bus type USB registered
[    1.775186] usbcore: registered new interface driver usbfs
[    1.775295] usbcore: registered new interface driver hub
[    1.777283] usbcore: registered new device driver usb
[    1.780772] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.780884] ACPI: Power Button [PWRB]
[    1.781030] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.781143] ACPI: Power Button [PWRF]
[    1.790332] pps_core: LinuxPPS API ver. 1 registered
[    1.790432] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.847383] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.868156] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.889034] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.894651] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.939651] PTP clock support registered
[    1.945133] ehci-pci: EHCI PCI platform driver
[    1.945515] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.945618] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    1.945733] ehci-pci 0000:00:1a.7: debug port 1
[    1.949727] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    1.949743] ehci-pci 0000:00:1a.7: irq 18, io mem 0xce000000
[    1.957013] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.958089] hub 1-0:1.0: USB hub found
[    1.958227] hub 1-0:1.0: 6 ports detected
[    1.959284] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.959387] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    1.959502] ehci-pci 0000:00:1d.7: debug port 1
[    1.963520] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    1.963529] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    1.963532] ehci-pci 0000:00:1d.7: irq 23, io mem 0xce001000
[    1.963634] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.971022] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.971427] hub 2-0:1.0: USB hub found
[    1.971530] hub 2-0:1.0: 6 ports detected
[    2.000275] uhci_hcd: USB Universal Host Controller Interface driver
[    2.000613] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.000717] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.000853] uhci_hcd 0000:00:1a.0: irq 19, io base 0x00001820
[    2.001605] hub 3-0:1.0: USB hub found
[    2.001757] hub 3-0:1.0: 2 ports detected
[    2.002226] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    2.002329] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    2.002457] uhci_hcd 0000:00:1a.1: irq 18, io base 0x00001840
[    2.003070] hub 4-0:1.0: USB hub found
[    2.003245] hub 4-0:1.0: 2 ports detected
[    2.003986] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    2.004104] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    2.004232] uhci_hcd 0000:00:1a.2: irq 18, io base 0x00001860
[    2.004797] hub 5-0:1.0: USB hub found
[    2.004971] hub 5-0:1.0: 2 ports detected
[    2.005728] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.005831] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    2.005959] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001880
[    2.006624] hub 6-0:1.0: USB hub found
[    2.006768] hub 6-0:1.0: 2 ports detected
[    2.007175] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.007278] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    2.007410] uhci_hcd 0000:00:1d.1: irq 22, io base 0x000018a0
[    2.007998] hub 7-0:1.0: USB hub found
[    2.008157] hub 7-0:1.0: 2 ports detected
[    2.008624] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.008727] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    2.008860] uhci_hcd 0000:00:1d.2: irq 21, io base 0x000018c0
[    2.009299] hub 8-0:1.0: USB hub found
[    2.009445] hub 8-0:1.0: 2 ports detected
[    2.180129] igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network Connection
[    2.180236] igb 0000:08:00.0: eth0: (PCIe:2.5Gb/s:Width x4) 00:19:99:ab:0b:38
[    2.180341] igb 0000:08:00.0: eth0: PBA No: Unknown
[    2.180438] igb 0000:08:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[    2.288110] BTRFS: device fsid 77ad40e4-d53c-4b3b-b135-7c3db9ee21fb devid 1 transid 627173 /dev/sdb1
[    2.396182] igb 0000:08:00.1: Intel(R) Gigabit Ethernet Network Connection
[    2.396287] igb 0000:08:00.1: eth1: (PCIe:2.5Gb/s:Width x4) 00:19:99:ab:0b:39
[    2.396393] igb 0000:08:00.1: eth1: PBA No: Unknown
[    2.396490] igb 0000:08:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[    2.450254] Adding 10451964k swap on /dev/sda3.  Priority:-2 extents:1 across:10451964k FS
[    2.997408] BTRFS info (device sda2): disk space caching is enabled
[    6.117523] BTRFS info (device sdb1): disk space caching is enabled
[    6.117628] BTRFS info (device sdb1): has skinny extents
[   12.233646] igb 0000:08:00.0: changing MTU from 1500 to 9000
[   14.677564] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   16.687919] vboxdrv: loading out-of-tree module taints kernel.
[   16.700867] vboxdrv: Found 24 processor cores
[   16.719679] vboxdrv: TSC mode is Invariant, tentative frequency 2400052291 Hz
[   16.719680] vboxdrv: Successfully loaded version 5.2.16 (interface 0x00290001)
[   16.819790] VBoxNetAdp: Successfully started.
[   16.865608] VBoxNetFlt: Successfully started.
[   16.906037] VBoxPciLinuxInit
[   16.906041] vboxpci: pci-stub module not available, cannot detach PCI devices
[   16.906041] vboxpci: IOMMU found
[   17.249930] SUPR0GipMap: fGetGipCpu=0xb
[   20.494736] vboxdrv: 000000003578d9f3 VMMR0.r0
[   20.910688] vboxdrv: 000000001208b0e7 VBoxDDR0.r0
[   20.944982] VBoxNetFlt: attached to 'eth0' / 00:19:99:ab:0b:38
[   20.966411] vboxpci: created IOMMU domain 00000000b7a309ce
[   20.968955] vboxpci: created IOMMU domain 00000000ddb8b5a8
[   20.969557] vboxpci: created IOMMU domain 000000004d2d6c45
[   20.996022] vboxpci: created IOMMU domain 00000000f51fe837
[   21.012536] vboxdrv: 00000000ef35e632 VBoxEhciR0.r0
[   24.927778] vboxpci: created IOMMU domain 00000000de9efd67
[   27.857259] device eth0 entered promiscuous mode
[   28.597515] vboxpci: created IOMMU domain 000000005c1cff53
[   29.422962] vboxpci: created IOMMU domain 0000000047538b73
[   33.414501] vboxpci: created IOMMU domain 00000000c887c04f
[   33.552714] vboxpci: created IOMMU domain 00000000233d8290
[   42.002817] vboxpci: created IOMMU domain 000000006366e8ae
[   42.256600] vboxpci: created IOMMU domain 00000000b0159a37
[   43.999946] vboxpci: created IOMMU domain 00000000d57e5c28
[53264.665564] hrtimer: interrupt took 7220 ns
[226277.797573] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <2>
                  TDH                  <de>
                  TDT                  <de>
                  next_to_use          <e0>
                  next_to_clean        <de>
                buffer_info[next_to_clean]
                  time_stamp           <10d782971>
                  next_to_watch        <0000000095a05ad2>
                  jiffies              <10d783141>
                  desc.status          <238220>
[226279.780541] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <2>
                  TDH                  <de>
                  TDT                  <de>
                  next_to_use          <e0>
                  next_to_clean        <de>
                buffer_info[next_to_clean]
                  time_stamp           <10d782971>
                  next_to_watch        <0000000095a05ad2>
                  jiffies              <10d783900>
                  desc.status          <238220>
[226281.764513] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <2>
                  TDH                  <de>
                  TDT                  <de>
                  next_to_use          <e0>
                  next_to_clean        <de>
                buffer_info[next_to_clean]
                  time_stamp           <10d782971>
                  next_to_watch        <0000000095a05ad2>
                  jiffies              <10d7840c0>
                  desc.status          <238220>
[226283.749485] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <2>
                  TDH                  <de>
                  TDT                  <de>
                  next_to_use          <e0>
                  next_to_clean        <de>
                buffer_info[next_to_clean]
                  time_stamp           <10d782971>
                  next_to_watch        <0000000095a05ad2>
                  jiffies              <10d784881>
                  desc.status          <238220>
[226285.156354] ------------[ cut here ]------------
[226285.156359] NETDEV WATCHDOG: eth0 (igb): transmit queue 2 timed out
[226285.156381] WARNING: CPU: 10 PID: 0 at net/sched/sch_generic.c:461 dev_watchdog+0x1d9/0x1e0
[226285.156382] Modules linked in: vboxpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(O) uhci_hcd igb ehci_pci ptp ehci_hcd 8250 evdev pps_core button 8250_base usbcore i2c_i801 i2c_algo_bit serial_core usb_common i2c_core loop
[226285.156399] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G          IO      4.18.0-rc6 #1
[226285.156400] Hardware name: FUJITSU                          PRIMERGY RX300 S6             /D2619, BIOS 6.00 Rev. 1.13.2619.N1           01/19/2012
[226285.156403] RIP: 0010:dev_watchdog+0x1d9/0x1e0
[226285.156404] Code: 00 48 63 4d f0 eb 97 4c 89 e7 c6 05 ca e3 83 00 01 e8 ab eb fd ff 89 d9 4c 89 e6 48 c7 c7 c0 48 b3 81 48 89 c2 e8 97 22 c3 ff <0f> 0b eb c0 0f 1f 00 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 00 
[226285.156437] RSP: 0018:ffff880fff283ec8 EFLAGS: 00010286
[226285.156439] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000006
[226285.156440] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff880fff294ff0
[226285.156441] RBP: ffff880ff11903b0 R08: 0000000000000001 R09: 000000000000036c
[226285.156443] R10: ffffffff81c05100 R11: 000000000000036c R12: ffff880ff1190000
[226285.156444] R13: 000000000000000a R14: 0000000000000202 R15: ffffffff81c05108
[226285.156446] FS:  0000000000000000(0000) GS:ffff880fff280000(0000) knlGS:0000000000000000
[226285.156447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[226285.156448] CR2: 0000000000310c00 CR3: 0000000001c0a003 CR4: 00000000000226a0
[226285.156449] Call Trace:
[226285.156452]  <IRQ>
[226285.156456]  ? qdisc_reset+0xe0/0xe0
[226285.156460]  call_timer_fn+0x13/0x80
[226285.156462]  expire_timers+0x70/0x80
[226285.156464]  run_timer_softirq+0x7e/0x150
[226285.156467]  ? __hrtimer_run_queues+0x130/0x190
[226285.156471]  ? recalibrate_cpu_khz+0x10/0x10
[226285.156474]  ? ktime_get+0x33/0x90
[226285.156477]  ? default_inquire_remote_apic+0x10/0x10
[226285.156481]  ? lapic_next_event+0x17/0x20
[226285.156485]  __do_softirq+0xd4/0x1c9
[226285.156488]  irq_exit+0xa7/0xb0
[226285.156490]  smp_apic_timer_interrupt+0x59/0x90
[226285.156492]  apic_timer_interrupt+0xf/0x20
[226285.156493]  </IRQ>
[226285.156496] RIP: 0010:acpi_idle_do_entry+0x2b/0x40
[226285.156496] Code: b6 47 08 3c 01 74 25 3c 02 74 0d 8b 57 04 ec 48 8b 15 fd 8f ac 00 ed c3 65 48 8b 04 25 40 4c 01 00 48 8b 00 a8 08 75 ef fb f4 <fa> c3 e9 ae fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 
[226285.156522] RSP: 0018:ffffc900000cbe48 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[226285.156524] RAX: 0000000080000000 RBX: ffff880ff83bf400 RCX: 0000000000000034
[226285.156525] RDX: 4ec4ec4ec4ec4ec5 RSI: ffffffff81c386e0 RDI: ffff880ff83bf464
[226285.156526] RBP: ffff880ff83bf464 R08: ffff880fff29e1c8 R09: 0000000000000008
[226285.156527] R10: 0000000000000003 R11: 0000000000000009 R12: 0000000000000001
[226285.156528] R13: 0000000000000001 R14: 0000000000000001 R15: ffff880ff8c9de80
[226285.156532]  acpi_idle_enter+0x8d/0x250
[226285.156536]  ? menu_select+0x399/0x550
[226285.156537]  cpuidle_enter_state+0xff/0x200
[226285.156541]  do_idle+0x113/0x200
[226285.156543]  cpu_startup_entry+0x6a/0x70
[226285.156545]  start_secondary+0x183/0x1b0
[226285.156547]  secondary_startup_64+0xa5/0xb0
[226285.156549] ---[ end trace 66fae9a7fe07d63b ]---
[226285.156564] igb 0000:08:00.0 eth0: Reset adapter
[226288.173886] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
