From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 30 Jun 2016 01:20:44 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of
 RX network flow classification
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81F26C2D@ORSMSX101.amr.corp.intel.com>
References: <1462786062-7572-1-git-send-email-gangfeng.huang@ni.com>
 <1462786062-7572-2-git-send-email-gangfeng.huang@ni.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EFDB5D@ORSMSX101.amr.corp.intel.com>
 <20160629191232.GA29990@beef>
 <309B89C4C689E141A5FF6A0C5FB2118B81F26C2D@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F27012@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Wednesday, June 29, 2016 1:06 PM
> To: Matt Porter <mporter@konsulko.com>
> Cc: Gangfeng <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org;
> Ruhao Gao <ruhao.gao@ni.com>
> Subject: RE: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX
> network flow classification
> 
> > From: Matt Porter [mailto:mporter at konsulko.com]
> > Sent: Wednesday, June 29, 2016 12:13 PM
> > To: Brown, Aaron F <aaron.f.brown@intel.com>
> > Cc: Gangfeng <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org;
> > Ruhao Gao <ruhao.gao@ni.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of
> RX
> > network flow classification
> >
> > On Mon, May 16, 2016 at 10:09:04PM +0000, Brown, Aaron F wrote:
> > > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> > On
> > > > Behalf Of Gangfeng
> > > > Sent: Monday, May 9, 2016 2:28 AM
> > > > To: intel-wired-lan at lists.osuosl.org
> > > > Cc: Gangfeng Huang <gangfeng.huang@ni.com>; Ruhao Gao
> > > > <ruhao.gao@ni.com>
> > > > Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX
> > > > network flow classification
> > > >
> > > > From: Gangfeng Huang <gangfeng.huang@ni.com>
> > > >
> > > > This patch is meant to allow for RX network flow classification to insert
> > > > and remove Rx filter by ethtool. Ethtool interface has it's own rules
> > > > manager
> > > >
> > > > Show all filters:
> > > > $ ethtool -n eth0
> > > > 4 RX rings available
> > > > Total 2 rules
> > > >
> > > > Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> > > > Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/igb/igb.h         |  32 +++++
> > > >  drivers/net/ethernet/intel/igb/igb_ethtool.c | 193
> > > > +++++++++++++++++++++++++++
> > > >  drivers/net/ethernet/intel/igb/igb_main.c    |  44 ++++++
> > > >  3 files changed, 269 insertions(+)
> > >
> > > This patch is causing 3/4 of my regression systems to fail.  Driver load
> > seems normal, but applying an IP address via ifconfig causes the following
> > splat in dmesg and /var/log/messages:
> >
> > Hi Aaron,
> >
> > I'm looking at this series on current net-next and am wondering if you
> > saw this issue with just patch 1 applied or you meant the entire series?
> 
> Hi Matt,
> 
> My recollection is that I saw it with just patch 1 applied.  And my procedure
> when I see an issue with a series is to try and isolate it to the individual patch
> and reply to the one in the series that triggers the issue, so I am pretty sure it
> was with this patch applied and the rest of the series not applied.

I was able to apply this (v5 1/4) patch to a recent version of Jeff's next-queue / dev-branch (with a little fuzz) and reproduce the problem on one of the systems that was previously triggering it without any difficulty.  It does occur with just this one patch applied.  This was with the system that has an i211 and a pair of 82580 ports.  I will still try to sort out if it happens with just i211 or the pair of 82580s (leaning towards the i211 as a system with a pair of 82580s and an i210 worked fine) but have been searching for another i211 as the system in question is at the bottom of a rack with a bunch of systems stacked on top of it, making the card cage rather difficult to get to.

> 
> >
> > I've been working with this on an i210 and haven't reproduced your
> > results yet either with just the (non-functional) first patch applied or
> > the entire series. However, I noticed you had no problems on your system
> > with an i210.
> 
> Correct, the system with an i210 included was one of the ones not affected
> by this.  I'm not sure if that is due to it not being a problem with the i210 or
> something more elusive like the system's chipset of a variation in the .config.
> 
> >
> > > ----------------------------------------------
> > > May 16 14:37:50 u1486 kernel: Hardware name: Supermicro A1SAi/A1SRi,
> > BIOS 1.0b 11/06/2013
> > > May 16 14:37:50 u1486 kernel: 0000000000000000 ffff880849ad3938
> > ffffffff813373d7 0000000000000007
> > > May 16 14:37:50 u1486 kernel: 0000000000000006 0000000000000000
> > ffff88085c2f6770 ffff880849ad3a58
> > > May 16 14:37:50 u1486 kernel: ffffffff810c4e13 ffff880849ad39f8
> > 0000000000000005 0000000000000000
> > > May 16 14:37:50 u1486 kernel: Call Trace:
> > > May 16 14:37:50 u1486 kernel: [<ffffffff813373d7>]
> dump_stack+0x6b/0xa4
> > > May 16 14:37:50 u1486 kernel: [<ffffffff810c4e13>]
> > register_lock_class+0x523/0x5c0
> > > May 16 14:37:50 u1486 kernel: [<ffffffff8136644b>] ?
> > check_preemption_disabled+0x1b/0x110
> > > May 16 14:37:50 u1486 kernel: [<ffffffff811f5655>] ? kfree+0x1a5/0x3a0
> > > May 16 14:37:50 u1486 kernel: [<ffffffff81366553>] ?
> > __this_cpu_preempt_check+0x13/0x20
> > > May 16 14:37:50 u1486 kernel: [<ffffffff810c7ae0>]
> > __lock_acquire+0x80/0x5d0
> > > May 16 14:37:50 u1486 kernel: [<ffffffff811f83f5>] ?
> > __kmalloc+0x265/0x3a0
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa051864f>] ? kzalloc+0xf/0x20
> [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffff810c80fa>]
> > lock_acquire+0xca/0x240
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa0520c3f>] ?
> > igb_configure+0xaf/0x1d0 [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffff815b958b>] ?
> > netdev_rss_key_fill+0x5b/0xa0
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa052dfb9>] ?
> > igb_vfta_set+0x189/0x1f0 [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffff816a8930>]
> > _raw_spin_lock+0x40/0x80
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa0520c3f>] ?
> > igb_configure+0xaf/0x1d0 [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa051bf62>] ?
> > igb_setup_rctl+0x22/0xb0 [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa0520c3f>]
> > igb_configure+0xaf/0x1d0 [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa052408d>]
> > __igb_open+0xfd/0x300 [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffff815ab260>] ?
> > call_netdevice_notifiers_info+0x40/0x70
> > > May 16 14:37:50 u1486 kernel: [<ffffffffa0524420>] igb_open+0x10/0x20
> > [igb]
> > > May 16 14:37:50 u1486 kernel: [<ffffffff815ac7f8>]
> > __dev_open+0xb8/0x110
> > > May 16 14:37:50 u1486 kernel: [<ffffffff815ac5fc>]
> > __dev_change_flags+0xac/0x180
> > > May 16 14:37:50 u1486 kernel: [<ffffffff815ac700>]
> > dev_change_flags+0x30/0x70
> > > May 16 14:37:50 u1486 kernel: [<ffffffff815c6685>] ?
> > lockdep_rtnl_is_held+0x15/0x20
> > > May 16 14:37:50 u1486 kernel: [<ffffffff816403a5>]
> > devinet_ioctl+0x5b5/0x620
> > > May 16 14:37:50 u1486 kernel: [<ffffffff81156660>] ?
> > trace_buffer_unlock_commit+0x60/0x80
> > > May 16 14:37:50 u1486 kernel: [<ffffffff81643033>] inet_ioctl+0x63/0x80
> > > May 16 14:37:50 u1486 kernel: [<ffffffff8158fd60>]
> > sock_do_ioctl+0x30/0x70
> > > May 16 14:37:50 u1486 kernel: [<ffffffff815901b3>]
> sock_ioctl+0x73/0x280
> > > May 16 14:37:50 u1486 kernel: [<ffffffff8121f678>] vfs_ioctl+0x18/0x30
> > > May 16 14:37:50 u1486 kernel: [<ffffffff81220057>]
> > do_vfs_ioctl+0x87/0x430
> > > May 16 14:37:50 u1486 kernel: [<ffffffff8100297e>] ?
> > syscall_trace_enter_phase2+0x6e/0x280
> > > May 16 14:37:50 u1486 kernel: [<ffffffff81220492>] SyS_ioctl+0x92/0xa0
> > > May 16 14:37:50 u1486 kernel: [<ffffffff81002fd3>]
> > do_syscall_64+0x63/0x130
> > > May 16 14:37:50 u1486 kernel: [<ffffffff8100201b>] ?
> > trace_hardirqs_on_thunk+0x1b/0x1d
> > > May 16 14:37:50 u1486 kernel: [<ffffffff816a981a>]
> > entry_SYSCALL64_slow_path+0x25/0x25
> > > ----------------------------------------------
> >
> > Since it's doing dump_stack in register_lock_class it appears some of
> > the error has been truncated before this stack trace. Can you confirm
> > that this is the complete output logged? By inspection, I would expect
> > to see one of the contextual messages from register_lock_class when it
> > calls dump_stack.
> 
> I will see if I still have a copy of, or can reproduce the trace along with more
> of the log messages leading up to it.

Yes, a tiny bit of more info before the trace.  I cleared the dmesg queue before running ifconfig and here is what I got, I also checked /var/log/messages and did not see any extra information there:
------------------------------------------------------------------------------------------------------------------------
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
dca service started, version 1.12.1
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
pps pps0: new PPS source ptp0
igb 0000:08:00.0: added PHC on eth1
igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:08:00.0: eth1: (PCIe:2.5Gb/s:Width x1) a0:36:9f:0c:76:de
igb 0000:08:00.0: eth1: PBA No: FFFFFF-0FF
igb 0000:08:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
igb 0000:09:00.0: added PHC on eth2
igb 0000:09:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:09:00.0: eth2: (PCIe:2.5Gb/s:Width x4) 00:1b:21:56:25:64
igb 0000:09:00.0: eth2: PBA No: Unknown
igb 0000:09:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
igb 0000:09:00.1: added PHC on eth3
igb 0000:09:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:09:00.1: eth3: (PCIe:2.5Gb/s:Width x4) 00:1b:21:56:25:65
igb 0000:09:00.1: eth3: PBA No: Unknown
igb 0000:09:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
BUG: spinlock bad magic on CPU#6, ifconfig/5569
 lock: 0xffff88007cbca080, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
CPU: 6 PID: 5569 Comm: ifconfig Not tainted 4.7.0-rc2_next_dev_rx_flow-00941-gb9e6e3f-dirty #2
Hardware name: Supermicro X7DBX/X7DBX, BIOS 2.1 06/23/2008
 0000000000000000 ffff880074393b08 ffffffff811e2937 0000000000000000
 ffffffff81717dbc ffff88007cbca080 0000000000000000 ffff880074393b28
 ffffffff81070724 ffff88007cbca080 ffff88007cbc8db0 ffff880074393b48
Call Trace:
 [<ffffffff811e2937>] dump_stack+0x53/0x74
 [<ffffffff81070724>] spin_dump+0x86/0x8b
 [<ffffffff8107074f>] spin_bug+0x26/0x28
 [<ffffffff810708d5>] do_raw_spin_lock+0x29/0x12c
 [<ffffffff811f55ad>] ? __do_once_done+0x71/0x78
 [<ffffffff814b488b>] _raw_spin_lock+0x1e/0x22
 [<ffffffffa00bd0d7>] igb_configure+0x2c8/0x3b1 [igb]
 [<ffffffffa00c0295>] __igb_open+0xb3/0x509 [igb]
 [<ffffffff81404799>] ? call_netdevice_notifiers_info+0x51/0x5a
 [<ffffffffa00c083c>] igb_open+0xb/0xd [igb]
 [<ffffffff81406542>] __dev_open+0xa7/0xf5
 [<ffffffff814063aa>] __dev_change_flags+0xb5/0x14d
 [<ffffffff81406465>] dev_change_flags+0x23/0x59
 [<ffffffff814b2b4f>] ? mutex_lock+0x27/0x38
[<ffffffff8145cc49>] devinet_ioctl+0x296/0x576
 [<ffffffff8145ecba>] inet_ioctl+0x92/0xaa
 [<ffffffff813f1566>] sock_ioctl+0x204/0x229
 [<ffffffff811092cf>] vfs_ioctl+0x13/0x23
 [<ffffffff811099e2>] do_vfs_ioctl+0x5e8/0x621
 [<ffffffff811fe00c>] ? __percpu_counter_add+0x8c/0xa8
 [<ffffffff810dfca7>] ? do_munmap+0x2e7/0x301
 [<ffffffff81109a5e>] SyS_ioctl+0x43/0x62
 [<ffffffff814b499b>] entry_SYSCALL_64_fastpath+0x13/0x8f
IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
igb 0000:08:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
------------------------------------------------------------------------------------------------------------------------
> 
> >
> > Also, any chance of seeing a .config for this run or a freshly
> > reproduced run?

Sure, I've attached the current .config from the system that I just reproduced it on.  I know we should not use attachments on the lists, but a .config file is rather long for pasting into a message.  If it gets stripped let me know and I'll figure out how to get it to you.

> > By inspection at least there's no obvious locking or
> > otherwise issues in the open path (only *filter_restore() is executed on
> > open and it's a mostly a NOP if this is just patch 1 applied) so I think
> > we need some more detailed output since you have the only system that
> > seems
> > to produce this issue.
> 
> I can certainly get you a copy of the .config file on the affected systems,
> however, they will have changed some as the kernel gets updated frequently
> for tests, along with a make oldconfig pushing occasional changes in.
> Assuming I can re-apply the patch to the current tree I'll try and reproduce
> the issue and get you copies of a .config known to be current when the issue
> strikes.
> 
> >
> > Any other details you can provide would be appreciated. I'm happy to dig
> > into the root cause.
> 
> Only thing that immediately comes to mind is that my test systems all have
> multiple ports to minimize the lab space needed to get a sampling of the
> different parts.  I will see if I can reproduce the issue in a system with a single
> port.  If I remember correctly, it was a consistent issue, always appearing
> relatively quickly on the affected systems.
> 
> >
> > Thanks,
> > Matt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ifconfig-up-bug-dotconfig
Type: application/octet-stream
Size: 78378 bytes
Desc: ifconfig-up-bug-dotconfig
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160630/eccc7c8c/attachment-0001.obj>
