From: Marco Berizzi <pupilla@libero.it>
Date: Wed, 21 Mar 2018 17:19:43 +0100 (CET)
Subject: [Intel-wired-lan] e1000e Detected Hardware Unit Hang
In-Reply-To: <1969863829.1651192.1521629811656@mail.libero.it>
References: <1969863829.1651192.1521629811656@mail.libero.it>
Message-ID: <1317189213.22495.1521649183803@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Marco Berizzi wrote:
> 
> Hello everyone,
> 
> I'm getting this error with a Slackware linux 64bit running 4.16-rc6:
> I have also done a full hardware replacement, but the problem is still
> present. This box is running squid, named, sshd and strongswan.
> 
> On february 3, I have replaced the network switch where this NIC is
> connected to (from cisco 3750 to HPE 5130).
> As you may see, the problem has popped up from Feb 13 with linux
> 4.15.3, but yesterday the problem has arisen also with 4.15.2 (I
> wanted to start a git bisect, but it is pointless).

I think I have found the root cause. Before getting this error the
interface MTU was 9000bytes, and now it is 1500bytes.
 
> Any response are welcome.
> 
> TIA
> 
> This is the 'grep Reset /var/log/kernel':
> 
> Feb 13 10:57:31 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 10:58:13 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 10:58:29 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 10:58:55 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 10:59:10 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 10:59:41 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 10:59:56 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:00:27 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:00:42 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:01:14 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:11:25 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:11:40 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:12:18 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:12:49 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 11:13:04 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 13 16:13:33 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 14 12:01:50 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 14 15:28:08 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 15 14:17:05 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 19 13:32:32 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 20 15:57:28 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 21 11:03:41 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 22 11:08:35 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 22 16:47:18 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Feb 28 16:18:10 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 1 16:13:35 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 2 10:02:46 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 5 10:35:13 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 5 10:55:46 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 6 12:12:07 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 13 13:10:47 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 14 10:40:27 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 14 14:35:38 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 15 18:17:04 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 16 14:49:28 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 19 13:08:08 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 19 15:12:51 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 19 15:36:41 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 19 17:15:53 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 20 09:48:38 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 20 10:39:42 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 20 15:06:23 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> 
> and 'last | grep reboot':
> 
> reboot system boot 4.16.0-rc6 Tue Mar 20 23:13 - 11:31 (12:18)
> reboot system boot 4.15.2 Tue Mar 20 13:25 - 23:12 (09:46)
> reboot system boot 4.16.0-rc6 Mon Mar 19 13:32 - 13:25 (23:52)
> reboot system boot 4.16.0-rc5 Tue Mar 13 08:56 - 13:32 (6+04:36)
> reboot system boot 4.16.0-rc4 Wed Mar 7 13:15 - 08:55 (5+19:40)
> [hardware replacement]
> reboot system boot 4.15.7 Wed Feb 28 21:27 - 13:15 (6+15:47)
> reboot system boot 4.15.6 Mon Feb 26 13:10 - 21:26 (2+08:16)
> reboot system boot 4.15.5 Fri Feb 23 13:25 - 13:09 (2+23:43)
> reboot system boot 4.15.4 Fri Feb 16 18:29 - 13:24 (6+18:55)
> reboot system boot 4.15.3 Tue Feb 13 04:32 - 18:28 (3+13:56)
> reboot system boot 4.15.2 Thu Feb 8 19:03 - 04:32 (4+09:28)
> reboot system boot 4.15.1 Mon Feb 5 13:29 - 19:03 (3+05:33)
> [network switch replacement from Cisco 3750 to HPE 5130 done]
> reboot system boot 4.15.0 Mon Jan 29 13:46 - 13:29 (6+23:42)
> reboot system boot 4.15.0-rc9 Mon Jan 22 13:16 - 13:46 (7+00:30)
> reboot system boot 4.15.0-rc8 Mon Jan 15 13:26 - 13:15 (6+23:49)
> reboot system boot 4.15.0-rc7 Mon Jan 8 18:59 - 13:26 (6+18:26)
> reboot system boot 4.15.0-rc6 Thu Jan 4 12:58 - 18:58 (4+05:59)
> reboot system boot 4.15.0-rc6 Thu Jan 4 11:04 - 12:12 (01:07)
> 
> Mar 19 13:32:48 Pleiadi kernel: klogd 1.5.1, log source = /proc/kmsg started.
> Mar 19 13:32:48 Pleiadi kernel: Linux version 4.16.0-rc6 (root at Pleiadi) (gcc version 5.5.0 (GCC)) #1 SMP Mon Mar 19 12:52:22 CET 2018
> Mar 19 13:32:48 Pleiadi kernel: Command line: auto BOOT_IMAGE=Linux ro root=805 vt.default_utf8=0
> Mar 19 13:32:48 Pleiadi kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> Mar 19 13:32:48 Pleiadi kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> Mar 19 13:32:48 Pleiadi kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> Mar 19 13:32:48 Pleiadi kernel: x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
> Mar 19 13:32:48 Pleiadi kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> Mar 19 13:32:48 Pleiadi kernel: e820: BIOS-provided physical RAM map:
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x0000000020200000-0x0000000040003fff] usable
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x0000000040004000-0x0000000040004fff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x0000000040005000-0x00000000d4176fff] usable
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d4177000-0x00000000d4622fff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d4623000-0x00000000d463cfff] ACPI data
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d463d000-0x00000000d6609fff] ACPI NVS
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d660a000-0x00000000d67d2fff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d67d3000-0x00000000d67d3fff] usable
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d67d4000-0x00000000d6816fff] ACPI NVS
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d6817000-0x00000000d6ffffff] usable
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000d7000000-0x00000000df9fffff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> Mar 19 13:32:48 Pleiadi kernel: BIOS-e820: [mem 0x0000000100000000-0x000000011e5fffff] usable
> Mar 19 13:32:48 Pleiadi kernel: NX (Execute Disable) protection: active
> Mar 19 13:32:48 Pleiadi kernel: random: fast init done
> Mar 19 13:32:48 Pleiadi kernel: SMBIOS 2.7 present.
> Mar 19 13:32:48 Pleiadi kernel: DMI: LENOVO 3220A11/MAHOBAY, BIOS 9SKT99AUS 06/30/2017
> Mar 19 13:32:48 Pleiadi kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> Mar 19 13:32:48 Pleiadi kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
> Mar 19 13:32:48 Pleiadi kernel: e820: last_pfn = 0x11e600 max_arch_pfn = 0x400000000
> Mar 19 13:32:48 Pleiadi kernel: MTRR default type: uncachable
> Mar 19 13:32:48 Pleiadi kernel: MTRR fixed ranges enabled:
> Mar 19 13:32:48 Pleiadi kernel: 00000-9FFFF write-back
> Mar 19 13:32:48 Pleiadi kernel: A0000-BFFFF uncachable
> Mar 19 13:32:48 Pleiadi kernel: C0000-CFFFF write-protect
> Mar 19 13:32:48 Pleiadi kernel: D0000-E7FFF uncachable
> Mar 19 13:32:48 Pleiadi kernel: E8000-FFFFF write-protect
> Mar 19 13:32:48 Pleiadi kernel: MTRR variable ranges enabled:
> Mar 19 13:32:48 Pleiadi kernel: 0 base 000000000 mask F00000000 write-back
> Mar 19 13:32:48 Pleiadi kernel: 1 base 100000000 mask FE0000000 write-back
> Mar 19 13:32:48 Pleiadi kernel: 2 base 0E0000000 mask FE0000000 uncachable
> Mar 19 13:32:48 Pleiadi kernel: 3 base 0D8000000 mask FF8000000 uncachable
> Mar 19 13:32:48 Pleiadi kernel: 4 base 0D7800000 mask FFF800000 uncachable
> Mar 19 13:32:48 Pleiadi kernel: 5 base 11F000000 mask FFF000000 uncachable
> Mar 19 13:32:48 Pleiadi kernel: 6 base 11E800000 mask FFF800000 uncachable
> Mar 19 13:32:48 Pleiadi kernel: 7 base 11E600000 mask FFFE00000 uncachable
> Mar 19 13:32:48 Pleiadi kernel: 8 disabled
> Mar 19 13:32:48 Pleiadi kernel: 9 disabled
> Mar 19 13:32:48 Pleiadi kernel: x86/PAT: Configuration [0-7]: WB WC UC- UC WB WP UC- WT
> Mar 19 13:32:48 Pleiadi kernel: e820: update [mem 0xd7800000-0xffffffff] usable ==> reserved
> Mar 19 13:32:48 Pleiadi kernel: e820: last_pfn = 0xd7000 max_arch_pfn = 0x400000000
> Mar 19 13:32:48 Pleiadi kernel: Base memory trampoline at [ (ptrval)] 97000 size 24576
> Mar 19 13:32:48 Pleiadi kernel: BRK [0x01cbd000, 0x01cbdfff] PGTABLE
> Mar 19 13:32:48 Pleiadi kernel: BRK [0x01cbe000, 0x01cbefff] PGTABLE
> Mar 19 13:32:48 Pleiadi kernel: BRK [0x01cbf000, 0x01cbffff] PGTABLE
> Mar 19 13:32:48 Pleiadi kernel: BRK [0x01cc0000, 0x01cc0fff] PGTABLE
> Mar 19 13:32:48 Pleiadi kernel: BRK [0x01cc1000, 0x01cc1fff] PGTABLE
> Mar 19 13:32:48 Pleiadi kernel: BRK [0x01cc2000, 0x01cc2fff] PGTABLE
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Early table checksum verification disabled
> Mar 19 13:32:48 Pleiadi kernel: ACPI: RSDP 0x00000000000F0450 000024 (v02 LENOVO)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: XSDT 0x00000000D4628080 000084 (v01 LENOVO TC-9S 00001620 AMI 00010013)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: FACP 0x00000000D463A638 00010C (v05 LENOVO TC-9S 00001620 AMI 00010013)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: DSDT 0x00000000D4628198 01249E (v02 LENOVO TC-9S 00001620 INTL 20051117)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: FACS 0x00000000D65F7080 000040
> Mar 19 13:32:48 Pleiadi kernel: ACPI: APIC 0x00000000D463A748 000072 (v03 LENOVO TC-9S 00001620 AMI 00010013)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: FPDT 0x00000000D463A7C0 000044 (v01 LENOVO TC-9S 00001620 AMI 00010013)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: MCFG 0x00000000D463A808 00003C (v01 LENOVO TC-9S 00001620 MSFT 00000097)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: SLIC 0x00000000D463A848 000176 (v01 LENOVO TC-9S 00001620 AMI 00010013)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: HPET 0x00000000D463A9C0 000038 (v01 LENOVO TC-9S 00001620 AMI. 00000005)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: SSDT 0x00000000D463A9F8 00036D (v01 LENOVO TC-9S 00001620 INTL 20091112)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: SSDT 0x00000000D463AD68 0009AA (v01 LENOVO TC-9S 00001620 INTL 20051117)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: SSDT 0x00000000D463B718 000B22 (v01 LENOVO TC-9S 00001620 INTL 20051117)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: ASF! 0x00000000D463C240 0000A5 (v32 LENOVO TC-9S 00001620 TFSM 000F4240)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: BGRT 0x00000000D463C2E8 000038 (v00 LENOVO TC-9S 00001620 AMI 00010013)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: TCPA 0x00000000D463C320 000032 (v02 LENOVO TC-9S 00001620 MSFT 01000013)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Local APIC address 0xfee00000
> Mar 19 13:32:48 Pleiadi kernel: tsc: Fast TSC calibration using PIT
> Mar 19 13:32:48 Pleiadi kernel: Zone ranges:
> Mar 19 13:32:48 Pleiadi kernel: DMA [mem 0x0000000000001000-0x0000000000ffffff]
> Mar 19 13:32:48 Pleiadi kernel: DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
> Mar 19 13:32:48 Pleiadi kernel: Normal [mem 0x0000000100000000-0x000000011e5fffff]
> Mar 19 13:32:48 Pleiadi kernel: Movable zone start for each node
> Mar 19 13:32:48 Pleiadi kernel: Early memory node ranges
> Mar 19 13:32:48 Pleiadi kernel: node 0: [mem 0x0000000000001000-0x000000000009cfff]
> Mar 19 13:32:48 Pleiadi kernel: node 0: [mem 0x0000000000100000-0x000000001fffffff]
> Mar 19 13:32:48 Pleiadi kernel: node 0: [mem 0x0000000020200000-0x0000000040003fff]
> Mar 19 13:32:48 Pleiadi kernel: node 0: [mem 0x0000000040005000-0x00000000d4176fff]
> Mar 19 13:32:48 Pleiadi kernel: node 0: [mem 0x00000000d67d3000-0x00000000d67d3fff]
> Mar 19 13:32:48 Pleiadi kernel: node 0: [mem 0x00000000d6817000-0x00000000d6ffffff]
> Mar 19 13:32:48 Pleiadi kernel: node 0: [mem 0x0000000100000000-0x000000011e5fffff]
> Mar 19 13:32:48 Pleiadi kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000011e5fffff]
> Mar 19 13:32:48 Pleiadi kernel: On node 0 totalpages: 994556
> Mar 19 13:32:48 Pleiadi kernel: DMA zone: 64 pages used for memmap
> Mar 19 13:32:48 Pleiadi kernel: DMA zone: 21 pages reserved
> Mar 19 13:32:48 Pleiadi kernel: DMA zone: 3996 pages, LIFO batch:0
> Mar 19 13:32:48 Pleiadi kernel: DMA32 zone: 13534 pages used for memmap
> Mar 19 13:32:48 Pleiadi kernel: DMA32 zone: 866144 pages, LIFO batch:31
> Mar 19 13:32:48 Pleiadi kernel: Normal zone: 1944 pages used for memmap
> Mar 19 13:32:48 Pleiadi kernel: Normal zone: 124416 pages, LIFO batch:31
> Mar 19 13:32:48 Pleiadi kernel: Reserved but unavailable: 100 pages
> Mar 19 13:32:48 Pleiadi kernel: Reserving Intel graphics memory at [mem 0xd7a00000-0xdf9fffff]
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PM-Timer IO Port: 0x408
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Local APIC address 0xfee00000
> Mar 19 13:32:48 Pleiadi kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> Mar 19 13:32:48 Pleiadi kernel: IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> Mar 19 13:32:48 Pleiadi kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: IRQ0 used by override.
> Mar 19 13:32:48 Pleiadi kernel: ACPI: IRQ9 used by override.
> Mar 19 13:32:48 Pleiadi kernel: Using ACPI (MADT) for SMP configuration information
> Mar 19 13:32:48 Pleiadi kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
> Mar 19 13:32:48 Pleiadi kernel: smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> Mar 19 13:32:48 Pleiadi kernel: e820: [mem 0xdfa00000-0xf7ffffff] available for PCI devices
> Mar 19 13:32:48 Pleiadi kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> Mar 19 13:32:48 Pleiadi kernel: setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> Mar 19 13:32:48 Pleiadi kernel: percpu: Embedded 41 pages/cpu @ (ptrval) s129944 r8192 d29800 u524288
> Mar 19 13:32:48 Pleiadi kernel: pcpu-alloc: s129944 r8192 d29800 u524288 alloc=1*2097152
> Mar 19 13:32:48 Pleiadi kernel: pcpu-alloc: [0] 0 1 2 3
> Mar 19 13:32:48 Pleiadi kernel: Built 1 zonelists, mobility grouping on. Total pages: 978993
> Mar 19 13:32:48 Pleiadi kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=805 vt.default_utf8=0
> Mar 19 13:32:48 Pleiadi kernel: Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Mar 19 13:32:48 Pleiadi kernel: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Mar 19 13:32:48 Pleiadi kernel: Memory: 3828752K/3978224K available (6152K kernel code, 333K rwdata, 1220K rodata, 764K init, 460K bss, 149472K reserved, 0K cma-reserved)
> Mar 19 13:32:48 Pleiadi kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> Mar 19 13:32:48 Pleiadi kernel: Kernel/User page tables isolation: enabled
> Mar 19 13:32:48 Pleiadi kernel: Hierarchical RCU implementation.
> Mar 19 13:32:48 Pleiadi kernel: NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: 16
> Mar 19 13:32:48 Pleiadi kernel: Console: colour VGA+ 80x25
> Mar 19 13:32:48 Pleiadi kernel: console [tty0] enabled
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Core revision 20180105
> Mar 19 13:32:48 Pleiadi kernel: ACPI: 4 ACPI AML tables successfully acquired and loaded
> Mar 19 13:32:48 Pleiadi kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> Mar 19 13:32:48 Pleiadi kernel: hpet clockevent registered
> Mar 19 13:32:48 Pleiadi kernel: APIC: Switch to symmetric I/O mode setup
> Mar 19 13:32:48 Pleiadi kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
> Mar 19 13:32:48 Pleiadi kernel: tsc: Fast TSC calibration using PIT
> Mar 19 13:32:48 Pleiadi kernel: tsc: Detected 3192.794 MHz processor
> Mar 19 13:32:48 Pleiadi kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e05b2c1dde, max_idle_ns: 440795275151 ns
> Mar 19 13:32:48 Pleiadi kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 6385.58 BogoMIPS (lpj=3192794)
> Mar 19 13:32:48 Pleiadi kernel: pid_max: default: 32768 minimum: 301
> Mar 19 13:32:48 Pleiadi kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Mar 19 13:32:48 Pleiadi kernel: Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Mar 19 13:32:48 Pleiadi kernel: CPU: Physical Processor ID: 0
> Mar 19 13:32:48 Pleiadi kernel: CPU: Processor Core ID: 0
> Mar 19 13:32:48 Pleiadi kernel: ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> Mar 19 13:32:48 Pleiadi kernel: ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> Mar 19 13:32:48 Pleiadi kernel: process: using mwait in idle threads
> Mar 19 13:32:48 Pleiadi kernel: Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> Mar 19 13:32:48 Pleiadi kernel: Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> Mar 19 13:32:48 Pleiadi kernel: Spectre V2 : Mitigation: Full generic retpoline
> Mar 19 13:32:48 Pleiadi kernel: Freeing SMP alternatives memory: 20K
> Mar 19 13:32:48 Pleiadi kernel: TSC deadline timer enabled
> Mar 19 13:32:48 Pleiadi kernel: smpboot: CPU0: Intel(R) Core(TM) i5-3470 CPU @ 3.20GHz (family: 0x6, model: 0x3a, stepping: 0x9)
> Mar 19 13:32:48 Pleiadi kernel: Performance Events: PEBS fmt1+, IvyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
> Mar 19 13:32:48 Pleiadi kernel: ... version: 3
> Mar 19 13:32:48 Pleiadi kernel: ... bit width: 48
> Mar 19 13:32:48 Pleiadi kernel: ... generic registers: 8
> Mar 19 13:32:48 Pleiadi kernel: ... value mask: 0000ffffffffffff
> Mar 19 13:32:48 Pleiadi kernel: ... max period: 00007fffffffffff
> Mar 19 13:32:48 Pleiadi kernel: ... fixed-purpose events: 3
> Mar 19 13:32:48 Pleiadi kernel: ... event mask: 00000007000000ff
> Mar 19 13:32:48 Pleiadi kernel: Hierarchical SRCU implementation.
> Mar 19 13:32:48 Pleiadi kernel: smp: Bringing up secondary CPUs ...
> Mar 19 13:32:48 Pleiadi kernel: x86: Booting SMP configuration:
> Mar 19 13:32:48 Pleiadi kernel: .... node #0, CPUs: #1 #2 #3
> Mar 19 13:32:48 Pleiadi kernel: smp: Brought up 1 node, 4 CPUs
> Mar 19 13:32:48 Pleiadi kernel: smpboot: Max logical packages: 1
> Mar 19 13:32:48 Pleiadi kernel: smpboot: Total of 4 processors activated (25542.35 BogoMIPS)
> Mar 19 13:32:48 Pleiadi kernel: devtmpfs: initialized
> Mar 19 13:32:48 Pleiadi kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> Mar 19 13:32:48 Pleiadi kernel: futex hash table entries: 1024 (order: 4, 65536 bytes)
> Mar 19 13:32:48 Pleiadi kernel: xor: automatically using best checksumming function avx
> Mar 19 13:32:48 Pleiadi kernel: NET: Registered protocol family 16
> Mar 19 13:32:48 Pleiadi kernel: cpuidle: using governor ladder
> Mar 19 13:32:48 Pleiadi kernel: cpuidle: using governor menu
> Mar 19 13:32:48 Pleiadi kernel: ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> Mar 19 13:32:48 Pleiadi kernel: ACPI: bus type PCI registered
> Mar 19 13:32:48 Pleiadi kernel: PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> Mar 19 13:32:48 Pleiadi kernel: PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
> Mar 19 13:32:48 Pleiadi kernel: pmd_set_huge: Cannot satisfy [mem 0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
> Mar 19 13:32:48 Pleiadi kernel: PCI: Using configuration type 1 for base access
> Mar 19 13:32:48 Pleiadi kernel: core: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
> Mar 19 13:32:48 Pleiadi kernel: raid6: sse2x1 gen() 8730 MB/s
> Mar 19 13:32:48 Pleiadi kernel: raid6: sse2x1 xor() 6357 MB/s
> Mar 19 13:32:48 Pleiadi kernel: raid6: sse2x2 gen() 10878 MB/s
> Mar 19 13:32:48 Pleiadi kernel: raid6: sse2x2 xor() 7568 MB/s
> Mar 19 13:32:48 Pleiadi kernel: raid6: sse2x4 gen() 12601 MB/s
> Mar 19 13:32:48 Pleiadi kernel: raid6: sse2x4 xor() 9439 MB/s
> Mar 19 13:32:48 Pleiadi kernel: raid6: using algorithm sse2x4 gen() 12601 MB/s
> Mar 19 13:32:48 Pleiadi kernel: raid6: .... xor() 9439 MB/s, rmw enabled
> Mar 19 13:32:48 Pleiadi kernel: raid6: using ssse3x2 recovery algorithm
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Added _OSI(Module Device)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Added _OSI(Processor Device)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Added _OSI(Processor Aggregator Device)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Executed 1 blocks of module-level executable AML code
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Dynamic OEM Table Load:
> Mar 19 13:32:48 Pleiadi kernel: ACPI: SSDT 0xFFFF880119A54000 00083B (v01 PmRef Cpu0Cst 00003001 INTL 20051117)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Dynamic OEM Table Load:
> Mar 19 13:32:48 Pleiadi kernel: ACPI: SSDT 0xFFFF880119BF2400 000303 (v01 PmRef ApIst 00003000 INTL 20051117)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Dynamic OEM Table Load:
> Mar 19 13:32:48 Pleiadi kernel: ACPI: SSDT 0xFFFF880119A1FC00 000119 (v01 PmRef ApCst 00003000 INTL 20051117)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Interpreter enabled
> Mar 19 13:32:48 Pleiadi kernel: ACPI: (supports S0 S5)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Using IOAPIC for interrupt routing
> Mar 19 13:32:48 Pleiadi kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Enabled 17 GPEs in block 00 to 3F
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Power Resource [FN00] (off)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Power Resource [FN01] (off)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Power Resource [FN02] (off)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Power Resource [FN03] (off)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Power Resource [FN04] (off)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
> Mar 19 13:32:48 Pleiadi kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> Mar 19 13:32:48 Pleiadi kernel: acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
> Mar 19 13:32:48 Pleiadi kernel: acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
> Mar 19 13:32:48 Pleiadi kernel: acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> Mar 19 13:32:48 Pleiadi kernel: PCI host bridge to bus 0000:00
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7 window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: root bus resource [bus 00-3e]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:00.0: [8086:0150] type 00 class 0x060000
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:01.0: [8086:0151] type 01 class 0x060400
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: [8086:0152] type 00 class 0x030000
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: reg 0x10: [mem 0xf7800000-0xf7bfffff 64bit]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: reg 0x20: [io 0xf000-0xf03f]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:14.0: reg 0x10: [mem 0xf7f20000-0xf7f2ffff 64bit]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:14.0: PME# supported from D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:16.0: reg 0x10: [mem 0xf7f38000-0xf7f3800f 64bit]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:16.3: reg 0x10: [io 0xf0e0-0xf0e7]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:16.3: reg 0x14: [mem 0xf7f36000-0xf7f36fff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:19.0: reg 0x10: [mem 0xf7f00000-0xf7f1ffff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:19.0: reg 0x14: [mem 0xf7f35000-0xf7f35fff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:19.0: reg 0x18: [io 0xf080-0xf09f]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1a.0: reg 0x10: [mem 0xf7f34000-0xf7f343ff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1d.0: reg 0x10: [mem 0xf7f33000-0xf7f333ff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.0: [8086:1e47] type 00 class 0x060100
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: [8086:1e02] type 00 class 0x010601
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: reg 0x10: [io 0xf0d0-0xf0d7]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: reg 0x14: [io 0xf0c0-0xf0c3]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: reg 0x18: [io 0xf0b0-0xf0b7]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: reg 0x1c: [io 0xf0a0-0xf0a3]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: reg 0x20: [io 0xf060-0xf07f]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: reg 0x24: [mem 0xf7f32000-0xf7f327ff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.2: PME# supported from D3hot
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.3: reg 0x10: [mem 0xf7f31000-0xf7f310ff 64bit]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1f.3: reg 0x20: [io 0xf040-0xf05f]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.0: [8086:1521] type 00 class 0x020000
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.0: reg 0x10: [mem 0xf7d00000-0xf7dfffff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.0: reg 0x1c: [mem 0xf7e84000-0xf7e87fff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.0: reg 0x30: [mem 0xf7e00000-0xf7e7ffff pref]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.1: [8086:1521] type 00 class 0x020000
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.1: reg 0x10: [mem 0xf7c00000-0xf7cfffff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.1: reg 0x1c: [mem 0xf7e80000-0xf7e83fff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:01:00.1: PME# supported from D0 D3hot D3cold
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:01.0: ASPM: Could not configure common clock
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:01.0: bridge window [mem 0xf7c00000-0xf7efffff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: PCI bridge to [bus 02] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [io 0x0000-0x0cf7 window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [io 0x0d00-0xffff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0x000d0000-0x000d3fff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0x000d4000-0x000d7fff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0x000d8000-0x000dbfff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0x000dc000-0x000dffff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0x000e0000-0x000e3fff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0x000e4000-0x000e7fff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: bridge window [mem 0xdfa00000-0xfeafffff window] (subtractive decode)
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: on NUMA node 0
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 10 11 12 14 15)
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> Mar 19 13:32:48 Pleiadi kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: vgaarb: setting as boot VGA device
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: vgaarb: bridge control possible
> Mar 19 13:32:48 Pleiadi kernel: vgaarb: loaded
> Mar 19 13:32:48 Pleiadi kernel: SCSI subsystem initialized
> Mar 19 13:32:48 Pleiadi kernel: libata version 3.00 loaded.
> Mar 19 13:32:48 Pleiadi kernel: PCI: Using ACPI for IRQ routing
> Mar 19 13:32:48 Pleiadi kernel: PCI: pci_cache_line_size set to 64 bytes
> Mar 19 13:32:48 Pleiadi kernel: e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
> Mar 19 13:32:48 Pleiadi kernel: e820: reserve RAM buffer [mem 0x40004000-0x43ffffff]
> Mar 19 13:32:48 Pleiadi kernel: e820: reserve RAM buffer [mem 0xd4177000-0xd7ffffff]
> Mar 19 13:32:48 Pleiadi kernel: e820: reserve RAM buffer [mem 0xd67d4000-0xd7ffffff]
> Mar 19 13:32:48 Pleiadi kernel: e820: reserve RAM buffer [mem 0xd7000000-0xd7ffffff]
> Mar 19 13:32:48 Pleiadi kernel: e820: reserve RAM buffer [mem 0x11e600000-0x11fffffff]
> Mar 19 13:32:48 Pleiadi kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> Mar 19 13:32:48 Pleiadi kernel: hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> Mar 19 13:32:48 Pleiadi kernel: clocksource: Switched to clocksource tsc-early
> Mar 19 13:32:48 Pleiadi kernel: pnp: PnP ACPI init
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0x0680-0x069f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0x1100-0x110f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0xffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0xffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0x0400-0x0453] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0x0458-0x047f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0x0500-0x057f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: [io 0x164e-0x164f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> Mar 19 13:32:48 Pleiadi kernel: pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
> Mar 19 13:32:48 Pleiadi kernel: system 00:02: [io 0x0454-0x0457] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> Mar 19 13:32:48 Pleiadi kernel: system 00:03: [io 0x0a00-0x0a2f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:03: [io 0x0a30-0x0a3f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:03: [io 0x0a40-0x0a4f] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:03: [io 0x0218-0x0219] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
> Mar 19 13:32:48 Pleiadi kernel: system 00:04: [io 0x04d0-0x04d1] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> Mar 19 13:32:48 Pleiadi kernel: pnp 00:05: [dma 0 disabled]
> Mar 19 13:32:48 Pleiadi kernel: pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
> Mar 19 13:32:48 Pleiadi kernel: pnp 00:06: Plug and Play ACPI device, IDs PNP0c31 (active)
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfed10000-0xfed17fff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfed90000-0xfed93fff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfed45000-0xfed8ffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xff000000-0xffffffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xfee00000-0xfeefffff] could not be reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: [mem 0xdfa00000-0xdfa00fff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
> Mar 19 13:32:48 Pleiadi kernel: system 00:08: [mem 0x20000000-0x201fffff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:08: [mem 0x40004000-0x40004fff] has been reserved
> Mar 19 13:32:48 Pleiadi kernel: system 00:08: Plug and Play ACPI device, IDs PNP0c01 (active)
> Mar 19 13:32:48 Pleiadi kernel: pnp: PnP ACPI: found 9 devices
> Mar 19 13:32:48 Pleiadi kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:01.0: bridge window [mem 0xf7c00000-0xf7efffff]
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:1e.0: PCI bridge to [bus 02]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 4 [io 0x0000-0x0cf7 window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 5 [io 0x0d00-0xffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 11 [mem 0x000e0000-0x000e3fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 12 [mem 0x000e4000-0x000e7fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:00: resource 13 [mem 0xdfa00000-0xfeafffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:01: resource 1 [mem 0xf7c00000-0xf7efffff]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 4 [io 0x0000-0x0cf7 window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 5 [io 0x0d00-0xffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 6 [mem 0x000a0000-0x000bffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 7 [mem 0x000d0000-0x000d3fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 8 [mem 0x000d4000-0x000d7fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 9 [mem 0x000d8000-0x000dbfff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 10 [mem 0x000dc000-0x000dffff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 11 [mem 0x000e0000-0x000e3fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 12 [mem 0x000e4000-0x000e7fff window]
> Mar 19 13:32:48 Pleiadi kernel: pci_bus 0000:02: resource 13 [mem 0xdfa00000-0xfeafffff window]
> Mar 19 13:32:48 Pleiadi kernel: NET: Registered protocol family 2
> Mar 19 13:32:48 Pleiadi kernel: tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
> Mar 19 13:32:48 Pleiadi kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes)
> Mar 19 13:32:48 Pleiadi kernel: TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
> Mar 19 13:32:48 Pleiadi kernel: TCP: Hash tables configured (established 32768 bind 32768)
> Mar 19 13:32:48 Pleiadi kernel: UDP hash table entries: 2048 (order: 4, 65536 bytes)
> Mar 19 13:32:48 Pleiadi kernel: UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
> Mar 19 13:32:48 Pleiadi kernel: NET: Registered protocol family 1
> Mar 19 13:32:48 Pleiadi kernel: pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> Mar 19 13:32:48 Pleiadi kernel: PCI: CLS 64 bytes, default 64
> Mar 19 13:32:48 Pleiadi kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> Mar 19 13:32:48 Pleiadi kernel: software IO TLB [mem 0xd0177000-0xd4177000] (64MB) mapped at [000000005f622a8e-000000006fd9c147]
> Mar 19 13:32:48 Pleiadi kernel: RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
> Mar 19 13:32:48 Pleiadi kernel: RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
> Mar 19 13:32:48 Pleiadi kernel: RAPL PMU: hw unit of domain package 2^-16 Joules
> Mar 19 13:32:48 Pleiadi kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
> Mar 19 13:32:48 Pleiadi kernel: workingset: timestamp_bits=62 max_order=20 bucket_order=0
> Mar 19 13:32:48 Pleiadi kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> Mar 19 13:32:48 Pleiadi kernel: io scheduler noop registered
> Mar 19 13:32:48 Pleiadi kernel: io scheduler cfq registered (default)
> Mar 19 13:32:48 Pleiadi kernel: io scheduler mq-deadline registered
> Mar 19 13:32:48 Pleiadi kernel: io scheduler kyber registered
> Mar 19 13:32:48 Pleiadi kernel: Monitor-Mwait will be used to enter C-1 state
> Mar 19 13:32:48 Pleiadi kernel: Monitor-Mwait will be used to enter C-2 state
> Mar 19 13:32:48 Pleiadi kernel: Monitor-Mwait will be used to enter C-3 state
> Mar 19 13:32:48 Pleiadi kernel: ahci 0000:00:1f.2: version 3.0
> Mar 19 13:32:48 Pleiadi kernel: ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
> Mar 19 13:32:48 Pleiadi kernel: ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0xb impl SATA mode
> Mar 19 13:32:48 Pleiadi kernel: ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part ems sxs apst
> Mar 19 13:32:48 Pleiadi kernel: scsi host0: ahci
> Mar 19 13:32:48 Pleiadi kernel: scsi host1: ahci
> Mar 19 13:32:48 Pleiadi kernel: scsi host2: ahci
> Mar 19 13:32:48 Pleiadi kernel: scsi host3: ahci
> Mar 19 13:32:48 Pleiadi kernel: scsi host4: ahci
> Mar 19 13:32:48 Pleiadi kernel: scsi host5: ahci
> Mar 19 13:32:48 Pleiadi kernel: ata1: SATA max UDMA/133 abar m2048 at 0xf7f32000 port 0xf7f32100 irq 24
> Mar 19 13:32:48 Pleiadi kernel: ata2: SATA max UDMA/133 abar m2048 at 0xf7f32000 port 0xf7f32180 irq 24
> Mar 19 13:32:48 Pleiadi kernel: ata3: DUMMY
> Mar 19 13:32:48 Pleiadi kernel: ata4: SATA max UDMA/133 abar m2048 at 0xf7f32000 port 0xf7f32280 irq 24
> Mar 19 13:32:48 Pleiadi kernel: ata5: DUMMY
> Mar 19 13:32:48 Pleiadi kernel: ata6: DUMMY
> Mar 19 13:32:48 Pleiadi kernel: intel_pstate: Intel P-state driver initializing
> Mar 19 13:32:48 Pleiadi kernel: Initializing XFRM netlink socket
> Mar 19 13:32:48 Pleiadi kernel: NET: Registered protocol family 17
> Mar 19 13:32:48 Pleiadi kernel: sched_clock: Marking stable (1215001659, 0)->(1219466383, -4464724)
> Mar 19 13:32:48 Pleiadi kernel: registered taskstats version 1
> Mar 19 13:32:48 Pleiadi kernel: Btrfs loaded, crc32c=crc32c-generic
> Mar 19 13:32:48 Pleiadi kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> Mar 19 13:32:48 Pleiadi kernel: ata1.00: ATA-8: ST500DM002-1BD142, KC65, max UDMA/100
> Mar 19 13:32:48 Pleiadi kernel: ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> Mar 19 13:32:48 Pleiadi kernel: ata1.00: configured for UDMA/100
> Mar 19 13:32:48 Pleiadi kernel: scsi 0:0:0:0: Direct-Access ATA ST500DM002-1BD14 KC65 PQ: 0 ANSI: 5
> Mar 19 13:32:48 Pleiadi kernel: sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> Mar 19 13:32:48 Pleiadi kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
> Mar 19 13:32:48 Pleiadi kernel: sd 0:0:0:0: [sda] Write Protect is off
> Mar 19 13:32:48 Pleiadi kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> Mar 19 13:32:48 Pleiadi kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Mar 19 13:32:48 Pleiadi kernel: sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
> Mar 19 13:32:48 Pleiadi kernel: sd 0:0:0:0: [sda] Attached SCSI disk
> Mar 19 13:32:48 Pleiadi kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Mar 19 13:32:48 Pleiadi kernel: ata2.00: ATAPI: HL-DT-STDVD-RAM GH82N, KU02, max UDMA/133
> Mar 19 13:32:48 Pleiadi kernel: ata2.00: configured for UDMA/133
> Mar 19 13:32:48 Pleiadi kernel: scsi 1:0:0:0: CD-ROM HL-DT-ST DVD-RAM GH82N KU02 PQ: 0 ANSI: 5
> Mar 19 13:32:48 Pleiadi kernel: ata4: SATA link down (SStatus 0 SControl 300)
> Mar 19 13:32:48 Pleiadi kernel: BTRFS: device fsid 15aaa597-530a-4049-a807-344b6e742f9b devid 1 transid 29997 /dev/root
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda5): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda5): has skinny extents
> Mar 19 13:32:48 Pleiadi kernel: tsc: Refined TSC clocksource calibration: 3192.754 MHz
> Mar 19 13:32:48 Pleiadi kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e058d02647, max_idle_ns: 440795319305 ns
> Mar 19 13:32:48 Pleiadi kernel: clocksource: Switched to clocksource tsc
> Mar 19 13:32:48 Pleiadi kernel: VFS: Mounted root (btrfs filesystem) readonly on device 0:11.
> Mar 19 13:32:48 Pleiadi kernel: Freeing unused kernel memory: 764K
> Mar 19 13:32:48 Pleiadi kernel: Write protecting the kernel read-only data: 10240k
> Mar 19 13:32:48 Pleiadi kernel: Freeing unused kernel memory: 2020K
> Mar 19 13:32:48 Pleiadi kernel: Freeing unused kernel memory: 828K
> Mar 19 13:32:48 Pleiadi kernel: udevd[797]: starting eudev-3.1.5
> Mar 19 13:32:48 Pleiadi kernel: random: crng init done
> Mar 19 13:32:48 Pleiadi kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Power Button [PWRB]
> Mar 19 13:32:48 Pleiadi kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Power Button [PWRF]
> Mar 19 13:32:48 Pleiadi kernel: thermal LNXTHERM:00: registered as thermal_zone0
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Thermal Zone [TZ00] (28 C)
> Mar 19 13:32:48 Pleiadi kernel: thermal LNXTHERM:01: registered as thermal_zone1
> Mar 19 13:32:48 Pleiadi kernel: ACPI: Thermal Zone [TZ01] (30 C)
> Mar 19 13:32:48 Pleiadi kernel: e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> Mar 19 13:32:48 Pleiadi kernel: e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> Mar 19 13:32:48 Pleiadi kernel: e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> Mar 19 13:32:48 Pleiadi kernel: Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> Mar 19 13:32:48 Pleiadi kernel: 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> Mar 19 13:32:48 Pleiadi kernel: sr 1:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
> Mar 19 13:32:48 Pleiadi kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
> Mar 19 13:32:48 Pleiadi kernel: sr 1:0:0:0: Attached scsi CD-ROM sr0
> Mar 19 13:32:48 Pleiadi kernel: ACPI: bus type USB registered
> Mar 19 13:32:48 Pleiadi kernel: usbcore: registered new interface driver usbfs
> Mar 19 13:32:48 Pleiadi kernel: usbcore: registered new interface driver hub
> Mar 19 13:32:48 Pleiadi kernel: usbcore: registered new device driver usb
> Mar 19 13:32:48 Pleiadi kernel: rtc_cmos 00:01: RTC can wake from S4
> Mar 19 13:32:48 Pleiadi kernel: rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
> Mar 19 13:32:48 Pleiadi kernel: rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> Mar 19 13:32:48 Pleiadi kernel: igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> Mar 19 13:32:48 Pleiadi kernel: igb: Copyright (c) 2007-2014 Intel Corporation.
> Mar 19 13:32:48 Pleiadi kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci: EHCI PCI platform driver
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.0: eth0: (PCIe:5.0Gb/s:Width x4) b4:96:91:0e:fc:e4
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.0: eth0: PBA No: H34227-005
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> Mar 19 13:32:48 Pleiadi kernel: e1000e 0000:00:19.0 eth1: (PCI Express:2.5GT/s:Width x1) fc:4d:d4:2f:e2:1b
> Mar 19 13:32:48 Pleiadi kernel: e1000e 0000:00:19.0 eth1: Intel(R) PRO/1000 Network Connection
> Mar 19 13:32:48 Pleiadi kernel: e1000e 0000:00:19.0 eth1: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
> Mar 19 13:32:48 Pleiadi kernel: e1000e 0000:00:19.0 eth125: renamed from eth1
> Mar 19 13:32:48 Pleiadi kernel: 0000:00:16.3: ttyS1 at I/O 0xf0e0 (irq = 19, base_baud = 115200) is a 16550A
> Mar 19 13:32:48 Pleiadi kernel: cryptd: max_cpu_qlen set to 1000
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1a.0: EHCI Host Controller
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1a.0: debug port 2
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7f34000
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> Mar 19 13:32:48 Pleiadi kernel: e1000e 0000:00:19.0 eth2: renamed from eth125
> Mar 19 13:32:48 Pleiadi kernel: hub 1-0:1.0: USB hub found
> Mar 19 13:32:48 Pleiadi kernel: hub 1-0:1.0: 3 ports detected
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1d.0: EHCI Host Controller
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1d.0: debug port 2
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7f33000
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.1: Intel(R) Gigabit Ethernet Network Connection
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.1: eth1: (PCIe:5.0Gb/s:Width x4) b4:96:91:0e:fc:e5
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.1: eth1: PBA No: H34227-005
> Mar 19 13:32:48 Pleiadi kernel: igb 0000:01:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> Mar 19 13:32:48 Pleiadi kernel: ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> Mar 19 13:32:48 Pleiadi kernel: hub 2-0:1.0: USB hub found
> Mar 19 13:32:48 Pleiadi kernel: hub 2-0:1.0: 3 ports detected
> Mar 19 13:32:48 Pleiadi kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
> Mar 19 13:32:48 Pleiadi kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> Mar 19 13:32:48 Pleiadi kernel: xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci version 0x100 quirks 0x0000b930
> Mar 19 13:32:48 Pleiadi kernel: xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> Mar 19 13:32:48 Pleiadi kernel: hub 3-0:1.0: USB hub found
> Mar 19 13:32:48 Pleiadi kernel: hub 3-0:1.0: 4 ports detected
> Mar 19 13:32:48 Pleiadi kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
> Mar 19 13:32:48 Pleiadi kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
> Mar 19 13:32:48 Pleiadi kernel: hub 4-0:1.0: USB hub found
> Mar 19 13:32:48 Pleiadi kernel: hub 4-0:1.0: 4 ports detected
> Mar 19 13:32:48 Pleiadi kernel: AVX version of gcm_enc/dec engaged.
> Mar 19 13:32:48 Pleiadi kernel: AES CTR mode by8 optimization enabled
> Mar 19 13:32:48 Pleiadi kernel: usb 1-1: new high-speed USB device number 2 using ehci-pci
> Mar 19 13:32:48 Pleiadi kernel: usb 2-1: new high-speed USB device number 2 using ehci-pci
> Mar 19 13:32:48 Pleiadi kernel: hub 1-1:1.0: USB hub found
> Mar 19 13:32:48 Pleiadi kernel: hub 1-1:1.0: 6 ports detected
> Mar 19 13:32:48 Pleiadi kernel: hub 2-1:1.0: USB hub found
> Mar 19 13:32:48 Pleiadi kernel: hub 2-1:1.0: 8 ports detected
> Mar 19 13:32:48 Pleiadi kernel: BTRFS: device fsid f4b6e010-47bf-4fd3-b309-d7b18397896b devid 1 transid 575 /dev/sda9
> Mar 19 13:32:48 Pleiadi kernel: BTRFS: device fsid 23a29ee3-8309-4a45-80e9-caf09a473550 devid 1 transid 50953 /dev/sda7
> Mar 19 13:32:48 Pleiadi kernel: BTRFS: device fsid 83dfcabe-2aef-4cbf-b4c1-8f5889c2a6e1 devid 1 transid 1023 /dev/sda8
> Mar 19 13:32:48 Pleiadi kernel: BTRFS: device fsid 72fa3bcd-f01d-4388-bd94-3f3e47deb2af devid 1 transid 851 /dev/sda6
> Mar 19 13:32:48 Pleiadi kernel: BTRFS: device fsid 2aa0afe6-3e76-4ad3-9d1c-02a525f1e98d devid 1 transid 91 /dev/sda10
> Mar 19 13:32:48 Pleiadi kernel: BTRFS: device fsid 8f8d78ab-6992-4d3b-8454-05761007ecb8 devid 1 transid 32761 /dev/sda11
> Mar 19 13:32:48 Pleiadi kernel: Adding 33385492k swap on /dev/sda12. Priority:-2 extents:1 across:33385492k
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda5): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda6): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda6): has skinny extents
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda7): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda7): has skinny extents
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda8): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda8): has skinny extents
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda9): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda9): has skinny extents
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda10): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda10): has skinny extents
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda11): disk space caching is enabled
> Mar 19 13:32:48 Pleiadi kernel: BTRFS info (device sda11): has skinny extents
> Mar 19 13:32:53 Pleiadi kernel: igb 0000:01:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> Mar 19 13:32:54 Pleiadi kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> Mar 19 13:32:57 Pleiadi kernel: NET: Registered protocol family 15
> Mar 19 13:42:13 Pleiadi kernel: nf_conntrack: default automatic helper assignment has been turned off for security reasons and CT-based firewall rule not found. Use the iptables CT target to attach helpers instead.
> Mar 19 15:12:46 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:12:46 Pleiadi kernel: TDH 
> Mar 19 15:12:46 Pleiadi kernel: TDT 
> Mar 19 15:12:46 Pleiadi kernel: next_to_use 
> Mar 19 15:12:46 Pleiadi kernel: next_to_clean 
> Mar 19 15:12:46 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:12:46 Pleiadi kernel: time_stamp 
> Mar 19 15:12:46 Pleiadi kernel: next_to_watch 
> Mar 19 15:12:46 Pleiadi kernel: jiffies 
> Mar 19 15:12:46 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:12:46 Pleiadi kernel: MAC Status 
> Mar 19 15:12:46 Pleiadi kernel: PHY Status 
> Mar 19 15:12:46 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:12:46 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:12:46 Pleiadi kernel: PCI Status 
> Mar 19 15:12:48 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:12:48 Pleiadi kernel: TDH 
> Mar 19 15:12:48 Pleiadi kernel: TDT 
> Mar 19 15:12:48 Pleiadi kernel: next_to_use 
> Mar 19 15:12:48 Pleiadi kernel: next_to_clean 
> Mar 19 15:12:48 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:12:48 Pleiadi kernel: time_stamp 
> Mar 19 15:12:48 Pleiadi kernel: next_to_watch 
> Mar 19 15:12:48 Pleiadi kernel: jiffies 
> Mar 19 15:12:48 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:12:48 Pleiadi kernel: MAC Status 
> Mar 19 15:12:48 Pleiadi kernel: PHY Status 
> Mar 19 15:12:48 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:12:48 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:12:48 Pleiadi kernel: PCI Status 
> Mar 19 15:12:50 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:12:50 Pleiadi kernel: TDH 
> Mar 19 15:12:50 Pleiadi kernel: TDT 
> Mar 19 15:12:50 Pleiadi kernel: next_to_use 
> Mar 19 15:12:50 Pleiadi kernel: next_to_clean 
> Mar 19 15:12:50 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:12:50 Pleiadi kernel: time_stamp 
> Mar 19 15:12:50 Pleiadi kernel: next_to_watch 
> Mar 19 15:12:50 Pleiadi kernel: jiffies 
> Mar 19 15:12:50 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:12:50 Pleiadi kernel: MAC Status 
> Mar 19 15:12:50 Pleiadi kernel: PHY Status 
> Mar 19 15:12:50 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:12:50 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:12:50 Pleiadi kernel: PCI Status 
> Mar 19 15:12:51 Pleiadi kernel: ------------[ cut here ]------------
> Mar 19 15:12:51 Pleiadi kernel: NETDEV WATCHDOG: eth2 (e1000e): transmit queue 0 timed out
> Mar 19 15:12:51 Pleiadi kernel: WARNING: CPU: 3 PID: 0 at net/sched/sch_generic.c:464 dev_watchdog+0x14b/0x1a2
> Mar 19 15:12:51 Pleiadi kernel: Modules linked in: sha256_ssse3 sha256_generic drbg ansi_cprng authenc echainiv xfrm4_mode_tunnel sha1_ssse3 sha1_generic hmac xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 af_key nf_nat_ftp nf_conntrack_ftp xt_TCPMSS xt_helper xt_mark xt_statistic xt_nat xt_multiport xt_limit xt_tcpudp xt_policy xt_conntrack iptable_mangle iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_filter ip_tables x_tables crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper xhci_pci ehci_pci xhci_hcd ehci_hcd 8250_pci igb rtc_cmos usbcore i2c_algo_bit 8250 e1000e 8250_base thermal usb_common serial_core sr_mod button i2c_core cdrom
> Mar 19 15:12:51 Pleiadi kernel: CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.16.0-rc6 #1
> Mar 19 15:12:51 Pleiadi kernel: Hardware name: LENOVO 3220A11/MAHOBAY, BIOS 9SKT99AUS 06/30/2017
> Mar 19 15:12:51 Pleiadi kernel: RIP: 0010:dev_watchdog+0x14b/0x1a2
> Mar 19 15:12:51 Pleiadi kernel: RSP: 0018:ffff88011e383ec8 EFLAGS: 00010282
> Mar 19 15:12:51 Pleiadi kernel: RAX: 000000000000003a RBX: ffff880117aa0438 RCX: 000000000000023d
> Mar 19 15:12:51 Pleiadi kernel: RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffffffff81c5bfac
> Mar 19 15:12:51 Pleiadi kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> Mar 19 15:12:51 Pleiadi kernel: R10: 0000000000000202 R11: ffffffff81c6ad1c R12: ffff880117aa0000
> Mar 19 15:12:51 Pleiadi kernel: R13: 0000000000000003 R14: 000000000000000a R15: 0000000000000001
> Mar 19 15:12:51 Pleiadi kernel: FS: 0000000000000000(0000) GS:ffff88011e380000(0000) knlGS:0000000000000000
> Mar 19 15:12:51 Pleiadi kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 19 15:12:51 Pleiadi kernel: CR2: 00007f8f2d96c5f8 CR3: 0000000001a0a003 CR4: 00000000001606a0
> Mar 19 15:12:51 Pleiadi kernel: Call Trace:
> Mar 19 15:12:51 Pleiadi kernel: 
> Mar 19 15:12:51 Pleiadi kernel: call_timer_fn+0x12/0x75
> Mar 19 15:12:51 Pleiadi kernel: ? qdisc_reset+0xc0/0xc0
> Mar 19 15:12:51 Pleiadi kernel: expire_timers+0x66/0x73
> Mar 19 15:12:51 Pleiadi kernel: run_timer_softirq+0x63/0xdf
> Mar 19 15:12:51 Pleiadi kernel: ? recalibrate_cpu_khz+0x1/0x1
> Mar 19 15:12:51 Pleiadi kernel: ? ktime_get+0x38/0x87
> Mar 19 15:12:51 Pleiadi kernel: ? lapic_next_event+0x1a/0x1a
> Mar 19 15:12:51 Pleiadi kernel: __do_softirq+0xc2/0x1b4
> Mar 19 15:12:51 Pleiadi kernel: irq_exit+0x49/0x88
> Mar 19 15:12:51 Pleiadi kernel: smp_apic_timer_interrupt+0x76/0x81
> Mar 19 15:12:51 Pleiadi kernel: apic_timer_interrupt+0xf/0x20
> Mar 19 15:12:51 Pleiadi kernel: 
> Mar 19 15:12:51 Pleiadi kernel: RIP: 0010:cpuidle_enter_state+0x116/0x168
> Mar 19 15:12:51 Pleiadi kernel: RSP: 0018:ffffc90000087ed8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff12
> Mar 19 15:12:51 Pleiadi kernel: RAX: 00000577fc8418a0 RBX: 00000577fc8418a0 RCX: 000000000000001f
> Mar 19 15:12:51 Pleiadi kernel: RDX: 0000000000000000 RSI: 0000118190c30038 RDI: 0000000000000000
> Mar 19 15:12:51 Pleiadi kernel: RBP: 0000000000000003 R08: 0000000000000004 R09: 0000000000000000
> Mar 19 15:12:51 Pleiadi kernel: R10: ffffc90000087ec0 R11: 00000000004a151c R12: ffff880119b25400
> Mar 19 15:12:51 Pleiadi kernel: R13: 00000577fc7da325 R14: ffffffff81a37698 R15: 0000000000000000
> Mar 19 15:12:51 Pleiadi kernel: ? cpuidle_enter_state+0xfc/0x168
> Mar 19 15:12:51 Pleiadi kernel: do_idle+0xdc/0x12f
> Mar 19 15:12:51 Pleiadi kernel: cpu_startup_entry+0x18/0x1a
> Mar 19 15:12:51 Pleiadi kernel: secondary_startup_64+0xa5/0xb0
> Mar 19 15:12:51 Pleiadi kernel: Code: 3d 7b 44 73 00 00 75 35 4c 89 e7 c6 05 6f 44 73 00 01 e8 cd 4a fe ff 89 e9 4c 89 e6 48 c7 c7 30 11 8f 81 48 89 c2 e8 63 ac d1 ff  0b eb 0e ff c5 48 05 40 01 00 00 39 cd 75 99 eb 13 48 8b 83
> Mar 19 15:12:51 Pleiadi kernel: ---[ end trace 3d40c0325b051656 ]---
> Mar 19 15:12:51 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 19 15:12:55 Pleiadi kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> Mar 19 15:36:33 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:36:33 Pleiadi kernel: TDH 
> Mar 19 15:36:33 Pleiadi kernel: TDT 
> Mar 19 15:36:33 Pleiadi kernel: next_to_use 
> Mar 19 15:36:33 Pleiadi kernel: next_to_clean 
> Mar 19 15:36:33 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:36:33 Pleiadi kernel: time_stamp 
> Mar 19 15:36:33 Pleiadi kernel: next_to_watch 
> Mar 19 15:36:33 Pleiadi kernel: jiffies 
> Mar 19 15:36:33 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:36:33 Pleiadi kernel: MAC Status 
> Mar 19 15:36:33 Pleiadi kernel: PHY Status 
> Mar 19 15:36:33 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:36:33 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:36:33 Pleiadi kernel: PCI Status 
> Mar 19 15:36:35 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:36:35 Pleiadi kernel: TDH 
> Mar 19 15:36:35 Pleiadi kernel: TDT 
> Mar 19 15:36:35 Pleiadi kernel: next_to_use 
> Mar 19 15:36:35 Pleiadi kernel: next_to_clean 
> Mar 19 15:36:35 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:36:35 Pleiadi kernel: time_stamp 
> Mar 19 15:36:35 Pleiadi kernel: next_to_watch 
> Mar 19 15:36:35 Pleiadi kernel: jiffies 
> Mar 19 15:36:35 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:36:35 Pleiadi kernel: MAC Status 
> Mar 19 15:36:35 Pleiadi kernel: PHY Status 
> Mar 19 15:36:35 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:36:35 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:36:35 Pleiadi kernel: PCI Status 
> Mar 19 15:36:37 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:36:37 Pleiadi kernel: TDH 
> Mar 19 15:36:37 Pleiadi kernel: TDT 
> Mar 19 15:36:37 Pleiadi kernel: next_to_use 
> Mar 19 15:36:37 Pleiadi kernel: next_to_clean 
> Mar 19 15:36:37 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:36:37 Pleiadi kernel: time_stamp 
> Mar 19 15:36:37 Pleiadi kernel: next_to_watch 
> Mar 19 15:36:37 Pleiadi kernel: jiffies 
> Mar 19 15:36:37 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:36:37 Pleiadi kernel: MAC Status 
> Mar 19 15:36:37 Pleiadi kernel: PHY Status 
> Mar 19 15:36:37 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:36:37 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:36:37 Pleiadi kernel: PCI Status 
> Mar 19 15:36:39 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:36:39 Pleiadi kernel: TDH 
> Mar 19 15:36:39 Pleiadi kernel: TDT 
> Mar 19 15:36:39 Pleiadi kernel: next_to_use 
> Mar 19 15:36:39 Pleiadi kernel: next_to_clean 
> Mar 19 15:36:39 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:36:39 Pleiadi kernel: time_stamp 
> Mar 19 15:36:39 Pleiadi kernel: next_to_watch 
> Mar 19 15:36:39 Pleiadi kernel: jiffies 
> Mar 19 15:36:39 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:36:39 Pleiadi kernel: MAC Status 
> Mar 19 15:36:39 Pleiadi kernel: PHY Status 
> Mar 19 15:36:39 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:36:39 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:36:39 Pleiadi kernel: PCI Status 
> Mar 19 15:36:41 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 15:36:41 Pleiadi kernel: TDH 
> Mar 19 15:36:41 Pleiadi kernel: TDT 
> Mar 19 15:36:41 Pleiadi kernel: next_to_use 
> Mar 19 15:36:41 Pleiadi kernel: next_to_clean 
> Mar 19 15:36:41 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 15:36:41 Pleiadi kernel: time_stamp 
> Mar 19 15:36:41 Pleiadi kernel: next_to_watch 
> Mar 19 15:36:41 Pleiadi kernel: jiffies 
> Mar 19 15:36:41 Pleiadi kernel: next_to_watch.status 
> Mar 19 15:36:41 Pleiadi kernel: MAC Status 
> Mar 19 15:36:41 Pleiadi kernel: PHY Status 
> Mar 19 15:36:41 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 15:36:41 Pleiadi kernel: PHY Extended Status 
> Mar 19 15:36:41 Pleiadi kernel: PCI Status 
> Mar 19 15:36:41 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 19 15:36:46 Pleiadi kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> Mar 19 17:15:44 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 17:15:44 Pleiadi kernel: TDH 
> Mar 19 17:15:44 Pleiadi kernel: TDT 
> Mar 19 17:15:44 Pleiadi kernel: next_to_use 
> Mar 19 17:15:44 Pleiadi kernel: next_to_clean 
> Mar 19 17:15:44 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 17:15:44 Pleiadi kernel: time_stamp 
> Mar 19 17:15:44 Pleiadi kernel: next_to_watch 
> Mar 19 17:15:44 Pleiadi kernel: jiffies 
> Mar 19 17:15:44 Pleiadi kernel: next_to_watch.status 
> Mar 19 17:15:44 Pleiadi kernel: MAC Status 
> Mar 19 17:15:44 Pleiadi kernel: PHY Status 
> Mar 19 17:15:44 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 17:15:44 Pleiadi kernel: PHY Extended Status 
> Mar 19 17:15:44 Pleiadi kernel: PCI Status 
> Mar 19 17:15:46 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 17:15:46 Pleiadi kernel: TDH 
> Mar 19 17:15:46 Pleiadi kernel: TDT 
> Mar 19 17:15:46 Pleiadi kernel: next_to_use 
> Mar 19 17:15:46 Pleiadi kernel: next_to_clean 
> Mar 19 17:15:46 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 17:15:46 Pleiadi kernel: time_stamp 
> Mar 19 17:15:46 Pleiadi kernel: next_to_watch 
> Mar 19 17:15:46 Pleiadi kernel: jiffies 
> Mar 19 17:15:46 Pleiadi kernel: next_to_watch.status 
> Mar 19 17:15:46 Pleiadi kernel: MAC Status 
> Mar 19 17:15:46 Pleiadi kernel: PHY Status 
> Mar 19 17:15:46 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 17:15:46 Pleiadi kernel: PHY Extended Status 
> Mar 19 17:15:46 Pleiadi kernel: PCI Status 
> Mar 19 17:15:48 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 17:15:48 Pleiadi kernel: TDH 
> Mar 19 17:15:48 Pleiadi kernel: TDT 
> Mar 19 17:15:48 Pleiadi kernel: next_to_use 
> Mar 19 17:15:48 Pleiadi kernel: next_to_clean 
> Mar 19 17:15:48 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 17:15:48 Pleiadi kernel: time_stamp 
> Mar 19 17:15:48 Pleiadi kernel: next_to_watch 
> Mar 19 17:15:48 Pleiadi kernel: jiffies 
> Mar 19 17:15:48 Pleiadi kernel: next_to_watch.status 
> Mar 19 17:15:48 Pleiadi kernel: MAC Status 
> Mar 19 17:15:48 Pleiadi kernel: PHY Status 
> Mar 19 17:15:48 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 17:15:48 Pleiadi kernel: PHY Extended Status 
> Mar 19 17:15:48 Pleiadi kernel: PCI Status 
> Mar 19 17:15:50 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 17:15:50 Pleiadi kernel: TDH 
> Mar 19 17:15:50 Pleiadi kernel: TDT 
> Mar 19 17:15:50 Pleiadi kernel: next_to_use 
> Mar 19 17:15:50 Pleiadi kernel: next_to_clean 
> Mar 19 17:15:50 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 17:15:50 Pleiadi kernel: time_stamp 
> Mar 19 17:15:50 Pleiadi kernel: next_to_watch 
> Mar 19 17:15:50 Pleiadi kernel: jiffies 
> Mar 19 17:15:50 Pleiadi kernel: next_to_watch.status 
> Mar 19 17:15:50 Pleiadi kernel: MAC Status 
> Mar 19 17:15:50 Pleiadi kernel: PHY Status 
> Mar 19 17:15:50 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 17:15:50 Pleiadi kernel: PHY Extended Status 
> Mar 19 17:15:50 Pleiadi kernel: PCI Status 
> Mar 19 17:15:52 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 19 17:15:52 Pleiadi kernel: TDH 
> Mar 19 17:15:52 Pleiadi kernel: TDT 
> Mar 19 17:15:52 Pleiadi kernel: next_to_use 
> Mar 19 17:15:52 Pleiadi kernel: next_to_clean 
> Mar 19 17:15:52 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 19 17:15:52 Pleiadi kernel: time_stamp 
> Mar 19 17:15:52 Pleiadi kernel: next_to_watch 
> Mar 19 17:15:52 Pleiadi kernel: jiffies 
> Mar 19 17:15:52 Pleiadi kernel: next_to_watch.status 
> Mar 19 17:15:52 Pleiadi kernel: MAC Status 
> Mar 19 17:15:52 Pleiadi kernel: PHY Status 
> Mar 19 17:15:52 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 19 17:15:52 Pleiadi kernel: PHY Extended Status 
> Mar 19 17:15:52 Pleiadi kernel: PCI Status 
> Mar 19 17:15:53 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 19 17:15:57 Pleiadi kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> Mar 19 21:46:44 Pleiadi kernel: conntrack: generic helper won't handle protocol 47. Please consider loading the specific helper module.
> Mar 20 09:48:32 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 20 09:48:32 Pleiadi kernel: TDH 
> Mar 20 09:48:32 Pleiadi kernel: TDT 
> Mar 20 09:48:32 Pleiadi kernel: next_to_use 
> Mar 20 09:48:32 Pleiadi kernel: next_to_clean 
> Mar 20 09:48:32 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 20 09:48:32 Pleiadi kernel: time_stamp 
> Mar 20 09:48:32 Pleiadi kernel: next_to_watch 
> Mar 20 09:48:32 Pleiadi kernel: jiffies 
> Mar 20 09:48:32 Pleiadi kernel: next_to_watch.status 
> Mar 20 09:48:32 Pleiadi kernel: MAC Status 
> Mar 20 09:48:32 Pleiadi kernel: PHY Status 
> Mar 20 09:48:32 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 20 09:48:32 Pleiadi kernel: PHY Extended Status 
> Mar 20 09:48:32 Pleiadi kernel: PCI Status 
> Mar 20 09:48:34 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 20 09:48:34 Pleiadi kernel: TDH 
> Mar 20 09:48:34 Pleiadi kernel: TDT 
> Mar 20 09:48:34 Pleiadi kernel: next_to_use 
> Mar 20 09:48:34 Pleiadi kernel: next_to_clean 
> Mar 20 09:48:34 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 20 09:48:34 Pleiadi kernel: time_stamp 
> Mar 20 09:48:34 Pleiadi kernel: next_to_watch 
> Mar 20 09:48:34 Pleiadi kernel: jiffies 
> Mar 20 09:48:34 Pleiadi kernel: next_to_watch.status 
> Mar 20 09:48:34 Pleiadi kernel: MAC Status 
> Mar 20 09:48:34 Pleiadi kernel: PHY Status 
> Mar 20 09:48:34 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 20 09:48:34 Pleiadi kernel: PHY Extended Status 
> Mar 20 09:48:34 Pleiadi kernel: PCI Status 
> Mar 20 09:48:36 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 20 09:48:36 Pleiadi kernel: TDH 
> Mar 20 09:48:36 Pleiadi kernel: TDT 
> Mar 20 09:48:36 Pleiadi kernel: next_to_use 
> Mar 20 09:48:36 Pleiadi kernel: next_to_clean 
> Mar 20 09:48:36 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 20 09:48:36 Pleiadi kernel: time_stamp 
> Mar 20 09:48:36 Pleiadi kernel: next_to_watch 
> Mar 20 09:48:36 Pleiadi kernel: jiffies 
> Mar 20 09:48:36 Pleiadi kernel: next_to_watch.status 
> Mar 20 09:48:36 Pleiadi kernel: MAC Status 
> Mar 20 09:48:36 Pleiadi kernel: PHY Status 
> Mar 20 09:48:36 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 20 09:48:36 Pleiadi kernel: PHY Extended Status 
> Mar 20 09:48:36 Pleiadi kernel: PCI Status 
> Mar 20 09:48:38 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 20 09:48:41 Pleiadi kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> Mar 20 10:39:37 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 20 10:39:37 Pleiadi kernel: TDH 
> Mar 20 10:39:37 Pleiadi kernel: TDT 
> Mar 20 10:39:37 Pleiadi kernel: next_to_use 
> Mar 20 10:39:37 Pleiadi kernel: next_to_clean 
> Mar 20 10:39:37 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 20 10:39:37 Pleiadi kernel: time_stamp 
> Mar 20 10:39:37 Pleiadi kernel: next_to_watch 
> Mar 20 10:39:37 Pleiadi kernel: jiffies 
> Mar 20 10:39:37 Pleiadi kernel: next_to_watch.status 
> Mar 20 10:39:37 Pleiadi kernel: MAC Status 
> Mar 20 10:39:37 Pleiadi kernel: PHY Status 
> Mar 20 10:39:37 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 20 10:39:37 Pleiadi kernel: PHY Extended Status 
> Mar 20 10:39:37 Pleiadi kernel: PCI Status 
> Mar 20 10:39:39 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 20 10:39:39 Pleiadi kernel: TDH 
> Mar 20 10:39:39 Pleiadi kernel: TDT 
> Mar 20 10:39:39 Pleiadi kernel: next_to_use 
> Mar 20 10:39:39 Pleiadi kernel: next_to_clean 
> Mar 20 10:39:39 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 20 10:39:39 Pleiadi kernel: time_stamp 
> Mar 20 10:39:39 Pleiadi kernel: next_to_watch 
> Mar 20 10:39:39 Pleiadi kernel: jiffies 
> Mar 20 10:39:39 Pleiadi kernel: next_to_watch.status 
> Mar 20 10:39:39 Pleiadi kernel: MAC Status 
> Mar 20 10:39:39 Pleiadi kernel: PHY Status 
> Mar 20 10:39:39 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 20 10:39:39 Pleiadi kernel: PHY Extended Status 
> Mar 20 10:39:39 Pleiadi kernel: PCI Status 
> Mar 20 10:39:41 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Detected Hardware Unit Hang:
> Mar 20 10:39:41 Pleiadi kernel: TDH 
> Mar 20 10:39:41 Pleiadi kernel: TDT 
> Mar 20 10:39:41 Pleiadi kernel: next_to_use 
> Mar 20 10:39:41 Pleiadi kernel: next_to_clean 
> Mar 20 10:39:41 Pleiadi kernel: buffer_info[next_to_clean]:
> Mar 20 10:39:41 Pleiadi kernel: time_stamp 
> Mar 20 10:39:41 Pleiadi kernel: next_to_watch 
> Mar 20 10:39:41 Pleiadi kernel: jiffies 
> Mar 20 10:39:41 Pleiadi kernel: next_to_watch.status 
> Mar 20 10:39:41 Pleiadi kernel: MAC Status 
> Mar 20 10:39:41 Pleiadi kernel: PHY Status 
> Mar 20 10:39:41 Pleiadi kernel: PHY 1000BASE-T Status 
> Mar 20 10:39:41 Pleiadi kernel: PHY Extended Status 
> Mar 20 10:39:41 Pleiadi kernel: PCI Status 
> Mar 20 10:39:42 Pleiadi kernel: e1000e 0000:00:19.0 eth2: Reset adapter unexpectedly
> Mar 20 10:39:46 Pleiadi kernel: e1000e: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> 
> ethtool -k eth2
> 
> Features for eth2:
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> rx-checksumming: on
> tx-checksumming: on
>  tx-checksum-ipv4: off [fixed]
>  tx-checksum-ip-generic: on
>  tx-checksum-ipv6: off [fixed]
>  tx-checksum-fcoe-crc: off [fixed]
>  tx-checksum-sctp: off [fixed]
> scatter-gather: on
>  tx-scatter-gather: on
>  tx-scatter-gather-fraglist: off [fixed]
> tcp-segmentation-offload: on
>  tx-tcp-segmentation: on
>  tx-tcp-ecn-segmentation: off [fixed]
>  tx-tcp-mangleid-segmentation: off
>  tx-tcp6-segmentation: on
> udp-fragmentation-offload: off
> generic-segmentation-offload: on
> generic-receive-offload: on
> large-receive-offload: off [fixed]
> rx-vlan-offload: on
> tx-vlan-offload: on
> ntuple-filters: off [fixed]
> receive-hashing: on
> highdma: on [fixed]
> rx-vlan-filter: off [fixed]
> vlan-challenged: off [fixed]
> tx-lockless: off [fixed]
> netns-local: off [fixed]
> tx-gso-robust: off [fixed]
> tx-fcoe-segmentation: off [fixed]
> tx-gre-segmentation: off [fixed]
> tx-gre-csum-segmentation: off [fixed]
> tx-ipxip4-segmentation: off [fixed]
> tx-ipxip6-segmentation: off [fixed]
> tx-udp_tnl-segmentation: off [fixed]
> tx-udp_tnl-csum-segmentation: off [fixed]
> tx-gso-partial: off [fixed]
> tx-sctp-segmentation: off [fixed]
> tx-esp-segmentation: off [fixed]
> fcoe-mtu: off [fixed]
> tx-nocache-copy: off
> loopback: off [fixed]
> rx-fcs: off
> rx-all: off
> tx-vlan-stag-hw-insert: off [fixed]
> rx-vlan-stag-hw-parse: off [fixed]
> rx-vlan-stag-filter: off [fixed]
> l2-fwd-offload: off [fixed]
> hw-tc-offload: off [fixed]
> esp-hw-offload: off [fixed]
> esp-tx-csum-hw-offload: off [fixed]
> rx-udp_tunnel-port-offload: off [fixed]
> rx-gro-hw: off [fixed]
> 
> ethtool -e eth2
> 
> Offset Values
> 
> ------ ------
> 0x0000: fc 4d d4 2f e2 1b 00 08 ff ff d4 00 ff ff ff ff
> 0x0010: ff ff ff ff c3 10 83 30 aa 17 02 15 00 00 00 00
> 0x0020: 02 07 00 00 00 00 05 a5 28 30 00 1a 00 00 00 0c
> 0x0030: f4 18 40 0b 43 08 13 01 02 15 ad ba 02 15 03 15
> 0x0040: ad ba ad ba ad ba 02 15 00 80 90 80 00 4e 86 08
> 0x0050: 00 00 00 00 07 00 00 00 00 00 00 00 00 00 ff ff
> 0x0060: c2 01 02 40 37 15 17 40 ff ff ff ff ff ff ff ff
> 0x0070: ff ff ff ff ff ff ff ff ff ff 00 01 ff ff ad 4c
> 0x0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0090: 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff
> 0x00a0: 02 34 30 00 14 02 31 00 36 38 30 00 0f 00 31 00
> 0x00b0: 37 38 30 00 0a 00 31 00 38 38 30 00 10 00 31 00
> 0x00c0: 3a 38 30 00 03 00 31 00 ae 38 30 00 18 00 31 00
> 0x00d0: af 38 30 00 18 00 31 00 b0 38 30 00 18 00 31 00
> 0x00e0: 1a 84 32 00 4c 52 3a 00 00 00 32 00 40 60 1f 00
> 0x00f0: 04 d1 11 00 80 60 1f 00 00 cc 10 00 80 08 15 00
> 0x0100: d5 35 13 00 00 00 1f 00 ff ff ff ff ff ff ff ff
> 0x0110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0130: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x01a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x01b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x01c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x01d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x01e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x01f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0200: 69 53 84 03 01 00 00 00 00 00 00 00 00 00 00 00
> 0x0210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x02a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x02b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x02c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x02d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x02e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x02f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0320: 00 00 00 00 00 00 00 00 03 3d 00 00 00 00 00 00
> 0x0330: 00 00 00 00 00 00 00 00 00 00 00 00 bc 0c 00 00
> 0x0340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x03a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x03b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x03c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x03d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x03e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x03f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x04a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x04b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x04c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x04d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x04e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x04f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0580: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0590: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x05a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x05b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x05c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x05d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x05e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x05f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0610: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0620: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0630: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0640: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0650: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0660: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0670: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0690: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x06a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x06b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x06c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x06d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x06e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x06f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0710: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0720: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0730: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0740: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0750: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0760: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0770: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0790: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x07a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x07b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x07c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x07d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x07e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x07f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0810: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0820: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0830: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0840: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0850: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0860: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0870: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0890: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x08a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x08b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x08c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x08d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x08e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x08f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0910: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0920: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0930: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0940: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0950: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0960: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0970: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0990: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x09a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x09b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x09c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x09d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x09e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x09f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0a90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0aa0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ab0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ac0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ad0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ae0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0af0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0b90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ba0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0bb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0bc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0bd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0be0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0bf0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0cf0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0d90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0da0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0db0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0dc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0dd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0de0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0df0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0e90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ea0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0eb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ec0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ed0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ee0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ef0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0f90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0fa0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0fb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0fc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0fd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0fe0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0ff0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> lspci -vv
> 
> 00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (Lewisville) (rev 04)
>  Subsystem: Lenovo 82579LM Gigabit Network Connection
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>  Latency: 0
>  Interrupt: pin A routed to IRQ 25
>  Region 0: Memory at f7f00000 (32-bit, non-prefetchable) [size=128K]
>  Region 1: Memory at f7f35000 (32-bit, non-prefetchable) [size=4K]
>  Region 2: I/O ports at f080 [size=32]
>  Capabilities: [c8] Power Management version 2
>  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>  Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>  Address: 00000000fee08004 Data: 4021
>  Capabilities: [e0] PCI Advanced Features
>  AFCap: TP+ FLR+
>  AFCtrl: FLR-
>  AFStatus: TP-
>  Kernel driver in use: e1000e
>  Kernel modules: e1000e
> 
> .config for 4.16-rc6
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ZONE_DMA32=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=4
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_EXTABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_CROSS_COMPILE=""
> CONFIG_LOCALVERSION=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_KERNEL_LZMA=y
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_DATA=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> CONFIG_NO_HZ_IDLE=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_TICK_CPU_ACCOUNTING=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_TASKSTATS=y
> CONFIG_CPU_ISOLATION=y
> CONFIG_TREE_RCU=y
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_LOG_BUF_SHIFT=18
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_IPC_NS=y
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_EVENTS=y
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> CONFIG_SLUB=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_DMA_API_DEBUG=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_HAVE_CC_STACKPROTECTOR=y
> CONFIG_CC_STACKPROTECTOR_NONE=y
> CONFIG_THIN_ARCHIVES=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_ARCH_HAS_PHYS_TO_DMA=y
> CONFIG_ARCH_HAS_REFCOUNT=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_EFI_PARTITION=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_DEFAULT_CFQ=y
> CONFIG_DEFAULT_IOSCHED="cfq"
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_PADATA=y
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_INLINE_READ_UNLOCK=y
> CONFIG_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_INLINE_WRITE_UNLOCK=y
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ZONE_DMA=y
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_FAST_FEATURE_TESTS=y
> CONFIG_RETPOLINE=y
> CONFIG_IOSF_MBI=m
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_NO_BOOTMEM=y
> CONFIG_MCORE2=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_P6_NOP=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> CONFIG_SWIOTLB=y
> CONFIG_IOMMU_HELPER=y
> CONFIG_NR_CPUS_RANGE_BEGIN=2
> CONFIG_NR_CPUS_RANGE_END=512
> CONFIG_NR_CPUS_DEFAULT=64
> CONFIG_NR_CPUS=4
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> CONFIG_PREEMPT_NONE=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_X86_DIRECT_GBPAGES=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_HAVE_GENERIC_GUP=y
> CONFIG_ARCH_DISCARD_MEMBLOCK=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_ARCH_HAS_ZONE_DEVICE=y
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_INTEL_UMIP=y
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_SECCOMP=y
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_SCHED_HRTICK=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_PHYSICAL_ALIGN=0x1000000
> CONFIG_LEGACY_VSYSCALL_EMULATE=y
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_X86_INTEL_PSTATE=y
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCIEAER=y
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> CONFIG_PCI_BUS_ADDR_T_64BIT=y
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_LABEL=y
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_COREDUMP=y
> CONFIG_X86_DEV_DMA_OPS=y
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> CONFIG_PACKET=y
> CONFIG_PACKET_DIAG=y
> CONFIG_UNIX=y
> CONFIG_UNIX_DIAG=y
> CONFIG_XFRM=y
> CONFIG_XFRM_OFFLOAD=y
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_USER=y
> CONFIG_XFRM_IPCOMP=m
> CONFIG_NET_KEY=m
> CONFIG_INET=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_ROUTE_CLASSID=y
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE_DEMUX=m
> CONFIG_NET_IP_TUNNEL=m
> CONFIG_NET_IPGRE=m
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_ESP=m
> CONFIG_INET_ESP_OFFLOAD=m
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_XFRM_TUNNEL=m
> CONFIG_INET_TUNNEL=m
> CONFIG_INET_XFRM_MODE_TRANSPORT=m
> CONFIG_INET_XFRM_MODE_TUNNEL=m
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_FAMILY_ARP=y
> CONFIG_NETFILTER_NETLINK_ACCT=m
> CONFIG_NETFILTER_NETLINK_QUEUE=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> CONFIG_NF_CONNTRACK=m
> CONFIG_NETFILTER_CONNCOUNT=m
> CONFIG_NF_CONNTRACK_MARK=y
> CONFIG_NF_CONNTRACK_EVENTS=y
> CONFIG_NF_CT_PROTO_GRE=m
> CONFIG_NF_CONNTRACK_FTP=m
> CONFIG_NF_CONNTRACK_H323=m
> CONFIG_NF_CONNTRACK_BROADCAST=m
> CONFIG_NF_CONNTRACK_NETBIOS_NS=m
> CONFIG_NF_CONNTRACK_PPTP=m
> CONFIG_NF_CONNTRACK_SIP=m
> CONFIG_NF_CONNTRACK_TFTP=m
> CONFIG_NF_CT_NETLINK=m
> CONFIG_NF_CT_NETLINK_TIMEOUT=m
> CONFIG_NF_NAT=m
> CONFIG_NF_NAT_NEEDED=y
> CONFIG_NF_NAT_FTP=m
> CONFIG_NF_NAT_SIP=m
> CONFIG_NF_NAT_TFTP=m
> CONFIG_NF_NAT_REDIRECT=m
> CONFIG_NETFILTER_SYNPROXY=m
> CONFIG_NETFILTER_XTABLES=m
> CONFIG_NETFILTER_XT_MARK=m
> CONFIG_NETFILTER_XT_CONNMARK=m
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
> CONFIG_NETFILTER_XT_TARGET_HL=m
> CONFIG_NETFILTER_XT_TARGET_MARK=m
> CONFIG_NETFILTER_XT_NAT=m
> CONFIG_NETFILTER_XT_TARGET_NETMAP=m
> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> CONFIG_NETFILTER_XT_MATCH_ECN=m
> CONFIG_NETFILTER_XT_MATCH_ESP=m
> CONFIG_NETFILTER_XT_MATCH_HELPER=m
> CONFIG_NETFILTER_XT_MATCH_HL=m
> CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
> CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> CONFIG_NETFILTER_XT_MATCH_MARK=m
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> CONFIG_NETFILTER_XT_MATCH_POLICY=m
> CONFIG_NETFILTER_XT_MATCH_QUOTA=m
> CONFIG_NETFILTER_XT_MATCH_STATE=m
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
> CONFIG_NETFILTER_XT_MATCH_U32=m
> CONFIG_IP_SET=m
> CONFIG_IP_SET_MAX=256
> CONFIG_IP_SET_BITMAP_IP=m
> CONFIG_IP_SET_BITMAP_IPMAC=m
> CONFIG_IP_SET_BITMAP_PORT=m
> CONFIG_IP_SET_HASH_IP=m
> CONFIG_IP_SET_HASH_IPPORT=m
> CONFIG_IP_SET_HASH_IPPORTIP=m
> CONFIG_IP_SET_HASH_IPPORTNET=m
> CONFIG_IP_SET_HASH_NET=m
> CONFIG_IP_SET_HASH_NETPORT=m
> CONFIG_IP_SET_HASH_NETIFACE=m
> CONFIG_IP_SET_LIST_SET=m
> CONFIG_NF_DEFRAG_IPV4=m
> CONFIG_NF_CONNTRACK_IPV4=m
> CONFIG_NF_REJECT_IPV4=m
> CONFIG_NF_NAT_IPV4=m
> CONFIG_NF_NAT_PROTO_GRE=m
> CONFIG_NF_NAT_PPTP=m
> CONFIG_NF_NAT_H323=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_AH=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_RPFILTER=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_SYNPROXY=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_TTL=m
> CONFIG_IP_NF_RAW=m
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> CONFIG_HAVE_NET_DSA=y
> CONFIG_NET_SCHED=y
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_HFSC=m
> CONFIG_NET_SCH_SFB=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_INGRESS=m
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_FLOW=m
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_U32=m
> CONFIG_NET_EMATCH_IPSET=m
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=m
> CONFIG_NET_ACT_GACT=m
> CONFIG_NET_ACT_MIRRED=m
> CONFIG_NET_ACT_IPT=m
> CONFIG_NET_ACT_NAT=m
> CONFIG_NET_ACT_PEDIT=m
> CONFIG_NET_SCH_FIFO=y
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_NET_FLOW_LIMIT=y
> CONFIG_FIB_RULES=y
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_MAY_USE_DEVLINK=y
> CONFIG_HAVE_EBPF_JIT=y
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> CONFIG_DEVTMPFS=y
> CONFIG_STANDALONE=y
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=m
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PNP=y
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_CDROM=m
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> CONFIG_HAVE_IDE=y
> CONFIG_SCSI_MOD=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_BLK_DEV_SR=m
> CONFIG_CHR_DEV_SG=m
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_ATA=y
> CONFIG_SATA_AHCI=y
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_ATA_SFF=y
> CONFIG_ATA_BMDMA=y
> CONFIG_ATA_PIIX=m
> CONFIG_NETDEVICES=y
> CONFIG_MII=m
> CONFIG_NET_CORE=y
> CONFIG_DUMMY=m
> CONFIG_IFB=m
> CONFIG_TUN=m
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_INTEL=y
> CONFIG_E1000E=m
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=m
> CONFIG_NET_VENDOR_REALTEK=y
> CONFIG_R8169=m
> CONFIG_INPUT=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_DEVMEM=y
> CONFIG_SERIAL_8250=m
> CONFIG_SERIAL_8250_PNP=y
> CONFIG_SERIAL_8250_PCI=m
> CONFIG_SERIAL_8250_EXAR=m
> CONFIG_SERIAL_8250_NR_UARTS=2
> CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> CONFIG_SERIAL_CORE=m
> CONFIG_HW_RANDOM=m
> CONFIG_HW_RANDOM_INTEL=m
> CONFIG_HW_RANDOM_AMD=m
> CONFIG_NVRAM=m
> CONFIG_HPET=y
> CONFIG_DEVPORT=y
> CONFIG_I2C=m
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_ALGOBIT=m
> CONFIG_PPS=m
> CONFIG_THERMAL=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_SSB_POSSIBLE=y
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> CONFIG_VGA_CONSOLE=y
> CONFIG_VGACON_SOFT_SCROLLBACK=y
> CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=128
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_HID=m
> CONFIG_HID_GENERIC=m
> CONFIG_USB_HID=m
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=m
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=m
> CONFIG_USB_PCI=y
> CONFIG_USB_DEFAULT_PERSIST=y
> CONFIG_USB_XHCI_HCD=m
> CONFIG_USB_XHCI_PCI=m
> CONFIG_USB_EHCI_HCD=m
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=m
> CONFIG_USB_EHCI_HCD_PLATFORM=m
> CONFIG_USB_OHCI_HCD=m
> CONFIG_USB_OHCI_HCD_PCI=m
> CONFIG_USB_UHCI_HCD=m
> CONFIG_USB_STORAGE=m
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_PL2303=m
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> CONFIG_RTC_NVMEM=y
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> CONFIG_RTC_I2C_AND_SPI=m
> CONFIG_RTC_DRV_CMOS=m
> CONFIG_PMC_ATOM=y
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> CONFIG_IOMMU_SUPPORT=y
> CONFIG_ARM_GIC_MAX_NR=1
> CONFIG_RAS=y
> CONFIG_NVMEM=y
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_EXT2_FS=y
> CONFIG_BTRFS_FS=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FSNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FUSE_FS=m
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_UDF_FS=m
> CONFIG_UDF_NLS=y
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_NTFS_FS=m
> CONFIG_NTFS_RW=y
> CONFIG_PROC_FS=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=m
> CONFIG_NLS_ASCII=m
> CONFIG_NLS_ISO8859_1=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_UTF8=m
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_FRAME_WARN=2048
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_STACK_VALIDATION=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_RUNTIME_TESTING_MENU=y
> CONFIG_HAVE_ARCH_KGDB=y
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_DOUBLEFAULT=y
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_IO_DELAY_TYPE_0X80=0
> CONFIG_IO_DELAY_TYPE_0XED=1
> CONFIG_IO_DELAY_TYPE_UDELAY=2
> CONFIG_IO_DELAY_TYPE_NONE=3
> CONFIG_IO_DELAY_0X80=y
> CONFIG_DEFAULT_IO_DELAY_TYPE=0
> CONFIG_UNWINDER_ORC=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_XOR_BLOCKS=y
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=m
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=m
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=m
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=m
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=m
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=m
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=m
> CONFIG_CRYPTO_WORKQUEUE=y
> CONFIG_CRYPTO_CRYPTD=m
> CONFIG_CRYPTO_AUTHENC=m
> CONFIG_CRYPTO_ABLK_HELPER=m
> CONFIG_CRYPTO_SIMD=m
> CONFIG_CRYPTO_GLUE_HELPER_X86=m
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=m
> CONFIG_CRYPTO_CHACHA20POLY1305=m
> CONFIG_CRYPTO_SEQIV=m
> CONFIG_CRYPTO_ECHAINIV=m
> CONFIG_CRYPTO_CBC=m
> CONFIG_CRYPTO_CTR=m
> CONFIG_CRYPTO_ECB=m
> CONFIG_CRYPTO_LRW=m
> CONFIG_CRYPTO_XTS=m
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=m
> CONFIG_CRYPTO_XCBC=m
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=m
> CONFIG_CRYPTO_GHASH=m
> CONFIG_CRYPTO_POLY1305=m
> CONFIG_CRYPTO_POLY1305_X86_64=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA1_SSSE3=m
> CONFIG_CRYPTO_SHA256_SSSE3=m
> CONFIG_CRYPTO_SHA512_SSSE3=m
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_SHA3=m
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_X86_64=m
> CONFIG_CRYPTO_AES_NI_INTEL=m
> CONFIG_CRYPTO_CAMELLIA=m
> CONFIG_CRYPTO_CAMELLIA_X86_64=m
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_DES3_EDE_X86_64=m
> CONFIG_CRYPTO_CHACHA20=m
> CONFIG_CRYPTO_CHACHA20_X86_64=m
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_LZO=m
> CONFIG_CRYPTO_842=m
> CONFIG_CRYPTO_LZ4=m
> CONFIG_CRYPTO_LZ4HC=m
> CONFIG_CRYPTO_ANSI_CPRNG=m
> CONFIG_CRYPTO_DRBG_MENU=m
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG=m
> CONFIG_CRYPTO_JITTERENTROPY=m
> CONFIG_HAVE_KVM=y
> CONFIG_RAID6_PQ=y
> CONFIG_BITREVERSE=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_CRC_ITU_T=m
> CONFIG_CRC32=y
> CONFIG_CRC32_SLICEBY8=y
> CONFIG_LIBCRC32C=m
> CONFIG_XXHASH=y
> CONFIG_842_COMPRESS=m
> CONFIG_842_DECOMPRESS=m
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=m
> CONFIG_LZ4HC_COMPRESS=m
> CONFIG_LZ4_DECOMPRESS=m
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> CONFIG_NLATTR=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_SG_CHAIN=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_SBITMAP=y
