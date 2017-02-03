From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 3 Feb 2017 04:01:52 +0000
Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
 padding	packet
In-Reply-To: <20170123165906.13402.80385.stgit@localhost.localdomain>
References: <20170123165647.13402.1254.stgit@localhost.localdomain>
 <20170123165906.13402.80385.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C588006@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, January 23, 2017 8:59 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for padding
> packet
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> With the size of the frame limited we can now write to an offset within the
> buffer instead of having to write at the very start of the buffer.  The
> advantage to this is that it allows us to leave padding room for things
> like supporting XDP in the future.
> 
> One side effect of this patch is that we can end up using a larger buffer
> if jumbo frames is enabled.  The impact shouldn't be too great, but it
> could hurt small packet performance for UDP workloads if jumbo frames is
> enabled as the truesize of frames will be larger.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v3: Fixed "unsigned char *" / "void *" mismatch on pointer arithmetic
> 
>  drivers/net/ethernet/intel/igb/igb.h         |   44 ++++++++++++-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |    4 +
>  drivers/net/ethernet/intel/igb/igb_main.c    |   91 +++++++++++++++++++--
> -----
>  drivers/net/ethernet/intel/igb/igb_ptp.c     |    3 -
>  4 files changed, 110 insertions(+), 32 deletions(-)

I am having one (and only one) system dump on me when running netperf_stress (multiple netperf sessions of varying sizes running in looped cycles.)  The system itself is an older SuperMicro system with a pair of 82575EB LOMs.  It's a rather dated system but I managed to locate another box of more or less the same era with 82575EB LOMs and am NOT seeing the dump there.  I stripped off the other patches from this series and the problem does not appear with the first 5, but with this one on I get the system to crash.  Usually it freezes or restarts, sometimes it just locks up the consoles.  When it repeats or restarts it captures the trace to /var/log/messages so I was able to grab this trace from there:
------------------------------------------------------------------------------------------------
Feb  2 15:08:00 u1485 xinetd[1866]: START: netperf pid=5528 from=::ffff:190.1.4.85
Feb  2 15:08:02 u1485 kernel: swap_free: Bad swap offset entry 1c995c1d195b8
Feb  2 15:08:02 u1485 kernel: BUG: Bad page map in process sleep  pte:72657074656e0066 pmd:7be3b067
Feb  2 15:08:02 u1485 kernel: addr:00007fdfedc00000 vm_flags:00000070 anon_vma:          (null) mapping:ffff880079436cc0 index:1ba
Feb  2 15:08:02 u1485 kernel: file:libc-2.12.so fault:ext4_filemap_fault [ext4] mmap:ext4_file_mmap [ext4] readpage:ext4_readpage [ext4]
Feb  2 15:08:02 u1485 kernel: CPU: 5 PID: 5526 Comm: sleep Tainted: G            E   4.10.0-rc4_next-queue_regress #18
Feb  2 15:08:02 u1485 kernel: Hardware name: Supermicro X7DW3/X7DWN+, BIOS 1.2c 11/19/2010
Feb  2 15:08:02 u1485 kernel: Call Trace:
Feb  2 15:08:02 u1485 kernel: dump_stack+0x51/0x78
Feb  2 15:08:02 u1485 kernel: ? ext4_bh_unmapped+0x20/0x20 [ext4]
Feb  2 15:08:02 u1485 kernel: ? ext4_file_open+0x220/0x220 [ext4]
Feb  2 15:08:02 u1485 kernel: print_bad_pte+0x1cd/0x280
Feb  2 15:08:02 u1485 kernel: zap_pte_range+0x5ab/0x640
Feb  2 15:08:02 u1485 kernel: ? pte_alloc_one_map+0x1c3/0x250
Feb  2 15:08:02 u1485 kernel: unmap_page_range+0x1f8/0x300
Feb  2 15:08:02 u1485 kernel: unmap_single_vma+0x60/0xe0
Feb  2 15:08:02 u1485 kernel: unmap_vmas+0x4b/0xa0
Feb  2 15:08:02 u1485 kernel: exit_mmap+0xbb/0x140
Feb  2 15:08:02 u1485 kernel: mmput+0x77/0x170
Feb  2 15:08:02 u1485 kernel: ? mm_release+0x57/0x140
Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
Feb  2 15:08:02 u1485 kernel: exit_mm+0x140/0x1d0
Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
Feb  2 15:08:02 u1485 kernel: ? exit_signals+0x150/0x170
Feb  2 15:08:02 u1485 kernel: do_exit+0x12e/0x490
Feb  2 15:08:02 u1485 kernel: ? handle_mm_fault+0x87/0x190
Feb  2 15:08:02 u1485 kernel: ? filp_close+0x65/0x90
Feb  2 15:08:02 u1485 kernel: do_group_exit+0x4e/0xc0
Feb  2 15:08:02 u1485 kernel: SyS_exit_group+0x17/0x20
Feb  2 15:08:02 u1485 kernel: entry_SYSCALL_64_fastpath+0x13/0x94
Feb  2 15:08:02 u1485 kernel: RIP: 0033:0x7fdfedaf2df8
Feb  2 15:08:02 u1485 kernel: RSP: 002b:00007ffe94402408 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Feb  2 15:08:02 u1485 kernel: RAX: ffffffffffffffda RBX: 00000000fbad2084 RCX: 00007fdfedaf2df8
Feb  2 15:08:02 u1485 kernel: RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
Feb  2 15:08:02 u1485 kernel: RBP: 00007fdfeddd47a0 R08: 00000000000000e7 R09: ffffffffffffffa8
Feb  2 15:08:02 u1485 kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
Feb  2 15:08:02 u1485 kernel: R13: 00007ffe94402468 R14: 0000000000000001 R15: 00007ffe94402460
Feb  2 15:08:02 u1485 kernel: Disabling lock debugging due to kernel taint
Feb  2 15:08:02 u1485 kernel: swap_free: Bad swap offset entry 1c995c1d195b8
Feb  2 15:08:02 u1485 kernel: BUG: Bad page map in process sleep  pte:72657074656e0066 pmd:7be3b067
Feb  2 15:08:02 u1485 kernel: addr:00007fdfedc01000 vm_flags:00000070 anon_vma:          (null) mapping:ffff880079436cc0 index:1bb
Feb  2 15:08:02 u1485 kernel: file:libc-2.12.so fault:ext4_filemap_fault [ext4] mmap:ext4_file_mmap [ext4] readpage:ext4_readpage [ext4]
Feb  2 15:08:02 u1485 kernel: CPU: 5 PID: 5526 Comm: sleep Tainted: G    B       E   4.10.0-rc4_next-queue_regress #18
Feb  2 15:08:02 u1485 kernel: Hardware name: Supermicro X7DW3/X7DWN+, BIOS 1.2c 11/19/2010
Feb  2 15:08:02 u1485 kernel: Call Trace:
Feb  2 15:08:02 u1485 kernel: dump_stack+0x51/0x78
Feb  2 15:08:02 u1485 kernel: ? ext4_bh_unmapped+0x20/0x20 [ext4]
Feb  2 15:08:02 u1485 kernel: ? ext4_file_open+0x220/0x220 [ext4]
Feb  2 15:08:02 u1485 kernel: print_bad_pte+0x1cd/0x280
Feb  2 15:08:02 u1485 kernel: zap_pte_range+0x5ab/0x640
Feb  2 15:08:02 u1485 kernel: ? pte_alloc_one_map+0x1c3/0x250
Feb  2 15:08:02 u1485 kernel: unmap_page_range+0x1f8/0x300
Feb  2 15:08:02 u1485 kernel: unmap_single_vma+0x60/0xe0
Feb  2 15:08:02 u1485 kernel: unmap_vmas+0x4b/0xa0
Feb  2 15:08:02 u1485 kernel: exit_mmap+0xbb/0x140
Feb  2 15:08:02 u1485 kernel: mmput+0x77/0x170
Feb  2 15:08:02 u1485 kernel: ? mm_release+0x57/0x140
Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
Feb  2 15:08:02 u1485 kernel: exit_mm+0x140/0x1d0
Feb  2 15:08:02 u1485 kernel: ? down_read+0x16/0x40
Feb  2 15:08:02 u1485 kernel: ? exit_signals+0x150/0x170
Feb  2 15:08:02 u1485 kernel: do_exit+0x12e/0x490
Feb  2 15:08:02 u1485 kernel: ? handle_mm_fault+0x87/0x190
Feb  2 15:08:02 u1485 kernel: ? filp_close+0x65/0x90
Feb  2 15:08:02 u1485 kernel: do_group_exit+0x4e/0xc0
Feb  2 15:08:02 u1485 kernel: SyS_exit_group+0x17/0x20
Feb  2 15:08:02 u1485 kernel: entry_SYSCALL_64_fastpath+0x13/0x94
Feb  2 15:08:02 u1485 kernel: RIP: 0033:0x7fdfedaf2df8
Feb  2 15:08:02 u1485 kernel: RSP: 002b:00007ffe94402408 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Feb  2 15:08:02 u1485 kernel: RAX: ffffffffffffffda RBX: 00000000fbad2084 RCX: 00007fdfedaf2df8
Feb  2 15:08:02 u1485 kernel: RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
Feb  2 15:08:02 u1485 kernel: RBP: 00007fdfeddd47a0 R08: 00000000000000e7 R09: ffffffffffffffa8
Feb  2 15:08:02 u1485 kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
Feb  2 15:08:02 u1485 kernel: R13: 00007ffe94402468 R14: 0000000000000001 R15: 00007ffe94402460
Feb  2 15:08:02 u1485 kernel: swap_free: Bad swap offset entry 1c995c1d195b8
Feb  2 15:08:02 u1485 kernel: BUG: Bad page map in process sleep  pte:72657074656e0066 pmd:7be3b067
Feb  2 15:08:02 u1485 kernel: addr:00007fdfedc02000 vm_flags:00000070 anon_vma:          (null) mapping:ffff880079436cc0 index:1bc
Feb  2 15:08:02 u1485 kernel: file:libc-2.12.so fault:ext4_filemap_fault [ext4] mmap:ext4_file_mmap [ext4] readpage:ext4_readpage [ext4]
Feb  2 15:08:02 u1485 kernel: CPU: 5 PID: 5526 Comm: sleep Tainted: G    B       E   4.10.0-rc4_next-queue_regress #18
Feb  2 15:08:02 u1485 kernel: Hardware name: Supermicro X7DW3/X7DWN+, BIOS 1.2c 11/19/2010
...
------------------------------------------------------------------------------------------------
This call trace pattern repeated 7 ot 8 times and then the system either rebooted on its own or simply locked up.

I am not entirely convinced it is not my hardware as I cannot reproduce the issue on any other system.  This one is very low on disk space and I have been meaning to rebuild it on a larger partition, preferably newer and larger drive for some time.  Given it calls out a bad swap offset at the beginning of the bug / call trace text I suppose I could be running into issues with an overly full disk (though that seems a bit unlikely being different partitions and all.)  I will go ahead and rebuild this system granting new, larger freshly formatted partitions and see if the problem goes away.
