From: Anders K. Pedersen | Cohaesio <akp@cohaesio.com>
Date: Wed, 4 Oct 2017 12:56:07 +0000
Subject: [Intel-wired-lan] Linux 4.12+ memory leak on router with i40e NICs
Message-ID: <1507121766.30720.4.camel@cohaesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

After updating one of our Linux based routers to kernel 4.13 it began
leaking memory quite fast (about 1 GB every half hour). To narrow we
tried various kernel versions and found that 4.11.12 is okay, while
4.12 also leaks, so we did a bisection between 4.11 and 4.12. 

The first bisection ended at
"[6964e53f55837b0c49ed60d36656d2e0ee4fc27b] i40e: fix handling of HW
ATR eviction", which fixes some flag handling that was broken by
47994c119a36 "i40e: remove hw_disabled_flags in favor of using separate
flag bits", so I did a second bisection, where I added 6964e53f5583
"i40e: fix handling of HW ATR eviction" to the steps that had
47994c119a36 "i40e: remove hw_disabled_flags in favor of using separate
flag bits" in them.

The second bisection ended at
"[0e626ff7ccbfc43c6cc4aeea611c40b899682382] i40e: Fix support for flow
director programming status", where I don't see any obvious problems,
so I'm hoping for some assistance.

The router is a PowerEdge R730 server (Haswell based) with three Intel
NICs (all using the i40e driver):

X710 quad port 10 GbE SFP+: eth0 eth1 eth2 eth3
X710 quad port 10 GbE SFP+: eth4 eth5 eth6 eth7
XL710 dual port 40 GbE QSFP+: eth8 eth9

The NICs are aggregated with LACP with the team driver:

team0: eth9 (40 GbE selected primary), and eth3, eth7 (10 GbE non-selected backups)
team1: eth0, eth1, eth4, eth5 (all 10 GbE selected)

team0 is used for internal networks and has one untagged and four
tagged VLAN interfaces, while team1 has an external uplink connection
without any VLANs.

The router runs an eBGP session on team1 to one of our uplinks, and
iBGP via team0 to our other border routers. It also runs OSPF on the
internal VLANs on team0. One thing I've noticed is that when OSPF is
not announcing a default gateway to the internal networks, so there is
almost no traffic coming in on team0 and out on team1, but still plenty
of traffic coming in on team1 and out via team0, there's no memory leak
(or at least it is so small that we haven't detected it). But as soon
as we configure OSPF to announce a default gateway to the internal
VLANs, so we get traffic from team0 to team1 the leaking begins.
Stopping the OSPF default gateway announcement again also stops the
leaking, but does not release already leaked memory.

So this leads to me suspect that the leaking is related to RX on team0
(where XL710 eth9 is normally the only active interface) or TX on team1
(X710 eth0, eth1, eth4, eth5). The first bad commit is related to RX
cleaning, which suggests RX on team0. Since we're only seeing the leak
for our outbound traffic, I suspect either a difference between the
X710 vs. XL710 NICs, or that the inbound traffic is for relatively few
destination addresses (only our own systems) while the outbound traffic
is for many different addresses on the internet. But I'm just guessing
here.

I've tried kmemleak, but it only found a few kB of suspected memory
leaks (several of which disappeared again after a while).

Below I've included more details - git bisect logs, ethtool -i, dmesg,
Kernel .config, and various memory related /proc files. Any help or
suggestions would be much appreciated, and please let me know if more
information is needed or there's something I should try.

Regards,
Anders K. Pedersen


Log of first git bisection:
git bisect start
# bad: [6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c] Linux 4.12
git bisect bad 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
# good: [a351e9b9fc24e982ec2f0e76379a49826036da12] Linux 4.11
git bisect good a351e9b9fc24e982ec2f0e76379a49826036da12
# good: [2bd80401743568ced7d303b008ae5298ce77e695] Merge tag 'gpio-v4.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
git bisect good 2bd80401743568ced7d303b008ae5298ce77e695
# good: [85d604902eb28eaea4f9e0f3a655ae986fa4bd2e] Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 85d604902eb28eaea4f9e0f3a655ae986fa4bd2e
# good: [b16c4c48390eb14a1bb4a06702a8c65b837c4566] Merge branch 'mlxsw-fixes'
git bisect good b16c4c48390eb14a1bb4a06702a8c65b837c4566
# good: [b29794ec95c6856b316c2295904208bf11ffddd9] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good b29794ec95c6856b316c2295904208bf11ffddd9
# bad: [a090bd4ff8387c409732a8e059fbf264ea0bdd56] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect bad a090bd4ff8387c409732a8e059fbf264ea0bdd56
# good: [8f56821d1db34b980ebe027a1b6fff2233471062] Merge branch 'libnvdimm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect good 8f56821d1db34b980ebe027a1b6fff2233471062
# good: [63f700aab4c11d46626de3cd051dae56cf7e9056] Merge tag 'xtensa-20170612' of git://github.com/jcmvbkbc/linux-xtensa
git bisect good 63f700aab4c11d46626de3cd051dae56cf7e9056
# good: [800c55cb76be6617232ef50a2be29830f3aa8e5c] net: ena: bug fix in lost tx packets detection mechanism
git bisect good 800c55cb76be6617232ef50a2be29830f3aa8e5c
# bad: [20a3d5bf5e5b13c02450ab6178ec374abd830686] caif: Add sockaddr length check before accessing sa_family in connect handler
git bisect bad 20a3d5bf5e5b13c02450ab6178ec374abd830686
# bad: [eb3c28c15555212227cfa8b9a3baa21ad5982a19] r8152: give the device version
git bisect bad eb3c28c15555212227cfa8b9a3baa21ad5982a19
# good: [91828bd89940e8145f91751a015bc11bc486aad0] net/mlx5: Enable 4K UAR only when page size is bigger than 4K
git bisect good 91828bd89940e8145f91751a015bc11bc486aad0
# good: [4b1f0d33db7d5bf92b5623e3ea2066e2de3999e3] net: ipmr: Fix some mroute forwarding issues in vrf's
git bisect good 4b1f0d33db7d5bf92b5623e3ea2066e2de3999e3
# good: [675c8da049fd6556eb2d6cdd745fe812752f07a8] hsr: fix incorrect warning
git bisect good 675c8da049fd6556eb2d6cdd745fe812752f07a8
# bad: [97d8b6e3b8538198aefb0003342920a82e062147] net: rps: fix uninitialized symbol warning
git bisect bad 97d8b6e3b8538198aefb0003342920a82e062147
# bad: [6964e53f55837b0c49ed60d36656d2e0ee4fc27b] i40e: fix handling of HW ATR eviction
git bisect bad 6964e53f55837b0c49ed60d36656d2e0ee4fc27b
# first bad commit: [6964e53f55837b0c49ed60d36656d2e0ee4fc27b] i40e: fix handling of HW ATR eviction


Log of second git bisection:
git bisect start
# bad: [6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c] Linux 4.12
git bisect bad 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
# good: [a351e9b9fc24e982ec2f0e76379a49826036da12] Linux 4.11
git bisect good a351e9b9fc24e982ec2f0e76379a49826036da12
# bad: [2bd80401743568ced7d303b008ae5298ce77e695] Merge tag 'gpio-v4.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
git bisect bad 2bd80401743568ced7d303b008ae5298ce77e695
# bad: [8d65b08debc7e62b2c6032d7fe7389d895b92cbc] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect bad 8d65b08debc7e62b2c6032d7fe7389d895b92cbc
# bad: [cec381919818a9a0cb85600b3c82404bdd38cf36] Merge tag 'mac80211-next-for-davem-2017-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next
git bisect bad cec381919818a9a0cb85600b3c82404bdd38cf36
# good: [5cd8985a19090f2b0ce8700ae3ec19e06a4fc5e9] net-next: dsa: add Mediatek tag RX/TX handler
git bisect good 5cd8985a19090f2b0ce8700ae3ec19e06a4fc5e9
# good: [763dbf6328e41de7a55851baf5ee49e367552531] net_sched: move the empty tp check from ->destroy() to ->delete()
git bisect good 763dbf6328e41de7a55851baf5ee49e367552531
# good: [291084951825e1efca081926b10bf3ff7e872476] iwlwifi: adjust NVM parsing APIs for new a000 method
git bisect good 291084951825e1efca081926b10bf3ff7e872476
# bad: [cf1ef3f0719b4dcb74810ed507e2a2540f9811b4] net/tcp_fastopen: Disable active side TFO in certain scenarios
git bisect bad cf1ef3f0719b4dcb74810ed507e2a2540f9811b4
# bad: [69e3948aaa559670da2662ad9d5cbc782bfc6885] Merge tag 'nfc-next-4.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/sameo/nfc-next
git bisect bad 69e3948aaa559670da2662ad9d5cbc782bfc6885
# bad: [b18b745397e0154795b2d5504def5ccd090b893c] net: arc_emac: switch to phy_start()/phy_stop()
git bisect bad b18b745397e0154795b2d5504def5ccd090b893c
# bad: [072cec7797b16c454156da737923a393322dc848] Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
git bisect bad 072cec7797b16c454156da737923a393322dc848
# bad: [e8d2f4c674571b2b2d8a58405196d4a390996e33] i40e: fix CONFIG_BUSY checks in i40e_set_settings function
git bisect bad e8d2f4c674571b2b2d8a58405196d4a390996e33
# bad: [3118025a070f3346a3f23cbb8e9039ff567a6c46] i40e: dump VF information in debugfs
git bisect bad 3118025a070f3346a3f23cbb8e9039ff567a6c46
# good: [53240e99dbbfe69a6b3ca808a6d15eea744be169] i40e/i40evf: Remove VF Rx csum offload for tunneled packets
git bisect good 53240e99dbbfe69a6b3ca808a6d15eea744be169
# bad: [0e626ff7ccbfc43c6cc4aeea611c40b899682382] i40e: Fix support for flow director programming status
git bisect bad 0e626ff7ccbfc43c6cc4aeea611c40b899682382
# first bad commit: [0e626ff7ccbfc43c6cc4aeea611c40b899682382] i40e: Fix support for flow director programming status


NIC info from working 4.11.12 kernel:
# ethtool -i eth0
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d37 18.0.17
bus-info: 0000:01:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth1
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d37 18.0.17
bus-info: 0000:01:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth2
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d37 18.0.17
bus-info: 0000:01:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth3
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d37 18.0.17
bus-info: 0000:01:00.3
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth4
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d36 18.0.17
bus-info: 0000:05:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth5
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d36 18.0.17
bus-info: 0000:05:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth6
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d36 18.0.17
bus-info: 0000:05:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth7
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d36 18.0.17
bus-info: 0000:05:00.3
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth8
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d3b 18.0.17
bus-info: 0000:03:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool -i eth9
driver: i40e
version: 1.6.27-k
firmware-version: 5.40 0x80002d3b 18.0.17
bus-info: 0000:03:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes


Kernel messages from booting git bisect kernel at first bad commit "[0e626ff7ccbfc43c6cc4aeea611c40b899682382] i40e: Fix support for flow director programming status":
[    0.000000] microcode: microcode updated early to revision 0x3a, date = 2017-01-30
[    0.000000] Linux version 4.11.0-rc6+ () (gcc version 4.9.2 (Debian 4.9.2-10) ) #31 SMP Tue Oct 3 05:26:44 CEST 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0-rc6+ root=UUID=f51799d0-da30-4b82-aa7e-999840cd0d19 ro consoleblank=0 console=uart8250,io,0x3f8,115200n8 console=tty0 slub_nomerge slub_min_objects=128 ipv6.autoconf=0 rhash_entries=2097151 quiet
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000067dc9fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000067dca000-0x000000006fdd1fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006fdd2000-0x000000007a088fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a089000-0x000000007a188fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a189000-0x000000007a288fff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007a289000-0x000000007af0afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007af0b000-0x000000007b93afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007b93b000-0x000000007bab7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007bab8000-0x000000007bae8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bae9000-0x000000007bafefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007baff000-0x000000007bafffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feda8000-0x00000000fedabfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff310000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fffffff] usable
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '115200n8')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by Dell Inc.
[    0.000000] efi:  ACPI 2.0=0x7bab7014  SMBIOS=0x7af0a000  ACPI=0x7bab7000 
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.4.3 01/17/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x880000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask 3FFF80000000 write-back
[    0.000000]   1 base 000100000000 mask 3FFF00000000 write-back
[    0.000000]   2 base 000200000000 mask 3FFE00000000 write-back
[    0.000000]   3 base 000400000000 mask 3FFC00000000 write-back
[    0.000000]   4 base 000800000000 mask 3FFF80000000 write-back
[    0.000000]   5 base 0000FF000000 mask 3FFFFF000000 write-protect
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] x2apic: enabled by BIOS, switching to x2apic ops
[    0.000000] e820: last_pfn = 0x7bb00 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01a81000, 0x01a81fff] PGTABLE
[    0.000000] BRK [0x01a82000, 0x01a82fff] PGTABLE
[    0.000000] BRK [0x01a83000, 0x01a83fff] PGTABLE
[    0.000000] BRK [0x01a84000, 0x01a84fff] PGTABLE
[    0.000000] BRK [0x01a85000, 0x01a85fff] PGTABLE
[    0.000000] BRK [0x01a86000, 0x01a86fff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x378fe000-0x37c76fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007BAB7014 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x000000007BAB60E8 0000C4 (v01 DELL   PE_SC3   00000000      01000013)
[    0.000000] ACPI: FACP 0x000000007BAB2000 0000F4 (v04 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: DSDT 0x000000007BA98000 010768 (v02 DELL   PE_SC3   00000003 DELL 00000001)
[    0.000000] ACPI: FACS 0x000000007B8F3000 000040
[    0.000000] ACPI: MCEJ 0x000000007BAB5000 000130 (v01 INTEL           00000001 INTL 0100000D)
[    0.000000] ACPI: WDAT 0x000000007BAB4000 000134 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SLIC 0x000000007BAB3000 000024 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: HPET 0x000000007BAB1000 000038 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: APIC 0x000000007BAAF000 001FFC (v03 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: MCFG 0x000000007BAAE000 00003C (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: MSCT 0x000000007BAAD000 000090 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SLIT 0x000000007BAAC000 00006C (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SRAT 0x000000007BAA9000 002330 (v03 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: SSDT 0x000000007B955000 1424A9 (v02 DELL   PE_SC3   00004000 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B952000 00217F (v02 DELL   PE_SC3   00000002 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B951000 00006E (v02 DELL   PE_SC3   00000002 INTL 20121114)
[    0.000000] ACPI: PRAD 0x000000007B950000 000132 (v02 DELL   PE_SC3   00000002 INTL 20121114)
[    0.000000] ACPI: SPCR 0x000000007BAFE000 000050 (v01                 00000000      00000000)
[    0.000000] ACPI: DMAR 0x000000007BAFD000 0000A8 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: HEST 0x000000007BAF5000 00017C (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: BERT 0x000000007BAF4000 000030 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: ERST 0x000000007BAF3000 000230 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: EINJ 0x000000007BAF2000 000150 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Setting APIC routing to cluster x2apic.
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000001000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000087fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000067dc9fff]
[    0.000000]   node   0: [mem 0x000000006fdd2000-0x000000007a088fff]
[    0.000000]   node   0: [mem 0x000000007bab8000-0x000000007bae8fff]
[    0.000000]   node   0: [mem 0x000000007baff000-0x000000007bafffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000087fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000087fffffff]
[    0.000000] On node 0 totalpages: 8331346
[    0.000000]   DMA32 zone: 7298 pages used for memmap
[    0.000000]   DMA32 zone: 1097 pages reserved
[    0.000000]   DMA32 zone: 467026 pages, LIFO batch:31
[    0.000000]   Normal zone: 122880 pages used for memmap
[    0.000000]   Normal zone: 7864320 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: X2APIC_NMI (uid[0x00] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x01] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x02] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x03] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x04] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x05] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x06] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x07] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x08] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x09] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x0a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x0b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x0c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x0d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x0e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x0f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x10] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x11] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x12] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x13] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x14] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x15] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x16] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x17] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x18] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x19] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x1a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x1b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x1c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x1d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x1e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x1f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x20] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x21] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x22] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x23] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x24] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x25] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x26] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x27] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x28] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x29] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x2a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x2b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x2c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x2d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x2e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x2f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x30] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x31] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x32] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x33] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x34] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x35] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x36] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x37] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x38] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x39] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x3a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x3b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x3c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x3d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x3e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x3f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x40] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x41] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x42] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x43] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x44] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x45] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x46] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x47] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x48] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x49] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x4a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x4b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x4c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x4d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x4e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x4f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x50] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x51] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x52] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x53] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x54] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x55] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x56] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x57] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x58] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x59] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x5a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x5b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x5c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x5d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x5e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x5f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x60] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x61] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x62] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x63] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x64] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x65] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x66] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x67] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x68] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x69] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x6a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x6b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x6c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x6d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x6e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x6f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x70] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x71] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x72] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x73] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x74] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x75] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x76] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x77] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x78] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x79] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x7a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x7b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x7c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x7d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x7e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x7f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x80] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x81] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x82] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x83] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x84] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x85] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x86] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x87] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x88] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x89] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x8a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x8b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x8c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x8d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x8e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x8f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x90] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x91] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x92] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x93] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x94] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x95] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x96] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x97] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x98] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x99] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x9a] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x9b] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x9c] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x9d] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x9e] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0x9f] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa0] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa1] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa2] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa3] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa4] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa5] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa6] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa7] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa8] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xa9] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xaa] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xab] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xac] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xad] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xae] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xaf] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb0] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb1] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb2] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb3] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb4] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb5] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb6] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb7] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb8] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xb9] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xba] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xbb] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xbc] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xbd] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xbe] high level lint[0x1])
[    0.000000] ACPI: X2APIC_NMI (uid[0xbf] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x20] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x21] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x22] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x23] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x24] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x25] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x26] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x27] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x28] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x29] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x30] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x31] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x32] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x33] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x34] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x35] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x36] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x37] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x38] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x39] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x40] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x41] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x42] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x43] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x44] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x45] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x46] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x47] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x48] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x49] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x50] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x51] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x52] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x53] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x54] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x55] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x56] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x57] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x58] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x59] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x60] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x61] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x62] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x63] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x64] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x65] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x66] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x67] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x68] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x69] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x70] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x71] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x72] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x73] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x74] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x75] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x76] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x77] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x78] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x79] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x80] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x81] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x82] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x83] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x84] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x85] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x86] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x87] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x88] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x89] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x90] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x91] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x92] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x93] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x94] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x95] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x96] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x97] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x98] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x99] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaa] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xab] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xac] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xad] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xae] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaf] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xba] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbb] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbc] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbd] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbe] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbf] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x90000000-0xfeda7fff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.000000] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 36 pages/cpu @ffff88085f200000 s108248 r8192 d31016 u262144
[    0.000000] pcpu-alloc: s108248 r8192 d31016 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8200071
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0-rc6+ root=UUID=f51799d0-da30-4b82-aa7e-999840cd0d19 ro consoleblank=0 console=uart8250,io,0x3f8,115200n8 console=tty0 slub_nomerge slub_min_objects=128 ipv6.autoconf=0 rhash_entries=2097151 quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Memory: 32470996K/33325384K available (5682K kernel code, 914K rwdata, 1580K rodata, 1068K init, 548K bss, 854388K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=128, CPUs=16, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:960 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [uart8250] disabled
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.010000] spurious 8259A interrupt: IRQ7.
[    0.010000] tsc: Detected 3199.724 MHz processor
[    0.010000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6399.44 BogoMIPS (lpj=31997240)
[    0.010000] pid_max: default: 32768 minimum: 301
[    0.010000] ACPI: Core revision 20170119
[    0.074706] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.075136] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.075137] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.075323] CPU: Physical Processor ID: 0
[    0.075324] CPU: Processor Core ID: 0
[    0.075327] mce: CPU supports 22 MCE banks
[    0.075340] CPU0: Thermal monitoring enabled (TM1)
[    0.075375] process: using mwait in idle threads
[    0.075377] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.075377] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.075409] Freeing SMP alternatives memory: 24K
[    0.079360] ftrace: allocating 22419 entries in 88 pages
[    0.085128] smpboot: Max logical packages: 26
[    0.085132] DMAR: Host address width 46
[    0.085133] DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
[    0.085136] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0466 ecap f020df
[    0.085137] DMAR: RMRR base: 0x00000067dca000 end: 0x0000006fdd1fff
[    0.085137] DMAR: ATSR flags: 0x0
[    0.085138] DMAR-IR: IOAPIC id 8 under DRHD base  0xfbffc000 IOMMU 0
[    0.085139] DMAR-IR: IOAPIC id 9 under DRHD base  0xfbffc000 IOMMU 0
[    0.085139] DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
[    0.085140] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.085243] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
[    0.085245] DMAR-IR: Failed to copy IR table for dmar0 from previous kernel
[    0.090092] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.090563] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.193587] TSC deadline timer enabled
[    0.193589] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2667 v3 @ 3.20GHz (family: 0x6, model: 0x3f, stepping: 0x2)
[    0.193621] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.193645] ... version:                3
[    0.193645] ... bit width:              48
[    0.193645] ... generic registers:      4
[    0.193646] ... value mask:             0000ffffffffffff
[    0.193646] ... max period:             00007fffffffffff
[    0.193646] ... fixed-purpose events:   3
[    0.193647] ... event mask:             000000070000000f
[    0.193900] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.193908] smp: Bringing up secondary CPUs ...
[    0.193941] x86: Booting SMP configuration:
[    0.193941] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    2.440016] smp: Brought up 1 node, 16 CPUs
[    2.440016] smpboot: Total of 16 processors activated (102398.30 BogoMIPS)
[    2.450129] sched_clock: Marking stable (2450000000, 0)->(2451140928, -1140928)
[    2.450515] devtmpfs: initialized
[    2.450669] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    2.450672] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    2.451261] NET: Registered protocol family 16
[    2.451340] cpuidle: using governor menu
[    2.451382] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    2.451383] ACPI: bus type PCI registered
[    2.451417] dca service started, version 1.12.1
[    2.451430] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    2.451441] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    2.451451] PCI: Using configuration type 1 for base access
[    2.451457] PCI: Dell System detected, enabling pci=bfsort.
[    2.451535] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    2.452266] ACPI: Added _OSI(Module Device)
[    2.452267] ACPI: Added _OSI(Processor Device)
[    2.452267] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.452268] ACPI: Added _OSI(Processor Aggregator Device)
[    2.531242] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    2.536580] ACPI: Dynamic OEM Table Load:
[    2.538673] ACPI: Interpreter enabled
[    2.538676] ACPI: (supports S0 S5)
[    2.538677] ACPI: Using IOAPIC for interrupt routing
[    2.538703] HEST: Table parsing has been initialized.
[    2.538705] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.546269] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
[    2.546272] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.546324] acpi PNP0A03:03: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.546339] PCI host bridge to bus 0000:ff
[    2.546340] pci_bus 0000:ff: root bus resource [bus ff]
[    2.546347] pci 0000:ff:0b.0: [8086:2f81] type 00 class 0x088000
[    2.546377] pci 0000:ff:0b.1: [8086:2f36] type 00 class 0x110100
[    2.546401] pci 0000:ff:0b.2: [8086:2f37] type 00 class 0x110100
[    2.546425] pci 0000:ff:0c.0: [8086:2fe0] type 00 class 0x088000
[    2.546449] pci 0000:ff:0c.1: [8086:2fe1] type 00 class 0x088000
[    2.546471] pci 0000:ff:0c.2: [8086:2fe2] type 00 class 0x088000
[    2.546493] pci 0000:ff:0c.3: [8086:2fe3] type 00 class 0x088000
[    2.546515] pci 0000:ff:0c.4: [8086:2fe4] type 00 class 0x088000
[    2.546538] pci 0000:ff:0c.5: [8086:2fe5] type 00 class 0x088000
[    2.546560] pci 0000:ff:0c.6: [8086:2fe6] type 00 class 0x088000
[    2.546582] pci 0000:ff:0c.7: [8086:2fe7] type 00 class 0x088000
[    2.546605] pci 0000:ff:0f.0: [8086:2ff8] type 00 class 0x088000
[    2.546626] pci 0000:ff:0f.1: [8086:2ff9] type 00 class 0x088000
[    2.546652] pci 0000:ff:0f.4: [8086:2ffc] type 00 class 0x088000
[    2.546674] pci 0000:ff:0f.5: [8086:2ffd] type 00 class 0x088000
[    2.546695] pci 0000:ff:0f.6: [8086:2ffe] type 00 class 0x088000
[    2.546717] pci 0000:ff:10.0: [8086:2f1d] type 00 class 0x088000
[    2.546741] pci 0000:ff:10.1: [8086:2f34] type 00 class 0x110100
[    2.546764] pci 0000:ff:10.5: [8086:2f1e] type 00 class 0x088000
[    2.546785] pci 0000:ff:10.6: [8086:2f7d] type 00 class 0x110100
[    2.546806] pci 0000:ff:10.7: [8086:2f1f] type 00 class 0x088000
[    2.546831] pci 0000:ff:12.0: [8086:2fa0] type 00 class 0x088000
[    2.546856] pci 0000:ff:12.1: [8086:2f30] type 00 class 0x110100
[    2.546879] pci 0000:ff:12.2: [8086:2f70] type 00 class 0x088000
[    2.546904] pci 0000:ff:13.0: [8086:2fa8] type 00 class 0x088000
[    2.546930] pci 0000:ff:13.1: [8086:2f71] type 00 class 0x088000
[    2.546957] pci 0000:ff:13.2: [8086:2faa] type 00 class 0x088000
[    2.546982] pci 0000:ff:13.3: [8086:2fab] type 00 class 0x088000
[    2.547008] pci 0000:ff:13.4: [8086:2fac] type 00 class 0x088000
[    2.547033] pci 0000:ff:13.5: [8086:2fad] type 00 class 0x088000
[    2.547058] pci 0000:ff:13.6: [8086:2fae] type 00 class 0x088000
[    2.547083] pci 0000:ff:13.7: [8086:2faf] type 00 class 0x088000
[    2.547107] pci 0000:ff:14.0: [8086:2fb0] type 00 class 0x088000
[    2.547133] pci 0000:ff:14.1: [8086:2fb1] type 00 class 0x088000
[    2.547159] pci 0000:ff:14.2: [8086:2fb2] type 00 class 0x088000
[    2.547187] pci 0000:ff:14.3: [8086:2fb3] type 00 class 0x088000
[    2.547212] pci 0000:ff:14.4: [8086:2fbc] type 00 class 0x088000
[    2.547236] pci 0000:ff:14.5: [8086:2fbd] type 00 class 0x088000
[    2.547260] pci 0000:ff:14.6: [8086:2fbe] type 00 class 0x088000
[    2.547283] pci 0000:ff:14.7: [8086:2fbf] type 00 class 0x088000
[    2.547309] pci 0000:ff:15.0: [8086:2fb4] type 00 class 0x088000
[    2.547335] pci 0000:ff:15.1: [8086:2fb5] type 00 class 0x088000
[    2.547361] pci 0000:ff:15.2: [8086:2fb6] type 00 class 0x088000
[    2.547386] pci 0000:ff:15.3: [8086:2fb7] type 00 class 0x088000
[    2.547416] pci 0000:ff:16.0: [8086:2f68] type 00 class 0x088000
[    2.547442] pci 0000:ff:16.6: [8086:2f6e] type 00 class 0x088000
[    2.547466] pci 0000:ff:16.7: [8086:2f6f] type 00 class 0x088000
[    2.547489] pci 0000:ff:17.0: [8086:2fd0] type 00 class 0x088000
[    2.547514] pci 0000:ff:17.4: [8086:2fb8] type 00 class 0x088000
[    2.547540] pci 0000:ff:17.5: [8086:2fb9] type 00 class 0x088000
[    2.547563] pci 0000:ff:17.6: [8086:2fba] type 00 class 0x088000
[    2.547587] pci 0000:ff:17.7: [8086:2fbb] type 00 class 0x088000
[    2.547613] pci 0000:ff:1e.0: [8086:2f98] type 00 class 0x088000
[    2.547637] pci 0000:ff:1e.1: [8086:2f99] type 00 class 0x088000
[    2.547659] pci 0000:ff:1e.2: [8086:2f9a] type 00 class 0x088000
[    2.547682] pci 0000:ff:1e.3: [8086:2fc0] type 00 class 0x088000
[    2.547697] pci 0000:ff:1e.4: [8086:2f9c] type 00 class 0x088000
[    2.547721] pci 0000:ff:1f.0: [8086:2f88] type 00 class 0x088000
[    2.547746] pci 0000:ff:1f.2: [8086:2f8a] type 00 class 0x088000
[    2.547771] pci_bus 0000:ff: on NUMA node 0
[    2.548096] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    2.548098] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.548136] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.548166] PCI host bridge to bus 0000:00
[    2.548167] pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
[    2.548168] pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
[    2.548168] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    2.548169] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
[    2.548170] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.548170] pci_bus 0000:00: root bus resource [mem 0x90000000-0xfbffbfff window]
[    2.548171] pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bfffffffff window]
[    2.548172] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.548176] pci 0000:00:00.0: [8086:2f00] type 00 class 0x060000
[    2.548260] pci 0000:00:01.0: [8086:2f02] type 01 class 0x060400
[    2.548312] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    2.548361] pci 0000:00:02.0: [8086:2f04] type 01 class 0x060400
[    2.548413] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    2.548464] pci 0000:00:02.2: [8086:2f06] type 01 class 0x060400
[    2.548515] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    2.548570] pci 0000:00:03.0: [8086:2f08] type 01 class 0x060400
[    2.548621] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    2.548668] pci 0000:00:03.2: [8086:2f0a] type 01 class 0x060400
[    2.548719] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
[    2.548771] pci 0000:00:04.0: [8086:2f20] type 00 class 0x088000
[    2.548778] pci 0000:00:04.0: reg 0x10: [mem 0x3bffff1c000-0x3bffff1ffff 64bit]
[    2.548851] pci 0000:00:04.1: [8086:2f21] type 00 class 0x088000
[    2.548858] pci 0000:00:04.1: reg 0x10: [mem 0x3bffff18000-0x3bffff1bfff 64bit]
[    2.548930] pci 0000:00:04.2: [8086:2f22] type 00 class 0x088000
[    2.548936] pci 0000:00:04.2: reg 0x10: [mem 0x3bffff14000-0x3bffff17fff 64bit]
[    2.549009] pci 0000:00:04.3: [8086:2f23] type 00 class 0x088000
[    2.549016] pci 0000:00:04.3: reg 0x10: [mem 0x3bffff10000-0x3bffff13fff 64bit]
[    2.549088] pci 0000:00:04.4: [8086:2f24] type 00 class 0x088000
[    2.549094] pci 0000:00:04.4: reg 0x10: [mem 0x3bffff0c000-0x3bffff0ffff 64bit]
[    2.549166] pci 0000:00:04.5: [8086:2f25] type 00 class 0x088000
[    2.549172] pci 0000:00:04.5: reg 0x10: [mem 0x3bffff08000-0x3bffff0bfff 64bit]
[    2.549244] pci 0000:00:04.6: [8086:2f26] type 00 class 0x088000
[    2.549250] pci 0000:00:04.6: reg 0x10: [mem 0x3bffff04000-0x3bffff07fff 64bit]
[    2.549323] pci 0000:00:04.7: [8086:2f27] type 00 class 0x088000
[    2.549329] pci 0000:00:04.7: reg 0x10: [mem 0x3bffff00000-0x3bffff03fff 64bit]
[    2.549401] pci 0000:00:05.0: [8086:2f28] type 00 class 0x088000
[    2.549468] pci 0000:00:05.1: [8086:2f29] type 00 class 0x088000
[    2.549545] pci 0000:00:05.2: [8086:2f2a] type 00 class 0x088000
[    2.549612] pci 0000:00:05.4: [8086:2f2c] type 00 class 0x080020
[    2.549617] pci 0000:00:05.4: reg 0x10: [mem 0x9ec04000-0x9ec04fff]
[    2.549700] pci 0000:00:11.0: [8086:8d7c] type 00 class 0xff0000
[    2.549753] pci 0000:00:11.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    2.549841] pci 0000:00:11.4: [8086:8d62] type 00 class 0x010601
[    2.549854] pci 0000:00:11.4: reg 0x10: [io  0x3078-0x307f]
[    2.549860] pci 0000:00:11.4: reg 0x14: [io  0x308c-0x308f]
[    2.549866] pci 0000:00:11.4: reg 0x18: [io  0x3070-0x3077]
[    2.549873] pci 0000:00:11.4: reg 0x1c: [io  0x3088-0x308b]
[    2.549879] pci 0000:00:11.4: reg 0x20: [io  0x3040-0x305f]
[    2.549886] pci 0000:00:11.4: reg 0x24: [mem 0x9ec01000-0x9ec017ff]
[    2.549935] pci 0000:00:11.4: PME# supported from D3hot
[    2.549977] pci 0000:00:16.0: [8086:8d3a] type 00 class 0x078000
[    2.549991] pci 0000:00:16.0: reg 0x10: [mem 0x3bffff23000-0x3bffff2300f 64bit]
[    2.550060] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    2.550098] pci 0000:00:16.1: [8086:8d3b] type 00 class 0x078000
[    2.550112] pci 0000:00:16.1: reg 0x10: [mem 0x3bffff22000-0x3bffff2200f 64bit]
[    2.550178] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    2.550226] pci 0000:00:1a.0: [8086:8d2d] type 00 class 0x0c0320
[    2.550241] pci 0000:00:1a.0: reg 0x10: [mem 0x9ec03000-0x9ec033ff]
[    2.550328] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    2.550368] pci 0000:00:1c.0: [8086:8d10] type 01 class 0x060400
[    2.550443] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.550486] pci 0000:00:1c.7: [8086:8d1e] type 01 class 0x060400
[    2.550565] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    2.550610] pci 0000:00:1d.0: [8086:8d26] type 00 class 0x0c0320
[    2.550624] pci 0000:00:1d.0: reg 0x10: [mem 0x9ec02000-0x9ec023ff]
[    2.550711] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    2.550752] pci 0000:00:1f.0: [8086:8d44] type 00 class 0x060100
[    2.550894] pci 0000:00:1f.2: [8086:8d02] type 00 class 0x010601
[    2.550904] pci 0000:00:1f.2: reg 0x10: [io  0x3068-0x306f]
[    2.550910] pci 0000:00:1f.2: reg 0x14: [io  0x3084-0x3087]
[    2.550915] pci 0000:00:1f.2: reg 0x18: [io  0x3060-0x3067]
[    2.550920] pci 0000:00:1f.2: reg 0x1c: [io  0x3080-0x3083]
[    2.550925] pci 0000:00:1f.2: reg 0x20: [io  0x3020-0x303f]
[    2.550931] pci 0000:00:1f.2: reg 0x24: [mem 0x9ec00000-0x9ec007ff]
[    2.550974] pci 0000:00:1f.2: PME# supported from D3hot
[    2.551030] pci 0000:02:00.0: [1000:005f] type 00 class 0x010400
[    2.551036] pci 0000:02:00.0: reg 0x10: [io  0x2000-0x20ff]
[    2.551041] pci 0000:02:00.0: reg 0x14: [mem 0x9eb00000-0x9eb0ffff 64bit]
[    2.551047] pci 0000:02:00.0: reg 0x1c: [mem 0x9ea00000-0x9eafffff 64bit]
[    2.551054] pci 0000:02:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    2.551109] pci 0000:02:00.0: supports D1 D2
[    2.551126] pci 0000:00:01.0: PCI bridge to [bus 02]
[    2.551127] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    2.551129] pci 0000:00:01.0:   bridge window [mem 0x9ea00000-0x9ebfffff]
[    2.551153] pci 0000:03:00.0: [8086:1583] type 00 class 0x020000
[    2.551163] pci 0000:03:00.0: reg 0x10: [mem 0x91000000-0x91ffffff 64bit pref]
[    2.551174] pci 0000:03:00.0: reg 0x1c: [mem 0x92008000-0x9200ffff 64bit pref]
[    2.551182] pci 0000:03:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.551241] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    2.551272] pci 0000:03:00.1: [8086:1583] type 00 class 0x020000
[    2.551282] pci 0000:03:00.1: reg 0x10: [mem 0x90000000-0x90ffffff 64bit pref]
[    2.551293] pci 0000:03:00.1: reg 0x1c: [mem 0x92000000-0x92007fff 64bit pref]
[    2.551302] pci 0000:03:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.551358] pci 0000:03:00.1: PME# supported from D0 D3hot D3cold
[    2.551377] pci 0000:00:02.0: PCI bridge to [bus 03]
[    2.551381] pci 0000:00:02.0:   bridge window [mem 0x90000000-0x920fffff 64bit pref]
[    2.551397] pci 0000:00:02.2: PCI bridge to [bus 04]
[    2.551422] pci 0000:01:00.0: [8086:1572] type 00 class 0x020000
[    2.551431] pci 0000:01:00.0: reg 0x10: [mem 0x96000000-0x96ffffff 64bit pref]
[    2.551442] pci 0000:01:00.0: reg 0x1c: [mem 0x97018000-0x9701ffff 64bit pref]
[    2.551451] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.551508] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    2.551577] pci 0000:01:00.1: [8086:1572] type 00 class 0x020000
[    2.551587] pci 0000:01:00.1: reg 0x10: [mem 0x95000000-0x95ffffff 64bit pref]
[    2.551598] pci 0000:01:00.1: reg 0x1c: [mem 0x97010000-0x97017fff 64bit pref]
[    2.551607] pci 0000:01:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.551664] pci 0000:01:00.1: PME# supported from D0 D3hot D3cold
[    2.551721] pci 0000:01:00.2: [8086:1572] type 00 class 0x020000
[    2.551731] pci 0000:01:00.2: reg 0x10: [mem 0x94000000-0x94ffffff 64bit pref]
[    2.551742] pci 0000:01:00.2: reg 0x1c: [mem 0x97008000-0x9700ffff 64bit pref]
[    2.551751] pci 0000:01:00.2: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.551808] pci 0000:01:00.2: PME# supported from D0 D3hot D3cold
[    2.551862] pci 0000:01:00.3: [8086:1572] type 00 class 0x020000
[    2.551872] pci 0000:01:00.3: reg 0x10: [mem 0x93000000-0x93ffffff 64bit pref]
[    2.551883] pci 0000:01:00.3: reg 0x1c: [mem 0x97000000-0x97007fff 64bit pref]
[    2.551892] pci 0000:01:00.3: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.551949] pci 0000:01:00.3: PME# supported from D0 D3hot D3cold
[    2.551998] pci 0000:00:03.0: PCI bridge to [bus 01]
[    2.552002] pci 0000:00:03.0:   bridge window [mem 0x93000000-0x970fffff 64bit pref]
[    2.552025] pci 0000:05:00.0: [8086:1572] type 00 class 0x020000
[    2.552035] pci 0000:05:00.0: reg 0x10: [mem 0x9b000000-0x9bffffff 64bit pref]
[    2.552047] pci 0000:05:00.0: reg 0x1c: [mem 0x9c018000-0x9c01ffff 64bit pref]
[    2.552055] pci 0000:05:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.552115] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    2.552144] pci 0000:05:00.1: [8086:1572] type 00 class 0x020000
[    2.552154] pci 0000:05:00.1: reg 0x10: [mem 0x9a000000-0x9affffff 64bit pref]
[    2.552165] pci 0000:05:00.1: reg 0x1c: [mem 0x9c010000-0x9c017fff 64bit pref]
[    2.552174] pci 0000:05:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.552232] pci 0000:05:00.1: PME# supported from D0 D3hot D3cold
[    2.552259] pci 0000:05:00.2: [8086:1572] type 00 class 0x020000
[    2.552269] pci 0000:05:00.2: reg 0x10: [mem 0x99000000-0x99ffffff 64bit pref]
[    2.552280] pci 0000:05:00.2: reg 0x1c: [mem 0x9c008000-0x9c00ffff 64bit pref]
[    2.552289] pci 0000:05:00.2: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.552347] pci 0000:05:00.2: PME# supported from D0 D3hot D3cold
[    2.552373] pci 0000:05:00.3: [8086:1572] type 00 class 0x020000
[    2.552383] pci 0000:05:00.3: reg 0x10: [mem 0x98000000-0x98ffffff 64bit pref]
[    2.552394] pci 0000:05:00.3: reg 0x1c: [mem 0x9c000000-0x9c007fff 64bit pref]
[    2.552403] pci 0000:05:00.3: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.552461] pci 0000:05:00.3: PME# supported from D0 D3hot D3cold
[    2.552480] pci 0000:00:03.2: PCI bridge to [bus 05]
[    2.552483] pci 0000:00:03.2:   bridge window [mem 0x98000000-0x9c0fffff 64bit pref]
[    2.552509] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    2.552871] pci 0000:07:00.0: [1912:001d] type 01 class 0x060400
[    2.556285] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    2.556750] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    2.556753] pci 0000:00:1c.7:   bridge window [mem 0x9e000000-0x9e9fffff]
[    2.556757] pci 0000:00:1c.7:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.557967] pci 0000:08:00.0: [1912:001d] type 01 class 0x060400
[    2.561931] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    2.564346] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    2.564550] pci 0000:07:00.0:   bridge window [mem 0x9e000000-0x9e9fffff]
[    2.564683] pci 0000:07:00.0:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.565986] pci 0000:09:00.0: [1912:001a] type 01 class 0x060400
[    2.570471] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    2.570704] pci 0000:08:00.0:   bridge window [mem 0x9e000000-0x9e8fffff]
[    2.570860] pci 0000:08:00.0:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.572016] pci 0000:0a:00.0: [102b:0534] type 00 class 0x030000
[    2.572497] pci 0000:0a:00.0: reg 0x10: [mem 0x9d000000-0x9dffffff pref]
[    2.572778] pci 0000:0a:00.0: reg 0x14: [mem 0x9e800000-0x9e803fff]
[    2.573059] pci 0000:0a:00.0: reg 0x18: [mem 0x9e000000-0x9e7fffff]
[    2.577496] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    2.577736] pci 0000:09:00.0:   bridge window [mem 0x9e000000-0x9e8fffff]
[    2.577893] pci 0000:09:00.0:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.578733] pci_bus 0000:00: on NUMA node 0
[    2.578844] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.578874] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.578903] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.578931] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.578959] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.578987] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.579015] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.579043] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    2.579225] ACPI: Enabled 2 GPEs in block 00 to 3F
[    2.579360] SCSI subsystem initialized
[    2.579362] ACPI: bus type USB registered
[    2.579371] usbcore: registered new interface driver usbfs
[    2.579374] usbcore: registered new interface driver hub
[    2.579396] usbcore: registered new device driver usb
[    2.579404] pps_core: LinuxPPS API ver. 1 registered
[    2.579405] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.579406] PTP clock support registered
[    2.579410] EDAC MC: Ver: 3.0.0
[    2.579926] Registered efivars operations
[    2.585338] wmi: Mapper loaded
[    2.585342] PCI: Using ACPI for IRQ routing
[    2.592439] PCI: pci_cache_line_size set to 64 bytes
[    2.592814] e820: reserve RAM buffer [mem 0x67dca000-0x67ffffff]
[    2.592815] e820: reserve RAM buffer [mem 0x7a089000-0x7bffffff]
[    2.592816] e820: reserve RAM buffer [mem 0x7bae9000-0x7bffffff]
[    2.592817] e820: reserve RAM buffer [mem 0x7bb00000-0x7bffffff]
[    2.592953] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.592956] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    2.594976] clocksource: Switched to clocksource hpet
[    2.599986] pnp: PnP ACPI init
[    2.600214] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.600268] system 00:01: [io  0x0500-0x053f] has been reserved
[    2.600268] system 00:01: [io  0x0400-0x047f] has been reserved
[    2.600269] system 00:01: [io  0x0540-0x057f] has been reserved
[    2.600270] system 00:01: [io  0x0600-0x061f] has been reserved
[    2.600271] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    2.600271] system 00:01: [io  0x0880-0x0883] has been reserved
[    2.600272] system 00:01: [io  0x0800-0x081f] has been reserved
[    2.600273] system 00:01: [mem 0xfeda8000-0xfedcbfff] could not be reserved
[    2.600274] system 00:01: [mem 0xff000000-0xffffffff] could not be reserved
[    2.600275] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    2.600275] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    2.600276] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    2.600277] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    2.600278] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.600385] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.600479] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.600504] system 00:04: [io  0x0ca8] has been reserved
[    2.600504] system 00:04: [io  0x0cac] has been reserved
[    2.600506] system 00:04: Plug and Play ACPI device, IDs IPI0001 PNP0c01 (active)
[    2.600549] pnp: PnP ACPI: found 5 devices
[    2.605881] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.605884] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    2.605885] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605886] pci 0000:03:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605886] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605887] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605888] pci 0000:01:00.2: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605888] pci 0000:01:00.3: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605889] pci 0000:05:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605890] pci 0000:05:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605890] pci 0000:05:00.2: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605891] pci 0000:05:00.3: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    2.605892] pci 0000:00:11.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    2.606656] pci 0000:00:02.0: BAR 8: assigned [mem 0x92100000-0x921fffff]
[    2.606658] pci 0000:00:03.0: BAR 8: assigned [mem 0x92200000-0x923fffff]
[    2.606658] pci 0000:00:03.2: BAR 8: assigned [mem 0x92400000-0x925fffff]
[    2.606660] pci 0000:00:11.0: BAR 6: assigned [mem 0x92600000-0x9260ffff pref]
[    2.606661] pci 0000:02:00.0: BAR 6: no space for [mem size 0x00100000 pref]
[    2.606662] pci 0000:02:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    2.606663] pci 0000:00:01.0: PCI bridge to [bus 02]
[    2.606664] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    2.606666] pci 0000:00:01.0:   bridge window [mem 0x9ea00000-0x9ebfffff]
[    2.606669] pci 0000:03:00.0: BAR 6: assigned [mem 0x92100000-0x9217ffff pref]
[    2.606670] pci 0000:03:00.1: BAR 6: assigned [mem 0x92180000-0x921fffff pref]
[    2.606670] pci 0000:00:02.0: PCI bridge to [bus 03]
[    2.606672] pci 0000:00:02.0:   bridge window [mem 0x92100000-0x921fffff]
[    2.606673] pci 0000:00:02.0:   bridge window [mem 0x90000000-0x920fffff 64bit pref]
[    2.606676] pci 0000:00:02.2: PCI bridge to [bus 04]
[    2.606680] pci 0000:01:00.0: BAR 6: assigned [mem 0x92200000-0x9227ffff pref]
[    2.606681] pci 0000:01:00.1: BAR 6: assigned [mem 0x92280000-0x922fffff pref]
[    2.606681] pci 0000:01:00.2: BAR 6: assigned [mem 0x92300000-0x9237ffff pref]
[    2.606682] pci 0000:01:00.3: BAR 6: assigned [mem 0x92380000-0x923fffff pref]
[    2.606683] pci 0000:00:03.0: PCI bridge to [bus 01]
[    2.606685] pci 0000:00:03.0:   bridge window [mem 0x92200000-0x923fffff]
[    2.606686] pci 0000:00:03.0:   bridge window [mem 0x93000000-0x970fffff 64bit pref]
[    2.606688] pci 0000:05:00.0: BAR 6: assigned [mem 0x92400000-0x9247ffff pref]
[    2.606689] pci 0000:05:00.1: BAR 6: assigned [mem 0x92480000-0x924fffff pref]
[    2.606690] pci 0000:05:00.2: BAR 6: assigned [mem 0x92500000-0x9257ffff pref]
[    2.606691] pci 0000:05:00.3: BAR 6: assigned [mem 0x92580000-0x925fffff pref]
[    2.606691] pci 0000:00:03.2: PCI bridge to [bus 05]
[    2.606693] pci 0000:00:03.2:   bridge window [mem 0x92400000-0x925fffff]
[    2.606694] pci 0000:00:03.2:   bridge window [mem 0x98000000-0x9c0fffff 64bit pref]
[    2.606697] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    2.606704] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    2.606851] pci 0000:09:00.0:   bridge window [mem 0x9e000000-0x9e8fffff]
[    2.606950] pci 0000:09:00.0:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.607155] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    2.607306] pci 0000:08:00.0:   bridge window [mem 0x9e000000-0x9e8fffff]
[    2.607405] pci 0000:08:00.0:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.607609] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    2.607752] pci 0000:07:00.0:   bridge window [mem 0x9e000000-0x9e9fffff]
[    2.607834] pci 0000:07:00.0:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.608058] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    2.608061] pci 0000:00:1c.7:   bridge window [mem 0x9e000000-0x9e9fffff]
[    2.608063] pci 0000:00:1c.7:   bridge window [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.608067] pci_bus 0000:00: resource 4 [io  0x0000-0x03bb window]
[    2.608068] pci_bus 0000:00: resource 5 [io  0x03bc-0x03df window]
[    2.608069] pci_bus 0000:00: resource 6 [io  0x03e0-0x0cf7 window]
[    2.608069] pci_bus 0000:00: resource 7 [io  0x1000-0xffff window]
[    2.608070] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    2.608071] pci_bus 0000:00: resource 9 [mem 0x90000000-0xfbffbfff window]
[    2.608071] pci_bus 0000:00: resource 10 [mem 0x38000000000-0x3bfffffffff window]
[    2.608072] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    2.608073] pci_bus 0000:02: resource 1 [mem 0x9ea00000-0x9ebfffff]
[    2.608073] pci_bus 0000:03: resource 1 [mem 0x92100000-0x921fffff]
[    2.608074] pci_bus 0000:03: resource 2 [mem 0x90000000-0x920fffff 64bit pref]
[    2.608075] pci_bus 0000:01: resource 1 [mem 0x92200000-0x923fffff]
[    2.608076] pci_bus 0000:01: resource 2 [mem 0x93000000-0x970fffff 64bit pref]
[    2.608076] pci_bus 0000:05: resource 1 [mem 0x92400000-0x925fffff]
[    2.608077] pci_bus 0000:05: resource 2 [mem 0x98000000-0x9c0fffff 64bit pref]
[    2.608078] pci_bus 0000:07: resource 1 [mem 0x9e000000-0x9e9fffff]
[    2.608078] pci_bus 0000:07: resource 2 [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.608079] pci_bus 0000:08: resource 1 [mem 0x9e000000-0x9e9fffff]
[    2.608080] pci_bus 0000:08: resource 2 [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.608080] pci_bus 0000:09: resource 1 [mem 0x9e000000-0x9e8fffff]
[    2.608081] pci_bus 0000:09: resource 2 [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.608081] pci_bus 0000:0a: resource 1 [mem 0x9e000000-0x9e8fffff]
[    2.608082] pci_bus 0000:0a: resource 2 [mem 0x9d000000-0x9dffffff 64bit pref]
[    2.608140] NET: Registered protocol family 2
[    2.608209] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    2.608417] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.608512] TCP: Hash tables configured (established 262144 bind 65536)
[    2.608536] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    2.608587] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    2.608661] NET: Registered protocol family 1
[    2.608899] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    2.609247] pci 0000:0a:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    2.609332] PCI: CLS 32 bytes, default 64
[    2.609361] Unpacking initramfs...
[    2.648500] Freeing initrd memory: 3556K
[    2.648502] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.648503] software IO TLB [mem 0x60a99000-0x64a99000] (64MB) mapped at [ffff880060a99000-ffff880064a98fff]
[    2.648549] Intel CQM monitoring enabled
[    2.648724] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    2.648724] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    2.648725] RAPL PMU: hw unit of domain package 2^-14 Joules
[    2.648725] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    2.648725] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    2.650023] simple-framebuffer simple-framebuffer.0: framebuffer at 0x9d000000, 0x300000 bytes, mapped to 0xffffc90000800000
[    2.650024] simple-framebuffer simple-framebuffer.0: format=a8r8g8b8, mode=1024x768x32, linelength=4096
[    2.667627] Console: switching to colour frame buffer device 128x48
[    2.685245] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
[    2.685648] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    2.686663] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    2.686663] io scheduler noop registered
[    2.686678] io scheduler cfq registered (default)
[    2.689746] intel_idle: MWAIT substates: 0x2120
[    2.689746] intel_idle: v0.4.1 model 0x3F
[    2.690020] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.690024] ipmi message handler version 39.2
[    2.690025] ipmi device interface
[    2.690031] IPMI System Interface driver.
[    2.690042] ipmi_si: probing via SMBIOS
[    2.690043] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
[    2.690044] ipmi_si: Adding SMBIOS-specified kcs state machine
[    2.690045] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 10
[    3.615091] ipmi_si ipmi_si.0: The BMC does not support setting the recv irq bit, compensating, but the BMC needs to be fixed.
[    3.685073] tsc: Refined TSC clocksource calibration: 3199.997 MHz
[    3.685077] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e204719c91, max_idle_ns: 440795261699 ns
[    3.775127] ipmi_si ipmi_si.0: Using irq 10
[    3.824714] random: fast init done
[    3.824897] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
[    3.824952] ipmi_si ipmi_si.0: IPMI kcs interface initialized
[    3.825929] IPMI Watchdog: driver initialized
[    3.825929] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
[    3.828975] IPMI poweroff: ATCA Detect mfg 0x2A2 prod 0x100
[    3.828975] IPMI poweroff: Found a chassis style poweroff function
[    3.831500] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.831502] ACPI: Power Button [PWRF]
[    3.842720] ERST: Error Record Serialization Table (ERST) support is initialized.
[    3.842721] pstore: using zlib compression
[    3.842722] pstore: Registered erst as persistent store backend
[    3.842743] ghes_edac: This EDAC driver relies on BIOS to enumerate memory and get error reports.
[    3.842744] ghes_edac: Unfortunately, not all BIOSes reflect the memory layout correctly.
[    3.842744] ghes_edac: So, the end result of using this driver varies from vendor to vendor.
[    3.842744] ghes_edac: If you find incorrect reports, please contact your hardware vendor
[    3.842744] ghes_edac: to correct its BIOS.
[    3.842745] ghes_edac: This system has 24 DIMM sockets.
[    3.842784] EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
[    3.842809] EDAC MC1: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
[    3.842833] EDAC MC2: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
[    3.843023] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    3.843051] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    3.879860] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.900371] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.920910] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    3.921055] Non-volatile memory driver v1.3
[    3.921858] megasas: 07.701.17.00-rc1
[    3.922125] megaraid_sas 0000:02:00.0: FW now in Ready state
[    3.922246] megaraid_sas 0000:02:00.0: firmware supports msix        : (96)
[    3.922247] megaraid_sas 0000:02:00.0: current msix/online cpus      : (16/16)
[    3.922248] megaraid_sas 0000:02:00.0: RDPQ mode     : (disabled)
[    3.922249] megaraid_sas 0000:02:00.0: Current firmware maximum commands: 928         LDIO threshold: 237
[    3.924018] megaraid_sas 0000:02:00.0: FW supports sync cache        : No
[    4.275167] megaraid_sas 0000:02:00.0: Init cmd success
[    4.315198] megaraid_sas 0000:02:00.0: firmware type : Legacy(64 VD) firmware
[    4.315201] megaraid_sas 0000:02:00.0: controller type       : iMR(0MB)
[    4.315203] megaraid_sas 0000:02:00.0: Online Controller Reset(OCR)  : Enabled
[    4.315204] megaraid_sas 0000:02:00.0: Secure JBOD support   : No
[    4.355757] megaraid_sas 0000:02:00.0: INIT adapter done
[    4.355759] megaraid_sas 0000:02:00.0: Jbod map is not supported megasas_setup_jbod_map 5092
[    4.382456] megaraid_sas 0000:02:00.0: pci id                : (0x1000)/(0x005f)/(0x1028)/(0x1f4b)
[    4.382456] megaraid_sas 0000:02:00.0: unevenspan support    : yes
[    4.382457] megaraid_sas 0000:02:00.0: firmware crash dump   : no
[    4.382458] megaraid_sas 0000:02:00.0: jbod sync map         : no
[    4.382459] scsi host0: Avago SAS based MegaRAID driver
[    4.382922] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 2.1.7-k
[    4.382922] i40e: Copyright (c) 2013 - 2014 Intel Corporation.
[    4.394288] scsi 0:2:0:0: Direct-Access     DELL     PERC H330 Mini   4.27 PQ: 0 ANSI: 5
[    4.408765] sd 0:2:0:0: Attached scsi generic sg0 type 0
[    4.408865] sd 0:2:0:0: [sda] 584843264 512-byte logical blocks: (299 GB/279 GiB)
[    4.408998] sd 0:2:0:0: [sda] Write Protect is off
[    4.408999] sd 0:2:0:0: [sda] Mode Sense: 1f 00 10 08
[    4.409038] sd 0:2:0:0: [sda] Write cache: disabled, read cache: disabled, supports DPO and FUA
[    4.418867]  sda: sda1 sda2 sda3
[    4.419101] sd 0:2:0:0: [sda] Attached SCSI disk
[    4.423180] i40e 0000:01:00.0: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d37 18.0.17
[    4.681400] i40e 0000:01:00.0: MAC address: f8:bc:12:06:22:e8
[    4.725305] clocksource: Switched to clocksource tsc
[    4.827007] i40e 0000:01:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    4.857827] i40e 0000:01:00.0: Features: PF-id[0] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    4.897776] i40e 0000:01:00.1: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d37 18.0.17
[    5.168736] i40e 0000:01:00.1: MAC address: f8:bc:12:06:22:ea
[    5.315220] i40e 0000:01:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    5.346050] i40e 0000:01:00.1: Features: PF-id[1] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    5.386142] i40e 0000:01:00.2: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d37 18.0.17
[    5.644463] i40e 0000:01:00.2: MAC address: f8:bc:12:06:22:ec
[    5.723524] i40e 0000:01:00.2: PCI-Express: Speed 8.0GT/s Width x8
[    5.729661] i40e 0000:01:00.2: Features: PF-id[2] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    5.769734] i40e 0000:01:00.3: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d37 18.0.17
[    6.028514] i40e 0000:01:00.3: MAC address: f8:bc:12:06:22:ee
[    6.189199] i40e 0000:01:00.3: PCI-Express: Speed 8.0GT/s Width x8
[    6.240516] i40e 0000:01:00.3: Features: PF-id[3] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    6.280888] i40e 0000:03:00.0: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d3b 18.0.17
[    6.542716] i40e 0000:03:00.0: MAC address: 3c:fd:fe:16:42:28
[    6.623655] i40e 0000:03:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    6.629789] i40e 0000:03:00.0: Features: PF-id[0] VSIs: 66 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    6.670352] i40e 0000:03:00.1: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d3b 18.0.17
[    6.928925] i40e 0000:03:00.1: MAC address: 3c:fd:fe:16:42:2a
[    7.073285] i40e 0000:03:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    7.104043] i40e 0000:03:00.1: Features: PF-id[1] VSIs: 66 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    7.144324] i40e 0000:05:00.0: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d36 18.0.17
[    7.403734] i40e 0000:05:00.0: MAC address: 3c:fd:fe:01:2c:60
[    7.552493] i40e 0000:05:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    7.583267] i40e 0000:05:00.0: Features: PF-id[0] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    7.623575] i40e 0000:05:00.1: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d36 18.0.17
[    7.882686] i40e 0000:05:00.1: MAC address: 3c:fd:fe:01:2c:62
[    8.028313] i40e 0000:05:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    8.059062] i40e 0000:05:00.1: Features: PF-id[1] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    8.099194] i40e 0000:05:00.2: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d36 18.0.17
[    8.358181] i40e 0000:05:00.2: MAC address: 3c:fd:fe:01:2c:64
[    8.505245] i40e 0000:05:00.2: PCI-Express: Speed 8.0GT/s Width x8
[    8.511431] i40e 0000:05:00.2: Features: PF-id[2] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    8.551856] i40e 0000:05:00.3: fw 5.40.47690 api 1.5 nvm 5.40 0x80002d36 18.0.17
[    8.811700] i40e 0000:05:00.3: MAC address: 3c:fd:fe:01:2c:66
[    9.028059] i40e 0000:05:00.3: PCI-Express: Speed 8.0GT/s Width x8
[    9.058902] i40e 0000:05:00.3: Features: PF-id[3] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    9.058923] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.058923] ehci-pci: EHCI PCI platform driver
[    9.059033] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    9.059036] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    9.059045] ehci-pci 0000:00:1a.0: debug port 2
[    9.062949] ehci-pci 0000:00:1a.0: cache line size of 32 is not supported
[    9.062956] ehci-pci 0000:00:1a.0: irq 18, io mem 0x9ec03000
[    9.085579] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    9.085856] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    9.085857] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.085858] usb usb1: Product: EHCI Host Controller
[    9.085858] usb usb1: Manufacturer: Linux 4.11.0-rc6+ ehci_hcd
[    9.085859] usb usb1: SerialNumber: 0000:00:1a.0
[    9.085949] hub 1-0:1.0: USB hub found
[    9.085978] hub 1-0:1.0: 2 ports detected
[    9.086217] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    9.086220] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    9.086228] ehci-pci 0000:00:1d.0: debug port 2
[    9.090111] ehci-pci 0000:00:1d.0: cache line size of 32 is not supported
[    9.090113] ehci-pci 0000:00:1d.0: irq 18, io mem 0x9ec02000
[    9.115583] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    9.115770] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    9.115771] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.115772] usb usb2: Product: EHCI Host Controller
[    9.115772] usb usb2: Manufacturer: Linux 4.11.0-rc6+ ehci_hcd
[    9.115773] usb usb2: SerialNumber: 0000:00:1d.0
[    9.115852] hub 2-0:1.0: USB hub found
[    9.115878] hub 2-0:1.0: 2 ports detected
[    9.116079] rtc_cmos 00:00: RTC can wake from S4
[    9.116196] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    9.116220] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    9.116602] device-mapper: uevent: version 1.0.3
[    9.116635] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel at redhat.com
[    9.116640] intel_pstate: Intel P-state driver initializing
[    9.117911] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    9.117914] EFI Variables Facility v0.08 2004-May-17
[    9.128391] hidraw: raw HID events driver (C) Jiri Kosina
[    9.128429] usbcore: registered new interface driver usbhid
[    9.128430] usbhid: USB HID core driver
[    9.128501] Netfilter messages via NETLINK v0.30.
[    9.128509] nf_tables: (c) 2007-2009 Patrick McHardy <kaber@trash.net>
[    9.128745] NET: Registered protocol family 10
[    9.129372] Segment Routing with IPv6
[    9.129392] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    9.129540] NET: Registered protocol family 17
[    9.129544] 8021q: 802.1Q VLAN Support v1.8
[    9.131250] microcode: sig=0x306f2, pf=0x1, revision=0x3a
[    9.131472] microcode: Microcode Update Driver: v2.2.
[    9.131477] AVX2 version of gcm_enc/dec engaged.
[    9.131478] AES CTR mode by8 optimization enabled
[    9.134674] rtc_cmos 00:00: setting system clock to 2017-10-03 03:30:10 UTC (1507001410)
[    9.135787] Freeing unused kernel memory: 1068K
[    9.135788] Write protecting the kernel read-only data: 8192k
[    9.136049] Freeing unused kernel memory: 444K
[    9.137687] Freeing unused kernel memory: 468K
[    9.137982] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    9.420759] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    9.465615] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    9.485581] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    9.676102] usb 1-1: New USB device found, idVendor=8087, idProduct=800a
[    9.676105] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    9.676346] hub 1-1:1.0: USB hub found
[    9.676441] hub 1-1:1.0: 6 ports detected
[    9.686112] usb 2-1: New USB device found, idVendor=8087, idProduct=8002
[    9.686115] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    9.686392] hub 2-1:1.0: USB hub found
[    9.686453] hub 2-1:1.0: 8 ports detected
[   10.015660] usb 1-1.6: new high-speed USB device number 3 using ehci-pci
[   10.166844] usb 1-1.6: New USB device found, idVendor=413c, idProduct=a001
[   10.166847] usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   10.166848] usb 1-1.6: Product: Gadget USB HUB
[   10.166850] usb 1-1.6: Manufacturer: no manufacturer
[   10.166851] usb 1-1.6: SerialNumber: 0123456789
[   10.167113] hub 1-1.6:1.0: USB hub found
[   10.167215] hub 1-1.6:1.0: 6 ports detected
[   10.745720] usb 1-1.6.1: new high-speed USB device number 4 using ehci-pci
[   10.916677] usb 1-1.6.1: New USB device found, idVendor=0624, idProduct=0249
[   10.916682] usb 1-1.6.1: New USB device strings: Mfr=4, Product=5, SerialNumber=6
[   10.916684] usb 1-1.6.1: Product: Keyboard/Mouse Function
[   10.916687] usb 1-1.6.1: Manufacturer: Avocent
[   10.916689] usb 1-1.6.1: SerialNumber: 20121018
[   10.917984] input: Avocent Keyboard/Mouse Function as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6.1/1-1.6.1:1.0/0003:0624:0249.0001/input/input1
[   10.995762] hid-generic 0003:0624:0249.0001: input,hidraw0: USB HID v1.00 Keyboard [Avocent Keyboard/Mouse Function] on usb-0000:00:1a.0-1.6.1/input0
[   10.996626] input: Avocent Keyboard/Mouse Function as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6.1/1-1.6.1:1.1/0003:0624:0249.0002/input/input2
[   10.996650] hid-generic 0003:0624:0249.0002: input,hidraw1: USB HID v1.00 Mouse [Avocent Keyboard/Mouse Function] on usb-0000:00:1a.0-1.6.1/input1
[   10.997336] input: Avocent Keyboard/Mouse Function as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6.1/1-1.6.1:1.2/0003:0624:0249.0003/input/input3
[   10.997358] hid-generic 0003:0624:0249.0003: input,hidraw2: USB HID v1.00 Mouse [Avocent Keyboard/Mouse Function] on usb-0000:00:1a.0-1.6.1/input2
[   11.037045] i40e 0000:05:00.3 rename12: renamed from eth9
[   11.205952] i40e 0000:03:00.1 eth9: renamed from eth5
[   11.305996] i40e 0000:05:00.2 rename11: renamed from eth8
[   11.425994] i40e 0000:03:00.0 eth8: renamed from eth4
[   11.452693] Adding 1998844k swap on /dev/mapper/vgsys-swap.  Priority:-1 extents:1 across:1998844k
[   11.525926] i40e 0000:05:00.1 eth5: renamed from eth7
[   11.566157] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   11.614517] FAT-fs (sda1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[   11.655936] i40e 0000:05:00.0 eth4: renamed from eth6
[   11.755870] i40e 0000:05:00.3 eth7: renamed from rename12
[   11.885949] i40e 0000:05:00.2 eth6: renamed from rename11
[   13.493009] team0: Mode changed to "loadbalance"
[   13.506673] i40e 0000:03:00.1 eth9: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
[   13.506732] 8021q: adding VLAN 0 to HW filter on device eth9
[   13.506791] team0: Port device eth9 added
[   13.515749] i40e 0000:01:00.3 eth3: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
[   13.515800] 8021q: adding VLAN 0 to HW filter on device eth3
[   13.515855] team0: Port device eth3 added
[   13.521462] i40e 0000:05:00.3 eth7: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
[   13.521514] 8021q: adding VLAN 0 to HW filter on device eth7
[   13.521571] team0: Port device eth7 added
[   13.528402] 8021q: adding VLAN 0 to HW filter on device team0
[   13.556248] i40e 0000:03:00.1 eth9: set new mac address 7a:8b:08:1e:ab:e1
[   13.562199] i40e 0000:03:00.1 eth9: returning to hw mac address 3c:fd:fe:16:42:2a
[   13.566976] i40e 0000:01:00.3 eth3: set new mac address 3c:fd:fe:16:42:2a
[   13.573592] i40e 0000:05:00.3 eth7: set new mac address 3c:fd:fe:16:42:2a
[   15.181316] random: crng init done
[   16.607265] team1: Mode changed to "loadbalance"
[   16.609656] IPv6: ADDRCONF(NETDEV_UP): team1: link is not ready
[   16.619244] i40e 0000:01:00.0 eth0: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
[   16.619296] 8021q: adding VLAN 0 to HW filter on device eth0
[   16.619348] team1: Port device eth0 added
[   16.627282] i40e 0000:01:00.1 eth1: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
[   16.627329] 8021q: adding VLAN 0 to HW filter on device eth1
[   16.627383] team1: Port device eth1 added
[   16.632709] i40e 0000:05:00.0 eth4: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
[   16.632753] 8021q: adding VLAN 0 to HW filter on device eth4
[   16.632803] team1: Port device eth4 added
[   16.638122] i40e 0000:05:00.1 eth5: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
[   16.638164] 8021q: adding VLAN 0 to HW filter on device eth5
[   16.638215] team1: Port device eth5 added
[   16.644922] IPv6: ADDRCONF(NETDEV_UP): team1: link is not ready
[   16.644923] 8021q: adding VLAN 0 to HW filter on device team1
[   16.671037] i40e 0000:01:00.0 eth0: set new mac address 46:29:ca:75:63:63
[   16.674911] i40e 0000:01:00.0 eth0: returning to hw mac address f8:bc:12:06:22:e8
[   16.680868] IPv6: ADDRCONF(NETDEV_CHANGE): team1: link becomes ready
[   16.681244] i40e 0000:01:00.1 eth1: set new mac address f8:bc:12:06:22:e8
[   16.686870] i40e 0000:05:00.0 eth4: set new mac address f8:bc:12:06:22:e8
[   16.690009] i40e 0000:05:00.1 eth5: set new mac address f8:bc:12:06:22:e8


Kernel .config:
#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 4.11.0-rc6 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_KTHREAD_PRIO=0
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_INITRAMFS_COMPRESSION=".gz"
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_POSIX_TIMERS=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
CONFIG_MEMBARRIER=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_INTEL_RDT_A is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_HYPERVISOR_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_P6_NOP=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=16
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
CONFIG_LEGACY_VSYSCALL_NONE=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
# CONFIG_ACPI_APEI_EINJ is not set
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_EXTLOG=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=m
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_HT_IRQ is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT is not set

#
# PCI host controller drivers
#
# CONFIG_VMD is not set
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_IP_MROUTE is not set
CONFIG_SYN_COOKIES=y
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_BEET is not set
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_NETLINK=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
CONFIG_NETFILTER_NETLINK_LOG=y
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NF_TABLES=y
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
CONFIG_NFT_EXTHDR=m
CONFIG_NFT_META=y
CONFIG_NFT_RT=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_SET_RBTREE=y
CONFIG_NFT_SET_HASH=y
CONFIG_NFT_SET_BITMAP=m
CONFIG_NFT_COUNTER=y
CONFIG_NFT_LOG=y
CONFIG_NFT_LIMIT=y
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=y
CONFIG_NFT_HASH=y
CONFIG_NFT_FIB=m
# CONFIG_NETFILTER_XTABLES is not set
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV4 is not set
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_CHAIN_ROUTE_IPV4 is not set
CONFIG_NFT_REJECT_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
CONFIG_NFT_FIB_IPV4=m
# CONFIG_NF_TABLES_ARP is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=y
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV6 is not set
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_CHAIN_ROUTE_IPV6 is not set
CONFIG_NFT_REJECT_IPV6=y
# CONFIG_NFT_DUP_IPV6 is not set
CONFIG_NFT_FIB_IPV6=m
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=y
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=m
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#

#
# Altera FPGA firmware download module
#
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
# CONFIG_MEGARAID_MAILBOX is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=y
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
# CONFIG_DM_CRYPT is not set
CONFIG_DM_SNAPSHOT=m
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_NET_TEAM=y
# CONFIG_NET_TEAM_MODE_BROADCAST is not set
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=y
# CONFIG_MACVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_CADENCE is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
# CONFIG_NET_VENDOR_I825XX is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_SERIO_I8042 is not set
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
# CONFIG_SERIAL_8250_PNP is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
# CONFIG_I2C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_VGASTATE is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_MON=m
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_UCSI is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GADGET is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
CONFIG_EDAC_GHES=y
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#

#
# SPI RTC drivers
#

#
# SPI and I2C RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_ACPI=y
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_DCA=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACERHDF is not set
# CONFIG_DELL_WMI is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_MXM_WMI is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_MLX_CPLD_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
# CONFIG_INTEL_IOMMU is not set
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
# CONFIG_SOC_ZTE is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set

#
# FPGA Configuration Support
#
# CONFIG_FPGA is not set

#
# FSI support
#
# CONFIG_FSI is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
CONFIG_UEFI_CPER=y
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=m
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
# CONFIG_FRAME_POINTER is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_UPROBE_EVENTS is not set
# CONFIG_PROBE_EVENTS is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_ENUM_MAP_FILE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_EFI is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SHA1_MB is not set
# CONFIG_CRYPTO_SHA256_MB is not set
# CONFIG_CRYPTO_SHA512_MB is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_JITTERENTROPY is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set

#
# Certificates for signature checking
#
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_SBITMAP=y


Output from free when running on Linux 4.11.12 without memory leak:
             total       used       free     shared    buffers     cached
Mem:      32674752    4581968   28092784     582196     351340    1946112
-/+ buffers/cache:    2284516   30390236
Swap:      1998844          0    1998844


/proc files from Linux 4.12.0 after running close to OOM:
meminfo:
MemTotal:       32674744 kB
MemFree:          269248 kB
MemAvailable:          0 kB
Buffers:            2188 kB
Cached:            36964 kB
SwapCached:        84596 kB
Active:           107128 kB
Inactive:         125872 kB
Active(anon):      98084 kB
Inactive(anon):   100020 kB
Active(file):       9044 kB
Inactive(file):    25852 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       1998844 kB
SwapFree:        1108336 kB
Dirty:              4192 kB
Writeback:           660 kB
AnonPages:        193928 kB
Mapped:            10288 kB
Shmem:              3724 kB
Slab:             255640 kB
SReclaimable:      28160 kB
SUnreclaim:       227480 kB
KernelStack:        3408 kB
PageTables:         4456 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    18336216 kB
Committed_AS:    1049008 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HardwareCorrupted:     0 kB
AnonHugePages:     32768 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
DirectMap4k:       45772 kB
DirectMap2M:     3919872 kB
DirectMap1G:    31457280 kB

vmstat:
nr_free_pages 73696
nr_zone_inactive_anon 24625
nr_zone_active_anon 24491
nr_zone_inactive_file 1425
nr_zone_active_file 1485
nr_zone_unevictable 0
nr_zone_write_pending 1874
nr_mlock 0
nr_slab_reclaimable 7008
nr_slab_unreclaimable 56870
nr_page_table_pages 1108
nr_kernel_stack 3392
nr_bounce 0
nr_free_cma 0
nr_inactive_anon 24607
nr_active_anon 24459
nr_inactive_file 1305
nr_active_file 1385
nr_unevictable 0
nr_isolated_anon 0
nr_isolated_file 0
workingset_refault 289912
workingset_activate 58516
workingset_nodereclaim 10037
nr_anon_pages 47350
nr_mapped 2033
nr_file_pages 25174
nr_dirty 0
nr_writeback 2037
nr_writeback_temp 0
nr_shmem 931
nr_shmem_hugepages 0
nr_shmem_pmdmapped 0
nr_anon_transparent_hugepages 16
nr_unstable 0
nr_vmscan_write 373426
nr_vmscan_immediate_reclaim 37113
nr_dirtied 243233
nr_written 607545
nr_dirty_threshold 538
nr_dirty_background_threshold 268
pgpgin 4259389
pgpgout 2534029
pswpin 277335
pswpout 373208
pgalloc_dma32 2527306
pgalloc_normal 50721385
pgalloc_movable 0
allocstall_dma32 0
allocstall_normal 75
allocstall_movable 1521
pgskip_dma32 0
pgskip_normal 0
pgskip_movable 0
pgfree 53323595
pgactivate 1011437
pgdeactivate 2748654
pglazyfree 0
pgfault 40825976
pgmajfault 284428
pglazyfreed 0
pgrefill 1500059
pgsteal_kswapd 1210729
pgsteal_direct 94076
pgscan_kswapd 1991305
pgscan_direct 212403
pgscan_direct_throttle 0
pginodesteal 0
slabs_scanned 225136
kswapd_inodesteal 11858
kswapd_low_wmark_hit_quickly 544
kswapd_high_wmark_hit_quickly 1799
pageoutrun 2552
pgrotated 413431
drop_pagecache 0
drop_slab 0
pgmigrate_success 33
pgmigrate_fail 0
compact_migrate_scanned 212
compact_free_scanned 130165
compact_isolated 68
compact_stall 2
compact_fail 0
compact_success 2
compact_daemon_wake 0
compact_daemon_migrate_scanned 0
compact_daemon_free_scanned 0
unevictable_pgs_culled 2012
unevictable_pgs_scanned 0
unevictable_pgs_rescued 1246
unevictable_pgs_mlocked 2106
unevictable_pgs_munlocked 2106
unevictable_pgs_cleared 0
unevictable_pgs_stranded 0
thp_fault_alloc 45
thp_fault_fallback 0
thp_collapse_alloc 1765
thp_collapse_alloc_failed 2
thp_file_alloc 0
thp_file_mapped 0
thp_split_page 407
thp_split_page_failed 0
thp_deferred_split_page 483
thp_split_pmd 407
thp_split_pud 0
thp_zero_page_alloc 0
thp_zero_page_alloc_failed 0

zoneinfo:
Node 0, zone    DMA32
  per-node stats
      nr_inactive_anon 24607
      nr_active_anon 24550
      nr_inactive_file 1123
      nr_active_file 1658
      nr_unevictable 0
      nr_isolated_anon 0
      nr_isolated_file 0
      workingset_refault 289912
      workingset_activate 58516
      workingset_nodereclaim 10037
      nr_anon_pages 47441
      nr_mapped    2033
      nr_file_pages 25174
      nr_dirty     0
      nr_writeback 2037
      nr_writeback_temp 0
      nr_shmem     931
      nr_shmem_hugepages 0
      nr_shmem_pmdmapped 0
      nr_anon_transparent_hugepages 16
      nr_unstable  0
      nr_vmscan_write 373426
      nr_vmscan_immediate_reclaim 37113
      nr_dirtied   243233
      nr_written   607545
  pages free     32875
        min      1798
        low      2247
        high     2696
        spanned  1048575
        present  467026
        managed  448415
        protection: (0, 30157, 30157)
      nr_free_pages 32875
      nr_zone_inactive_anon 63
      nr_zone_active_anon 312
      nr_zone_inactive_file 111
      nr_zone_active_file 68
      nr_zone_unevictable 0
      nr_zone_write_pending 120
      nr_mlock     0
      nr_slab_reclaimable 287
      nr_slab_unreclaimable 1266
      nr_page_table_pages 8
      nr_kernel_stack 160
      nr_bounce    0
      nr_free_cma  0
  pagesets
    cpu: 0
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 1
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 2
              count: 30
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 3
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 4
              count: 1
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 5
              count: 165
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 6
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 7
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 8
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 9
              count: 61
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 10
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 11
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 12
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 13
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 14
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
    cpu: 15
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 50
  node_unreclaimable:  0
  start_pfn:           1
  node_inactive_ratio: 0
Node 0, zone   Normal
  pages free     40666
        min      30969
        low      38711
        high     46453
        spanned  7864320
        present  7864320
        managed  7720271
        protection: (0, 0, 0)
      nr_free_pages 40666
      nr_zone_inactive_anon 24562
      nr_zone_active_anon 24270
      nr_zone_inactive_file 1041
      nr_zone_active_file 1690
      nr_zone_unevictable 0
      nr_zone_write_pending 1754
      nr_mlock     0
      nr_slab_reclaimable 6721
      nr_slab_unreclaimable 55604
      nr_page_table_pages 1100
      nr_kernel_stack 3232
      nr_bounce    0
      nr_free_cma  0
  pagesets
    cpu: 0
              count: 21
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 1
              count: 27
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 2
              count: 98
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 3
              count: 126
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 4
              count: 103
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 5
              count: 184
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 6
              count: 22
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 7
              count: 113
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 8
              count: 0
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 9
              count: 91
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 10
              count: 31
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 11
              count: 68
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 12
              count: 107
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 13
              count: 23
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 14
              count: 29
              high:  186
              batch: 31
  vm stats threshold: 90
    cpu: 15
              count: 46
              high:  186
              batch: 31
  vm stats threshold: 90
  node_unreclaimable:  0
  start_pfn:           1048576
  node_inactive_ratio: 0
Node 0, zone  Movable
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0)

vmallocinfo:
0xffffc90000000000-0xffffc90000002000    8192 hpet_enable+0x2d/0x2b5 phys=0x00000000fed00000 ioremap
0xffffc90000002000-0xffffc90000004000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007b951000 ioremap
0xffffc90000004000-0xffffc90000008000   16384 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007b952000 ioremap
0xffffc90000008000-0xffffc9000000d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000000d000-0xffffc9000000f000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007bafe000 ioremap
0xffffc90000010000-0xffffc90000015000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000015000-0xffffc90000017000    8192 dmar_parse_one_drhd+0x1f8/0x4b0 phys=0x00000000fbffc000 ioremap
0xffffc90000018000-0xffffc9000001d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000001d000-0xffffc9000001f000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc90000020000-0xffffc90000032000   73728 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007ba98000 ioremap
0xffffc90000032000-0xffffc90000034000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007a93b000 ioremap
0xffffc90000034000-0xffffc90000039000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000039000-0xffffc9000003b000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007a937000 ioremap
0xffffc90000041000-0xffffc90000043000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007b8f3000 ioremap
0xffffc90000044000-0xffffc90000049000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000049000-0xffffc9000004b000    8192 dm_table_create+0x95/0x120 pages=1 vmalloc
0xffffc9000004c000-0xffffc90000051000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000051000-0xffffc90000053000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc90000054000-0xffffc90000059000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000059000-0xffffc9000005b000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007b950000 ioremap
0xffffc9000005c000-0xffffc90000061000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000061000-0xffffc90000063000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007b8f4000 ioremap
0xffffc90000064000-0xffffc90000069000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000069000-0xffffc9000006b000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007bab2000 ioremap
0xffffc9000006c000-0xffffc90000071000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000071000-0xffffc90000073000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007bab5000 ioremap
0xffffc90000074000-0xffffc90000079000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc90000079000-0xffffc9000007b000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007bab4000 ioremap
0xffffc9000007c000-0xffffc90000081000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc90000081000-0xffffc90000083000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007bab3000 ioremap
0xffffc90000084000-0xffffc90000089000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc90000089000-0xffffc9000008b000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007bab1000 ioremap
0xffffc9000008c000-0xffffc90000091000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc90000091000-0xffffc90000093000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baae000 ioremap
0xffffc90000094000-0xffffc90000099000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc90000099000-0xffffc9000009b000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baad000 ioremap
0xffffc9000009c000-0xffffc900000a1000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000a1000-0xffffc900000a3000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baac000 ioremap
0xffffc900000a4000-0xffffc900000a9000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000a9000-0xffffc900000ab000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baf6000 ioremap
0xffffc900000ac000-0xffffc900000b1000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000b1000-0xffffc900000b3000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baf5000 ioremap
0xffffc900000b4000-0xffffc900000b9000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000b9000-0xffffc900000bb000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baf4000 ioremap
0xffffc900000bc000-0xffffc900000c1000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000c1000-0xffffc900000c3000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baf3000 ioremap
0xffffc900000c4000-0xffffc900000c9000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000c9000-0xffffc900000cb000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x00000000fed1f000 ioremap
0xffffc900000cc000-0xffffc900000d1000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000d1000-0xffffc900000d3000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007b632000 ioremap
0xffffc900000d4000-0xffffc900000d9000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000d9000-0xffffc900000db000    8192 dmi_init+0x68/0x113 phys=0x000000007af09000 ioremap
0xffffc900000dc000-0xffffc900000e1000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000e1000-0xffffc900000e3000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000003bffff22000 ioremap
0xffffc900000e4000-0xffffc900000e9000   20480 fork_idle+0x27/0xb0 pages=4 vmalloc
0xffffc900000e9000-0xffffc900000eb000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc900000ec000-0xffffc900000f1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900000f1000-0xffffc900000f3000    8192 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007a938000 ioremap
0xffffc900000f4000-0xffffc900000f9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900000f9000-0xffffc900000fb000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc900000fc000-0xffffc90000101000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000101000-0xffffc90000103000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff1e000 ioremap
0xffffc90000104000-0xffffc90000109000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000109000-0xffffc9000010b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff1a000 ioremap
0xffffc9000010c000-0xffffc90000111000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000111000-0xffffc90000113000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff16000 ioremap
0xffffc90000114000-0xffffc90000119000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000119000-0xffffc9000011b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff12000 ioremap
0xffffc9000011c000-0xffffc90000121000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000121000-0xffffc90000123000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff0e000 ioremap
0xffffc90000124000-0xffffc90000129000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000129000-0xffffc9000012b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff0a000 ioremap
0xffffc9000012c000-0xffffc90000131000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000131000-0xffffc90000133000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff06000 ioremap
0xffffc90000134000-0xffffc90000139000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000139000-0xffffc9000013b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000003bffff02000 ioremap
0xffffc9000013c000-0xffffc90000141000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000141000-0xffffc90000143000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc90000144000-0xffffc90000149000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000149000-0xffffc9000014b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000000009eb0e000 ioremap
0xffffc9000014c000-0xffffc90000151000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000151000-0xffffc90000154000   12288 pcpu_get_pages+0x2d/0x40 pages=2 vmalloc
0xffffc90000154000-0xffffc90000159000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000159000-0xffffc9000015b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x0000000097018000 ioremap
0xffffc9000015c000-0xffffc90000161000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000161000-0xffffc90000163000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x0000000097010000 ioremap
0xffffc90000164000-0xffffc90000169000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000169000-0xffffc9000016b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x0000000097008000 ioremap
0xffffc9000016c000-0xffffc90000171000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000171000-0xffffc90000173000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x0000000097000000 ioremap
0xffffc90000174000-0xffffc90000179000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000179000-0xffffc9000017b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x0000000092008000 ioremap
0xffffc9000017c000-0xffffc90000181000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000181000-0xffffc90000183000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x0000000092000000 ioremap
0xffffc90000184000-0xffffc90000189000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000189000-0xffffc9000018b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000000009c018000 ioremap
0xffffc9000018c000-0xffffc90000191000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000191000-0xffffc90000193000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000000009c010000 ioremap
0xffffc90000194000-0xffffc90000199000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000199000-0xffffc9000019b000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000000009c008000 ioremap
0xffffc9000019c000-0xffffc900001a1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001a1000-0xffffc900001a3000    8192 __pci_enable_msix+0x2e0/0x470 phys=0x000000009c000000 ioremap
0xffffc900001a4000-0xffffc900001a9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001a9000-0xffffc900001ab000    8192 usb_hcd_pci_probe+0x129/0x440 phys=0x000000009ec03000 ioremap
0xffffc900001ac000-0xffffc900001b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001b1000-0xffffc900001b3000    8192 usb_hcd_pci_probe+0x129/0x440 phys=0x000000009ec02000 ioremap
0xffffc900001b4000-0xffffc900001b9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001b9000-0xffffc900001bb000    8192 intel_pstate_init+0x2c7/0x3df pages=1 vmalloc
0xffffc900001bc000-0xffffc900001c1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001c1000-0xffffc900001c3000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc900001c4000-0xffffc900001c9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001c9000-0xffffc900001cb000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc900001cc000-0xffffc900001d1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001d1000-0xffffc900001d3000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc900001d4000-0xffffc900001d9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001dc000-0xffffc900001e1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001e1000-0xffffc900001e3000    8192 bpf_prog_alloc+0x39/0xb0 pages=1 vmalloc
0xffffc900001e4000-0xffffc900001e9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001ec000-0xffffc900001f1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001f4000-0xffffc900001f9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900001fa000-0xffffc900001fd000   12288 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baaf000 ioremap
0xffffc90000200000-0xffffc90000344000 1327104 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007b955000 ioremap
0xffffc90000344000-0xffffc90000349000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000354000-0xffffc90000359000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000359000-0xffffc9000035c000   12288 tnode_new+0x45/0xb0 pages=2 vmalloc
0xffffc9000035c000-0xffffc90000361000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000364000-0xffffc90000369000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000036c000-0xffffc90000371000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000374000-0xffffc90000379000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000037c000-0xffffc90000381000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000384000-0xffffc90000389000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000038c000-0xffffc90000391000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000394000-0xffffc90000399000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900003c4000-0xffffc900003c9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900003cc000-0xffffc900003d1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900003d4000-0xffffc900003d9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900003dc000-0xffffc900003e1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900003ec000-0xffffc900003f1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900003f4000-0xffffc900003f9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900003fc000-0xffffc90000401000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000404000-0xffffc90000409000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000040c000-0xffffc90000411000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000041c000-0xffffc90000421000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000424000-0xffffc90000429000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000042c000-0xffffc90000431000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000434000-0xffffc90000439000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000043c000-0xffffc90000441000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000044c000-0xffffc90000451000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000454000-0xffffc90000459000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000045c000-0xffffc90000461000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000464000-0xffffc90000469000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000046c000-0xffffc90000471000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000047c000-0xffffc90000481000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000484000-0xffffc90000489000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000048c000-0xffffc90000491000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000494000-0xffffc90000499000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000049c000-0xffffc900004a1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004ac000-0xffffc900004b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004b4000-0xffffc900004b9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004bc000-0xffffc900004c1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004c4000-0xffffc900004c9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004cc000-0xffffc900004d1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004dc000-0xffffc900004e1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004e4000-0xffffc900004e9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900004f4000-0xffffc900004f9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000050c000-0xffffc90000511000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000514000-0xffffc90000519000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000051c000-0xffffc90000521000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000524000-0xffffc90000529000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000052c000-0xffffc90000531000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000053c000-0xffffc90000541000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000544000-0xffffc90000549000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000054c000-0xffffc90000551000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000554000-0xffffc90000559000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000055c000-0xffffc90000561000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000056c000-0xffffc90000571000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000574000-0xffffc90000579000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000057c000-0xffffc90000581000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000584000-0xffffc90000589000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000058c000-0xffffc90000591000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000594000-0xffffc90000599000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000059c000-0xffffc900005a1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005a4000-0xffffc900005a9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005ac000-0xffffc900005b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005b4000-0xffffc900005b9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005bc000-0xffffc900005c1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005c4000-0xffffc900005c9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005cc000-0xffffc900005d0000   16384 acpi_os_map_iomem+0x14b/0x180 phys=0x000000007baa9000 ioremap
0xffffc900005d8000-0xffffc900005dd000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005e0000-0xffffc900005e5000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005f0000-0xffffc900005f5000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900005f8000-0xffffc900005fd000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000608000-0xffffc9000060d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000610000-0xffffc90000615000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000630000-0xffffc90000635000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000638000-0xffffc9000063d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000660000-0xffffc90000665000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000668000-0xffffc9000066d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000670000-0xffffc90000674000   16384 erst_init+0x1df/0x2ff phys=0x000000007a93b000 ioremap
0xffffc90000674000-0xffffc90000677000   12288 ghes_init+0x90/0x195 ioremap
0xffffc90000678000-0xffffc9000067d000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff1c000 ioremap
0xffffc90000680000-0xffffc90000685000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff18000 ioremap
0xffffc90000688000-0xffffc9000068d000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff14000 ioremap
0xffffc90000690000-0xffffc90000695000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff10000 ioremap
0xffffc90000698000-0xffffc9000069d000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff0c000 ioremap
0xffffc900006a0000-0xffffc900006a5000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff08000 ioremap
0xffffc900006a8000-0xffffc900006ad000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff04000 ioremap
0xffffc900006b0000-0xffffc900006b5000   20480 pcim_iomap+0x3a/0x50 phys=0x000003bffff00000 ioremap
0xffffc900006b8000-0xffffc900006bd000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900006c0000-0xffffc900006c5000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900006c6000-0xffffc900006c9000   12288 megasas_probe_one+0x6d6/0x1d00 phys=0x000000009eb00000 ioremap
0xffffc900006e4000-0xffffc900006e9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900006f4000-0xffffc900006f9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000071c000-0xffffc90000721000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000749000-0xffffc9000074d000   16384 tnode_new+0x45/0xb0 pages=3 vmalloc
0xffffc9000074d000-0xffffc90000751000   16384 n_tty_open+0x14/0xd0 pages=3 vmalloc
0xffffc900007a9000-0xffffc900007ad000   16384 n_tty_open+0x14/0xd0 pages=3 vmalloc
0xffffc900007b0000-0xffffc900007b5000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900007bd000-0xffffc900007c1000   16384 n_tty_open+0x14/0xd0 pages=3 vmalloc
0xffffc900007c4000-0xffffc900007c9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900007cc000-0xffffc900007d1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900007d4000-0xffffc900007d9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900007dc000-0xffffc900007e1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000800000-0xffffc90000b01000 3149824 simplefb_probe+0x260/0x3a0 phys=0x000000009d000000 ioremap
0xffffc90000ba4000-0xffffc90000ba9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000bac000-0xffffc90000bb1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000bb4000-0xffffc90000bb9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000bbc000-0xffffc90000bc1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000bdc000-0xffffc90000be1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000bec000-0xffffc90000bf1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000bf4000-0xffffc90000bf9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90000c00000-0xffffc90000ff1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000096000000 ioremap
0xffffc9000100c000-0xffffc90001011000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001014000-0xffffc90001019000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001024000-0xffffc90001029000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000102c000-0xffffc90001031000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001054000-0xffffc90001059000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001064000-0xffffc90001069000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000106c000-0xffffc90001071000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001074000-0xffffc90001079000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000107c000-0xffffc90001081000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900010ac000-0xffffc900010b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900010b4000-0xffffc900010b9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900010bc000-0xffffc900010c1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900010dc000-0xffffc900010e1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900010f0000-0xffffc900010f5000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001100000-0xffffc90001105000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001128000-0xffffc9000112d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000112d000-0xffffc9000114e000  135168 pcpu_extend_area_map+0x23/0xa0 pages=32 vmalloc
0xffffc90001158000-0xffffc9000115d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900011ac000-0xffffc900011b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900011ec000-0xffffc900011f1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001221000-0xffffc9000129c000  503808 SyS_swapon+0x369/0xf10 pages=122 vmalloc
0xffffc900012e9000-0xffffc900012fb000   73728 bucket_table_alloc+0x208/0x270 pages=17 vmalloc
0xffffc90001314000-0xffffc90001319000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001334000-0xffffc90001339000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000136c000-0xffffc90001371000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900013b4000-0xffffc900013b9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000143c000-0xffffc90001441000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001444000-0xffffc90001449000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001454000-0xffffc90001459000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001470000-0xffffc90001475000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900014ac000-0xffffc900014b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900014cc000-0xffffc900014d1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900014d1000-0xffffc900014f2000  135168 pcpu_extend_area_map+0x23/0xa0 pages=32 vmalloc
0xffffc9000152c000-0xffffc90001531000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000160c000-0xffffc90001611000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000163c000-0xffffc90001641000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900016ac000-0xffffc900016b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000171c000-0xffffc90001721000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001854000-0xffffc90001859000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900018d4000-0xffffc900018d9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001988000-0xffffc9000198d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000199c000-0xffffc900019a1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001a78000-0xffffc90001a7d000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001a80000-0xffffc90001a85000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001a9c000-0xffffc90001aa1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001aac000-0xffffc90001ab1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001abd000-0xffffc90001ac1000   16384 n_tty_open+0x14/0xd0 pages=3 vmalloc
0xffffc90001ac5000-0xffffc90001ac9000   16384 n_tty_open+0x14/0xd0 pages=3 vmalloc
0xffffc90001bdc000-0xffffc90001be1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90001c00000-0xffffc90001ff1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000095000000 ioremap
0xffffc90002000000-0xffffc900023f1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000094000000 ioremap
0xffffc90002400000-0xffffc900027f1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000093000000 ioremap
0xffffc90002800000-0xffffc90002bf1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000091000000 ioremap
0xffffc90002c00000-0xffffc90002ff1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000090000000 ioremap
0xffffc90003000000-0xffffc900033f1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x000000009b000000 ioremap
0xffffc90003400000-0xffffc900037f1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x000000009a000000 ioremap
0xffffc90003800000-0xffffc90003bf1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000099000000 ioremap
0xffffc90003c00000-0xffffc90003ff1000 4132864 i40e_probe.part.78+0x255/0x1ba0 phys=0x0000000098000000 ioremap
0xffffc90003ff1000-0xffffc900041f3000 2105344 tnode_new+0x45/0xb0 pages=513 vmalloc vpages
0xffffc90004214000-0xffffc90004219000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900042f4000-0xffffc900042f9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc9000436c000-0xffffc90004371000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90004804000-0xffffc90004809000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90004b0c000-0xffffc90004b11000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90004d1c000-0xffffc90004d21000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90004d3c000-0xffffc90004d41000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90004e0c000-0xffffc90004e11000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90004e1c000-0xffffc90004e21000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900052fc000-0xffffc90005301000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005544000-0xffffc90005549000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005884000-0xffffc90005889000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005c3c000-0xffffc90005c41000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005c4c000-0xffffc90005c51000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005c64000-0xffffc90005c69000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005c6c000-0xffffc90005c71000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005cec000-0xffffc90005cf1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005cf4000-0xffffc90005cf9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005d0c000-0xffffc90005d11000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005d14000-0xffffc90005d19000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005d5c000-0xffffc90005d61000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005dc4000-0xffffc90005dc9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005dd4000-0xffffc90005dd9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005dfc000-0xffffc90005e01000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e24000-0xffffc90005e29000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e34000-0xffffc90005e39000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e5c000-0xffffc90005e61000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e64000-0xffffc90005e69000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e6c000-0xffffc90005e71000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e74000-0xffffc90005e79000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e7c000-0xffffc90005e81000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e84000-0xffffc90005e89000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e8c000-0xffffc90005e91000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005e94000-0xffffc90005e99000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005ea4000-0xffffc90005ea9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005eb4000-0xffffc90005eb9000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005ebc000-0xffffc90005ec1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005edc000-0xffffc90005ee1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005f24000-0xffffc90005f29000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005f3c000-0xffffc90005f41000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005f44000-0xffffc90005f49000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90005f4c000-0xffffc90005f51000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc900086b1000-0xffffc900086d2000  135168 pcpu_extend_area_map+0x23/0xa0 pages=32 vmalloc
0xffffc900091ca000-0xffffc900091db000   69632 pcpu_extend_area_map+0x23/0xa0 pages=16 vmalloc
0xffffc9000f8ac000-0xffffc9000f8b1000   20480 _do_fork+0xb8/0x320 pages=4 vmalloc
0xffffc90010000000-0xffffc90020001000 268439552 pci_mmcfg_arch_map+0x2d/0x70 phys=0x0000000080000000 ioremap
0xffffe8fffee00000-0xffffe8ffff200000 4194304 pcpu_get_vm_areas+0x0/0x4e0 vmalloc
0xffffe8ffff200000-0xffffe8ffff600000 4194304 pcpu_get_vm_areas+0x0/0x4e0 vmalloc
0xffffe8ffff600000-0xffffe8ffffa00000 4194304 pcpu_get_vm_areas+0x0/0x4e0 vmalloc
0xffffe8ffffa00000-0xffffe8ffffe00000 4194304 pcpu_get_vm_areas+0x0/0x4e0 vmalloc
0xffffffffa0000000-0xffffffffa0002000    8192 bpf_jit_binary_alloc+0x32/0x90 pages=1 vmalloc
0xffffffffa0002000-0xffffffffa0004000    8192 bpf_jit_binary_alloc+0x32/0x90 pages=1 vmalloc
0xffffffffa0004000-0xffffffffa0006000    8192 bpf_jit_binary_alloc+0x32/0x90 pages=1 vmalloc
0xffffffffa0006000-0xffffffffa0008000    8192 bpf_jit_binary_alloc+0x32/0x90 pages=1 vmalloc
0xffffffffa0008000-0xffffffffa000a000    8192 bpf_jit_binary_alloc+0x32/0x90 pages=1 vmalloc
0xffffffffa000a000-0xffffffffa000c000    8192 bpf_jit_binary_alloc+0x32/0x90 pages=1 vmalloc
0xffffffffa000e000-0xffffffffa0010000    8192 bpf_jit_binary_alloc+0x32/0x90 pages=1 vmalloc

stat:
cpu  88857 19 30428 22071061 147033 0 208005 0 0 0
cpu0 7006 0 1780 1375714 11455 0 13685 0 0 0
cpu1 16959 2 1524 1366668 10946 0 13716 0 0 0
cpu2 5230 0 3672 1379069 7617 0 14140 0 0 0
cpu3 2863 0 2183 1380424 9966 0 12760 0 0 0
cpu4 3381 1 1944 1383055 9498 0 13219 0 0 0
cpu5 1477 0 1624 1385791 11109 0 10142 0 0 0
cpu6 4768 1 1170 1378367 9660 0 14192 0 0 0
cpu7 1392 0 1126 1382637 13569 0 11742 0 0 0
cpu8 13925 4 1960 1373219 10146 0 10784 0 0 0
cpu9 9974 1 1281 1372502 6092 0 19307 0 0 0
cpu10 8842 1 3414 1376279 7780 0 12628 0 0 0
cpu11 3123 0 2004 1381568 4755 0 11732 0 0 0
cpu12 2365 0 2676 1382040 9621 0 12538 0 0 0
cpu13 2007 8 1446 1384110 8097 0 12975 0 0 0
cpu14 2541 1 1312 1383961 9534 0 12325 0 0 0
cpu15 3004 0 1312 1385649 7181 0 12120 0 0 0
intr 1464748852 16 0 0 0 9 0 0 0 1 2 176031 0 0 0 0 0 0 0 240 0 0 0 0 0 0 0 2 0 2 2 2 2 2 2 2 0 72583 24508 19398 32349 26978 41074 29889 39159 27553 17121 22427 14224 0 26392 22457 22714 18029 0 1 11954218 8818301 18920055 8456404 7985258 5803113 9918578 6031861 9378832 12757010 9173398 8137476 9520104 8321108 6726575 8041322 0 0 0 0 0 0 0 0 0 1 11064375 13705187 8458016 9983827 9363214 7265392 10507105 6709457 7387502 6534835 11088705 11225946 10131724 7129049 8760429 16104706 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 2 19 40 36 25543 2164 233 69 2 34 5 10 70 47 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 50083057 53875528 54608392 50024162 44488627 39677270 58114649 40462105 41963136 71533913 50073059 45714728 44949574 50947829 49618229 45819000 0 0 0 0 0 0 0 0 0 0 1 11196479 16195245 10713944 15475423 7982978 11255989 7438167 9438944 8906390 19938580 10160525 9537774 8704381 8998638 17365643 6741879 0 0 0 0 0 0 0 0 0 1 13824315 6742981 8316350 8243480 10656881 5796431 23766177 10585977 5794119 22454353 9105790 8059043 8683758 12698756 8665176 7653836 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 25 69 45 25082 2600 235 48 3 34 4 1 61 62 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 10359751
btime 1499131862
processes 54554
procs_running 1
procs_blocked 3
softirq 1490151321 23 14940233 302027 1447276735 414804 0 44164 15025241 0 12148094

slabinfo:
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
ext4_groupinfo_4k    454    454    144  227    8 : tunables    0    0    0 : slabdata      2      2      0
bio-2              14480  14480    256  128    8 : tunables    0    0    0 : slabdata    114    114      0
ip6-frags              0      0    200  163    8 : tunables    0    0    0 : slabdata      0      0      0
fib6_nodes         76257  76544     64  128    2 : tunables    0    0    0 : slabdata    598    598      0
ip6_dst_cache      40541  42585    384   85    8 : tunables    0    0    0 : slabdata    501    501      0
PINGv6                 0      0   1088   30    8 : tunables    0    0    0 : slabdata      0      0      0
RAWv6                120    120   1088   30    8 : tunables    0    0    0 : slabdata      4      4      0
UDPLITEv6              0      0   1088   30    8 : tunables    0    0    0 : slabdata      0      0      0
UDPv6                540    540   1088   30    8 : tunables    0    0    0 : slabdata     18     18      0
tw_sock_TCPv6        132    132    248  132    8 : tunables    0    0    0 : slabdata      1      1      0
request_sock_TCPv6    525    525    312  105    8 : tunables    0    0    0 : slabdata      5      5      0
TCPv6                240    240   2112   15    8 : tunables    0    0    0 : slabdata     16     16      0
kcopyd_job             0      0   3240   10    8 : tunables    0    0    0 : slabdata      0      0      0
io                     0      0     64  128    2 : tunables    0    0    0 : slabdata      0      0      0
dm_uevent              0      0   2632   12    8 : tunables    0    0    0 : slabdata      0      0      0
dm_old_clone_request      0      0    304  107    8 : tunables    0    0    0 : slabdata      0      0      0
dm_rq_target_io        0      0    120  136    4 : tunables    0    0    0 : slabdata      0      0      0
dm_io              28397  28397     56  146    2 : tunables    0    0    0 : slabdata    197    197      0
sd_ext_cdb           128    128     32  128    1 : tunables    0    0    0 : slabdata      1      1      0
scsi_sense_cache    4128   4128    128  128    4 : tunables    0    0    0 : slabdata     33     33      0
ioat_sed_ent           0      0     32  128    1 : tunables    0    0    0 : slabdata      0      0      0
ioat                2176   2816    128  128    4 : tunables    0    0    0 : slabdata     22     22      0
sgpool-128             8      8   4096    8    8 : tunables    0    0    0 : slabdata      1      1      0
sgpool-64            848    848   2048   16    8 : tunables    0    0    0 : slabdata     53     53      0
sgpool-32            768    768   1024   32    8 : tunables    0    0    0 : slabdata     24     24      0
sgpool-16           1280   1280    512   64    8 : tunables    0    0    0 : slabdata     20     20      0
sgpool-8            2432   2432    256  128    8 : tunables    0    0    0 : slabdata     19     19      0
cfq_io_cq           2336   2336    112  146    4 : tunables    0    0    0 : slabdata     16     16      0
cfq_queue           2176   2176    240  136    8 : tunables    0    0    0 : slabdata     16     16      0
bsg_cmd                0      0    216  151    8 : tunables    0    0    0 : slabdata      0      0      0
fat_inode_cache       94     94    696   47    8 : tunables    0    0    0 : slabdata      2      2      0
fat_cache              0      0     40  204    2 : tunables    0    0    0 : slabdata      0      0      0
jbd2_transaction_s   2048   2048    256  128    8 : tunables    0    0    0 : slabdata     16     16      0
jbd2_inode          2720   2720     48  170    2 : tunables    0    0    0 : slabdata     16     16      0
jbd2_journal_handle   2720   2720     48  170    2 : tunables    0    0    0 : slabdata     16     16      0
jbd2_journal_head   2176   2176    120  136    4 : tunables    0    0    0 : slabdata     16     16      0
jbd2_revoke_table_s    256    256     16  256    1 : tunables    0    0    0 : slabdata      1      1      0
jbd2_revoke_record_s   2048   2048     32  128    1 : tunables    0    0    0 : slabdata     16     16      0
ext4_inode_cache    2208   2208   1008   32    8 : tunables    0    0    0 : slabdata     69     69      0
ext4_free_data      2048   2048     64  128    2 : tunables    0    0    0 : slabdata     16     16      0
ext4_allocation_context   2048   2048    128  128    4 : tunables    0    0    0 : slabdata     16     16      0
ext4_prealloc_space   2512   2512    104  157    4 : tunables    0    0    0 : slabdata     16     16      0
ext4_system_zone     204    204     40  204    2 : tunables    0    0    0 : slabdata      1      1      0
ext4_io_end         2496   2496     64  128    2 : tunables    0    0    0 : slabdata     20     20      0
ext4_extent_status  10608  11220     40  204    2 : tunables    0    0    0 : slabdata     55     55      0
mbcache                0      0     56  146    2 : tunables    0    0    0 : slabdata      0      0      0
kioctx                 0      0    640   51    8 : tunables    0    0    0 : slabdata      0      0      0
aio_kiocb              0      0    128  128    4 : tunables    0    0    0 : slabdata      0      0      0
fanotify_event_info      0      0     56  146    2 : tunables    0    0    0 : slabdata      0      0      0
fsnotify_mark          0      0     72  227    4 : tunables    0    0    0 : slabdata      0      0      0
dio                    0      0    640   51    8 : tunables    0    0    0 : slabdata      0      0      0
bio-1                128    128    256  128    8 : tunables    0    0    0 : slabdata      1      1      0
fasync_cache           0      0     48  170    2 : tunables    0    0    0 : slabdata      0      0      0
posix_timers_cache      0      0    216  151    8 : tunables    0    0    0 : slabdata      0      0      0
UNIX                 612    612    960   34    8 : tunables    0    0    0 : slabdata     18     18      0
ip4-frags           1958   1958    184  178    8 : tunables    0    0    0 : slabdata     11     11      0
UDP-Lite               0      0    960   34    8 : tunables    0    0    0 : slabdata      0      0      0
tcp_bind_bucket     2048   2048     64  128    2 : tunables    0    0    0 : slabdata     16     16      0
inet_peer_cache    13940  13940    192  170    8 : tunables    0    0    0 : slabdata     82     82      0
ip_fib_trie       603828 604690     48  170    2 : tunables    0    0    0 : slabdata   3557   3557      0
ip_fib_alias      648043 657730     56  146    2 : tunables    0    0    0 : slabdata   4505   4505      0
ip_dst_cache       10496  10496    256  128    8 : tunables    0    0    0 : slabdata     82     82      0
PING                   0      0    896   36    8 : tunables    0    0    0 : slabdata      0      0      0
RAW                  108    108    896   36    8 : tunables    0    0    0 : slabdata      3      3      0
UDP                  544    544    960   34    8 : tunables    0    0    0 : slabdata     16     16      0
tw_sock_TCP         2112   2112    248  132    8 : tunables    0    0    0 : slabdata     16     16      0
request_sock_TCP     735    735    312  105    8 : tunables    0    0    0 : slabdata      7      7      0
TCP                  272    272   1920   17    8 : tunables    0    0    0 : slabdata     16     16      0
eventpoll_pwq       3632   3632     72  227    4 : tunables    0    0    0 : slabdata     16     16      0
eventpoll_epi       2048   2048    128  128    4 : tunables    0    0    0 : slabdata     16     16      0
inotify_inode_mark   3264   3264     80  204    4 : tunables    0    0    0 : slabdata     16     16      0
scsi_data_buffer       0      0     24  170    1 : tunables    0    0    0 : slabdata      0      0      0
dax_cache             84     84    768   42    8 : tunables    0    0    0 : slabdata      2      2      0
request_queue        624    624   2016   16    8 : tunables    0    0    0 : slabdata     39     39      0
blkdev_requests        0      0    304  107    8 : tunables    0    0    0 : slabdata      0      0      0
blkdev_ioc          2512   2512    104  157    4 : tunables    0    0    0 : slabdata     16     16      0
bio-0              29131  29131    192  170    8 : tunables    0    0    0 : slabdata    181    181      0
biovec-256           216    224   4096    8    8 : tunables    0    0    0 : slabdata     42     42      0
biovec-128             0      0   2048   16    8 : tunables    0    0    0 : slabdata      0      0      0
biovec-64            512    512   1024   32    8 : tunables    0    0    0 : slabdata     16     16      0
biovec-16           2048   2048    256  128    8 : tunables    0    0    0 : slabdata     16     16      0
bio_integrity_payload    170    170    192  170    8 : tunables    0    0    0 : slabdata      1      1      0
khugepaged_mm_slot   3264   3264     40  204    2 : tunables    0    0    0 : slabdata     16     16      0
uid_cache           1152   1152    128  128    4 : tunables    0    0    0 : slabdata      9      9      0
dmaengine-unmap-256     15     15   2112   15    8 : tunables    0    0    0 : slabdata      1      1      0
dmaengine-unmap-128     30     30   1088   30    8 : tunables    0    0    0 : slabdata      1      1      0
dmaengine-unmap-16    170    170    192  170    8 : tunables    0    0    0 : slabdata      1      1      0
dmaengine-unmap-2    128    128     64  128    2 : tunables    0    0    0 : slabdata      1      1      0
sock_inode_cache     969    969    640   51    8 : tunables    0    0    0 : slabdata     19     19      0
skbuff_fclone_cache   1168   1168    448   73    8 : tunables    0    0    0 : slabdata     16     16      0
skbuff_head_cache   7936   8448    256  128    8 : tunables    0    0    0 : slabdata     66     66      0
file_lock_cache     2512   2512    208  157    8 : tunables    0    0    0 : slabdata     16     16      0
file_lock_ctx       2336   2336     56  146    2 : tunables    0    0    0 : slabdata     16     16      0
fsnotify_mark_connector   1870   1870     24  170    1 : tunables    0    0    0 : slabdata     11     11      0
net_namespace          0      0   3328    9    8 : tunables    0    0    0 : slabdata      0      0      0
shmem_inode_cache   1600   1600    648   50    8 : tunables    0    0    0 : slabdata     32     32      0
proc_inode_cache    3877   4080    632   51    8 : tunables    0    0    0 : slabdata     80     80      0
sigqueue            3264   3264    160  204    8 : tunables    0    0    0 : slabdata     16     16      0
bdev_cache           195    195    832   39    8 : tunables    0    0    0 : slabdata      5      5      0
kernfs_node_cache  37944  37944    120  136    4 : tunables    0    0    0 : slabdata    279    279      0
mnt_cache            935    935    384   85    8 : tunables    0    0    0 : slabdata     11     11      0
filp               17671  20480    256  128    8 : tunables    0    0    0 : slabdata    160    160      0
inode_cache        10498  10498    560   58    8 : tunables    0    0    0 : slabdata    181    181      0
dentry             43350  43350    192  170    8 : tunables    0    0    0 : slabdata    255    255      0
names_cache          128    128   4096    8    8 : tunables    0    0    0 : slabdata     16     16      0
buffer_head        20698  22876    104  157    4 : tunables    0    0    0 : slabdata    166    166      0
nsproxy              146    146     56  146    2 : tunables    0    0    0 : slabdata      1      1      0
vm_area_struct     33511  35154    176  186    8 : tunables    0    0    0 : slabdata    189    189      0
mm_struct            612    612    960   34    8 : tunables    0    0    0 : slabdata     18     18      0
fs_cache            2048   2048     64  128    2 : tunables    0    0    0 : slabdata     16     16      0
files_cache          736    736    704   46    8 : tunables    0    0    0 : slabdata     16     16      0
signal_cache        1080   1080    896   36    8 : tunables    0    0    0 : slabdata     30     30      0
sighand_cache        525    525   2112   15    8 : tunables    0    0    0 : slabdata     35     35      0
task_struct          660    660   3264   10    8 : tunables    0    0    0 : slabdata     66     66      0
cred_jar           37760  37760    128  128    4 : tunables    0    0    0 : slabdata    295    295      0
Acpi-Operand      164121 164121     72  227    4 : tunables    0    0    0 : slabdata    723    723      0
Acpi-ParseExt       3264   3264     80  204    4 : tunables    0    0    0 : slabdata     16     16      0
Acpi-Parse          2336   2336     56  146    2 : tunables    0    0    0 : slabdata     16     16      0
Acpi-State          3264   3264     80  204    4 : tunables    0    0    0 : slabdata     16     16      0
Acpi-Namespace     14280  14280     40  204    2 : tunables    0    0    0 : slabdata     70     70      0
anon_vma_chain     24320  24320     64  128    2 : tunables    0    0    0 : slabdata    190    190      0
anon_vma            7140   7140     80  204    4 : tunables    0    0    0 : slabdata     35     35      0
pid                 2176   2176    128  128    4 : tunables    0    0    0 : slabdata     17     17      0
trace_event_file    1116   1116     88  186    4 : tunables    0    0    0 : slabdata      6      6      0
ftrace_event_field   2550   2550     48  170    2 : tunables    0    0    0 : slabdata     15     15      0
pool_workqueue       384    384    256  128    8 : tunables    0    0    0 : slabdata      3      3      0
radix_tree_node     6330   6552    584   56    8 : tunables    0    0    0 : slabdata    117    117      0
task_group             0      0    576   56    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-8192         128    128   8192    4    8 : tunables    0    0    0 : slabdata     32     32      0
kmalloc-4096         360    376   4096    8    8 : tunables    0    0    0 : slabdata     47     47      0
kmalloc-2048        1584   1584   2048   16    8 : tunables    0    0    0 : slabdata     99     99      0
kmalloc-1024        5839   6048   1024   32    8 : tunables    0    0    0 : slabdata    189    189      0
kmalloc-512        14023  16448    512   64    8 : tunables    0    0    0 : slabdata    257    257      0
kmalloc-256        17924  18560    256  128    8 : tunables    0    0    0 : slabdata    145    145      0
kmalloc-192        35334  42840    192  170    8 : tunables    0    0    0 : slabdata    252    252      0
kmalloc-128        29224  89856    128  128    4 : tunables    0    0    0 : slabdata    702    702      0
kmalloc-96         94282 122230     96  170    4 : tunables    0    0    0 : slabdata    719    719      0
kmalloc-64        116845 129408     64  128    2 : tunables    0    0    0 : slabdata   1011   1011      0
kmalloc-32         32384  32384     32  128    1 : tunables    0    0    0 : slabdata    253    253      0
kmalloc-16          7168   7168     16  256    1 : tunables    0    0    0 : slabdata     28     28      0
kmalloc-8          12800  12800      8  512    1 : tunables    0    0    0 : slabdata     25     25      0
kmem_cache_node      512    512     64  128    2 : tunables    0    0    0 : slabdata      4      4      0
kmem_cache           512    512    256  128    8 : tunables    0    0    0 : slabdata      4      4      0

pagetypeinfo:
Page block order: 10
Pages per block:  1024

Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
Node    0, zone    DMA32, type    Unmovable    115     32     14     11     17      3      1      0      0      1      0
Node    0, zone    DMA32, type      Movable      6      1      5     23      6      1      5     13     13      6     21
Node    0, zone    DMA32, type  Reclaimable      1      1      2      2      0      1      0      0      1      1      0
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type    Unmovable      1     92     30      4      4      1      0      0      0      1      0
Node    0, zone   Normal, type      Movable   2605   1137    134     33    201     56    100     52     20     10      0
Node    0, zone   Normal, type  Reclaimable     11      9     17     42     43     12      2      2      0      0      0
Node    0, zone   Normal, type   HighAtomic      1      1      2      9      2      0      0      0      0      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0

Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic      Isolate
Node 0, zone    DMA32          407          104            1            0            0
Node 0, zone   Normal         7406          263           10            1            0

buddyinfo:
Node 0, zone    DMA32      9      6      6      8     20      9     11     13     14      8     21
Node 0, zone   Normal   1876   1637    708    127    256     68    103     54     20     11      0
