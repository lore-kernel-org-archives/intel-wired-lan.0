From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 4 Feb 2017 00:39:11 +0000
Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
 padding packet
In-Reply-To: <CAKgT0Uf2uZZOgX_2w7bpBbuFv4_VcTAJ0GnWyZAejEVVvtKBdA@mail.gmail.com>
References: <20170123165647.13402.1254.stgit@localhost.localdomain>
 <20170123165906.13402.80385.stgit@localhost.localdomain>
 <309B89C4C689E141A5FF6A0C5FB2118B8C588006@ORSMSX101.amr.corp.intel.com>
 <CAKgT0Uf2uZZOgX_2w7bpBbuFv4_VcTAJ0GnWyZAejEVVvtKBdA@mail.gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5887B6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Friday, February 3, 2017 9:58 AM
> To: Brown, Aaron F <aaron.f.brown@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: Re: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
> padding packet
> 
> On Thu, Feb 2, 2017 at 8:01 PM, Brown, Aaron F <aaron.f.brown@intel.com>
> wrote:
> >> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> On
> >> Behalf Of Alexander Duyck
> >> Sent: Monday, January 23, 2017 8:59 AM
> >> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> >> <jeffrey.t.kirsher@intel.com>
> >> Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
> padding
> >> packet
> >>
> >> From: Alexander Duyck <alexander.h.duyck@intel.com>
> >>
> >> With the size of the frame limited we can now write to an offset within
> the
> >> buffer instead of having to write at the very start of the buffer.  The
> >> advantage to this is that it allows us to leave padding room for things
> >> like supporting XDP in the future.
> >>
> >> One side effect of this patch is that we can end up using a larger buffer
> >> if jumbo frames is enabled.  The impact shouldn't be too great, but it
> >> could hurt small packet performance for UDP workloads if jumbo frames
> is
> >> enabled as the truesize of frames will be larger.
> >>
> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> >> ---
> >>
> >> v3: Fixed "unsigned char *" / "void *" mismatch on pointer arithmetic
> >>
> >>  drivers/net/ethernet/intel/igb/igb.h         |   44 ++++++++++++-
> >>  drivers/net/ethernet/intel/igb/igb_ethtool.c |    4 +
> >>  drivers/net/ethernet/intel/igb/igb_main.c    |   91
> +++++++++++++++++++--
> >> -----
> >>  drivers/net/ethernet/intel/igb/igb_ptp.c     |    3 -
> >>  4 files changed, 110 insertions(+), 32 deletions(-)
> >
> > I am having one (and only one) system dump on me when running
> netperf_stress (multiple netperf sessions of varying sizes running in looped
> cycles.)  The system itself is an older SuperMicro system with a pair of
> 82575EB LOMs.  It's a rather dated system but I managed to locate another
> box of more or less the same era with 82575EB LOMs and am NOT seeing the
> dump there.  I stripped off the other patches from this series and the
> problem does not appear with the first 5, but with this one on I get the
> system to crash.  Usually it freezes or restarts, sometimes it just locks up the
> consoles.  When it repeats or restarts it captures the trace to
> /var/log/messages so I was able to grab this trace from there:
> > -------------------------------------------------------------------------------------------
> -----
> > Feb  2 15:08:00 u1485 xinetd[1866]: START: netperf pid=5528
> from=::ffff:190.1.4.85
> > Feb  2 15:08:02 u1485 kernel: swap_free: Bad swap offset entry
> 1c995c1d195b8
> > Feb  2 15:08:02 u1485 kernel: BUG: Bad page map in process sleep
> pte:72657074656e0066 pmd:7be3b067
> > Feb  2 15:08:02 u1485 kernel: addr:00007fdfedc00000 vm_flags:00000070
> anon_vma:          (null) mapping:ffff880079436cc0 index:1ba
> > Feb  2 15:08:02 u1485 kernel: file:libc-2.12.so fault:ext4_filemap_fault
> [ext4] mmap:ext4_file_mmap [ext4] readpage:ext4_readpage [ext4]
> > Feb  2 15:08:02 u1485 kernel: CPU: 5 PID: 5526 Comm: sleep Tainted: G
> E   4.10.0-rc4_next-queue_regress #18
> > Feb  2 15:08:02 u1485 kernel: Hardware name: Supermicro
> X7DW3/X7DWN+, BIOS 1.2c 11/19/2010
> > Feb  2 15:08:02 u1485 kernel: Call Trace:
> > Feb  2 15:08:02 u1485 kernel: dump_stack+0x51/0x78
> > Feb  2 15:08:02 u1485 kernel: ? ext4_bh_unmapped+0x20/0x20 [ext4]
> > Feb  2 15:08:02 u1485 kernel: ? ext4_file_open+0x220/0x220 [ext4]
> > Feb  2 15:08:02 u1485 kernel: print_bad_pte+0x1cd/0x280
> > Feb  2 15:08:02 u1485 kernel: zap_pte_range+0x5ab/0x640
> > Feb  2 15:08:02 u1485 kernel: ? pte_alloc_one_map+0x1c3/0x250
> > Feb  2 15:08:02 u1485 kernel: unmap_page_range+0x1f8/0x300
> > Feb  2 15:08:02 u1485 kernel: unmap_single_vma+0x60/0xe0
> > Feb  2 15:08:02 u1485 kernel: unmap_vmas+0x4b/0xa0
> > Feb  2 15:08:02 u1485 kernel: exit_mmap+0xbb/0x140
> > Feb  2 15:08:02 u1485 kernel: mmput+0x77/0x170
> > Feb  2 15:08:02 u1485 kernel: ? mm_release+0x57/0x140
> > Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
> > Feb  2 15:08:02 u1485 kernel: exit_mm+0x140/0x1d0
> > Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
> > Feb  2 15:08:02 u1485 kernel: ? exit_signals+0x150/0x170
> > Feb  2 15:08:02 u1485 kernel: do_exit+0x12e/0x490
> > Feb  2 15:08:02 u1485 kernel: ? handle_mm_fault+0x87/0x190
> > Feb  2 15:08:02 u1485 kernel: ? filp_close+0x65/0x90
> > Feb  2 15:08:02 u1485 kernel: do_group_exit+0x4e/0xc0
> > Feb  2 15:08:02 u1485 kernel: SyS_exit_group+0x17/0x20
> > Feb  2 15:08:02 u1485 kernel: entry_SYSCALL_64_fastpath+0x13/0x94
> > Feb  2 15:08:02 u1485 kernel: RIP: 0033:0x7fdfedaf2df8
> > Feb  2 15:08:02 u1485 kernel: RSP: 002b:00007ffe94402408 EFLAGS:
> 00000246 ORIG_RAX: 00000000000000e7
> > Feb  2 15:08:02 u1485 kernel: RAX: ffffffffffffffda RBX: 00000000fbad2084
> RCX: 00007fdfedaf2df8
> > Feb  2 15:08:02 u1485 kernel: RDX: 0000000000000000 RSI:
> 000000000000003c RDI: 0000000000000000
> > Feb  2 15:08:02 u1485 kernel: RBP: 00007fdfeddd47a0 R08:
> 00000000000000e7 R09: ffffffffffffffa8
> > Feb  2 15:08:02 u1485 kernel: R10: 0000000000000004 R11:
> 0000000000000246 R12: 0000000000000000
> > Feb  2 15:08:02 u1485 kernel: R13: 00007ffe94402468 R14: 0000000000000001
> R15: 00007ffe94402460
> > Feb  2 15:08:02 u1485 kernel: Disabling lock debugging due to kernel taint
> > Feb  2 15:08:02 u1485 kernel: swap_free: Bad swap offset entry
> 1c995c1d195b8
> > Feb  2 15:08:02 u1485 kernel: BUG: Bad page map in process sleep
> pte:72657074656e0066 pmd:7be3b067
> > Feb  2 15:08:02 u1485 kernel: addr:00007fdfedc01000 vm_flags:00000070
> anon_vma:          (null) mapping:ffff880079436cc0 index:1bb
> > Feb  2 15:08:02 u1485 kernel: file:libc-2.12.so fault:ext4_filemap_fault
> [ext4] mmap:ext4_file_mmap [ext4] readpage:ext4_readpage [ext4]
> > Feb  2 15:08:02 u1485 kernel: CPU: 5 PID: 5526 Comm: sleep Tainted: G    B
> E   4.10.0-rc4_next-queue_regress #18
> > Feb  2 15:08:02 u1485 kernel: Hardware name: Supermicro
> X7DW3/X7DWN+, BIOS 1.2c 11/19/2010
> > Feb  2 15:08:02 u1485 kernel: Call Trace:
> > Feb  2 15:08:02 u1485 kernel: dump_stack+0x51/0x78
> > Feb  2 15:08:02 u1485 kernel: ? ext4_bh_unmapped+0x20/0x20 [ext4]
> > Feb  2 15:08:02 u1485 kernel: ? ext4_file_open+0x220/0x220 [ext4]
> > Feb  2 15:08:02 u1485 kernel: print_bad_pte+0x1cd/0x280
> > Feb  2 15:08:02 u1485 kernel: zap_pte_range+0x5ab/0x640
> > Feb  2 15:08:02 u1485 kernel: ? pte_alloc_one_map+0x1c3/0x250
> > Feb  2 15:08:02 u1485 kernel: unmap_page_range+0x1f8/0x300
> > Feb  2 15:08:02 u1485 kernel: unmap_single_vma+0x60/0xe0
> > Feb  2 15:08:02 u1485 kernel: unmap_vmas+0x4b/0xa0
> > Feb  2 15:08:02 u1485 kernel: exit_mmap+0xbb/0x140
> > Feb  2 15:08:02 u1485 kernel: mmput+0x77/0x170
> > Feb  2 15:08:02 u1485 kernel: ? mm_release+0x57/0x140
> > Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
> > Feb  2 15:08:02 u1485 kernel: exit_mm+0x140/0x1d0
> > Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
> > Feb  2 15:08:02 u1485 kernel: ? exit_signals+0x150/0x170
> > Feb  2 15:08:02 u1485 kernel: do_exit+0x12e/0x490
> > Feb  2 15:08:02 u1485 kernel: ? handle_mm_fault+0x87/0x190
> > Feb  2 15:08:02 u1485 kernel: ? filp_close+0x65/0x90
> > Feb  2 15:08:02 u1485 kernel: do_group_exit+0x4e/0xc0
> > Feb  2 15:08:02 u1485 kernel: SyS_exit_group+0x17/0x20
> > Feb  2 15:08:02 u1485 kernel: entry_SYSCALL_64_fastpath+0x13/0x94
> > Feb  2 15:08:02 u1485 kernel: RIP: 0033:0x7fdfedaf2df8
> > Feb  2 15:08:02 u1485 kernel: RSP: 002b:00007ffe94402408 EFLAGS:
> 00000246 ORIG_RAX: 00000000000000e7
> > Feb  2 15:08:02 u1485 kernel: RAX: ffffffffffffffda RBX: 00000000fbad2084
> RCX: 00007fdfedaf2df8
> > Feb  2 15:08:02 u1485 kernel: RDX: 0000000000000000 RSI:
> 000000000000003c RDI: 0000000000000000
> > Feb  2 15:08:02 u1485 kernel: RBP: 00007fdfeddd47a0 R08:
> 00000000000000e7 R09: ffffffffffffffa8
> > Feb  2 15:08:02 u1485 kernel: R10: 0000000000000004 R11:
> 0000000000000246 R12: 0000000000000000
> > Feb  2 15:08:02 u1485 kernel: R13: 00007ffe94402468 R14: 0000000000000001
> R15: 00007ffe94402460
> > Feb  2 15:08:02 u1485 kernel: swap_free: Bad swap offset entry
> 1c995c1d195b8
> > Feb  2 15:08:02 u1485 kernel: BUG: Bad page map in process sleep
> pte:72657074656e0066 pmd:7be3b067
> > Feb  2 15:08:02 u1485 kernel: addr:00007fdfedc02000 vm_flags:00000070
> anon_vma:          (null) mapping:ffff880079436cc0 index:1bc
> > Feb  2 15:08:02 u1485 kernel: file:libc-2.12.so fault:ext4_filemap_fault
> [ext4] mmap:ext4_file_mmap [ext4] readpage:ext4_readpage [ext4]
> > Feb  2 15:08:02 u1485 kernel: CPU: 5 PID: 5526 Comm: sleep Tainted: G    B
> E   4.10.0-rc4_next-queue_regress #18
> > Feb  2 15:08:02 u1485 kernel: Hardware name: Supermicro
> X7DW3/X7DWN+, BIOS 1.2c 11/19/2010
> > ...
> > -------------------------------------------------------------------------------------------
> -----
> > This call trace pattern repeated 7 ot 8 times and then the system either
> rebooted on its own or simply locked up.
> >
> > I am not entirely convinced it is not my hardware as I cannot reproduce the
> issue on any other system.  This one is very low on disk space and I have
> been meaning to rebuild it on a larger partition, preferably newer and larger
> drive for some time.  Given it calls out a bad swap offset at the beginning of
> the bug / call trace text I suppose I could be running into issues with an overly
> full disk (though that seems a bit unlikely being different partitions and all.)  I
> will go ahead and rebuild this system granting new, larger freshly formatted
> partitions and see if the problem goes away.
> 
> Well one thing you might try doing is running "ethtool
> --set-priv-flags <ethX> legacy-rx on" and seeing if you have the same
> problem or not.  Turning on legacy Rx with this patch applied should
> only have the effect of adding padding to the front of the frame and
> will help to eliminate some of the code as being potentially
> responsible for this.

Well, I had wiped the old system before I got this message, but after rebuilding I still get a dump from running the same netperf_stress test.  The trace has changed to a GPF and if I turn on legacy RX as you suggested netperf_stress continues to run fine and I do NOT get the dump.  Here is a copy of the latest dump I got when running netperf_stress (and with legacy RX off.):
---------------------------------------------------------------
Feb  3 16:23:14 u1485 xinetd[2096]: START: netperf pid=4207 from=::ffff:190.2.4.85
Feb  3 16:23:15 u1485 xinetd[2096]: START: netperf pid=4237 from=::ffff:190.2.4.85
Feb  3 16:23:20 u1485 kernel: general protection fault: 0000 [#1] SMP
Feb  3 16:23:20 u1485 kernel: Modules linked in: igb e100 ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge stp llc nfsd lockd grace nfs_acl auth_rpcgss sunrpc autofs4 ipv6 crc_ccitt dm_mirror dm_region_hash dm_log vhost_net macvtap macvlan vhost tun uinput iTCO_wdt iTCO_vendor_support mii sg joydev serio_raw i2c_i801 lpc_ich mfd_core dca ptp pps_core shpchp i5400_edac edac_core i5k_amb dm_mod(E) ext4(E) mbcache(E) jbd2(E) sd_mod(E) sr_mod(E) cdrom(E) pata_acpi(E) ata_generic(E) ata_piix(E) radeon(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E) [last unloaded: e100]
Feb  3 16:23:20 u1485 kernel: CPU: 7 PID: 77 Comm: kworker/7:1 Tainted: G            E   4.10.0-rc4_next_dev_8b48872+ #1
Feb  3 16:23:20 u1485 kernel: Hardware name: Supermicro X7DW3/X7DWN+, BIOS 1.2c 11/19/2010
Feb  3 16:23:20 u1485 kernel: Workqueue: events_long gc_worker [nf_conntrack]
Feb  3 16:23:20 u1485 kernel: task: ffff88007c608980 task.stack: ffffc900005bc000
Feb  3 16:23:20 u1485 kernel: RIP: 0010:gc_worker+0x94/0x1e0 [nf_conntrack]
Feb  3 16:23:20 u1485 kernel: RSP: 0018:ffffc900005bfc20 EFLAGS: 00010246
Feb  3 16:23:20 u1485 kernel: RAX: 72657074656e0066 RBX: ffffffffa0290aa0 RCX: 000000000001b118
Feb  3 16:23:20 u1485 kernel: RDX: ffffc900005bfc40 RSI: 000000010003d572 RDI: ffff88006d0ad000
Feb  3 16:23:20 u1485 kernel: RBP: ffffc900005bfca0 R08: ffffc900005bfab0 R09: ffffc900005bfa90
Feb  3 16:23:20 u1485 kernel: R10: 0000000000000a0c R11: 0000000000000001 R12: 0000000000000eb9
Feb  3 16:23:20 u1485 kernel: R13: 0000000000000000 R14: 0000000000000003 R15: fffffffffffffff0
Feb  3 16:23:20 u1485 kernel: FS:  0000000000000000(0000) GS:ffff88007fdc0000(0000) knlGS:0000000000000000
Feb  3 16:23:20 u1485 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb  3 16:23:20 u1485 kernel: CR2: 00007f6c3623d000 CR3: 0000000069ef3000 CR4: 00000000000006e0
Feb  3 16:23:20 u1485 kernel: Call Trace:
Feb  3 16:23:20 u1485 kernel: ? trace_event_raw_event_workqueue_execute_start+0x66/0xa0
Feb  3 16:23:20 u1485 kernel: process_one_work+0x19e/0x500
Feb  3 16:23:20 u1485 kernel: ? schedule+0x3a/0xa0
Feb  3 16:23:20 u1485 kernel: worker_thread+0x186/0x530
Feb  3 16:23:20 u1485 kernel: ? default_wake_function+0x12/0x20
Feb  3 16:23:20 u1485 kernel: ? maybe_create_worker+0x110/0x110
Feb  3 16:23:20 u1485 kernel: ? schedule+0x3a/0xa0
Feb  3 16:23:20 u1485 kernel: ? maybe_create_worker+0x110/0x110
Feb  3 16:23:20 u1485 kernel: kthread+0x103/0x140
Feb  3 16:23:20 u1485 kernel: ? __kthread_init_worker+0x40/0x40
Feb  3 16:23:20 u1485 kernel: ret_from_fork+0x29/0x40
Feb  3 16:23:20 u1485 kernel: Code: 75 da 41 39 f4 0f 82 f7 00 00 00 31 c0 45 31 e4 48 8d 04 01 48 8b 00 a8 01 48 89 45 b0 74 0c eb 61 48 8b 00 a8 01 48 89 02 75 57 <0f> b6 48 37 41 83 c6 01 48 8d 34 cd 00 00 00 00 48 c1 e1 06 48
Feb  3 16:23:20 u1485 kernel: RIP: gc_worker+0x94/0x1e0 [nf_conntrack] RSP: ffffc900005bfc20
Feb  3 16:23:20 u1485 kernel: ---[ end trace e0cac6f2424f4578 ]---
Feb  3 16:23:24 u1485 xinetd[2096]: EXIT: netperf status=0 pid=4207 duration=10(sec)
Feb  3 16:23:25 u1485 xinetd[2096]: EXIT: netperf status=0 pid=4237 duration=10(sec)
---------------------------------------------------------------
In this case the system rebooted continued to run but rebooted itself shortly afterwards.  An earlier instance it seemed to lock up.

> 
> I'll look through this patch several times today and try to see if I
> can find anything that might be causing the issue.
> 
> - Alex
