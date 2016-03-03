From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Mar 2016 00:22:55 +0000
Subject: [Intel-wired-lan] [PATCH] igb: simplify check for all F
	for	surprise removal
In-Reply-To: <20160226215708.15005.5114.stgit@htfujina-fc.jf.intel.com>
References: <20160226215708.15005.5114.stgit@htfujina-fc.jf.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EA831F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Friday, February 26, 2016 1:57 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: simplify check for all F for surprise
> removal
> 
> The previous check appears to be delaying problems by doing multiple reads.
> Also, we've found that having igbvf in the host and vm and using direct-
> assign returns all F's on the STATUS register and we can't use that as an error
> condition. Since the VLAN Ether Type register
> (E1000_VET) has a hard-coded return value of 0x8100, check that register for
> all Fs instead.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

This breaks ethtool diagnostic on older hardware, 82575 and 82576 parts.  So far it seems fine with all the other parts I have accumulated.

When you run ethtool -t ethX, where ethX is either an 82575 or 82576, the system displays the following, leading in to a "unable to handle kernel paging request" trace:
-------------------------------------------------------
igb 0000:08:00.0: offline testing starting
igb 0000:08:00.0 eth1: igb: eth1 NIC Link is Down
igb 0000:08:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
igb 0000:08:00.0 eth1: PCIe link lost, device now detached
igb 0000:08:00.0: pattern test reg 2800 failed: got 0xFFFFFF80 expected 0x5A5A5A00
igb 0000:08:00.0: testing shared interrupt
igb 0000:08:00.0: Cannot do PHY loopback test when SoL/IDER is active.
BUG: unable to handle kernel paging request at 0000000000003818
IP: [<ffffffffa0729f47>] igb_configure_tx_ring+0x157/0x260 [igb]
PGD 7ba3a067 PUD 7a1f3067 PMD 0
Oops: 0002 [#1] SMP
Modules linked in: igb dca ptp pps_core nfsd lockd grace nfs_acl exportfs auth_rpcgss sunrpc autofs4 ipv6 dm_mirror dm_region_hash dm_log vhost_net macvtap macvlan vhost tun uinput joydev sg e100 mii serio_raw iTCO_wdt iTCO_vendor_support kvm_intel kvm irqbypass i2c_i801 lpc_ich mfd_core i5400_edac edac_core i5k_amb shpchp dm_mod(E) ext4(E) jbd2(E) mbcache(E) sd_mod(E) sr_mod(E) cdrom(E) pata_acpi(E) ata_generic(E) ata_piix(E) radeon(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E)
CPU: 7 PID: 3501 Comm: ethtool Tainted: G            E   4.5.0-rc5_next-queue_dev-queue_1ee6f69 #15
Hardware name: Supermicro X7DW3/X7DWN+, BIOS  1.1 04/30/2008
task: ffff880037b7e500 ti: ffff88007b8cc000 task.ti: ffff88007b8cc000
RIP: 0010:[<ffffffffa0729f47>]  [<ffffffffa0729f47>] igb_configure_tx_ring+0x157/0x260 [igb]
RSP: 0018:ffff88007b8cfb58  EFLAGS: 00010246
RAX: 0000000000003818 RBX: 0000000000000000 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 000000d632721ec3 RDI: 0000000000305021
RBP: ffff88007b8cfb88 R08: 0000000000000005 R09: ffff880079e8ce08
R10: 0000000000000000 R11: 0000000000000008 R12: ffff880079e8c840
R13: ffff88000010a140 R14: 000000007ad9a000 R15: ffffffffffffffff
FS:  00007fbfb5722700(0000) GS:ffff88007fdc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fa29f056020 CR3: 000000007bcc0000 CR4: 00000000000006e0
Stack:
 ffff880079e8c840 ffff880079e8c840 0000000000000001 ffff880079e8c848
 0000000000000000 ffff88007c60c000 ffff88007b8cfbb8 ffffffffa072c389
 ffff88007b8cfbb8 0000000000000000 ffff880079e8c840 ffff880079e8c000
Call Trace:
 [<ffffffffa072c389>] igb_configure+0xc9/0x1a0 [igb]
 [<ffffffffa073057d>] __igb_open+0xfd/0x300 [igb]
 [<ffffffffa0730910>] igb_open+0x10/0x20 [igb]
 [<ffffffffa0735b6f>] igb_diag_test+0x25f/0x3d0 [igb]
 [<ffffffff8151672f>] ethtool_self_test+0xbf/0x130
 [<ffffffff8151874d>] dev_ethtool+0xa3d/0xda0
 [<ffffffff8150fa43>] ? dev_get_by_name_rcu+0x73/0xa0
 [<ffffffff8118d923>] ? page_add_new_anon_rmap+0xa3/0xf0
 [<ffffffff8152a919>] dev_ioctl+0x2a9/0x370
 [<ffffffff8117f942>] ? do_anonymous_page+0x262/0x2e0
 [<ffffffff814f3884>] sock_do_ioctl+0x54/0x70
[<ffffffff814f3c4f>] sock_ioctl+0x6f/0x250
 [<ffffffff811d3138>] vfs_ioctl+0x18/0x30
 [<ffffffff811d3a12>] do_vfs_ioctl+0x162/0x490
 [<ffffffff81055531>] ? __do_page_fault+0x1a1/0x440
 [<ffffffff811d3dd2>] SyS_ioctl+0x92/0xa0
 [<ffffffff815e14d7>] entry_SYSCALL_64_fastpath+0x12/0x6a
Code: c0 0f 84 16 01 00 00 83 fb 03 0f 8f 86 00 00 00 89 da c1 e2 08 81 c2 10 38 00 00 48 63 d2 48 01 d0 31 d2 89 10 49 8b 45 30 31 d2 <89> 10 41 8b 84 24 54 06 00 00 66 ba 14 01 83 f8 05 74 0e 83 f8
RIP  [<ffffffffa0729f47>] igb_configure_tx_ring+0x157/0x260 [igb]
 RSP <ffff88007b8cfb58>
CR2: 0000000000003818
---[ end trace 19a1b0efa7748862 ]---
-------------------------------------------------------
The interface is no longer usable after this trace occurs.  Attempts to use the interface or restart the system will hang.
