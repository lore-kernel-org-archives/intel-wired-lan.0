From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 4 Jan 2016 23:56:31 +0000
Subject: [Intel-wired-lan] Add I210 cable fault detection to self test
In-Reply-To: <1481105116.578767.1450304180215.JavaMail.zimbra@xes-inc.com>
References: <907278953.561265.1450303005823.JavaMail.zimbra@xes-inc.com>,
 <1481105116.578767.1450304180215.JavaMail.zimbra@xes-inc.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E48F04@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Aaron Sierra [asierra at xes-inc.com]
> Sent: Wednesday, December 16, 2015 2:16 PM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Wyborny, Carolyn; Brandeburg, Jesse; Williams, Mitch A; Brown, Aaron F; Joe Schultz
> Subject: [PATCH v3] igb: Add I210 cable fault detection to self test
> 
> From: Joe Schultz <jschultz@xes-inc.com>
>
> Add an offline diagnostic test for the I210 internal PHY which checks
> for cable faults and reports the distance along the cable where the
> fault was detected. Fault types detected include open, short, and
> cross-pair short.
> 
> Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  v2 - account for changes made by this patch in dev-queue:
>    drivers/net: get rid of unnecessary initializations in .get_drvinfo()
>  v3 - fix uninitialized variable compile warning
>     - remove unneeded igb_cable_fault_test_prep() function
>     - don't add unused define to e1000_defines.h
>     - only run cable diagnostic if link test fails
> 
>  drivers/net/ethernet/intel/igb/e1000_defines.h |  12 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c   | 186 ++++++++++++++++++++++++-
>  2 files changed, 192 insertions(+), 6 deletions(-)

A question and a bug.  Question first since it's short:

Q. Was this version supposed to suppress running the cable diagnostics if the system has link?  I am still seeing the cable fault output (complete with -1 for the fault distances) when I run ethtool -t against an i210 or i211.

When I run diagnostics against a number of parts I get a "Bug:  This version of the patch is causing (or exposing) a "BUG: unable to handle kernel paging request at ffffffffffffffff" followed by a Call Trace.  It does not seem to occur with i210 or i211, but I consistently get the trace on 82575EB, 82576, i350 and i354. 
 
 It does not occur every time I run the diagnostics, but pretty frequently.  Generally if it shows up it does so within 5 or 6 iterations (though sometimes it takes many more.)  The system hangs and becomes unusable, but the trace is captured to /var/log/messages.  Here is a sample of the trace, in this case from an the 82575EB, the other traces look pretty similar:
-----------------------------------------------------------------------------------------------------------------------------------
Jan  4 13:07:19 u1485 kernel: BUG: unable to handle kernel paging request at ffffffffffffffff
Jan  4 13:07:19 u1485 kernel: IP: [<ffffffff81181998>] unlink_anon_vmas+0x78/0x190
Jan  4 13:07:19 u1485 kernel: PGD 1a0b067 PUD 1a0d067 PMD 0
Jan  4 13:07:19 u1485 kernel: Oops: 0000 [#1] SMP
Jan  4 13:07:19 u1485 kernel: Modules linked in: igb dca ptp pps_core ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge stp llc nfsd lockd grace nfs_acl exportfs auth_rpcgss sunrpc autofs4 ipv6 dm_mirror dm_region_hash dm_log vhost_net macvtap macvlan vhost tun uinput joydev sg e100 mii serio_raw iTCO_wdt iTCO_vendor_support kvm_intel kvm irqbypass i2c_i801 lpc_ich mfd_core i5400_edac edac_core i5k_amb shpchp dm_mod(E) ext4(E) jbd2(E) mbcache(E) sd_mod(E) sr_mod(E) cdrom(E) pata_acpi(E) ata_generic(E) ata_piix(E) radeon(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E)
Jan  4 13:07:19 u1485 kernel: CPU: 3 PID: 9351 Comm: ethtool Tainted: G            E   4.4.0-rc5_next_dev_2d9a87e-01243-g2d9a87e #13
Jan  4 13:07:19 u1485 kernel: Hardware name: Supermicro X7DW3/X7DWN+, BIOS  1.1 04/30/2008
Jan  4 13:07:19 u1485 kernel: task: ffff88005df5e280 ti: ffff88005df60000 task.ti: ffff88005df60000
Jan  4 13:07:19 u1485 kernel: RIP: 0010:[<ffffffff81181998>]  [<ffffffff81181998>] unlink_anon_vmas+0x78/0x190
Jan  4 13:07:19 u1485 kernel: RSP: 0018:ffff88005df63c98  EFLAGS: 00010246
Jan  4 13:07:19 u1485 kernel: RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 000000000000018e
Jan  4 13:07:19 u1485 kernel: RDX: 000000359f18f000 RSI: ffff88007c3b7240 RDI: ffff88007b631970
Jan  4 13:07:19 u1485 kernel: RBP: ffff88005df63ce8 R08: 000000359f18f000 R09: ffff88007a80d408
Jan  4 13:07:19 u1485 kernel: R10: 0000000000000000 R11: ffff88007aecce18 R12: 0000000000000000
Jan  4 13:07:19 u1485 kernel: R13: ffffffffffffffef R14: ffff88007acfbd00 R15: ffff88007b6319e8
Jan  4 13:07:19 u1485 kernel: FS:  0000000000000000(0000) GS:ffff88007fcc0000(0000) knlGS:0000000000000000
Jan  4 13:07:19 u1485 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan  4 13:07:19 u1485 kernel: CR2: ffffffffffffffff CR3: 000000007a978000 CR4: 00000000000006e0
Jan  4 13:07:19 u1485 kernel: Stack:
Jan  4 13:07:19 u1485 kernel: ffff88005df63cb8 ffffffff815ba8c6 ffff88007b631970 ffff88007acfbd10
Jan  4 13:07:19 u1485 kernel: ffff88005df63ce8 ffff88007b631468 0000000000000000 ffff88005df63d58
Jan  4 13:07:19 u1485 kernel: 0000000000000000 000000359e600000 ffff88005df63d38 ffffffff811735e4
Jan  4 13:07:19 u1485 kernel: Call Trace:
Jan  4 13:07:19 u1485 kernel: [<ffffffff815ba8c6>] ? down_write+0x16/0x50
Jan  4 13:07:19 u1485 kernel: [<ffffffff811735e4>] free_pgtables+0x84/0x100
Jan  4 13:07:19 u1485 kernel: [<ffffffff8117aa81>] exit_mmap+0xd1/0x140
Jan  4 13:07:19 u1485 kernel: [<ffffffff813766d5>] ? do_tty_write+0x125/0x1d0
Jan  4 13:07:19 u1485 kernel: [<ffffffff8105b86a>] mmput+0x6a/0x100
Jan  4 13:07:19 u1485 kernel: [<ffffffff8105ec54>] exit_mm+0x134/0x1c0
Jan  4 13:07:19 u1485 kernel: [<ffffffff815ba916>] ? down_read+0x16/0x30
Jan  4 13:07:19 u1485 kernel: [<ffffffff81060517>] do_exit+0x147/0x460
Jan  4 13:07:19 u1485 kernel: [<ffffffff81050271>] ? __do_page_fault+0x1a1/0x440
Jan  4 13:07:19 u1485 kernel: [<ffffffff81060881>] do_group_exit+0x51/0xb0
Jan  4 13:07:19 u1485 kernel: [<ffffffff810608f7>] SyS_exit_group+0x17/0x20
Jan  4 13:07:19 u1485 kernel: [<ffffffff815bc1d7>] entry_SYSCALL_64_fastpath+0x12/0x6a
Jan  4 13:07:19 u1485 kernel: Code: 7f 9a d1 00 4c 89 f6 e8 57 b6 01 00 49 8d 45 10 49 8b 55 10 4c 39 f8 48 89 45 c8 74 46 4d 89 ee 4c 8d 6a f0 4c 89 e0 49 8b 5e 08 <4c> 8b 23 4c 39 e0 74 13 48 85 c0 0f 85 ca 00 00 00 49 8d 7c 24
Jan  4 13:07:19 u1485 kernel: RIP  [<ffffffff81181998>] unlink_anon_vmas+0x78/0x190
Jan  4 13:07:19 u1485 kernel: RSP <ffff88005df63c98>
Jan  4 13:07:19 u1485 kernel: CR2: ffffffffffffffff
Jan  4 13:07:19 u1485 kernel: ---[ end trace 720ddd6818910144 ]---
Jan  4 13:07:19 u1485 kernel: Fixing recursive fault but reboot is needed!
