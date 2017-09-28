From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 28 Sep 2017 08:33:24 -0700
Subject: [Intel-wired-lan] Igb driver: Kernel panic as soon as any
	packet received
In-Reply-To: <DBXPR07MB36855D8C0F51BE3436817BDE3790@DBXPR07MB368.eurprd07.prod.outlook.com>
References: <DBXPR07MB36855D8C0F51BE3436817BDE3790@DBXPR07MB368.eurprd07.prod.outlook.com>
Message-ID: <CAKgT0UeXsgaO8Qgpk28PTTsE0efiPAsQwEWuAr78prqVbWaG9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 28, 2017 at 1:51 AM, Lijun Shen <lijun.shen@ericsson.com> wrote:
> Hi,
>
>
>
> Can you please look at the issue below? Thank you if any comments and
> suggestions.
>
>
>
> Environment:
>
> CPU                       : Westmere-EP 6C
>
> Memory              : 24G
>
> PCH                        : Tylersburg
>
> Ether Ports         : Intel Corporation 82576 Gigabit Network Connection
> [8086:10c9]
>
>
>
> Problem:
>
>                 When the OS boot up, kernel panic as soon as the ether
> port/igb driver receives any packets.
>
>
>
> Log (whole log attached):
>
> linux:~ # ifconfig ctrll0 10.163.177.16
>
> linux:~ # ping 10.163.177.1
>
> PING 10.163.177.[  303.711998] BUG: unable to handle kernel paging request
> at 00000000bf3c78ed
>
> [  303.719064] IP: [<ffffffff814a1029>] inet_gro_receive+0x39/0x200
>
> [  303.725089] PGD 0
>
> [  303.727117] Oops: 0000 [#1] SMP
>
> [  303.730375] Modules linked in: af_packet iscsi_ibft iscsi_boot_sysfs
> gsio(OEN) eri_ipmi(OEN) gephwid(OEN) msr intel_powerclamp uas coretemp
> kvm_intel kvm usb_storage sd_mod ahci libahci crct10dif_pclmul iTCO_wdt
> crc32_pclmul gpio_ich iTCO_vendor_support e1000e crc32c_intel libata
> ehci_pci uhci_hcd i7core_edac ppdev igb ehci_hcd ipmi_si ixgbe mpt2sas
> parport_pc aesni_intel mdio edac_core ioatdma ptp aes_x86_64 pps_core
> i2c_algo_bit lrw gf128mul glue_helper ablk_helper usbcore cryptd serio_raw
> pcspkr lpc_ich i2c_i801 mfd_core raid_class scsi_transport_sas acpi_cpufreq
> usb_common parport ipmi_msghandler dca shpchp button processor sg scsi_mod
> autofs4
>
> [  303.788756] Supported: No, Unsupported modules are loaded
>
> [  303.794150] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE N
> 3.12.53-60.30-default #1
>
> [  303.802666] Hardware name: Ericsson AB CXC1060259/ROJ208840/3 , BIOS
> R12A01 2017-07-06
>
> [  303.810571] task: ffffffff81c11460 ti: ffffffff81c00000 task.ti:
> ffffffff81c00000
>
> [  303.818041] RIP: 0010:[<ffffffff814a1029>]  [<ffffffff814a1029>]
> inet_gro_receive+0x39/0x200
>
> [  303.826484] RSP: 0018:ffff88063f203d20  EFLAGS: 00010206
>
> [  303.831789] RAX: 0000000000000001 RBX: ffff880602499880 RCX:
> 0000000000000054
>
> [  303.838911] RDX: ffff88062273174e RSI: ffff880602499880 RDI:
> ffff8805e2d5ae88
>
> [  303.846037] RBP: 0000000000000000 R08: 00000000bf3c78dd R09:
> 0000000000000000
>
> [  303.853161] R10: 0000000000000000 R11: 0000000000001043 R12:
> 0000000000000000
>
> [  303.860286] R13: ffff8805e2d5ae88 R14: 000000000000000e R15:
> 000000000000000e
>
> [  303.867411] FS:  0000000000000000(0000) GS:ffff88063f200000(0000)
> knlGS:0000000000000000
>
> [  303.875496] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>
> [  303.881232] CR2: 00000000bf3c78ed CR3: 0000000001c0c000 CR4:
> 00000000000007f0
>
> [  303.888357] Stack:
>
> [  303.890369]  ffff880602499880 0000000000000008 ffff8805e2d5ae50
> ffffffff81d39e48
>
> [  303.897821]  000000000000000e ffffffff81435ec4 ffff880622731700
> ffffffff81d39e48
>
> [  303.905275]  ffff880602499880 ffff8805e2d5ae50 ffff880602499880
> 0000000000000001
>
> [  303.912727] Call Trace:
>
> [  303.915182]  [<ffffffff81435ec4>] dev_gro_receive+0x1d4/0x290
>
> [  303.920923]  [<ffffffff81436210>] napi_gro_receive+0x20/0x90
>
> [  303.926588]  [<ffffffffa0252f60>] igb_clean_rx_irq+0x390/0x8c0 [igb]
>
> [  303.932954]  [<ffffffffa025379a>] igb_poll+0x30a/0x770 [igb]
>
> [  303.938620]  [<ffffffff81435bf0>] net_rx_action+0x140/0x240
>
> [  303.944197]  [<ffffffff8105e2d5>] __do_softirq+0xe5/0x230
>
> [  303.949593]  [<ffffffff8152d09c>] call_softirq+0x1c/0x30
>
> [  303.954906]  [<ffffffff81004665>] do_softirq+0x55/0x90
>
> [  303.960046]  [<ffffffff8105e575>] irq_exit+0x95/0xa0
>
> [  303.965011]  [<ffffffff8152d88e>] do_IRQ+0x4e/0xb0
>
> [  303.969805]  [<ffffffff8152386d>] common_interrupt+0x6d/0x6d
>
> [  303.975467]  [<ffffffff813f220f>] cpuidle_enter_state+0x4f/0xc0
>
> [  303.981383]  [<ffffffff813f2352>] cpuidle_idle_call+0xd2/0x210
>
> [  303.987219]  [<ffffffff8100ba0a>] arch_cpu_idle+0xa/0x30
>
> [  303.992531]  [<ffffffff810b06b1>] cpu_startup_entry+0xe1/0x270
>
> [  303.998364]  [<ffffffff81d50ea1>] start_kernel+0x43e/0x449
>
> [  304.003847]  [<ffffffff81d506a3>] x86_64_start_kernel+0x10c/0x11b
>
> [  304.009940] Code: 55 53 8b 6e 34 48 89 f3 48 8b 56 28 41 89 ec 8d 45 14
> 4c 01 e2 3b 46 30 77 38 0f b6 42 09 4c 8b 04 c5 e0 8b d3 81 4d 85 c0 74 0c
> <49> 83 78 10 00 74 05 80 3a 45 74 53 ba 01 00 00 00 31 c0 66 09
>
> [  304.029897] RIP  [<ffffffff814a1029>] inet_gro_receive+0x39/0x200
>
> [  304.035999]  RSP <ffff88063f203d20>
>
> [  304.039482] CR2: 00000000bf3c78ed
>
> 1 (10.163.177.1)[  304.042850] ---[ end trace f18a2476a4cd658a ]---
>
> 56(84) bytes of[  304.044551] systemd-journald[171]: Compressed data object
> 651 -> 512
>
> data.
>
> [  304.193794] Kernel panic - not syncing: Fatal exception in interrupt
>
>
>
> BR//Lijun

Can you clarify what distribution and driver version you are working
with? Have any additional patches been applied? If so have you tried
testing without those patches?

Based on your kernel version it looks like a SLES 12 kernel, thought
it isn't the latest update to that kernel. If your distribution has
updates available I would suggest checking with them first to make
sure you have the latest version of their kernel supported for your
release as this trace looks like it could possibly be a kernel bug
instead of bug in the driver itself. For example we have seen
something similar in the past as a result of flow dissector
initializing after the network driver was loaded which resulted in
uninitialized state in the flow dissector causing issues.

One thing you might try as a debugging step would be to boot the OS
with the igb driver blacklisted and then manually insert it after the
kernel has been fully booted using insmod. If that makes the issue
disappear then the kernel likely has an issue with the initialization
order for the components of the network stack.

Secondly we would need to know what version of the driver you are
using. Are you using the driver included with the distribution or did
you build a separate driver for use with the hardware?

Thanks.

- Alex
