From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 16 May 2016 22:09:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of
 RX	network flow classification
In-Reply-To: <1462786062-7572-2-git-send-email-gangfeng.huang@ni.com>
References: <1462786062-7572-1-git-send-email-gangfeng.huang@ni.com>
 <1462786062-7572-2-git-send-email-gangfeng.huang@ni.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EFDB5D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Gangfeng
> Sent: Monday, May 9, 2016 2:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gangfeng Huang <gangfeng.huang@ni.com>; Ruhao Gao
> <ruhao.gao@ni.com>
> Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX
> network flow classification
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for RX network flow classification to insert
> and remove Rx filter by ethtool. Ethtool interface has it's own rules
> manager
> 
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 2 rules
> 
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  32 +++++
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 193
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c    |  44 ++++++
>  3 files changed, 269 insertions(+)

This patch is causing 3/4 of my regression systems to fail.  Driver load seems normal, but applying an IP address via ifconfig causes the following splat in dmesg and /var/log/messages:
----------------------------------------------
May 16 14:37:50 u1486 kernel: Hardware name: Supermicro A1SAi/A1SRi, BIOS 1.0b 11/06/2013
May 16 14:37:50 u1486 kernel: 0000000000000000 ffff880849ad3938 ffffffff813373d7 0000000000000007
May 16 14:37:50 u1486 kernel: 0000000000000006 0000000000000000 ffff88085c2f6770 ffff880849ad3a58
May 16 14:37:50 u1486 kernel: ffffffff810c4e13 ffff880849ad39f8 0000000000000005 0000000000000000
May 16 14:37:50 u1486 kernel: Call Trace:
May 16 14:37:50 u1486 kernel: [<ffffffff813373d7>] dump_stack+0x6b/0xa4
May 16 14:37:50 u1486 kernel: [<ffffffff810c4e13>] register_lock_class+0x523/0x5c0
May 16 14:37:50 u1486 kernel: [<ffffffff8136644b>] ? check_preemption_disabled+0x1b/0x110
May 16 14:37:50 u1486 kernel: [<ffffffff811f5655>] ? kfree+0x1a5/0x3a0
May 16 14:37:50 u1486 kernel: [<ffffffff81366553>] ? __this_cpu_preempt_check+0x13/0x20
May 16 14:37:50 u1486 kernel: [<ffffffff810c7ae0>] __lock_acquire+0x80/0x5d0
May 16 14:37:50 u1486 kernel: [<ffffffff811f83f5>] ? __kmalloc+0x265/0x3a0
May 16 14:37:50 u1486 kernel: [<ffffffffa051864f>] ? kzalloc+0xf/0x20 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffff810c80fa>] lock_acquire+0xca/0x240
May 16 14:37:50 u1486 kernel: [<ffffffffa0520c3f>] ? igb_configure+0xaf/0x1d0 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffff815b958b>] ? netdev_rss_key_fill+0x5b/0xa0
May 16 14:37:50 u1486 kernel: [<ffffffffa052dfb9>] ? igb_vfta_set+0x189/0x1f0 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffff816a8930>] _raw_spin_lock+0x40/0x80
May 16 14:37:50 u1486 kernel: [<ffffffffa0520c3f>] ? igb_configure+0xaf/0x1d0 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffffa051bf62>] ? igb_setup_rctl+0x22/0xb0 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffffa0520c3f>] igb_configure+0xaf/0x1d0 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffffa052408d>] __igb_open+0xfd/0x300 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffff815ab260>] ? call_netdevice_notifiers_info+0x40/0x70
May 16 14:37:50 u1486 kernel: [<ffffffffa0524420>] igb_open+0x10/0x20 [igb]
May 16 14:37:50 u1486 kernel: [<ffffffff815ac7f8>] __dev_open+0xb8/0x110
May 16 14:37:50 u1486 kernel: [<ffffffff815ac5fc>] __dev_change_flags+0xac/0x180
May 16 14:37:50 u1486 kernel: [<ffffffff815ac700>] dev_change_flags+0x30/0x70
May 16 14:37:50 u1486 kernel: [<ffffffff815c6685>] ? lockdep_rtnl_is_held+0x15/0x20
May 16 14:37:50 u1486 kernel: [<ffffffff816403a5>] devinet_ioctl+0x5b5/0x620
May 16 14:37:50 u1486 kernel: [<ffffffff81156660>] ? trace_buffer_unlock_commit+0x60/0x80
May 16 14:37:50 u1486 kernel: [<ffffffff81643033>] inet_ioctl+0x63/0x80
May 16 14:37:50 u1486 kernel: [<ffffffff8158fd60>] sock_do_ioctl+0x30/0x70
May 16 14:37:50 u1486 kernel: [<ffffffff815901b3>] sock_ioctl+0x73/0x280
May 16 14:37:50 u1486 kernel: [<ffffffff8121f678>] vfs_ioctl+0x18/0x30
May 16 14:37:50 u1486 kernel: [<ffffffff81220057>] do_vfs_ioctl+0x87/0x430
May 16 14:37:50 u1486 kernel: [<ffffffff8100297e>] ? syscall_trace_enter_phase2+0x6e/0x280
May 16 14:37:50 u1486 kernel: [<ffffffff81220492>] SyS_ioctl+0x92/0xa0
May 16 14:37:50 u1486 kernel: [<ffffffff81002fd3>] do_syscall_64+0x63/0x130
May 16 14:37:50 u1486 kernel: [<ffffffff8100201b>] ? trace_hardirqs_on_thunk+0x1b/0x1d
May 16 14:37:50 u1486 kernel: [<ffffffff816a981a>] entry_SYSCALL64_slow_path+0x25/0x25
----------------------------------------------
The system will then seem to function normally for a few minutes more then, even if left completely idle, will spew out another splat and the console freezes.  A few more minutes and another splat hits the screen, but he console is otherwise still locked up.  These later splats do not get captured to the logs.

I am seeing this on systems with a pair i350s and 82576s, a quad i354 and an i211 and pair of 82580s.  A system with a pair of 82580 ports and an i210 seems fine.

