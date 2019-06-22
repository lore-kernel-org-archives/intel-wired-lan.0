From: Detlev Casanova <detlev.casanova@gmail.com>
Date: Sat, 22 Jun 2019 12:22:56 -0400
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Make watchdog use delayed
 work
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B970B111B@ORSMSX103.amr.corp.intel.com>
References: <20190618220846.19486-1-detlev.casanova@gmail.com>
 <309B89C4C689E141A5FF6A0C5FB2118B970B111B@ORSMSX103.amr.corp.intel.com>
Message-ID: <CAC-44GXp0bCjDp85k_Sisrv8ZesdOa8CPEzkXvkTVLw7B7vYBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It probably needs to use a refcount for the work queue or use one per
instance. I'll check that.

On Thu, Jun 20, 2019 at 7:17 PM Brown, Aaron F <aaron.f.brown@intel.com>
wrote:

> On Tue, 2019-06-18 at 18:08 -0400, Detlev Casanova wrote:
> > Use delayed work instead of timers to run the watchdog of the e1000e
> > driver.
> >
> > Simplify the code with one less middle function.
> >
> > Signed-off-by: Detlev Casanova <detlev.casanova@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/e1000e/e1000.h  |  3 +-
> >  drivers/net/ethernet/intel/e1000e/netdev.c | 54 ++++++++++++----------
> >  2 files changed, 30 insertions(+), 27 deletions(-)
> >
>
> This patch is causing a NULL pointer dereference trace (or just a freeze)
> on a number of my regression systems when I unload the e1000e driver.  The
> crashing test systems each have multiple e1000e
> based ports, I can pull the systems from the rack and change cards out if
> necessary, though it's not a trivial task getting to them.
>
> Systems affected had the following e1000e chipsets:
> - 82579LM Gigabit Network Connection rev 05) LOM
> - 82574L LOM
>
> - I217-LM LOM
> - 82572EI (Rimon)
>
> - 80003ES2LAN x2 LOMs
> - 82572EI Add in card
>
> - 80003ES2LAN x2 LOMs
> - 82571EB (Ophir) copper (dual port card)
> - 82571EB (Ophir) fibre  (dual port card)
>
> Here is the trace caputrued from the last system listed, the 80003ES2LAN
> LOMs and 2 dual port Ophir cards:
> -------------------------------------------------------------
> u1462:[ttyS1]/root> rmmod e1000e
> [  131.799739] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [  131.806908] #PF: supervisor write access in kernel mode
> [  131.812285] #PF: error_code(0x0002) - not-present page
> [  131.817565] PGD 8000000072327067 P4D 8000000072327067 PUD 3050f067 PMD 0
> [  131.824540] Oops: 0002 [#1] SMP PTI
> [  131.828133] CPU: 3 PID: 4306 Comm: rmmod Not tainted
> 5.2.0-rc5_next-queue_dev-queue_15bf1c7+ #9
> [  131.837073] Hardware name: Supermicro X7DBX/X7DBX, BIOS 2.1 06/23/2008
> [  131.843791] RIP: 0010:_raw_spin_lock_irq+0x13/0x30
> [  131.848722] Code: 00 75 02 f3 c3 e9 3d 16 8a ff 0f 1f 00 66 2e 0f 1f 84
> 00 00 00 00 00 66 66 66 66 90 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00
> <f0> 0f b1 17 0f 94 c2 84 d2 74 02 f3 c3 89 c6 e9 b2
> fd 89 ff 66 0f
> [  131.867998] RSP: 0018:ffffb85601f87d58 EFLAGS: 00010046
> [  131.873377] RAX: 0000000000000000 RBX: ffff9a5a9faa5b90 RCX:
> 0000000000000003
> [  131.880702] RDX: 0000000000000001 RSI: 0000000000000002 RDI:
> 0000000000000000
> [  131.888032] RBP: 0000000000000002 R08: 0000000000000000 R09:
> 0000000000000000
> [  131.895356] R10: ffff9a5ab340a550 R11: ffffe13500cd0280 R12:
> 0000000000000003
> [  131.902679] R13: 0000000000000002 R14: ffff9a5a9faa4400 R15:
> 0000000000000000
> [  131.910003] FS:  00007f37948a9740(0000) GS:ffff9a5afcac0000(0000)
> knlGS:0000000000000000
> [  131.918325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  131.924229] CR2: 0000000000000000 CR3: 0000000020602000 CR4:
> 00000000000006e0
> [  131.931557] Call Trace:
> [  131.934093]  flush_workqueue_prep_pwqs+0x55/0x120
> [  131.938929]  flush_workqueue+0x1b6/0x460
> [  131.942987]  e1000_remove+0x93/0x190 [e1000e]
> [  131.947466]  pci_device_remove+0x3b/0xc0
> [  131.951511]  device_release_driver_internal+0xdf/0x1a0
> [  131.956797]  driver_detach+0x43/0x80
> [  131.960487]  bus_remove_driver+0x55/0xd0
> [  131.964535]  pci_unregister_driver+0x26/0xa0
> [  131.968938]  __x64_sys_delete_module+0x16c/0x250
> [  131.973698]  ? exit_to_usermode_loop+0xaa/0xc6
> [  131.978270]  do_syscall_64+0x5b/0x1b0
> [  131.982041]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  131.987237] RIP: 0033:0x7f3793d82397
> [  131.990923] Code: 73 01 c3 48 8b 0d f9 7a 2c 00 f7 d8 64 89 01 48 83 c8
> ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05
> <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 7a 2c 00 f7
> d8 64 89 01 48
> [  132.010190] RSP: 002b:00007ffc6b3dea18 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [  132.017972] RAX: ffffffffffffffda RBX: 0000000001a23190 RCX:
> 00007f3793d82397
> [  132.034233] RDX: 00007f3793df6b20 RSI: 0000000000000800 RDI:
> 0000000001a231f8
> [  132.050479] RBP: 0000000000000000 R08: 00007f379404b060 R09:
> 00007f3793df6b20
> [  132.066683] R10: 00007ffc6b3de5e0 R11: 0000000000000206 R12:
> 00007ffc6b3e0d4a
> [  132.082874] R13: 0000000000000000 R14: 0000000001a23190 R15:
> 0000000001a23010
> [  132.098961] Modules linked in: xt_CHECKSUM iptable_mangle xt_MASQUERADE
> iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> ipt_REJECT nf_reject_ipv4 tun bridge stp llc
> ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
> dm_mirror dm_region_hash dm_log dm_mod coretemp kvm_intel kvm iTCO_wdt
> i2c_i801 gpio_ich iTCO_vendor_support lpc_ich pcspkr i5000_edac
> sg irqbypass acpi_cpufreq i5k_amb nfsd auth_rpcgss nfs_acl lockd grace
> sunrpc ip_tables xfs libcrc32c radeon sr_mod sd_mod cdrom ata_generic
> pata_acpi i2c_algo_bit drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops ttm drm ata_piix libata serio_raw
> e1000e(-) e1000
> [  132.215961] CR2: 0000000000000000
> [  132.229473] ---[ end trace 31a92a65bb543b98 ]---
> [  132.244260] RIP: 0010:_raw_spin_lock_irq+0x13/0x30
> [  132.259217] Code: 00 75 02 f3 c3 e9 3d 16 8a ff 0f 1f 00 66 2e 0f 1f 84
> 00 00 00 00 00 66 66 66 66 90 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00
> <f0> 0f b1 17 0f 94 c2 84 d2 74 02 f3 c3 89 c6 e9 b2
> fd 89 ff 66 0f
> [  132.299254] RSP: 0018:ffffb85601f87d58 EFLAGS: 00010046
> [  132.315166] RAX: 0000000000000000 RBX: ffff9a5a9faa5b90 RCX:
> 0000000000000003
> [  132.333000] RDX: 0000000000000001 RSI: 0000000000000002 RDI:
> 0000000000000000
> [  132.350749] RBP: 0000000000000002 R08: 0000000000000000 R09:
> 0000000000000000
> [  132.368150] R10: ffff9a5ab340a550 R11: ffffe13500cd0280 R12:
> 0000000000000003
> [  132.385257] R13: 0000000000000002 R14: ffff9a5a9faa4400 R15:
> 0000000000000000
> [  132.402202] FS:  00007f37948a9740(0000) GS:ffff9a5afcac0000(0000)
> knlGS:0000000000000000
> [  132.420165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  132.435818] CR2: 0000000000000000 CR3: 0000000020602000 CR4:
> 00000000000006e0
> [  132.453030] Kernel panic - not syncing: Fatal exception
> [  132.468323] Kernel Offset: 0x7e00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  132.489386] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190622/4484306e/attachment.html>
