From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Date: Fri, 4 Oct 2019 21:52:47 +0200
Subject: [Intel-wired-lan] e1000e regression - 5.4rc1
In-Reply-To: <56242322-D549-4E23-97AB-153CC392B107@canonical.com>
References: <171f0c61-73a2-81c2-5c8a-7c140f548803@mni.thm.de>
 <56242322-D549-4E23-97AB-153CC392B107@canonical.com>
Message-ID: <76fc2204-0786-03b3-773d-110912d48168@mni.thm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

On 04.10.19 19:36, Kai-Heng Feng wrote:
> Hi Tobias
>
>> On Oct 4, 2019, at 18:34, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
>>
>> Hello all,
>>
>> While testing the 5.4rc1 release, i noticed my Ethernet never coming fully up, seemingly having a timeout problem. While bisecting this i landed at the commit dee23594d587386e9fda76732aa5f5a487709510 ("e1000e: Make speed detection on hotplugging cable more reliable") as the first bad commit. And indeed just reverting the commit on top of 5.4rc1 resolves the problem. Let me know if you have further questions, or patches to test!
> Is runtime PM enabled (i.e. "power/control" = auto)?


Yes it is set to auto.


> Also please attach full dmesg, thanks!

Attached,

Tobias

>
> Kai-Heng
>
>> Greetings,
>>
>> Tobias
>>
>>
>> lspci:
>>
>> 00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network Connection (rev 06)
>>          DeviceName:  Onboard LAN
>>          Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
>>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>          Latency: 0
>>          Interrupt: pin A routed to IRQ 56
>>          Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=128K]
>>          Region 1: Memory at fbf28000 (32-bit, non-prefetchable) [size=4K]
>>          Region 2: I/O ports at f040 [size=32]
>>          Capabilities: [c8] Power Management version 2
>>                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>          Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>                  Address: 00000000fee00698  Data: 0000
>>          Capabilities: [e0] PCI Advanced Features
>>                  AFCap: TP+ FLR+
>>                  AFCtrl: FLR-
>>                  AFStatus: TP-
>>          Kernel driver in use: e1000e
>>          Kernel modules: e1000e
>>
-------------- next part --------------
[    0.000000] microcode: microcode updated early to revision 0x42e, date = 2019-03-14
[    0.000000] Linux version 5.3.0-desktop-saa716x+ (a at b) (gcc version 9.2.1 20190820 [gcc-9-branch revision 274748] (SUSE Linux)) #25 SMP PREEMPT Wed Sep 25 20:20:52 CEST 2019
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.3.0-desktop-saa716x+ root=UUID=25fa63a5-ffbc-4ea5-ade2-5c85298551ca resume=/dev/disk/by-id/ata-Samsung_SSD_840_PRO_Series_S12RNEACC48007K-part3 radeon.si_support=0 amdgpu.si_support=1 radeon.cik_support=0 amdgpu.cik_support=1 quiet mitigations=auto
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000008ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x0000000000090fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000091000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bc1f1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bc1f2000-0x00000000bc4d7fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bc4d8000-0x00000000bc5f9fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bc5fa000-0x00000000bc818fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bc819000-0x00000000bd746fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bd747000-0x00000000bd747fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bd748000-0x00000000bd7cdfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bd7ce000-0x00000000bdc08fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bdc09000-0x00000000bdff3fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bdff4000-0x00000000bdffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x79e89018-0x79ea7057] usable ==> usable
[    0.000000] e820: update [mem 0x79e89018-0x79ea7057] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000001000-0x000000000008ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x0000000000090fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000091000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000079e89017] usable
[    0.000000] reserve setup_data: [mem 0x0000000079e89018-0x0000000079ea7057] usable
[    0.000000] reserve setup_data: [mem 0x0000000079ea7058-0x00000000bc1f1fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000bc1f2000-0x00000000bc4d7fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000bc4d8000-0x00000000bc5f9fff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000bc5fa000-0x00000000bc818fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000bc819000-0x00000000bd746fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000bd747000-0x00000000bd747fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000bd748000-0x00000000bd7cdfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000bd7ce000-0x00000000bdc08fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000bdc09000-0x00000000bdff3fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000bdff4000-0x00000000bdffffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000043fffffff] usable
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0xbc512000  ACPI=0xbc512000  SMBIOS=0xbd6d6298 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: System manufacturer System Product Name/P9X79, BIOS 4801 07/24/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3700.116 MHz processor
[    0.000115] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000116] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000120] last_pfn = 0x440000 max_arch_pfn = 0x400000000
[    0.000122] MTRR default type: uncachable
[    0.000123] MTRR fixed ranges enabled:
[    0.000123]   00000-9FFFF write-back
[    0.000124]   A0000-DFFFF uncachable
[    0.000124]   E0000-FFFFF write-protect
[    0.000125] MTRR variable ranges enabled:
[    0.000126]   0 base 000000000000 mask 3FFC00000000 write-back
[    0.000126]   1 base 000400000000 mask 3FFFC0000000 write-back
[    0.000127]   2 base 0000BF000000 mask 3FFFFF000000 uncachable
[    0.000127]   3 base 0000C0000000 mask 3FFFC0000000 uncachable
[    0.000127]   4 disabled
[    0.000128]   5 disabled
[    0.000128]   6 disabled
[    0.000128]   7 disabled
[    0.000128]   8 disabled
[    0.000129]   9 disabled
[    0.000403] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000479] e820: update [mem 0xbf000000-0xffffffff] usable ==> reserved
[    0.000483] last_pfn = 0xbe000 max_arch_pfn = 0x400000000
[    0.005719] check: Scanning 1 areas for low memory corruption
[    0.005724] Using GB pages for direct mapping
[    0.005725] BRK [0x39d601000, 0x39d601fff] PGTABLE
[    0.005726] BRK [0x39d602000, 0x39d602fff] PGTABLE
[    0.005727] BRK [0x39d603000, 0x39d603fff] PGTABLE
[    0.005742] BRK [0x39d604000, 0x39d604fff] PGTABLE
[    0.005764] BRK [0x39d605000, 0x39d605fff] PGTABLE
[    0.005772] BRK [0x39d606000, 0x39d606fff] PGTABLE
[    0.005779] BRK [0x39d607000, 0x39d607fff] PGTABLE
[    0.005796] BRK [0x39d608000, 0x39d608fff] PGTABLE
[    0.005825] BRK [0x39d609000, 0x39d609fff] PGTABLE
[    0.005833] Secure boot disabled
[    0.005833] RAMDISK: [mem 0x3dded000-0x3e7cdfff]
[    0.005838] ACPI: Early table checksum verification disabled
[    0.005840] ACPI: RSDP 0x00000000BC512000 000024 (v02 ALASKA)
[    0.005843] ACPI: XSDT 0x00000000BC512078 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.005846] ACPI: FACP 0x00000000BC51C6C8 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.005850] ACPI: DSDT 0x00000000BC512170 00A553 (v02 ALASKA A M I    00000016 INTL 20051117)
[    0.005851] ACPI: FACS 0x00000000BC810080 000040
[    0.005853] ACPI: APIC 0x00000000BC51C7D8 0000C8 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.005855] ACPI: FPDT 0x00000000BC51C8A0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.005856] ACPI: MCFG 0x00000000BC51C8E8 00003C (v01 ALASKA OEMMCFG. 01072009 MSFT 00000097)
[    0.005858] ACPI: HPET 0x00000000BC51C928 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
[    0.005860] ACPI: DMAR 0x00000000BC5F9B68 0000B4 (v01 A M I  OEMDMAR  00000001 INTL 00000001)
[    0.005861] ACPI: SSDT 0x00000000BC51C9B8 0CD128 (v02 INTEL  CpuPm    00004000 INTL 20051117)
[    0.005863] ACPI: VFCT 0x00000000BC5E9AE0 010084 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.005868] ACPI: Local APIC address 0xfee00000
[    0.005895] No NUMA configuration found
[    0.005896] Faking a node at [mem 0x0000000000000000-0x000000043fffffff]
[    0.005901] NODE_DATA(0) allocated [mem 0x43ffe9000-0x43fffffff]
[    0.005922] Zone ranges:
[    0.005922]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005923]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005924]   Normal   [mem 0x0000000100000000-0x000000043fffffff]
[    0.005924]   Device   empty
[    0.005925] Movable zone start for each node
[    0.005926] Early memory node ranges
[    0.005927]   node   0: [mem 0x0000000000001000-0x000000000008ffff]
[    0.005927]   node   0: [mem 0x0000000000091000-0x000000000009ffff]
[    0.005928]   node   0: [mem 0x0000000000100000-0x00000000bc1f1fff]
[    0.005928]   node   0: [mem 0x00000000bd747000-0x00000000bd747fff]
[    0.005929]   node   0: [mem 0x00000000bd7ce000-0x00000000bdc08fff]
[    0.005929]   node   0: [mem 0x00000000bdff4000-0x00000000bdffffff]
[    0.005929]   node   0: [mem 0x0000000100000000-0x000000043fffffff]
[    0.006039] Zeroed struct page in unavailable ranges: 14888 pages
[    0.006039] Initmem setup node 0 [mem 0x0000000000001000-0x000000043fffffff]
[    0.006040] On node 0 totalpages: 4179416
[    0.006041]   DMA zone: 64 pages used for memmap
[    0.006041]   DMA zone: 22 pages reserved
[    0.006042]   DMA zone: 3998 pages, LIFO batch:0
[    0.006089]   DMA32 zone: 11993 pages used for memmap
[    0.006090]   DMA32 zone: 767546 pages, LIFO batch:63
[    0.015776]   Normal zone: 53248 pages used for memmap
[    0.015777]   Normal zone: 3407872 pages, LIFO batch:63
[    0.016339] ACPI: PM-Timer IO Port: 0x408
[    0.016340] ACPI: Local APIC address 0xfee00000
[    0.016345] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.016345] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.016346] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.016346] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.016346] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.016347] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.016347] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.016347] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.016356] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.016359] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 24-47
[    0.016361] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.016362] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.016363] ACPI: IRQ0 used by override.
[    0.016363] ACPI: IRQ9 used by override.
[    0.016364] Using ACPI (MADT) for SMP configuration information
[    0.016365] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.016369] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.016385] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.016386] PM: Registered nosave memory: [mem 0x00090000-0x00090fff]
[    0.016387] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.016389] PM: Registered nosave memory: [mem 0x79e89000-0x79e89fff]
[    0.016390] PM: Registered nosave memory: [mem 0x79ea7000-0x79ea7fff]
[    0.016391] PM: Registered nosave memory: [mem 0xbc1f2000-0xbc4d7fff]
[    0.016391] PM: Registered nosave memory: [mem 0xbc4d8000-0xbc5f9fff]
[    0.016391] PM: Registered nosave memory: [mem 0xbc5fa000-0xbc818fff]
[    0.016392] PM: Registered nosave memory: [mem 0xbc819000-0xbd746fff]
[    0.016393] PM: Registered nosave memory: [mem 0xbd748000-0xbd7cdfff]
[    0.016394] PM: Registered nosave memory: [mem 0xbdc09000-0xbdff3fff]
[    0.016395] PM: Registered nosave memory: [mem 0xbe000000-0xdfffffff]
[    0.016395] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.016396] PM: Registered nosave memory: [mem 0xf0000000-0xfed1bfff]
[    0.016396] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.016396] PM: Registered nosave memory: [mem 0xfed20000-0xfeffffff]
[    0.016397] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.016398] [mem 0xbe000000-0xdfffffff] available for PCI devices
[    0.016401] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.078305] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:8 nr_node_ids:1
[    0.078456] percpu: Embedded 45 pages/cpu s144600 r8192 d31528 u262144
[    0.078461] pcpu-alloc: s144600 r8192 d31528 u262144 alloc=1*2097152
[    0.078462] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.078478] Built 1 zonelists, mobility grouping on.  Total pages: 4114089
[    0.078478] Policy zone: Normal
[    0.078480] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.3.0-desktop-saa716x+ root=UUID=25fa63a5-ffbc-4ea5-ade2-5c85298551ca resume=/dev/disk/by-id/ata-Samsung_SSD_840_PRO_Series_S12RNEACC48007K-part3 radeon.si_support=0 amdgpu.si_support=1 radeon.cik_support=0 amdgpu.cik_support=1 quiet mitigations=auto
[    0.078576] printk: log_buf_len individual max cpu contribution: 32768 bytes
[    0.078576] printk: log_buf_len total cpu_extra contributions: 229376 bytes
[    0.078576] printk: log_buf_len min size: 262144 bytes
[    0.078626] printk: log_buf_len: 524288 bytes
[    0.078626] printk: early log buf free: 248100(94%)
[    0.079489] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.079941] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.079993] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.093333] Memory: 3079144K/16717664K available (10243K kernel code, 694K rwdata, 1644K rodata, 1416K init, 2672K bss, 449888K reserved, 0K cma-reserved)
[    0.093414] Kernel/User page tables isolation: enabled
[    0.093461] rcu: Preemptible hierarchical RCU implementation.
[    0.093461] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=8.
[    0.093462] 	Tasks RCU enabled.
[    0.093462] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.093463] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.093471] NR_IRQS: 4352, nr_irqs: 896, preallocated irqs: 16
[    0.093674] random: crng done (trusting CPU's manufacturer)
[    0.093765] Console: colour dummy device 80x25
[    0.093768] printk: console [tty0] enabled
[    0.093792] ACPI: Core revision 20190816
[    0.094369] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.094380] APIC: Switch to symmetric I/O mode setup
[    0.094381] DMAR: Host address width 46
[    0.094382] DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
[    0.094386] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0466 ecap f020de
[    0.094387] DMAR: RMRR base: 0x000000bc4be000 end: 0x000000bc4cafff
[    0.094388] DMAR: ATSR flags: 0x0
[    0.094388] DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x0
[    0.094390] DMAR-IR: IOAPIC id 0 under DRHD base  0xfbffc000 IOMMU 0
[    0.094391] DMAR-IR: IOAPIC id 2 under DRHD base  0xfbffc000 IOMMU 0
[    0.094391] DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
[    0.094392] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.094639] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.094640] x2apic enabled
[    0.094645] Switched APIC routing to cluster x2apic.
[    0.095128] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.099380] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6aab873aab9, max_idle_ns: 881590561701 ns
[    0.099383] Calibrating delay loop (skipped), value calculated using timer frequency.. 7400.23 BogoMIPS (lpj=3700116)
[    0.099384] pid_max: default: 32768 minimum: 301
[    0.101349] LSM: Security Framework initializing
[    0.101375] AppArmor: AppArmor initialized
[    0.101376] TOMOYO Linux initialized
[    0.101418] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.101445] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.101622] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.101655] process: using mwait in idle threads
[    0.101657] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.101658] Last level dTLB entries: 4KB 512, 2MB 0, 4MB 0, 1GB 4
[    0.101660] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.101661] Spectre V2 : Mitigation: Full generic retpoline
[    0.101661] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.101662] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.101663] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.101663] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.101664] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.101666] MDS: Mitigation: Clear CPU buffers
[    0.101796] Freeing SMP alternatives memory: 32K
[    0.102427] TSC deadline timer enabled
[    0.102429] smpboot: CPU0: Intel(R) Core(TM) i7-4820K CPU @ 3.70GHz (family: 0x6, model: 0x3e, stepping: 0x4)
[    0.108385] Performance Events: PEBS fmt1+, IvyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.108390] ... version:                3
[    0.108391] ... bit width:              48
[    0.108391] ... generic registers:      4
[    0.108391] ... value mask:             0000ffffffffffff
[    0.108392] ... max period:             00007fffffffffff
[    0.108392] ... fixed-purpose events:   3
[    0.108392] ... event mask:             000000070000000f
[    0.110383] rcu: Hierarchical SRCU implementation.
[    0.114632] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.116383] smp: Bringing up secondary CPUs ...
[    0.126395] x86: Booting SMP configuration:
[    0.126396] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.163439] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.173402]  #5 #6 #7
[    0.196417] smp: Brought up 1 node, 8 CPUs
[    0.196417] smpboot: Max logical packages: 1
[    0.196417] smpboot: Total of 8 processors activated (59201.85 BogoMIPS)
[    0.234391] node 0 initialised, 3297158 pages in 37ms
[    0.234718] devtmpfs: initialized
[    0.234718] x86/mm: Memory block size: 128MB
[    0.236472] PM: Registering ACPI NVS region [mem 0xbc5fa000-0xbc818fff] (2224128 bytes)
[    0.236472] PM: Registering ACPI NVS region [mem 0xbd748000-0xbd7cdfff] (548864 bytes)
[    0.236529] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.236529] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.236529] pinctrl core: initialized pinctrl subsystem
[    0.236590] NET: Registered protocol family 16
[    0.236675] audit: initializing netlink subsys (disabled)
[    0.236679] audit: type=2000 audit(1570217874.142:1): state=initialized audit_enabled=0 res=1
[    0.236679] cpuidle: using governor ladder
[    0.236679] cpuidle: using governor menu
[    0.236679] ACPI: bus type PCI registered
[    0.236679] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.236679] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.236679] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.236679] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a huge-page mapping due to MTRR override.
[    0.236679] PCI: Using configuration type 1 for base access
[    0.236679] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.237906] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.238593] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.238593] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.239424] ACPI: Added _OSI(Module Device)
[    0.239425] ACPI: Added _OSI(Processor Device)
[    0.239425] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.239426] ACPI: Added _OSI(Processor Aggregator Device)
[    0.239427] ACPI: Added _OSI(Linux-Dell-Video)
[    0.239428] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.239428] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.361585] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.379568] ACPI: EC: EC started
[    0.379569] ACPI: EC: interrupt blocked
[    0.379587] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
[    0.379588] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x1e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.379589] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle transactions
[    0.379589] ACPI: Interpreter enabled
[    0.379601] ACPI: (supports S0 S3 S4 S5)
[    0.379602] ACPI: Using IOAPIC for interrupt routing
[    0.379627] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.380052] ACPI: Enabled 7 GPEs in block 00 to 3F
[    0.393724] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.393728] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.393896] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    0.394053] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
[    0.394330] PCI host bridge to bus 0000:00
[    0.394332] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.394333] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.394334] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.394335] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.394335] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.394336] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.394337] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    0.394338] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.394348] pci 0000:00:00.0: [8086:0e00] type 00 class 0x060000
[    0.394420] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.394499] pci 0000:00:01.0: [8086:0e02] type 01 class 0x060400
[    0.394583] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.394684] pci 0000:00:02.0: [8086:0e04] type 01 class 0x060400
[    0.394767] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.394863] pci 0000:00:03.0: [8086:0e08] type 01 class 0x060400
[    0.394902] pci 0000:00:03.0: enabling Extended Tags
[    0.394950] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.395043] pci 0000:00:05.0: [8086:0e28] type 00 class 0x088000
[    0.395155] pci 0000:00:05.2: [8086:0e2a] type 00 class 0x088000
[    0.395266] pci 0000:00:05.4: [8086:0e2c] type 00 class 0x080020
[    0.395278] pci 0000:00:05.4: reg 0x10: [mem 0xfbf2a000-0xfbf2afff]
[    0.395401] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    0.395500] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    0.395602] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
[    0.395623] pci 0000:00:16.0: reg 0x10: [mem 0xfbf29000-0xfbf2900f 64bit]
[    0.395689] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.395762] pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
[    0.395778] pci 0000:00:19.0: reg 0x10: [mem 0xfbf00000-0xfbf1ffff]
[    0.395784] pci 0000:00:19.0: reg 0x14: [mem 0xfbf28000-0xfbf28fff]
[    0.395790] pci 0000:00:19.0: reg 0x18: [io  0xf040-0xf05f]
[    0.395841] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.395917] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    0.395935] pci 0000:00:1a.0: reg 0x10: [mem 0xfbf27000-0xfbf273ff]
[    0.396008] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.396088] pci 0000:00:1b.0: [8086:1d20] type 00 class 0x040300
[    0.396104] pci 0000:00:1b.0: reg 0x10: [mem 0xfbf20000-0xfbf23fff 64bit]
[    0.396161] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.396229] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
[    0.396312] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.396398] pci 0000:00:1c.1: [8086:1d12] type 01 class 0x060400
[    0.396482] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.396568] pci 0000:00:1c.3: [8086:1d16] type 01 class 0x060400
[    0.396651] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.396734] pci 0000:00:1c.4: [8086:1d18] type 01 class 0x060400
[    0.396817] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.396901] pci 0000:00:1c.5: [8086:1d1a] type 01 class 0x060400
[    0.396984] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.397069] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    0.397088] pci 0000:00:1d.0: reg 0x10: [mem 0xfbf26000-0xfbf263ff]
[    0.397162] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.397237] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.397354] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    0.397522] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
[    0.397537] pci 0000:00:1f.2: reg 0x10: [io  0xf090-0xf097]
[    0.397543] pci 0000:00:1f.2: reg 0x14: [io  0xf080-0xf083]
[    0.397548] pci 0000:00:1f.2: reg 0x18: [io  0xf070-0xf077]
[    0.397554] pci 0000:00:1f.2: reg 0x1c: [io  0xf060-0xf063]
[    0.397560] pci 0000:00:1f.2: reg 0x20: [io  0xf020-0xf03f]
[    0.397565] pci 0000:00:1f.2: reg 0x24: [mem 0xfbf25000-0xfbf257ff]
[    0.397599] pci 0000:00:1f.2: PME# supported from D3hot
[    0.397671] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[    0.397686] pci 0000:00:1f.3: reg 0x10: [mem 0xfbf24000-0xfbf240ff 64bit]
[    0.397703] pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
[    0.397810] pci 0000:00:01.0: PCI bridge to [bus 03]
[    0.397848] pci 0000:01:00.0: [1002:67b1] type 00 class 0x030000
[    0.397862] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.397868] pci 0000:01:00.0: reg 0x18: [mem 0xd0000000-0xd07fffff 64bit pref]
[    0.397873] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.397877] pci 0000:01:00.0: reg 0x24: [mem 0xfbe00000-0xfbe3ffff]
[    0.397881] pci 0000:01:00.0: reg 0x30: [mem 0xfbe40000-0xfbe5ffff pref]
[    0.397885] pci 0000:01:00.0: enabling Extended Tags
[    0.397892] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.397920] pci 0000:01:00.0: supports D1 D2
[    0.397921] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.397967] pci 0000:01:00.1: [1002:aac8] type 00 class 0x040300
[    0.397978] pci 0000:01:00.1: reg 0x10: [mem 0xfbe60000-0xfbe63fff 64bit]
[    0.397994] pci 0000:01:00.1: enabling Extended Tags
[    0.398021] pci 0000:01:00.1: supports D1 D2
[    0.398060] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.398062] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.398064] pci 0000:00:02.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.398067] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd07fffff 64bit pref]
[    0.398095] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.398135] pci 0000:00:11.0: PCI bridge to [bus 04]
[    0.398175] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    0.398232] pci 0000:06:00.0: [1b21:1042] type 00 class 0x0c0330
[    0.398270] pci 0000:06:00.0: reg 0x10: [mem 0xfbd00000-0xfbd07fff 64bit]
[    0.398425] pci 0000:06:00.0: PME# supported from D3hot D3cold
[    0.398516] pci 0000:00:1c.1: PCI bridge to [bus 06]
[    0.398521] pci 0000:00:1c.1:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.398576] pci 0000:07:00.0: [1b21:1042] type 00 class 0x0c0330
[    0.398614] pci 0000:07:00.0: reg 0x10: [mem 0xfbc00000-0xfbc07fff 64bit]
[    0.398768] pci 0000:07:00.0: PME# supported from D3hot D3cold
[    0.398857] pci 0000:00:1c.3: PCI bridge to [bus 07]
[    0.398861] pci 0000:00:1c.3:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.398912] pci 0000:08:00.0: [1b21:0612] type 00 class 0x010601
[    0.398939] pci 0000:08:00.0: reg 0x10: [io  0xd050-0xd057]
[    0.398951] pci 0000:08:00.0: reg 0x14: [io  0xd040-0xd043]
[    0.398963] pci 0000:08:00.0: reg 0x18: [io  0xd030-0xd037]
[    0.398974] pci 0000:08:00.0: reg 0x1c: [io  0xd020-0xd023]
[    0.398985] pci 0000:08:00.0: reg 0x20: [io  0xd000-0xd01f]
[    0.398997] pci 0000:08:00.0: reg 0x24: [mem 0xfbb00000-0xfbb001ff]
[    0.399154] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.399157] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.399159] pci 0000:00:1c.4:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.399211] pci 0000:09:00.0: [1106:3403] type 00 class 0x0c0010
[    0.399249] pci 0000:09:00.0: reg 0x10: [mem 0xfba00000-0xfba007ff 64bit]
[    0.399261] pci 0000:09:00.0: reg 0x18: [io  0xc000-0xc0ff]
[    0.399383] pci 0000:09:00.0: supports D2
[    0.399383] pci 0000:09:00.0: PME# supported from D2 D3hot D3cold
[    0.402412] pci 0000:00:1c.5: PCI bridge to [bus 09]
[    0.402417] pci 0000:00:1c.5:   bridge window [io  0xc000-0xcfff]
[    0.402421] pci 0000:00:1c.5:   bridge window [mem 0xfba00000-0xfbafffff]
[    0.402455] pci_bus 0000:0a: extended config space not accessible
[    0.402498] pci 0000:00:1e.0: PCI bridge to [bus 0a] (subtractive decode)
[    0.402505] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.402506] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.402507] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.402507] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.402508] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.402509] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.402509] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xffffffff window] (subtractive decode)
[    0.402941] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
[    0.402944] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.402965] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    0.403008] PCI host bridge to bus 0000:ff
[    0.403009] pci_bus 0000:ff: root bus resource [bus ff]
[    0.403016] pci 0000:ff:08.0: [8086:0e80] type 00 class 0x088000
[    0.403054] pci 0000:ff:09.0: [8086:0e90] type 00 class 0x088000
[    0.403089] pci 0000:ff:0a.0: [8086:0ec0] type 00 class 0x088000
[    0.403119] pci 0000:ff:0a.1: [8086:0ec1] type 00 class 0x088000
[    0.403149] pci 0000:ff:0a.2: [8086:0ec2] type 00 class 0x088000
[    0.403178] pci 0000:ff:0a.3: [8086:0ec3] type 00 class 0x088000
[    0.403209] pci 0000:ff:0b.0: [8086:0e1e] type 00 class 0x088000
[    0.403236] pci 0000:ff:0b.3: [8086:0e1f] type 00 class 0x088000
[    0.403264] pci 0000:ff:0c.0: [8086:0ee0] type 00 class 0x088000
[    0.403290] pci 0000:ff:0c.1: [8086:0ee2] type 00 class 0x088000
[    0.403318] pci 0000:ff:0d.0: [8086:0ee1] type 00 class 0x088000
[    0.403345] pci 0000:ff:0d.1: [8086:0ee3] type 00 class 0x088000
[    0.403373] pci 0000:ff:0e.0: [8086:0ea0] type 00 class 0x088000
[    0.403405] pci 0000:ff:0e.1: [8086:0e30] type 00 class 0x110100
[    0.403438] pci 0000:ff:0f.0: [8086:0ea8] type 00 class 0x088000
[    0.403478] pci 0000:ff:0f.1: [8086:0e71] type 00 class 0x088000
[    0.403518] pci 0000:ff:0f.2: [8086:0eaa] type 00 class 0x088000
[    0.403557] pci 0000:ff:0f.3: [8086:0eab] type 00 class 0x088000
[    0.403597] pci 0000:ff:0f.4: [8086:0eac] type 00 class 0x088000
[    0.403637] pci 0000:ff:0f.5: [8086:0ead] type 00 class 0x088000
[    0.403677] pci 0000:ff:10.0: [8086:0eb0] type 00 class 0x088000
[    0.403718] pci 0000:ff:10.1: [8086:0eb1] type 00 class 0x088000
[    0.403757] pci 0000:ff:10.2: [8086:0eb2] type 00 class 0x088000
[    0.403797] pci 0000:ff:10.3: [8086:0eb3] type 00 class 0x088000
[    0.403836] pci 0000:ff:10.4: [8086:0eb4] type 00 class 0x088000
[    0.403876] pci 0000:ff:10.5: [8086:0eb5] type 00 class 0x088000
[    0.403916] pci 0000:ff:10.6: [8086:0eb6] type 00 class 0x088000
[    0.403955] pci 0000:ff:10.7: [8086:0eb7] type 00 class 0x088000
[    0.403994] pci 0000:ff:13.0: [8086:0e1d] type 00 class 0x088000
[    0.404022] pci 0000:ff:13.1: [8086:0e34] type 00 class 0x110100
[    0.404050] pci 0000:ff:13.4: [8086:0e81] type 00 class 0x088000
[    0.404078] pci 0000:ff:13.5: [8086:0e36] type 00 class 0x110100
[    0.404107] pci 0000:ff:16.0: [8086:0ec8] type 00 class 0x088000
[    0.404134] pci 0000:ff:16.1: [8086:0ec9] type 00 class 0x088000
[    0.404163] pci 0000:ff:16.2: [8086:0eca] type 00 class 0x088000
[    0.404286] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.404337] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.404390] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.404440] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.404489] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.404537] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.404587] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.404636] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.408752] ACPI: EC: interrupt unblocked
[    0.408758] ACPI: EC: event unblocked
[    0.408763] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x1e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.408763] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle transactions and events
[    0.408828] iommu: Default domain type: Translated 
[    0.408828] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.408828] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.408828] pci 0000:01:00.0: vgaarb: setting as boot device
[    0.408828] vgaarb: loaded
[    0.408828] SCSI subsystem initialized
[    0.408828] libata version 3.00 loaded.
[    0.408828] EDAC MC: Ver: 3.0.0
[    0.408828] Registered efivars operations
[    0.412418] PCI: Using ACPI for IRQ routing
[    0.418128] PCI: pci_cache_line_size set to 64 bytes
[    0.418209] e820: reserve RAM buffer [mem 0x79e89018-0x7bffffff]
[    0.418210] e820: reserve RAM buffer [mem 0xbc1f2000-0xbfffffff]
[    0.418211] e820: reserve RAM buffer [mem 0xbd748000-0xbfffffff]
[    0.418212] e820: reserve RAM buffer [mem 0xbdc09000-0xbfffffff]
[    0.418212] e820: reserve RAM buffer [mem 0xbe000000-0xbfffffff]
[    0.418288] NetLabel: Initializing
[    0.418288] NetLabel:  domain hash size = 128
[    0.418289] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.418299] NetLabel:  unlabeled traffic allowed by default
[    0.418301] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.418301] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.419392] clocksource: Switched to clocksource tsc-early
[    0.419438] VFS: Disk quotas dquot_6.6.0
[    0.419450] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.419537] AppArmor: AppArmor Filesystem Enabled
[    0.419543] pnp: PnP ACPI init
[    0.419625] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.419626] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.419627] system 00:00: [mem 0xfe000000-0xfeafffff] has been reserved
[    0.419628] system 00:00: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.419629] system 00:00: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    0.419630] system 00:00: [mem 0xfed45000-0xfedfffff] has been reserved
[    0.419631] system 00:00: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.419634] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.419709] system 00:01: [mem 0xfbffc000-0xfbffdfff] could not be reserved
[    0.419711] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.419811] system 00:02: [io  0x0290-0x029f] has been reserved
[    0.419813] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.419830] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.419888] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.419891] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.420079] pnp 00:05: [dma 0 disabled]
[    0.420110] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.420305] system 00:06: [io  0x0400-0x0453] has been reserved
[    0.420306] system 00:06: [io  0x0458-0x047f] has been reserved
[    0.420307] system 00:06: [io  0x1180-0x119f] has been reserved
[    0.420308] system 00:06: [io  0x0500-0x057f] has been reserved
[    0.420309] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.420310] system 00:06: [mem 0xfec00000-0xfecfffff] could not be reserved
[    0.420311] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.420314] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.420380] system 00:07: [io  0x0454-0x0457] has been reserved
[    0.420380] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.420641] pnp: PnP ACPI: found 8 devices
[    0.421418] thermal_sys: Registered thermal governor 'fair_share'
[    0.421418] thermal_sys: Registered thermal governor 'bang_bang'
[    0.421419] thermal_sys: Registered thermal governor 'step_wise'
[    0.421419] thermal_sys: Registered thermal governor 'user_space'
[    0.425939] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.425970] pci 0000:00:01.0: PCI bridge to [bus 03]
[    0.425978] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.425979] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.425982] pci 0000:00:02.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.425984] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd07fffff 64bit pref]
[    0.425988] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.425995] pci 0000:00:11.0: PCI bridge to [bus 04]
[    0.426005] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    0.426014] pci 0000:00:1c.1: PCI bridge to [bus 06]
[    0.426017] pci 0000:00:1c.1:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.426023] pci 0000:00:1c.3: PCI bridge to [bus 07]
[    0.426026] pci 0000:00:1c.3:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.426032] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.426034] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.426037] pci 0000:00:1c.4:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.426043] pci 0000:00:1c.5: PCI bridge to [bus 09]
[    0.426045] pci 0000:00:1c.5:   bridge window [io  0xc000-0xcfff]
[    0.426048] pci 0000:00:1c.5:   bridge window [mem 0xfba00000-0xfbafffff]
[    0.426054] pci 0000:00:1e.0: PCI bridge to [bus 0a]
[    0.426062] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.426063] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.426063] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.426064] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.426065] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.426066] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.426066] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.426067] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.426068] pci_bus 0000:01: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.426069] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd07fffff 64bit pref]
[    0.426069] pci_bus 0000:06: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    0.426070] pci_bus 0000:07: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    0.426071] pci_bus 0000:08: resource 0 [io  0xd000-0xdfff]
[    0.426072] pci_bus 0000:08: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    0.426072] pci_bus 0000:09: resource 0 [io  0xc000-0xcfff]
[    0.426073] pci_bus 0000:09: resource 1 [mem 0xfba00000-0xfbafffff]
[    0.426074] pci_bus 0000:0a: resource 4 [io  0x0000-0x03af window]
[    0.426074] pci_bus 0000:0a: resource 5 [io  0x03e0-0x0cf7 window]
[    0.426075] pci_bus 0000:0a: resource 6 [io  0x03b0-0x03df window]
[    0.426076] pci_bus 0000:0a: resource 7 [io  0x0d00-0xffff window]
[    0.426076] pci_bus 0000:0a: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.426077] pci_bus 0000:0a: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.426078] pci_bus 0000:0a: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.426147] NET: Registered protocol family 2
[    0.426240] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.426256] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.426370] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.426465] TCP: Hash tables configured (established 131072 bind 65536)
[    0.426487] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.426512] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.426570] NET: Registered protocol family 1
[    0.426573] NET: Registered protocol family 44
[    0.442497] pci 0000:00:1a.0: 0xffffffffb659d070 took 15531 usecs
[    0.458493] pci 0000:00:1d.0: 0xffffffffb659d070 took 15607 usecs
[    0.458508] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.458818] PCI: CLS 64 bytes, default 64
[    0.458845] Trying to unpack rootfs image as initramfs...
[    1.127982] Freeing initrd memory: 10116K
[    1.138409] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.138412] software IO TLB: mapped [mem 0xb41be000-0xb81be000] (64MB)
[    1.138522] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[    1.138522] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    1.138523] RAPL PMU: hw unit of domain package 2^-16 Joules
[    1.138731] check: Scanning for low memory corruption every 60 seconds
[    1.139070] Initialise system trusted keyrings
[    1.139078] Key type blacklist registered
[    1.139112] workingset: timestamp_bits=37 max_order=22 bucket_order=0
[    1.139147] zbud: loaded
[    1.139364] Platform Keyring initialized
[    1.143246] Key type asymmetric registered
[    1.143247] Asymmetric key parser 'x509' registered
[    1.143252] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    1.143282] io scheduler mq-deadline registered
[    1.143283] io scheduler kyber registered
[    1.143290] io scheduler bfq registered
[    1.144637] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.144657] intel_idle: MWAIT substates: 0x1120
[    1.144658] intel_idle: v0.4.1 model 0x3E
[    1.144878] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.155073] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.175696] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.176452] Non-volatile memory driver v1.3
[    1.176464] Linux agpgart interface v0.103
[    1.176944] ahci 0000:00:1f.2: version 3.0
[    1.187175] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x2f impl SATA mode
[    1.187177] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    1.198755] scsi host0: ahci
[    1.198822] scsi host1: ahci
[    1.198876] scsi host2: ahci
[    1.198951] scsi host3: ahci
[    1.199014] scsi host4: ahci
[    1.199066] scsi host5: ahci
[    1.199091] ata1: SATA max UDMA/133 abar m2048 at 0xfbf25000 port 0xfbf25100 irq 36
[    1.199092] ata2: SATA max UDMA/133 abar m2048 at 0xfbf25000 port 0xfbf25180 irq 36
[    1.199093] ata3: SATA max UDMA/133 abar m2048 at 0xfbf25000 port 0xfbf25200 irq 36
[    1.199094] ata4: SATA max UDMA/133 abar m2048 at 0xfbf25000 port 0xfbf25280 irq 36
[    1.199095] ata5: DUMMY
[    1.199096] ata6: SATA max UDMA/133 abar m2048 at 0xfbf25000 port 0xfbf25380 irq 36
[    1.199213] ahci 0000:08:00.0: SSS flag set, parallel bus scan disabled
[    1.199249] ahci 0000:08:00.0: AHCI 0001.0200 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.199251] ahci 0000:08:00.0: flags: 64bit ncq sntf stag led clo pmp pio slum part ccc sxs 
[    1.199389] scsi host6: ahci
[    1.199442] scsi host7: ahci
[    1.199467] ata7: SATA max UDMA/133 abar m512 at 0xfbb00000 port 0xfbb00100 irq 37
[    1.199469] ata8: SATA max UDMA/133 abar m512 at 0xfbb00000 port 0xfbb00180 irq 37
[    1.199515] i8042: PNP: No PS/2 controller found.
[    1.199550] mousedev: PS/2 mouse device common for all mice
[    1.199583] rtc_cmos 00:03: RTC can wake from S4
[    1.199720] rtc_cmos 00:03: registered as rtc0
[    1.199729] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.199736] intel_pstate: Intel P-state driver initializing
[    1.199894] ledtrig-cpu: registered to indicate activity on CPUs
[    1.199898] EFI Variables Facility v0.08 2004-May-17
[    1.206150] hidraw: raw HID events driver (C) Jiri Kosina
[    1.206437] NET: Registered protocol family 10
[    1.221942] Segment Routing with IPv6
[    1.222335] RAS: Correctable Errors collector initialized.
[    1.222351] microcode: sig=0x306e4, pf=0x4, revision=0x42e
[    1.222393] microcode: Microcode Update Driver: v2.2.
[    1.222396] IPI shorthand broadcast: enabled
[    1.222403] sched_clock: Marking stable (1221652951, 736408)->(1236675476, -14286117)
[    1.222443] registered taskstats version 1
[    1.222444] Loading compiled-in X.509 certificates
[    1.224874] Loaded X.509 cert 'Build time autogenerated kernel key: 79b22605c9a894ae155b6c3f799370fec3ba2b6c'
[    1.224902] zswap: loaded using pool lzo/zbud
[    1.225003] Key type ._fscrypt registered
[    1.225004] Key type .fscrypt registered
[    1.233436] Key type big_key registered
[    1.237254] Key type encrypted registered
[    1.237256] AppArmor: AppArmor sha1 policy hashing enabled
[    1.237406] integrity: Loading X.509 certificate: UEFI:db
[    1.237603] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    1.237604] integrity: Loading X.509 certificate: UEFI:db
[    1.237977] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    1.237978] integrity: Loading X.509 certificate: UEFI:db
[    1.238009] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.238010] integrity: Loading X.509 certificate: UEFI:db
[    1.238038] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.238039] integrity: Loading X.509 certificate: UEFI:db
[    1.238402] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    1.238536] integrity: Loading X.509 certificate: UEFI:MokListRT
[    1.238551] integrity: Loaded X.509 cert 'openSUSE Secure Boot Signkey: 0332fa9cbf0d88bf21924b0de82a09a54d5defc8'
[    1.238651] ima: No TPM chip found, activating TPM-bypass!
[    1.238654] ima: Allocated hash algorithm: sha256
[    1.238663] No architecture policies found
[    1.238676] evm: Initialising EVM extended attributes:
[    1.238676] evm: security.selinux
[    1.238677] evm: security.apparmor
[    1.238677] evm: security.ima
[    1.238678] evm: security.capability
[    1.238679] evm: HMAC attrs: 0x1
[    1.238980] rtc_cmos 00:03: setting system clock to 2019-10-04T19:37:55 UTC (1570217875)
[    1.507957] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.507984] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.508005] ata7: SATA link down (SStatus 0 SControl 300)
[    1.508014] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.508034] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.508056] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.508786] ata3.00: ATA-10: WDC WD40EFRX-68N32N0, 82.00A82, max UDMA/133
[    1.508789] ata3.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.508889] ata1.00: NCQ Send/Recv Log not supported
[    1.508892] ata1.00: ATA-9: Samsung SSD 840 PRO Series, DXM06B0Q, max UDMA/133
[    1.508895] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.509143] ata1.00: NCQ Send/Recv Log not supported
[    1.509147] ata1.00: configured for UDMA/133
[    1.509353] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 840  6B0Q PQ: 0 ANSI: 5
[    1.509415] ata3.00: configured for UDMA/133
[    1.509640] ata1.00: Enabling discard_zeroes_data
[    1.509777] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    1.509800] sd 0:0:0:0: [sda] Write Protect is off
[    1.509804] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.509840] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.509870] ata2.00: supports DRM functions and may not be fully accessible
[    1.510097] ata6.00: ATA-8: WDC WD10EARS-00Y5B1, 80.00A80, max UDMA/133
[    1.510101] ata6.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.510103] ata1.00: Enabling discard_zeroes_data
[    1.510697] ata2.00: ATA-11: Samsung SSD 860 EVO 1TB, RVT02B6Q, max UDMA/133
[    1.510699] ata2.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.511825]  sda: sda1 sda2 sda3
[    1.512291] ata1.00: Enabling discard_zeroes_data
[    1.512527] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.512790] ata6.00: configured for UDMA/133
[    1.513101] ata2.00: supports DRM functions and may not be fully accessible
[    1.516054] ata2.00: configured for UDMA/133
[    1.516315] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 860  2B6Q PQ: 0 ANSI: 5
[    1.516614] ata2.00: Enabling discard_zeroes_data
[    1.516754] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    1.516774] scsi 2:0:0:0: Direct-Access     ATA      WDC WD40EFRX-68N 0A82 PQ: 0 ANSI: 5
[    1.516783] sd 1:0:0:0: [sdb] Write Protect is off
[    1.516787] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.516827] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.517138] ata2.00: Enabling discard_zeroes_data
[    1.517150] sd 2:0:0:0: [sdc] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    1.517155] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    1.517182] sd 2:0:0:0: [sdc] Write Protect is off
[    1.517185] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.517226] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.518984]  sdb: sdb1
[    1.519386] ata2.00: Enabling discard_zeroes_data
[    1.520627] sd 1:0:0:0: [sdb] supports TCG Opal
[    1.520631] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.545543] ata4.00: ATA-10: ST1000LM035-1RK172, ACM1, max UDMA/133
[    1.545547] ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.556069]  sdc: sdc1
[    1.556739] sd 2:0:0:0: [sdc] Attached SCSI disk
[    1.683166] ata4.00: configured for UDMA/133
[    1.683439] scsi 3:0:0:0: Direct-Access     ATA      ST1000LM035-1RK1 ACM1 PQ: 0 ANSI: 5
[    1.683853] scsi 5:0:0:0: Direct-Access     ATA      WDC WD10EARS-00Y 0A80 PQ: 0 ANSI: 5
[    1.683900] sd 3:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    1.683904] sd 3:0:0:0: [sdd] 4096-byte physical blocks
[    1.683944] sd 3:0:0:0: [sdd] Write Protect is off
[    1.683947] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    1.683986] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.684195] sd 5:0:0:0: [sde] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    1.684228] sd 5:0:0:0: [sde] Write Protect is off
[    1.684232] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    1.684279] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.726164]  sde: sde1
[    1.726766] sd 5:0:0:0: [sde] Attached SCSI disk
[    1.734352]  sdd: sdd1
[    1.735039] sd 3:0:0:0: [sdd] Attached SCSI disk
[    1.987939] ata8: SATA link down (SStatus 0 SControl 300)
[    1.988576] Freeing unused kernel image memory: 1416K
[    1.988639] Write protecting the kernel read-only data: 14336k
[    1.989445] Freeing unused kernel image memory: 2008K
[    1.989666] Freeing unused kernel image memory: 404K
[    1.989683] Run /init as init process
[    2.004450] efivarfs: module verification failed: signature and/or required key missing - tainting kernel
[    2.013574] systemd[1]: systemd +suse.135.g0f9271c133 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    2.025576] systemd[1]: Detected architecture x86-64.
[    2.025580] systemd[1]: Running in initial RAM disk.
[    2.036742] systemd[1]: Set hostname to <zwei>.
[    2.099668] systemd[1]: Listening on udev Kernel Socket.
[    2.099706] systemd[1]: Reached target Timers.
[    2.099765] systemd[1]: Listening on udev Control Socket.
[    2.099824] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.099888] systemd[1]: Listening on Journal Socket.
[    2.100695] systemd[1]: Starting Load Kernel Modules...
[    2.103614] alua: device handler registered
[    2.103795] emc: device handler registered
[    2.103959] rdac: device handler registered
[    2.105794] device-mapper: uevent: version 1.0.3
[    2.105844] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialised: dm-devel at redhat.com
[    2.106719] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.106746] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.106772] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    2.106794] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.106818] sd 5:0:0:0: Attached scsi generic sg4 type 0
[    2.174391] tsc: Refined TSC clocksource calibration: 3700.042 MHz
[    2.174397] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6aaaf98e733, max_idle_ns: 881590608932 ns
[    2.174408] clocksource: Switched to clocksource tsc
[    2.441844] ACPI: bus type USB registered
[    2.441865] usbcore: registered new interface driver usbfs
[    2.441876] usbcore: registered new interface driver hub
[    2.441899] usbcore: registered new device driver usb
[    2.442445] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.443457] ehci-pci: EHCI PCI platform driver
[    2.443716] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    2.443722] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    2.443734] ehci-pci 0000:00:1a.0: debug port 2
[    2.447651] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    2.447671] ehci-pci 0000:00:1a.0: irq 23, io mem 0xfbf27000
[    2.454475] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.454518] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
[    2.454520] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.454522] usb usb1: Product: EHCI Host Controller
[    2.454523] usb usb1: Manufacturer: Linux 5.3.0-desktop-saa716x+ ehci_hcd
[    2.454524] usb usb1: SerialNumber: 0000:00:1a.0
[    2.454924] hub 1-0:1.0: USB hub found
[    2.454932] hub 1-0:1.0: 2 ports detected
[    2.455078] xhci_hcd 0000:06:00.0: xHCI Host Controller
[    2.455086] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 2
[    2.504437] firewire_ohci 0000:09:00.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x10
[    2.514430] xhci_hcd 0000:06:00.0: hcc params 0x0200f180 hci version 0x96 quirks 0x0000000000080000
[    2.514683] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
[    2.514684] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.514685] usb usb2: Product: xHCI Host Controller
[    2.514686] usb usb2: Manufacturer: Linux 5.3.0-desktop-saa716x+ xhci-hcd
[    2.514686] usb usb2: SerialNumber: 0000:06:00.0
[    2.514771] hub 2-0:1.0: USB hub found
[    2.514779] hub 2-0:1.0: 2 ports detected
[    2.514881] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    2.514888] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 3
[    2.514891] xhci_hcd 0000:06:00.0: xHCI Host Controller
[    2.514893] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 4
[    2.514895] xhci_hcd 0000:06:00.0: Host supports USB 3.0 SuperSpeed
[    2.514902] ehci-pci 0000:00:1d.0: debug port 2
[    2.514915] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.514928] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
[    2.514929] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.514930] usb usb4: Product: xHCI Host Controller
[    2.514930] usb usb4: Manufacturer: Linux 5.3.0-desktop-saa716x+ xhci-hcd
[    2.514931] usb usb4: SerialNumber: 0000:06:00.0
[    2.514987] hub 4-0:1.0: USB hub found
[    2.514995] hub 4-0:1.0: 2 ports detected
[    2.518817] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    2.518821] ehci-pci 0000:00:1d.0: irq 23, io mem 0xfbf26000
[    2.525400] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.525424] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
[    2.525425] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.525426] usb usb3: Product: EHCI Host Controller
[    2.525426] usb usb3: Manufacturer: Linux 5.3.0-desktop-saa716x+ ehci_hcd
[    2.525427] usb usb3: SerialNumber: 0000:00:1d.0
[    2.525509] hub 3-0:1.0: USB hub found
[    2.525516] hub 3-0:1.0: 2 ports detected
[    2.525653] xhci_hcd 0000:07:00.0: xHCI Host Controller
[    2.525658] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 5
[    2.584991] xhci_hcd 0000:07:00.0: hcc params 0x0200f180 hci version 0x96 quirks 0x0000000000080000
[    2.585239] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
[    2.585240] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.585241] usb usb5: Product: xHCI Host Controller
[    2.585241] usb usb5: Manufacturer: Linux 5.3.0-desktop-saa716x+ xhci-hcd
[    2.585242] usb usb5: SerialNumber: 0000:07:00.0
[    2.585320] hub 5-0:1.0: USB hub found
[    2.585327] hub 5-0:1.0: 2 ports detected
[    2.585443] xhci_hcd 0000:07:00.0: xHCI Host Controller
[    2.585445] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 6
[    2.585447] xhci_hcd 0000:07:00.0: Host supports USB 3.0 SuperSpeed
[    2.585466] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.585479] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
[    2.585480] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.585481] usb usb6: Product: xHCI Host Controller
[    2.585481] usb usb6: Manufacturer: Linux 5.3.0-desktop-saa716x+ xhci-hcd
[    2.585482] usb usb6: SerialNumber: 0000:07:00.0
[    2.585541] hub 6-0:1.0: USB hub found
[    2.585548] hub 6-0:1.0: 2 ports detected
[    2.620031] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    2.776397] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.849393] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    2.867653] systemd-journald[278]: Received SIGTERM from PID 1 (systemd).
[    2.882728] printk: systemd: 26 output lines suppressed due to ratelimiting
[    2.904842] usb 1-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    2.904844] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.905125] hub 1-1:1.0: USB hub found
[    2.905210] hub 1-1:1.0: 6 ports detected
[    2.953740] systemd[1]: systemd +suse.135.g0f9271c133 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    2.954005] systemd[1]: Detected architecture x86-64.
[    2.954598] systemd[1]: Set hostname to <zwei>.
[    2.977711] usb 3-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    2.977712] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.977850] hub 3-1:1.0: USB hub found
[    2.977958] hub 3-1:1.0: 8 ports detected
[    3.006503] firewire_core 0000:09:00.0: created device fw0: GUID 001e8c0000640ad8, S400
[    3.026808] systemd[1]: /usr/lib/systemd/system/auditd.service:12: PIDFile= references a path below legacy directory /var/run/, updating /var/run/auditd.pid ? /run/auditd.pid; please update the unit file accordingly.
[    3.049911] systemd[1]: /usr/lib/systemd/system/display-manager.service:12: PIDFile= references a path below legacy directory /var/run/, updating /var/run/displaymanager.pid ? /run/displaymanager.pid; please update the unit file accordingly.
[    3.062646] systemd[1]: /usr/lib/systemd/system/chronyd.service:14: PIDFile= references a path below legacy directory /var/run/, updating /var/run/chrony/chronyd.pid ? /run/chrony/chronyd.pid; please update the unit file accordingly.
[    3.089457] systemd[1]: /usr/lib/systemd/system/pcscd.socket:5: ListenStream= references a path below legacy directory /var/run/, updating /var/run/pcscd/pcscd.comm ? /run/pcscd/pcscd.comm; please update the unit file accordingly.
[    3.126696] systemd[1]: initrd-switch-root.service: Succeeded.
[    3.126897] systemd[1]: Stopped Switch Root.
[    3.126978] systemd[1]: haveged.service: Service RestartSec=100ms expired, scheduling restart.
[    3.133538] EXT4-fs (sda2): re-mounted. Opts: (null)
[    3.157423] Adding 16777212k swap on /dev/sda3.  Priority:-2 extents:1 across:16777212k SSFS
[    3.180663] audit: type=1400 audit(1570217877.440:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ping" pid=536 comm="apparmor_parser"
[    3.204078] audit: type=1400 audit(1570217877.463:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ghostscript" pid=552 comm="apparmor_parser"
[    3.204080] audit: type=1400 audit(1570217877.463:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ghostscript///usr/bin/hpijs" pid=552 comm="apparmor_parser"
[    3.216295] audit: type=1400 audit(1570217877.475:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=562 comm="apparmor_parser"
[    3.225474] audit: type=1400 audit(1570217877.485:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=569 comm="apparmor_parser"
[    3.225476] audit: type=1400 audit(1570217877.485:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=569 comm="apparmor_parser"
[    3.234261] audit: type=1400 audit(1570217877.493:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="klogd" pid=576 comm="apparmor_parser"
[    3.243437] audit: type=1400 audit(1570217877.503:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslogd" pid=583 comm="apparmor_parser"
[    3.253037] audit: type=1400 audit(1570217877.512:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslog-ng" pid=590 comm="apparmor_parser"
[    3.254392] usb 3-1.3: new full-speed USB device number 3 using ehci-pci
[    3.330424] systemd-journald[509]: Received request to flush runtime journal from PID 1
[    3.337725] usb 3-1.3: New USB device found, idVendor=1532, idProduct=0101, bcdDevice=21.00
[    3.337727] usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.337728] usb 3-1.3: Product: Razer Copperhead Laser Mouse
[    3.337729] usb 3-1.3: Manufacturer: Razer
[    3.403412] usb 3-1.6: new low-speed USB device number 4 using ehci-pci
[    3.442254] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    3.451744] ACPI: Power Button [PWRB]
[    3.451837] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    3.454455] ACPI: Power Button [PWRF]
[    3.487720] pps_core: LinuxPPS API ver. 1 registered
[    3.487721] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.510967] usb 3-1.6: New USB device found, idVendor=046d, idProduct=c30e, bcdDevice= 1.80
[    3.510969] usb 3-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.510970] usb 3-1.6: Product: HID compliant keyboard
[    3.510971] usb 3-1.6: Manufacturer: Logitech
[    3.512909] PTP clock support registered
[    3.513273] i801_smbus 0000:00:1f.3: enabling device (0001 -> 0003)
[    3.513456] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    3.526212] cryptd: max_cpu_qlen set to 1000
[    3.541571] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    3.541572] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.541762] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.544395] asus_wmi: ASUS WMI generic driver loaded
[    3.544936] asus_wmi: Initialization: 0x0
[    3.544975] asus_wmi: BIOS WMI version: 0.9
[    3.545051] asus_wmi: SFUN value: 0x0
[    3.545053] eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
[    3.545966] AVX version of gcm_enc/dec engaged.
[    3.545967] AES CTR mode by8 optimization enabled
[    3.548300] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input2
[    3.582549] iTCO_vendor_support: vendor-support=0
[    3.587642] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    3.587815] iTCO_wdt: Found a Patsburg TCO device (Version=2, TCOBASE=0x0460)
[    3.587911] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    3.613576] usbcore: registered new interface driver usbhid
[    3.613577] usbhid: USB HID core driver
[    3.615728] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[    3.615958] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[    3.616007] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    3.616008] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    3.652693] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[    3.660892] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.3/3-1.3:1.0/0003:1532:0101.0001/input/input3
[    3.661372] hid-generic 0003:1532:0101.0001: input,hidraw0: USB HID v10.01 Mouse [Razer Razer Copperhead Laser Mouse] on usb-0000:00:1d.0-1.3/input0
[    3.661536] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.3/3-1.3:1.1/0003:1532:0101.0002/input/input4
[    3.671864] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input5
[    3.685703] [drm] radeon kernel modesetting enabled.
[    3.685763] radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 0: 0xc0000000 -> 0xcfffffff
[    3.685764] radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 2: 0xd0000000 -> 0xd07fffff
[    3.685766] radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 5: 0xfbe00000 -> 0xfbe3ffff
[    3.685767] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    3.685942] radeon 0000:01:00.0: CIK support disabled by module param
[    3.686468] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[    3.686471] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    3.686474] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    3.686476] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    3.686477] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[    3.686478] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    3.686480] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    3.686482] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    3.686484] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    3.699495] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    3.700483] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.700495] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.700499] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.700503] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.700507] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.700508] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.700512] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.700514] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.700518] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.700519] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.700523] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.700525] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.700529] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.700530] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.700534] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.700535] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.700539] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.700543] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.700547] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.700551] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.700554] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.700559] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.700563] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.700566] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.700572] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.700572] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.700577] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.700578] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.700583] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.700602] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.700609] EDAC sbridge: Couldn't find mci handler
[    3.700612] EDAC sbridge: Failed to register device with error -19.
[    3.700754] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    3.700755] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    3.713601] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input6
[    3.713673] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input7
[    3.713756] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[    3.713846] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input8
[    3.713918] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input9
[    3.713938] hid-generic 0003:1532:0101.0002: input,hidraw1: USB HID v10.01 Keyboard [Razer Razer Copperhead Laser Mouse] on usb-0000:00:1d.0-1.3/input1
[    3.713992] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    3.714073] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[    3.714154] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input10
[    3.714347] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[    3.714411] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[    3.714480] input: HDA Intel PCH Line Out Side as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[    3.714557] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[    3.714800] input: Logitech HID compliant keyboard as /devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.6/3-1.6:1.0/0003:046D:C30E.0003/input/input19
[    3.726635] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.726653] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.726657] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.726661] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.726664] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.726666] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.726669] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.726671] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.726674] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.726676] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.726679] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.726680] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.726683] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.726685] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.726688] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.726689] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.726693] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.726697] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.726701] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.726705] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.726709] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.726712] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.726716] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.726721] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.726725] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.726726] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.726730] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.726731] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.726736] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.726755] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.726763] EDAC sbridge: Couldn't find mci handler
[    3.726766] EDAC sbridge: Failed to register device with error -19.
[    3.728368] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[    3.750910] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) ac:22:0b:cc:2b:0f
[    3.750911] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.750949] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
[    3.765312] e1000e 0000:00:19.0 eno1: renamed from eth0
[    3.767503] hid-generic 0003:046D:C30E.0003: input,hidraw2: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on usb-0000:00:1d.0-1.6/input0
[    3.767598] input: Logitech HID compliant keyboard Consumer Control as /devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.6/3-1.6:1.1/0003:046D:C30E.0004/input/input20
[    3.783135] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.783147] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.783153] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.783160] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.783165] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.783168] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.783173] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.783176] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.783181] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.783184] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.783189] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.783191] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.783197] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.783199] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.783205] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.783207] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.783214] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.783220] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.783227] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.783234] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.783240] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.783247] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.783253] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.783260] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.783267] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.783268] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.783275] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.783276] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.783283] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.783312] [drm] amdgpu kernel modesetting enabled.
[    3.783316] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.783331] EDAC sbridge: Couldn't find mci handler
[    3.783336] EDAC sbridge: Failed to register device with error -19.
[    3.783899] CRAT table not found
[    3.783904] Virtual CRAT table created for CPU
[    3.783905] Parsing CRAT table with 1 nodes
[    3.783907] Creating topology SYSFS entries
[    3.783932] Topology: Add CPU node
[    3.783933] Finished initializing topology
[    3.784024] amdgpu 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 0: 0xc0000000 -> 0xcfffffff
[    3.784040] amdgpu 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 2: 0xd0000000 -> 0xd07fffff
[    3.784042] amdgpu 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 5: 0xfbe00000 -> 0xfbe3ffff
[    3.784044] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
[    3.784452] [drm] initializing kernel modesetting (HAWAII 0x1002:0x67B1 0x1458:0x228F 0x00).
[    3.784464] [drm] register mmio base: 0xFBE00000
[    3.784465] [drm] register mmio size: 262144
[    3.784475] [drm] add ip block number 0 <cik_common>
[    3.784487] [drm] add ip block number 1 <gmc_v7_0>
[    3.784488] [drm] add ip block number 2 <cik_ih>
[    3.784490] [drm] add ip block number 3 <gfx_v7_0>
[    3.784491] [drm] add ip block number 4 <cik_sdma>
[    3.784492] [drm] add ip block number 5 <powerplay>
[    3.784493] [drm] add ip block number 6 <dm>
[    3.784494] [drm] add ip block number 7 <uvd_v4_2>
[    3.784495] [drm] add ip block number 8 <vce_v2_0>
[    3.784543] ATOM BIOS: xxx-xxx-xxx
[    3.784624] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[    3.785103] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[    3.785480] intel_rapl_common: Found RAPL domain package
[    3.785482] intel_rapl_common: Found RAPL domain core
[    3.787343] EXT4-fs (sde1): mounted filesystem with ordered data mode. Opts: (null)
[    3.788135] amdgpu 0000:01:00.0: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)
[    3.788136] amdgpu 0000:01:00.0: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
[    3.788143] [drm] Detected VRAM RAM=4096M, BAR=256M
[    3.788144] [drm] RAM width 512bits GDDR5
[    3.788193] [TTM] Zone  kernel: Available graphics memory: 8171992 KiB
[    3.788194] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    3.788195] [TTM] Initializing pool allocator
[    3.788211] [TTM] Initializing DMA pool allocator
[    3.788474] [drm] amdgpu: 4096M of VRAM memory ready
[    3.788477] [drm] amdgpu: 4096M of GTT memory ready.
[    3.788488] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    3.789050] [drm] PCIE GART of 1024M enabled (table at 0x000000F400300000).
[    3.794717] amdgpu: [powerplay] hwmgr_sw_init smu backed is ci_smu
[    3.805033] [drm] Found UVD firmware Version: 1.64 Family ID: 9
[    3.809924] [drm] Found VCE firmware Version: 50.10 Binary ID: 2
[    3.810168] [drm] PCIE gen 3 link speeds already enabled
[    3.810627] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.810636] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.810640] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.810644] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.810646] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.810648] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.810651] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.810652] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.810655] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.810657] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.810660] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.810661] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.810664] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.810665] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.810668] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.810670] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.810673] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.810677] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.810681] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.810685] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.810688] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.810692] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.810696] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.810699] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.810703] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.810704] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.810707] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.810708] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.810712] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.810729] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.810736] EDAC sbridge: Couldn't find mci handler
[    3.810739] EDAC sbridge: Failed to register device with error -19.
[    3.820466] input: Logitech HID compliant keyboard System Control as /devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.6/3-1.6:1.1/0003:046D:C30E.0004/input/input21
[    3.820512] hid-generic 0003:046D:C30E.0004: input,hidraw3: USB HID v1.10 Device [Logitech HID compliant keyboard] on usb-0000:00:1d.0-1.6/input1
[    3.830331] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[    3.830866] [drm] dce110_link_encoder_construct: Failed to get encoder_cap_info from VBIOS with error code 4!
[    3.830878] [drm] dce110_link_encoder_construct: Failed to get encoder_cap_info from VBIOS with error code 4!
[    3.830889] [drm] dce110_link_encoder_construct: Failed to get encoder_cap_info from VBIOS with error code 4!
[    3.831928] EXT4-fs (sdd1): mounted filesystem with ordered data mode. Opts: (null)
[    3.833414] [drm] Display Core initialized with v3.2.48!
[    3.833452] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops 0xffffffffc0dc36a0)
[    3.843636] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.843652] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.843657] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.843663] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.843667] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.843669] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.843672] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.843674] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.843677] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.843679] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.843683] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.843684] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.843688] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.843689] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.843693] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.843694] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.843699] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.843703] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.843708] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.843712] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.843717] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.843721] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.843725] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.843730] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.843734] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.843735] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.843739] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.843742] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.843747] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.843766] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.843774] EDAC sbridge: Couldn't find mci handler
[    3.843779] EDAC sbridge: Failed to register device with error -19.
[    3.864013] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.864014] [drm] Driver supports precise vblank timestamp query.
[    3.868597] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.868605] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.868608] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.868611] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.868614] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.868615] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.868618] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.868619] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.868621] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.868623] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.868625] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.868627] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.868632] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.868633] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.868636] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.868638] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.868642] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.868646] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.868650] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.868654] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.868658] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.868661] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.868666] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.868670] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.868674] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.868675] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.868680] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.868680] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.868685] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.868704] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.868712] EDAC sbridge: Couldn't find mci handler
[    3.868715] EDAC sbridge: Failed to register device with error -19.
[    3.899454] [drm] UVD initialized successfully.
[    3.922653] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.922725] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.922731] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.922735] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.922739] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.922741] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.922745] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.922746] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.922750] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.922751] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.922755] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.922756] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.922760] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.922761] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.922765] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.922766] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.922770] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.922774] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.922778] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.922782] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.922786] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.922790] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.922794] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.922798] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.922802] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.922803] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.922807] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.922808] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.922812] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.922880] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.922890] EDAC sbridge: Couldn't find mci handler
[    3.922894] EDAC sbridge: Failed to register device with error -19.
[    3.943064] Loading iSCSI transport class v2.0-870.
[    3.970641] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.970651] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    3.970655] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    3.970659] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.970663] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    3.970664] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.970667] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    3.970669] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.970672] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    3.970674] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.970677] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    3.970679] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.970682] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    3.970684] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.970687] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    3.970689] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    3.970693] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    3.970697] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    3.970701] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    3.970705] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    3.970709] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    3.970713] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    3.970717] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    3.970722] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.970726] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    3.970726] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.970730] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    3.970731] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.970735] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    3.970755] EDAC sbridge: CPU SrcID #0, Ha #0, Channel #0 has DIMMs, but ECC is disabled
[    3.970763] EDAC sbridge: Couldn't find mci handler
[    3.970765] EDAC sbridge: Failed to register device with error -19.
[    4.020505] [drm] VCE initialized successfully.
[    4.023314] kfd kfd: Allocated 3969056 bytes on gart
[    4.024813] Virtual CRAT table created for GPU
[    4.024814] Parsing CRAT table with 1 nodes
[    4.024826] Creating topology SYSFS entries
[    4.024945] Topology: Add dGPU node [0x67b1:0x1002]
[    4.024947] kfd kfd: added device 1002:67b1
[    4.026251] [drm] fb mappable at 0xC06EB000
[    4.026252] [drm] vram apper at 0xC0000000
[    4.026252] [drm] size 8294400
[    4.026253] [drm] fb depth is 24
[    4.026253] [drm]    pitch is 7680
[    4.026308] fbcon: amdgpudrmfb (fb0) is primary device
[    4.041586] Console: switching to colour frame buffer device 240x67
[    4.059339] amdgpu 0000:01:00.0: fb0: amdgpudrmfb frame buffer device
[    4.080560] [drm] Initialized amdgpu 3.34.0 20150101 for 0000:01:00.0 on minor 0
[   10.248188] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   10.248225] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   10.388220] NET: Registered protocol family 17
[   16.950062] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   23.616019] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   30.261959] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   36.962899] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   43.584839] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   50.236837] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   56.904738] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   63.588176] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   70.337656] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   77.094599] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   83.771557] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   90.362493] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
