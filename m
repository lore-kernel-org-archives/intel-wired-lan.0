From: Marco Berizzi <pupilla@libero.it>
Date: Mon, 6 Aug 2018 13:39:47 +0200 (CEST)
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <117857591.886490.1532956286262@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
 <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
 <1265852288.743881.1532617415845@mail.libero.it>
 <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
 <1312873949.790150.1532681266921@mail.libero.it>
 <117857591.886490.1532956286262@mail.libero.it>
Message-ID: <403709248.209641.1533555587417@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Il 30 luglio 2018 alle 15.11 Marco Berizzi <pupilla@libero.it> ha scritto:
> 
> > Il 27 luglio 2018 alle 10.47 Marco Berizzi <pupilla@libero.it> ha scritto:
> > 
> > Should I disable the TSO? Or should I set all my linux boxes MTU to 1500?
> 
> Hello everyone,
> 
> One hour ago I upgraded to linux 4.18-rc7 and I set the MTU=1500
> 
> I will keep you updated.

After 6 days uptime I got the same error message with MTU=1500.
Now I will upgrade to 4.18-rc8 with MTU=1500 and I will disable
the tso with the following command: ethtool -K eth0 tso off

[    0.000000] Linux version 4.18.0-rc7 (root at Kaa) (gcc version 5.5.0 (GCC)) #1 SMP Mon Jul 30 11:06:16 CEST 2018
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
[    0.006000] tsc: Detected 2399.929 MHz processor
[    0.007000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2297f48f5eb, max_idle_ns: 440795257017 ns
[    0.007000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4799.85 BogoMIPS (lpj=2399929)
[    0.007000] pid_max: default: 32768 minimum: 301
[    0.007000] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.008228] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.008494] CPU: Physical Processor ID: 0
[    0.008588] CPU: Processor Core ID: 0
[    0.008688] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.008788] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.008894] process: using mwait in idle threads
[    0.008991] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.009001] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.009103] Spectre V2 : Mitigation: Full generic retpoline
[    0.009202] Speculative Store Bypass: Vulnerable
[    0.009373] Freeing SMP alternatives memory: 20K
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
[    0.011532] smp: Bringing up secondary CPUs ...
[    0.011698] x86: Booting SMP configuration:
[    0.011793] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.113045] smp: Brought up 1 node, 24 CPUs
[    0.113248] smpboot: Max logical packages: 2
[    0.113343] smpboot: Total of 24 processors activated (115196.64 BogoMIPS)
[    0.116417] devtmpfs: initialized
[    0.116417] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.116417] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    0.117124] xor: measuring software checksum speed
[    0.127002]    prefetch64-sse: 12920.000 MB/sec
[    0.137001]    generic_sse: 10992.000 MB/sec
[    0.137095] xor: using function: prefetch64-sse (12920.000 MB/sec)
[    0.138756] NET: Registered protocol family 16
[    0.139043] cpuidle: using governor ladder
[    0.139109] cpuidle: using governor menu
[    0.139117] Simple Boot Flag at 0x7c set to 0x1
[    0.139221] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.139326] ACPI: bus type PCI registered
[    0.139430] PCI: MMCONFIG for domain 0000 [bus 00-0a] at [mem 0xe0000000-0xe0afffff] (base 0xe0000000)
[    0.139568] PCI: MMCONFIG at [mem 0xe0000000-0xe0afffff] reserved in E820
[    0.139677] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a huge-page mapping due to MTRR override.
[    0.140017] PCI: Using configuration type 1 for base access
[    0.158004] raid6: sse2x1   gen()  5929 MB/s
[    0.175002] raid6: sse2x1   xor()  4658 MB/s
[    0.192009] raid6: sse2x2   gen()  6988 MB/s
[    0.209002] raid6: sse2x2   xor()  5521 MB/s
[    0.226008] raid6: sse2x4   gen()  7851 MB/s
[    0.243003] raid6: sse2x4   xor()  6201 MB/s
[    0.243098] raid6: using algorithm sse2x4 gen() 7851 MB/s
[    0.243196] raid6: .... xor() 6201 MB/s, rmw enabled
[    0.243293] raid6: using ssse3x2 recovery algorithm
[    0.243459] ACPI: Added _OSI(Module Device)
[    0.243554] ACPI: Added _OSI(Processor Device)
[    0.243649] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.243745] ACPI: Added _OSI(Processor Aggregator Device)
[    0.243843] ACPI: Added _OSI(Linux-Dell-Video)
[    0.248396] ACPI: 50 ACPI AML tables successfully acquired and loaded
[    0.262849] ACPI: Interpreter enabled
[    0.262947] ACPI: (supports S0 S5)
[    0.263002] ACPI: Using IOAPIC for interrupt routing
[    0.263122] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.263390] ACPI: Enabled 10 GPEs in block 00 to 3F
[    0.267431] ACPI: PCI Root Bridge [CPU0] (domain 0000 [bus ff])
[    0.267536] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.267646] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.267750] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.268009] PCI host bridge to bus 0000:ff
[    0.268009] pci_bus 0000:ff: root bus resource [bus ff]
[    0.268108] pci 0000:ff:00.0: [8086:2c70] type 00 class 0x060000
[    0.268156] pci 0000:ff:00.1: [8086:2d81] type 00 class 0x060000
[    0.268200] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000
[    0.268238] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000
[    0.268276] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000
[    0.268314] pci 0000:ff:02.3: [8086:2d93] type 00 class 0x060000
[    0.268352] pci 0000:ff:02.4: [8086:2d94] type 00 class 0x060000
[    0.268390] pci 0000:ff:02.5: [8086:2d95] type 00 class 0x060000
[    0.269014] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
[    0.269014] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000
[    0.269014] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000
[    0.269014] pci 0000:ff:03.4: [8086:2d9c] type 00 class 0x060000
[    0.269014] pci 0000:ff:04.0: [8086:2da0] type 00 class 0x060000
[    0.269014] pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000
[    0.269014] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000
[    0.269014] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000
[    0.269014] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060000
[    0.269014] pci 0000:ff:05.1: [8086:2da9] type 00 class 0x060000
[    0.269014] pci 0000:ff:05.2: [8086:2daa] type 00 class 0x060000
[    0.269014] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000
[    0.269014] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000
[    0.269014] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000
[    0.269014] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x060000
[    0.269028] pci 0000:ff:06.3: [8086:2db3] type 00 class 0x060000
[    0.269077] pci_bus 0000:ff: on NUMA node 0
[    0.269097] ACPI: PCI Root Bridge [CPU1] (domain 0000 [bus fe])
[    0.269199] acpi PNP0A03:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.269310] acpi PNP0A03:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.269414] acpi PNP0A03:01: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.270000] PCI host bridge to bus 0000:fe
[    0.270000] pci_bus 0000:fe: root bus resource [bus fe]
[    0.270000] pci 0000:fe:00.0: [8086:2c70] type 00 class 0x060000
[    0.270009] pci 0000:fe:00.1: [8086:2d81] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.0: [8086:2d90] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.1: [8086:2d91] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.2: [8086:2d92] type 00 class 0x060000
[    0.270009] pci 0000:fe:02.3: [8086:2d93] type 00 class 0x060000
[    0.270038] pci 0000:fe:02.4: [8086:2d94] type 00 class 0x060000
[    0.270079] pci 0000:fe:02.5: [8086:2d95] type 00 class 0x060000
[    0.270121] pci 0000:fe:03.0: [8086:2d98] type 00 class 0x060000
[    0.270162] pci 0000:fe:03.1: [8086:2d99] type 00 class 0x060000
[    0.270202] pci 0000:fe:03.2: [8086:2d9a] type 00 class 0x060000
[    0.270243] pci 0000:fe:03.4: [8086:2d9c] type 00 class 0x060000
[    0.270285] pci 0000:fe:04.0: [8086:2da0] type 00 class 0x060000
[    0.270327] pci 0000:fe:04.1: [8086:2da1] type 00 class 0x060000
[    0.270368] pci 0000:fe:04.2: [8086:2da2] type 00 class 0x060000
[    0.270409] pci 0000:fe:04.3: [8086:2da3] type 00 class 0x060000
[    0.271009] pci 0000:fe:05.0: [8086:2da8] type 00 class 0x060000
[    0.271009] pci 0000:fe:05.1: [8086:2da9] type 00 class 0x060000
[    0.271009] pci 0000:fe:05.2: [8086:2daa] type 00 class 0x060000
[    0.271009] pci 0000:fe:05.3: [8086:2dab] type 00 class 0x060000
[    0.271009] pci 0000:fe:06.0: [8086:2db0] type 00 class 0x060000
[    0.271010] pci 0000:fe:06.1: [8086:2db1] type 00 class 0x060000
[    0.271010] pci 0000:fe:06.2: [8086:2db2] type 00 class 0x060000
[    0.271010] pci 0000:fe:06.3: [8086:2db3] type 00 class 0x060000
[    0.271010] pci_bus 0000:fe: on NUMA node 0
[    0.271010] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3d])
[    0.271010] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.271010] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.271109] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-0a] only partially covers this bridge
[    0.271318] PCI host bridge to bus 0000:00
[    0.271414] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.271517] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.271620] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.271726] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000dffff window]
[    0.271832] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff window]
[    0.272002] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfebfffff window]
[    0.272108] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfedfffff window]
[    0.272213] pci_bus 0000:00: root bus resource [mem 0xfef00000-0xffbfffff window]
[    0.272319] pci_bus 0000:00: root bus resource [bus 00-3d]
[    0.272428] pci 0000:00:00.0: [8086:3406] type 00 class 0x060000
[    0.272459] pci 0000:00:00.0: enabling Extended Tags
[    0.272586] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.273000] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    0.273000] pci 0000:00:01.0: enabling Extended Tags
[    0.273000] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.273010] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    0.273010] pci 0000:00:03.0: enabling Extended Tags
[    0.273035] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.273113] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
[    0.273140] pci 0000:00:05.0: enabling Extended Tags
[    0.273269] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.273345] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    0.273374] pci 0000:00:07.0: enabling Extended Tags
[    0.273505] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.274000] pci 0000:00:08.0: [8086:340f] type 01 class 0x060400
[    0.274000] pci 0000:00:08.0: enabling Extended Tags
[    0.274000] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
[    0.274009] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    0.274009] pci 0000:00:09.0: enabling Extended Tags
[    0.274015] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.274093] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
[    0.274120] pci 0000:00:0a.0: enabling Extended Tags
[    0.274249] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.274325] pci 0000:00:10.0: [8086:3425] type 00 class 0x080000
[    0.274424] pci 0000:00:10.1: [8086:3426] type 00 class 0x080000
[    0.275009] pci 0000:00:11.0: [8086:3427] type 00 class 0x080000
[    0.275009] pci 0000:00:11.1: [8086:3428] type 00 class 0x080000
[    0.275010] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    0.275013] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    0.275013] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    0.275035] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    0.275125] pci 0000:00:15.0: [8086:342f] type 00 class 0x080020
[    0.275221] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    0.275264] pci 0000:00:1a.0: reg 0x20: [io  0x1820-0x183f]
[    0.275359] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    0.275402] pci 0000:00:1a.1: reg 0x20: [io  0x1840-0x185f]
[    0.275499] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    0.275541] pci 0000:00:1a.2: reg 0x20: [io  0x1860-0x187f]
[    0.276010] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    0.276010] pci 0000:00:1a.7: reg 0x10: [mem 0xce000000-0xce0003ff]
[    0.276010] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.276010] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    0.276010] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.276010] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    0.276040] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.276118] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    0.276160] pci 0000:00:1d.0: reg 0x20: [io  0x1880-0x189f]
[    0.276257] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    0.276299] pci 0000:00:1d.1: reg 0x20: [io  0x18a0-0x18bf]
[    0.276395] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    0.276438] pci 0000:00:1d.2: reg 0x20: [io  0x18c0-0x18df]
[    0.277009] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    0.277009] pci 0000:00:1d.7: reg 0x10: [mem 0xce001000-0xce0013ff]
[    0.277009] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.277012] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.277012] pci 0000:00:1f.0: [8086:3a18] type 00 class 0x060100
[    0.277012] pci 0000:00:1f.2: [8086:3a20] type 00 class 0x01018f
[    0.277012] pci 0000:00:1f.2: reg 0x10: [io  0x1c50-0x1c57]
[    0.277012] pci 0000:00:1f.2: reg 0x14: [io  0x1c44-0x1c47]
[    0.277012] pci 0000:00:1f.2: reg 0x18: [io  0x1c48-0x1c4f]
[    0.277019] pci 0000:00:1f.2: reg 0x1c: [io  0x1c40-0x1c43]
[    0.277026] pci 0000:00:1f.2: reg 0x20: [io  0x1c10-0x1c1f]
[    0.277033] pci 0000:00:1f.2: reg 0x24: [io  0x1c00-0x1c0f]
[    0.277129] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    0.277146] pci 0000:00:1f.3: reg 0x10: [mem 0xce002000-0xce0020ff 64bit]
[    0.277165] pci 0000:00:1f.3: reg 0x20: [io  0x18e0-0x18ff]
[    0.277245] pci 0000:00:1f.5: [8086:3a26] type 00 class 0x010185
[    0.277261] pci 0000:00:1f.5: reg 0x10: [io  0x1c68-0x1c6f]
[    0.277268] pci 0000:00:1f.5: reg 0x14: [io  0x1c5c-0x1c5f]
[    0.277275] pci 0000:00:1f.5: reg 0x18: [io  0x1c60-0x1c67]
[    0.277282] pci 0000:00:1f.5: reg 0x1c: [io  0x1c58-0x1c5b]
[    0.277289] pci 0000:00:1f.5: reg 0x20: [io  0x1c30-0x1c3f]
[    0.277296] pci 0000:00:1f.5: reg 0x24: [io  0x1c20-0x1c2f]
[    0.277420] pci 0000:01:00.0: [1000:0079] type 00 class 0x010400
[    0.277435] pci 0000:01:00.0: reg 0x10: [io  0x2000-0x20ff]
[    0.277444] pci 0000:01:00.0: reg 0x14: [mem 0xce100000-0xce103fff 64bit]
[    0.277454] pci 0000:01:00.0: reg 0x1c: [mem 0xce180000-0xce1bffff 64bit]
[    0.277466] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.277472] pci 0000:01:00.0: enabling Extended Tags
[    0.277604] pci 0000:01:00.0: supports D1 D2
[    0.278011] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.278011] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.278011] pci 0000:00:01.0:   bridge window [mem 0xce100000-0xce1fffff]
[    0.278011] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.278011] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.278036] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.278165] pci 0000:00:08.0: PCI bridge to [bus 05]
[    0.278295] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.278427] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.279013] pci 0000:08:00.0: [8086:10a7] type 00 class 0x020000
[    0.279013] pci 0000:08:00.0: reg 0x10: [mem 0xce260000-0xce27ffff]
[    0.279013] pci 0000:08:00.0: reg 0x14: [mem 0xce240000-0xce25ffff]
[    0.279013] pci 0000:08:00.0: reg 0x18: [io  0x3000-0x301f]
[    0.279013] pci 0000:08:00.0: reg 0x1c: [mem 0xce200000-0xce203fff]
[    0.279013] pci 0000:08:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.279013] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    0.279013] pci 0000:08:00.1: [8086:10a7] type 00 class 0x020000
[    0.279013] pci 0000:08:00.1: reg 0x10: [mem 0xce2c0000-0xce2dffff]
[    0.279013] pci 0000:08:00.1: reg 0x14: [mem 0xce2a0000-0xce2bffff]
[    0.279013] pci 0000:08:00.1: reg 0x18: [io  0x3020-0x303f]
[    0.279013] pci 0000:08:00.1: reg 0x1c: [mem 0xce204000-0xce207fff]
[    0.279013] pci 0000:08:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.279013] pci 0000:08:00.1: PME# supported from D0 D3hot D3cold
[    0.279069] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    0.279169] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.279172] pci 0000:00:1c.0:   bridge window [mem 0xce200000-0xce2fffff]
[    0.279227] pci 0000:09:00.0: [102b:0522] type 00 class 0x030000
[    0.279258] pci 0000:09:00.0: reg 0x10: [mem 0xcf000000-0xcfffffff pref]
[    0.279272] pci 0000:09:00.0: reg 0x14: [mem 0xce300000-0xce303fff]
[    0.279286] pci 0000:09:00.0: reg 0x18: [mem 0xce800000-0xceffffff]
[    0.279483] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    0.279584] pci 0000:00:1c.4:   bridge window [mem 0xce300000-0xceffffff]
[    0.279589] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.279606] pci_bus 0000:0a: extended config space not accessible
[    0.280009] pci 0000:00:1e.0: PCI bridge to [bus 0a] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [mem 0x000c8000-0x000dffff window] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff window] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfebfffff window] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [mem 0xfed00000-0xfedfffff window] (subtractive decode)
[    0.280009] pci 0000:00:1e.0:   bridge window [mem 0xfef00000-0xffbfffff window] (subtractive decode)
[    0.280009] pci_bus 0000:00: on NUMA node 0
[    0.280087] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.280246] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.280404] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.280564] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.280715] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.280877] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.281038] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.281196] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.282032] pci 0000:09:00.0: vgaarb: setting as boot VGA device
[    0.283000] pci 0000:09:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.283005] pci 0000:09:00.0: vgaarb: bridge control possible
[    0.283104] vgaarb: loaded
[    0.284038] SCSI subsystem initialized
[    0.284038] PCI: Using ACPI for IRQ routing
[    0.284038] PCI: pci_cache_line_size set to 64 bytes
[    0.284038] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    0.284038] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
[    0.284038] e820: reserve RAM buffer [mem 0xbf6a0000-0xbfffffff]
[    0.284137] clocksource: Switched to clocksource tsc-early
[    0.284170] pnp: PnP ACPI init
[    0.284382] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.284490] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.284791] system 00:01: [io  0x0200-0x020f] has been reserved
[    0.284892] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.284993] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.285095] system 00:01: [io  0x0800-0x080f] has been reserved
[    0.285195] system 00:01: [io  0x0810-0x081f] has been reserved
[    0.285296] system 00:01: [io  0x0ca0-0x0ca1] has been reserved
[    0.285396] system 00:01: [io  0x0ca4-0x0ca7] has been reserved
[    0.285497] system 00:01: [io  0x0ca8-0x0cab] has been reserved
[    0.285601] system 00:01: [io  0x0cae-0x0caf] has been reserved
[    0.285702] system 00:01: [io  0x0e00-0x0e7f] has been reserved
[    0.285802] system 00:01: [io  0x1000-0x107f] has been reserved
[    0.285903] system 00:01: [io  0x1100-0x110f] has been reserved
[    0.286004] system 00:01: [io  0x1180-0x11ff] has been reserved
[    0.286104] system 00:01: [io  0xfe00] has been reserved
[    0.286203] system 00:01: [io  0xff00] has been reserved
[    0.286302] system 00:01: [mem 0xfec00000-0xfecfffff] could not be reserved
[    0.286406] system 00:01: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.286511] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.286620] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.286653] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.286854] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.286998] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.287051] pnp: PnP ACPI: found 5 devices
[    0.292635] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.292821] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 08] add_size 200000 add_align 100000
[    0.292829] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
[    0.292850] pci 0000:00:1c.0: BAR 9: assigned [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.292958] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0x4fff]
[    0.293060] pci 0000:01:00.0: BAR 6: assigned [mem 0xce140000-0xce17ffff pref]
[    0.293166] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.293263] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.293367] pci 0000:00:01.0:   bridge window [mem 0xce100000-0xce1fffff]
[    0.293474] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.293579] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.293682] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.293785] pci 0000:00:08.0: PCI bridge to [bus 05]
[    0.293887] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.293990] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.294095] pci 0000:08:00.0: BAR 6: assigned [mem 0xce220000-0xce23ffff pref]
[    0.294200] pci 0000:08:00.1: BAR 6: assigned [mem 0xce280000-0xce29ffff pref]
[    0.294305] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    0.294402] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.294506] pci 0000:00:1c.0:   bridge window [mem 0xce200000-0xce2fffff]
[    0.294612] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.294721] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    0.294819] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.294922] pci 0000:00:1c.4:   bridge window [mem 0xce300000-0xceffffff]
[    0.295028] pci 0000:00:1c.4:   bridge window [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.295137] pci 0000:00:1e.0: PCI bridge to [bus 0a]
[    0.295242] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.295244] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.295245] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.295247] pci_bus 0000:00: resource 7 [mem 0x000c8000-0x000dffff window]
[    0.295248] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff window]
[    0.295250] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfebfffff window]
[    0.295251] pci_bus 0000:00: resource 10 [mem 0xfed00000-0xfedfffff window]
[    0.295253] pci_bus 0000:00: resource 11 [mem 0xfef00000-0xffbfffff window]
[    0.295254] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.295256] pci_bus 0000:01: resource 1 [mem 0xce100000-0xce1fffff]
[    0.295258] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.295259] pci_bus 0000:08: resource 1 [mem 0xce200000-0xce2fffff]
[    0.295261] pci_bus 0000:08: resource 2 [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.295262] pci_bus 0000:09: resource 0 [io  0x4000-0x4fff]
[    0.295264] pci_bus 0000:09: resource 1 [mem 0xce300000-0xceffffff]
[    0.295265] pci_bus 0000:09: resource 2 [mem 0xcf000000-0xcfffffff 64bit pref]
[    0.295267] pci_bus 0000:0a: resource 4 [io  0x0000-0x0cf7 window]
[    0.295269] pci_bus 0000:0a: resource 5 [io  0x0d00-0xffff window]
[    0.295270] pci_bus 0000:0a: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.295272] pci_bus 0000:0a: resource 7 [mem 0x000c8000-0x000dffff window]
[    0.295273] pci_bus 0000:0a: resource 8 [mem 0xc0000000-0xdfffffff window]
[    0.295275] pci_bus 0000:0a: resource 9 [mem 0xf0000000-0xfebfffff window]
[    0.295276] pci_bus 0000:0a: resource 10 [mem 0xfed00000-0xfedfffff window]
[    0.295278] pci_bus 0000:0a: resource 11 [mem 0xfef00000-0xffbfffff window]
[    0.295342] NET: Registered protocol family 2
[    0.295559] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes)
[    0.295787] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.296867] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.297204] TCP: Hash tables configured (established 524288 bind 65536)
[    0.297380] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.297736] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.298159] NET: Registered protocol family 1
[    0.301277] pci 0000:08:00.0: Disabling L0s
[    0.301373] pci 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM control
[    0.301480] pci 0000:08:00.1: Disabling L0s
[    0.301577] pci 0000:08:00.1: can't disable ASPM; OS doesn't have ASPM control
[    0.301693] pci 0000:09:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.301803] PCI: CLS 64 bytes, default 64
[    0.301830] DMAR: Host address width 40
[    0.301924] DMAR: DRHD base: 0x000000fed14000 flags: 0x1
[    0.302029] DMAR: dmar0: reg_base_addr fed14000 ver 1:0 cap c90780106f0462 ecap f02076
[    0.302136] DMAR: RMRR base: 0x000000bf6d0000 end: 0x000000bf6e7fff
[    0.302237] DMAR: RMRR base: 0x000000bf6f0000 end: 0x000000bf6f0fff
[    0.302338] DMAR: RMRR base: 0x000000bf6f1000 end: 0x000000bf6f1fff
[    0.302439] DMAR: RMRR base: 0x000000bf6f2000 end: 0x000000bf6f2fff
[    0.302540] DMAR: RMRR base: 0x000000bf6fa000 end: 0x000000bf6fafff
[    0.302644] DMAR: RMRR base: 0x000000bf6f3000 end: 0x000000bf6f3fff
[    0.302744] DMAR: RMRR base: 0x000000bf6f4000 end: 0x000000bf6f4fff
[    0.302845] DMAR: RMRR base: 0x000000bf6f5000 end: 0x000000bf6f5fff
[    0.302946] DMAR: RMRR base: 0x000000bf6fb000 end: 0x000000bf6fbfff
[    0.303048] DMAR: ATSR flags: 0x0
[    0.303367] DMAR: dmar0: Using Queued invalidation
[    0.303481] DMAR: Setting RMRR:
[    0.303847] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf6fb000 - 0xbf6fbfff]
[    0.304325] DMAR: Setting identity map for device 0000:00:1d.2 [0xbf6f5000 - 0xbf6f5fff]
[    0.304637] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf6f4000 - 0xbf6f4fff]
[    0.304949] DMAR: Setting identity map for device 0000:00:1d.0 [0xbf6f3000 - 0xbf6f3fff]
[    0.305268] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf6fa000 - 0xbf6fafff]
[    0.305581] DMAR: Setting identity map for device 0000:00:1a.2 [0xbf6f2000 - 0xbf6f2fff]
[    0.305897] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf6f1000 - 0xbf6f1fff]
[    0.306216] DMAR: Setting identity map for device 0000:00:1a.0 [0xbf6f0000 - 0xbf6f0fff]
[    0.306345] DMAR: Setting identity map for device 0000:00:1a.0 [0xbf6d0000 - 0xbf6e7fff]
[    0.306453] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf6d0000 - 0xbf6e7fff]
[    0.306562] DMAR: Setting identity map for device 0000:00:1a.2 [0xbf6d0000 - 0xbf6e7fff]
[    0.306670] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf6d0000 - 0xbf6e7fff]
[    0.306778] DMAR: Setting identity map for device 0000:00:1d.0 [0xbf6d0000 - 0xbf6e7fff]
[    0.306886] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf6d0000 - 0xbf6e7fff]
[    0.306995] DMAR: Setting identity map for device 0000:00:1d.2 [0xbf6d0000 - 0xbf6e7fff]
[    0.307103] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf6d0000 - 0xbf6e7fff]
[    0.307221] DMAR: Prepare 0-16MiB unity mapping for LPC
[    0.307517] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    0.307798] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.307975] iommu: Adding device 0000:ff:00.0 to group 0
[    0.308088] iommu: Adding device 0000:ff:00.1 to group 0
[    0.308257] iommu: Adding device 0000:ff:02.0 to group 1
[    0.308367] iommu: Adding device 0000:ff:02.1 to group 1
[    0.308478] iommu: Adding device 0000:ff:02.2 to group 1
[    0.308588] iommu: Adding device 0000:ff:02.3 to group 1
[    0.308698] iommu: Adding device 0000:ff:02.4 to group 1
[    0.308808] iommu: Adding device 0000:ff:02.5 to group 1
[    0.308956] iommu: Adding device 0000:ff:03.0 to group 2
[    0.309067] iommu: Adding device 0000:ff:03.1 to group 2
[    0.309177] iommu: Adding device 0000:ff:03.2 to group 2
[    0.309290] iommu: Adding device 0000:ff:03.4 to group 2
[    0.309437] iommu: Adding device 0000:ff:04.0 to group 3
[    0.309548] iommu: Adding device 0000:ff:04.1 to group 3
[    0.309660] iommu: Adding device 0000:ff:04.2 to group 3
[    0.309771] iommu: Adding device 0000:ff:04.3 to group 3
[    0.309918] iommu: Adding device 0000:ff:05.0 to group 4
[    0.310030] iommu: Adding device 0000:ff:05.1 to group 4
[    0.310142] iommu: Adding device 0000:ff:05.2 to group 4
[    0.310256] iommu: Adding device 0000:ff:05.3 to group 4
[    0.310404] iommu: Adding device 0000:ff:06.0 to group 5
[    0.310516] iommu: Adding device 0000:ff:06.1 to group 5
[    0.310628] iommu: Adding device 0000:ff:06.2 to group 5
[    0.310740] iommu: Adding device 0000:ff:06.3 to group 5
[    0.310869] iommu: Adding device 0000:fe:00.0 to group 6
[    0.310982] iommu: Adding device 0000:fe:00.1 to group 6
[    0.311149] iommu: Adding device 0000:fe:02.0 to group 7
[    0.311264] iommu: Adding device 0000:fe:02.1 to group 7
[    0.311377] iommu: Adding device 0000:fe:02.2 to group 7
[    0.311490] iommu: Adding device 0000:fe:02.3 to group 7
[    0.311602] iommu: Adding device 0000:fe:02.4 to group 7
[    0.311714] iommu: Adding device 0000:fe:02.5 to group 7
[    0.311861] iommu: Adding device 0000:fe:03.0 to group 8
[    0.311975] iommu: Adding device 0000:fe:03.1 to group 8
[    0.312088] iommu: Adding device 0000:fe:03.2 to group 8
[    0.312201] iommu: Adding device 0000:fe:03.4 to group 8
[    0.312351] iommu: Adding device 0000:fe:04.0 to group 9
[    0.312465] iommu: Adding device 0000:fe:04.1 to group 9
[    0.312578] iommu: Adding device 0000:fe:04.2 to group 9
[    0.312693] iommu: Adding device 0000:fe:04.3 to group 9
[    0.312840] iommu: Adding device 0000:fe:05.0 to group 10
[    0.312955] iommu: Adding device 0000:fe:05.1 to group 10
[    0.313070] iommu: Adding device 0000:fe:05.2 to group 10
[    0.313185] iommu: Adding device 0000:fe:05.3 to group 10
[    0.313334] iommu: Adding device 0000:fe:06.0 to group 11
[    0.313452] iommu: Adding device 0000:fe:06.1 to group 11
[    0.313567] iommu: Adding device 0000:fe:06.2 to group 11
[    0.313682] iommu: Adding device 0000:fe:06.3 to group 11
[    0.313794] iommu: Adding device 0000:00:00.0 to group 12
[    0.313905] iommu: Adding device 0000:00:01.0 to group 13
[    0.314018] iommu: Adding device 0000:00:03.0 to group 14
[    0.314131] iommu: Adding device 0000:00:05.0 to group 15
[    0.314246] iommu: Adding device 0000:00:07.0 to group 16
[    0.314357] iommu: Adding device 0000:00:08.0 to group 17
[    0.314469] iommu: Adding device 0000:00:09.0 to group 18
[    0.314582] iommu: Adding device 0000:00:0a.0 to group 19
[    0.314712] iommu: Adding device 0000:00:10.0 to group 20
[    0.314829] iommu: Adding device 0000:00:10.1 to group 20
[    0.314959] iommu: Adding device 0000:00:11.0 to group 21
[    0.315076] iommu: Adding device 0000:00:11.1 to group 21
[    0.315230] iommu: Adding device 0000:00:14.0 to group 22
[    0.315348] iommu: Adding device 0000:00:14.1 to group 22
[    0.315466] iommu: Adding device 0000:00:14.2 to group 22
[    0.315583] iommu: Adding device 0000:00:14.3 to group 22
[    0.315703] iommu: Adding device 0000:00:15.0 to group 23
[    0.315851] iommu: Adding device 0000:00:1a.0 to group 24
[    0.315969] iommu: Adding device 0000:00:1a.1 to group 24
[    0.316087] iommu: Adding device 0000:00:1a.2 to group 24
[    0.316204] iommu: Adding device 0000:00:1a.7 to group 24
[    0.316340] iommu: Adding device 0000:00:1c.0 to group 25
[    0.316461] iommu: Adding device 0000:00:1c.4 to group 25
[    0.316609] iommu: Adding device 0000:00:1d.0 to group 26
[    0.316727] iommu: Adding device 0000:00:1d.1 to group 26
[    0.316845] iommu: Adding device 0000:00:1d.2 to group 26
[    0.316963] iommu: Adding device 0000:00:1d.7 to group 26
[    0.317076] iommu: Adding device 0000:00:1e.0 to group 27
[    0.317226] iommu: Adding device 0000:00:1f.0 to group 28
[    0.317345] iommu: Adding device 0000:00:1f.2 to group 28
[    0.317464] iommu: Adding device 0000:00:1f.3 to group 28
[    0.318817] iommu: Adding device 0000:00:1f.5 to group 28
[    0.318932] iommu: Adding device 0000:01:00.0 to group 29
[    0.319036] iommu: Adding device 0000:08:00.0 to group 25
[    0.319139] iommu: Adding device 0000:08:00.1 to group 25
[    0.319244] iommu: Adding device 0000:09:00.0 to group 25
[    0.321705] workingset: timestamp_bits=62 max_order=24 bucket_order=0
[    0.323431] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.323537] io scheduler noop registered
[    0.323630] io scheduler deadline registered
[    0.323769] io scheduler cfq registered (default)
[    0.323865] io scheduler mq-deadline registered
[    0.323961] io scheduler kyber registered
[    0.329026] megasas: 07.705.02.00-rc1
[    0.329270] megaraid_sas 0000:01:00.0: FW now in Ready state
[    0.329374] megaraid_sas 0000:01:00.0: 64 bit DMA mask and 32 bit consistent mask
[    0.329905] megaraid_sas 0000:01:00.0: firmware supports msix        : (0)
[    0.330010] megaraid_sas 0000:01:00.0: current msix/online cpus      : (1/24)
[    0.330115] megaraid_sas 0000:01:00.0: RDPQ mode     : (disabled)
[    0.419248] megaraid_sas 0000:01:00.0: controller type       : MR(512MB)
[    0.419360] megaraid_sas 0000:01:00.0: Online Controller Reset(OCR)  : Enabled
[    0.419471] megaraid_sas 0000:01:00.0: Secure JBOD support   : No
[    0.419577] megaraid_sas 0000:01:00.0: NVMe passthru support : No
[    0.419680] megaraid_sas 0000:01:00.0: megasas_init_mfi: fw_support_ieee=0
[    0.419797] megaraid_sas 0000:01:00.0: INIT adapter done
[    0.419901] megaraid_sas 0000:01:00.0: Jbod map is not supported megasas_setup_jbod_map 5128
[    0.464258] megaraid_sas 0000:01:00.0: pci id                : (0x1000)/(0x0079)/(0x1734)/(0x1176)
[    0.464374] megaraid_sas 0000:01:00.0: unevenspan support    : no
[    0.464482] megaraid_sas 0000:01:00.0: firmware crash dump   : no
[    0.464585] megaraid_sas 0000:01:00.0: jbod sync map         : no
[    0.464686] scsi host0: Avago SAS based MegaRAID driver
[    0.469948] scsi 0:2:0:0: Direct-Access     LSI      RAID 5/6 SAS 6G  2.90 PQ: 0 ANSI: 5
[    0.471114] scsi 0:2:1:0: Direct-Access     LSI      RAID 5/6 SAS 6G  2.90 PQ: 0 ANSI: 5
[    0.482332] rtc_cmos 00:02: RTC can wake from S4
[    0.482724] random: fast init done
[    0.482734] rtc_cmos 00:02: registered as rtc0
[    0.482930] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.482989] sd 0:2:0:0: [sda] 285671424 512-byte logical blocks: (146 GB/136 GiB)
[    0.483064] sd 0:2:1:0: [sdb] 1171062784 512-byte logical blocks: (600 GB/558 GiB)
[    0.483254] sd 0:2:0:0: [sda] Write Protect is off
[    0.483302] sd 0:2:1:0: [sdb] Write Protect is off
[    0.483371] sd 0:2:0:0: [sda] Mode Sense: 1f 00 10 08
[    0.483469] sd 0:2:1:0: [sdb] Mode Sense: 1f 00 10 08
[    0.483779] sd 0:2:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    0.483782] sd 0:2:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    0.483922] NET: Registered protocol family 17
[    0.484179] sched_clock: Marking stable (483853967, 0)->(655552400, -171698433)
[    0.484546] registered taskstats version 1
[    0.484615]  sdb: sdb1
[    0.484987] Btrfs loaded, crc32c=crc32c-generic
[    0.485062] sd 0:2:1:0: [sdb] Attached SCSI disk
[    0.485746] rtc_cmos 00:02: setting system clock to 2018-07-30 14:09:47 UTC (1532959787)
[    0.492262]  sda: sda1 sda2 sda3
[    0.493377] sd 0:2:0:0: [sda] Attached SCSI disk
[    0.501206] BTRFS: device fsid 473b3d83-48a1-4653-b073-5b55b600badd devid 1 transid 459686 /dev/root
[    0.502634] BTRFS info (device sda2): disk space caching is enabled
[    0.502756] BTRFS info (device sda2): has skinny extents
[    0.735104] VFS: Mounted root (btrfs filesystem) readonly on device 0:13.
[    0.739573] devtmpfs: mounted
[    0.742282] Freeing unused kernel memory: 780K
[    0.745915] Write protecting the kernel read-only data: 12288k
[    0.751546] Freeing unused kernel memory: 2020K
[    0.754978] Freeing unused kernel memory: 564K
[    1.206649] loop: module loaded
[    1.375143] tsc: Refined TSC clocksource calibration: 2400.085 MHz
[    1.376387] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229887d25b0, max_idle_ns: 440795264680 ns
[    1.377118] clocksource: Switched to clocksource tsc
[    1.463209] random: udevd: uninitialized urandom read (16 bytes read)
[    1.466347] random: udevd: uninitialized urandom read (16 bytes read)
[    1.466459] random: udevd: uninitialized urandom read (16 bytes read)
[    1.473319] random: crng init done
[    1.473413] random: 2 urandom warning(s) missed due to ratelimiting
[    1.700486] udevd[1021]: starting eudev-3.1.5
[    1.902225] ACPI: bus type USB registered
[    1.902343] usbcore: registered new interface driver usbfs
[    1.902449] usbcore: registered new interface driver hub
[    1.903839] usbcore: registered new device driver usb
[    1.948543] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.948657] ACPI: Power Button [PWRB]
[    1.948798] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.948903] ACPI: Power Button [PWRF]
[    1.988855] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.043072] pps_core: LinuxPPS API ver. 1 registered
[    2.043172] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.091555] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.130658] ehci-pci: EHCI PCI platform driver
[    2.131012] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    2.131116] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    2.131231] ehci-pci 0000:00:1a.7: debug port 1
[    2.135220] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    2.135233] ehci-pci 0000:00:1a.7: irq 18, io mem 0xce000000
[    2.142102] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    2.142830] hub 1-0:1.0: USB hub found
[    2.142982] hub 1-0:1.0: 6 ports detected
[    2.143576] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    2.143679] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    2.143793] ehci-pci 0000:00:1d.7: debug port 1
[    2.147794] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    2.147806] ehci-pci 0000:00:1d.7: irq 23, io mem 0xce001000
[    2.154084] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    2.154776] hub 2-0:1.0: USB hub found
[    2.154895] hub 2-0:1.0: 6 ports detected
[    2.172398] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.172408] PTP clock support registered
[    2.193168] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.214040] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    2.215961] uhci_hcd: USB Universal Host Controller Interface driver
[    2.216279] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.216381] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.216514] uhci_hcd 0000:00:1a.0: irq 19, io base 0x00001820
[    2.216788] hub 3-0:1.0: USB hub found
[    2.216894] hub 3-0:1.0: 2 ports detected
[    2.217274] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    2.217376] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    2.217502] uhci_hcd 0000:00:1a.1: irq 18, io base 0x00001840
[    2.217758] hub 4-0:1.0: USB hub found
[    2.217863] hub 4-0:1.0: 2 ports detected
[    2.218323] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    2.218426] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    2.218552] uhci_hcd 0000:00:1a.2: irq 18, io base 0x00001860
[    2.218813] hub 5-0:1.0: USB hub found
[    2.218918] hub 5-0:1.0: 2 ports detected
[    2.219306] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.219408] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    2.219535] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001880
[    2.219899] hub 6-0:1.0: USB hub found
[    2.220010] hub 6-0:1.0: 2 ports detected
[    2.220398] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.220502] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    2.220639] uhci_hcd 0000:00:1d.1: irq 22, io base 0x000018a0
[    2.220994] hub 7-0:1.0: USB hub found
[    2.221116] hub 7-0:1.0: 2 ports detected
[    2.221544] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.221646] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    2.221777] uhci_hcd 0000:00:1d.2: irq 21, io base 0x000018c0
[    2.222341] hub 8-0:1.0: USB hub found
[    2.222450] hub 8-0:1.0: 2 ports detected
[    2.349833] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    2.349938] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.489474] BTRFS: device fsid 77ad40e4-d53c-4b3b-b135-7c3db9ee21fb devid 1 transid 644604 /dev/sdb1
[    2.565144] igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network Connection
[    2.565252] igb 0000:08:00.0: eth0: (PCIe:2.5Gb/s:Width x4) 00:19:99:ab:0b:38
[    2.565358] igb 0000:08:00.0: eth0: PBA No: Unknown
[    2.565456] igb 0000:08:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[    2.780153] igb 0000:08:00.1: Intel(R) Gigabit Ethernet Network Connection
[    2.780258] igb 0000:08:00.1: eth1: (PCIe:2.5Gb/s:Width x4) 00:19:99:ab:0b:39
[    2.780364] igb 0000:08:00.1: eth1: PBA No: Unknown
[    2.780461] igb 0000:08:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[    2.821806] Adding 10451964k swap on /dev/sda3.  Priority:-2 extents:1 across:10451964k FS
[    3.038614] BTRFS info (device sda2): disk space caching is enabled
[    6.172613] BTRFS info (device sdb1): disk space caching is enabled
[    6.172716] BTRFS info (device sdb1): has skinny extents
[   13.678524] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   15.986005] vboxdrv: loading out-of-tree module taints kernel.
[   15.999934] vboxdrv: Found 24 processor cores
[   16.018167] vboxdrv: TSC mode is Invariant, tentative frequency 2400054158 Hz
[   16.018168] vboxdrv: Successfully loaded version 5.2.16 (interface 0x00290001)
[   16.041728] VBoxNetAdp: Successfully started.
[   16.067723] VBoxNetFlt: Successfully started.
[   16.091988] VBoxPciLinuxInit
[   16.091993] vboxpci: pci-stub module not available, cannot detach PCI devices
[   16.091993] vboxpci: IOMMU found
[   16.369632] SUPR0GipMap: fGetGipCpu=0xb
[   18.248121] vboxdrv: 00000000881526ac VMMR0.r0
[   18.739377] vboxdrv: 000000003a1a14e1 VBoxDDR0.r0
[   18.765360] VBoxNetFlt: attached to 'eth0' / 00:19:99:ab:0b:38
[   18.780026] vboxpci: created IOMMU domain 00000000d484a79e
[   18.780028] vboxpci: created IOMMU domain 000000006e044039
[   18.844414] vboxpci: created IOMMU domain 000000004ae1f849
[   18.850616] vboxdrv: 00000000ade09819 VBoxEhciR0.r0
[   21.224480] vboxpci: created IOMMU domain 00000000b71d898c
[   23.474490] vboxpci: created IOMMU domain 00000000b56b67cd
[   24.700057] device eth0 entered promiscuous mode
[   26.883569] vboxpci: created IOMMU domain 0000000024991026
[   27.802108] vboxpci: created IOMMU domain 000000009e100ecb
[   32.443105] vboxpci: created IOMMU domain 0000000097fb3d02
[   33.835008] vboxpci: created IOMMU domain 000000007880b684
[   37.269955] vboxpci: created IOMMU domain 000000002ea74cc5
[   37.759160] vboxpci: created IOMMU domain 00000000bcefe813
[   37.789438] vboxpci: created IOMMU domain 0000000051a3e809
[72024.007074] hrtimer: interrupt took 94671 ns
[526394.608753] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             
                  TDH                  
                  TDT                  
                  next_to_use          
                  next_to_clean        
                buffer_info[next_to_clean]
                  time_stamp           
                  next_to_watch        
                  jiffies              
                  desc.status          
[526396.593717] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             
                  TDH                  
                  TDT                  
                  next_to_use          
                  next_to_clean        
                buffer_info[next_to_clean]
                  time_stamp           
                  next_to_watch        
                  jiffies              
                  desc.status          
[526398.576746] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             
                  TDH                  
                  TDT                  
                  next_to_use          
                  next_to_clean        
                buffer_info[next_to_clean]
                  time_stamp           
                  next_to_watch        
                  jiffies              
                  desc.status          
[526400.560676] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             
                  TDH                  
                  TDT                  
                  next_to_use          
                  next_to_clean        
                buffer_info[next_to_clean]
                  time_stamp           
                  next_to_watch        
                  jiffies              
                  desc.status          
[526401.584539] ------------[ cut here ]------------
[526401.584543] NETDEV WATCHDOG: eth0 (igb): transmit queue 1 timed out
[526401.584565] WARNING: CPU: 22 PID: 0 at net/sched/sch_generic.c:461 dev_watchdog+0x1d9/0x1e0
[526401.584566] Modules linked in: vboxpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(O) igb uhci_hcd ptp 8250 ehci_pci ehci_hcd 8250_base pps_core i2c_algo_bit evdev i2c_i801 button serial_core i2c_core usbcore usb_common loop
[526401.584582] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G          IO      4.18.0-rc7 #1
[526401.584583] Hardware name: FUJITSU                          PRIMERGY RX300 S6             /D2619, BIOS 6.00 Rev. 1.13.2619.N1           01/19/2012
[526401.584585] RIP: 0010:dev_watchdog+0x1d9/0x1e0
[526401.584586] Code: 00 48 63 4d f0 eb 97 4c 89 e7 c6 05 0a e2 83 00 01 e8 8b eb fd ff 89 d9 4c 89 e6 48 c7 c7 f0 49 b3 81 48 89 c2 e8 e7 20 c3 ff  0b eb c0 0f 1f 00 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 00 
[526401.584612] RSP: 0018:ffff880fff583ec8 EFLAGS: 00010286
[526401.584613] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000006
[526401.584614] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff880fff594ff0
[526401.584615] RBP: ffff880ff7ddc3b0 R08: 0000000000000001 R09: 000000000000036f
[526401.584616] R10: ffffffff81c05100 R11: 000000000000036f R12: ffff880ff7ddc000
[526401.584617] R13: 0000000000000016 R14: 0000000000000002 R15: ffffffff81c05108
[526401.584619] FS:  0000000000000000(0000) GS:ffff880fff580000(0000) knlGS:0000000000000000
[526401.584620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[526401.584621] CR2: 000000000185e4d8 CR3: 0000000001c0a004 CR4: 00000000000226a0
[526401.584621] Call Trace:
[526401.584624]  
[526401.584627]  ? qdisc_reset+0xe0/0xe0
[526401.584630]  call_timer_fn+0x13/0x80
[526401.584633]  expire_timers+0x70/0x80
[526401.584634]  run_timer_softirq+0x7e/0x150
[526401.584636]  ? __hrtimer_run_queues+0x130/0x190
[526401.584640]  ? recalibrate_cpu_khz+0x10/0x10
[526401.584642]  ? ktime_get+0x33/0x90
[526401.584645]  ? default_inquire_remote_apic+0x10/0x10
[526401.584648]  ? lapic_next_event+0x17/0x20
[526401.584652]  __do_softirq+0xd4/0x1c9
[526401.584655]  irq_exit+0xa7/0xb0
[526401.584657]  smp_apic_timer_interrupt+0x59/0x90
[526401.584659]  apic_timer_interrupt+0xf/0x20
[526401.584660]  
[526401.584663] RIP: 0010:cpuidle_enter_state+0x127/0x200
[526401.584663] Code: 43 00 89 c3 e8 da f0 c9 ff 65 8b 3d 53 c5 c4 7e e8 ee ef c9 ff 31 ff 49 89 c4 e8 94 f8 c9 ff fb 48 ba cf f7 53 e3 a5 9b c4 20  89 e1 4c 29 e9 48 89 c8 48 c1 f9 3f 48 f7 ea b8 ff ff ff 7f 48 
[526401.584689] RSP: 0018:ffffc9000012be98 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[526401.584691] RAX: ffff880fff59eec0 RBX: 0000000000000003 RCX: 000000000000001f
[526401.584692] RDX: 20c49ba5e353f7cf RSI: 000000003554d98c RDI: 0000000000000000
[526401.584693] RBP: ffff880ff7dfd800 R08: 000000000000000f R09: 0000000000000002
[526401.584694] R10: 0000000000000000 R11: 0000000000000040 R12: 0001dec26b748498
[526401.584695] R13: 0001dec26b6a9da8 R14: 0000000000000003 R15: ffff880ff8cede80
[526401.584697]  ? cpuidle_enter_state+0x11c/0x200
[526401.584700]  do_idle+0x113/0x200
[526401.584702]  cpu_startup_entry+0x6a/0x70
[526401.584704]  start_secondary+0x183/0x1b0
[526401.584707]  secondary_startup_64+0xa5/0xb0
[526401.584709] ---[ end trace 66b857b7877218ad ]---
[526401.584721] igb 0000:08:00.0 eth0: Reset adapter
[526404.640014] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
