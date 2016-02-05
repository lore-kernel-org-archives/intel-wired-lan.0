From: Legacy, Allain <Allain.Legacy@windriver.com>
Date: Fri, 5 Feb 2016 21:47:05 +0000
Subject: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
 sending TX pause frames?
In-Reply-To: <F6FB0E698C9B3143BDF729DF2228664691E71713@ORSMSX116.amr.corp.intel.com>
References: <56AA60A1.7060408@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
 <56AF744B.1000403@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E71472@ORSMSX116.amr.corp.intel.com>
 <56AFF0BB.1030309@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E71713@ORSMSX116.amr.corp.intel.com>
Message-ID: <70A7408C6E1BFB41B192A929744D85235911689A@ALA-MBB.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Don,
Any thoughts on this issue after taking a look at the registers?   We have had several new occurrences of this issue this week and still have not been able to determine a root cause.  We are going to ramp up our efforts next week and try to find a way to reproduce this more readily.  

Some more observations about the stats... when the adapter is in this state we notice that "rx_bytes_nic" is incrementing, but not "rx_pkts_nic" nor "rx_packets".   We also noticed that "non_eop_descs" is 1 while "rx_missed_errors" is also incrementing along with "tx_flow_control_xoff".    See below:

     rx_packets: 73
     tx_packets: 27336
     rx_bytes: 37498
     tx_bytes: 15286476
     rx_pkts_nic: 953
     tx_pkts_nic: 27336
     rx_bytes_nic: 20138615
     tx_bytes_nic: 15520958
     lsc_int: 2
     tx_busy: 0
     non_eop_descs: 1
     rx_errors: 0
     tx_errors: 0
     rx_dropped: 0
     tx_dropped: 0
     multicast: 44544
     broadcast: 1266
     rx_no_buffer_count: 0
     collisions: 0
     rx_over_errors: 0
     rx_crc_errors: 0
     rx_frame_errors: 0
     hw_rsc_aggregated: 0
     hw_rsc_flushed: 0
     fdir_match: 0
     fdir_miss: 102
     fdir_overflow: 0
     rx_fifo_errors: 0
     rx_missed_errors: 47863
     tx_aborted_errors: 0
     tx_carrier_errors: 0
     tx_fifo_errors: 0
     tx_heartbeat_errors: 0
     tx_timeout_count: 0
     tx_restart_queue: 0
     rx_long_length_errors: 0
     rx_short_length_errors: 0
     tx_flow_control_xon: 0
     rx_flow_control_xon: 0
     tx_flow_control_xoff: 1005561
     rx_flow_control_xoff: 0
     rx_csum_offload_errors: 0
     alloc_rx_page_failed: 0


Also, I am not sure if this is related or not but looking back through our support case history we had a kernel panic (oops is at the end of this message) issue in what relates to the RSC code.    Based on the debug notes it looks like we were seeing kernel panics in ixgbe_is_non_eop() in the last few lines before the end of the function because the "ntc" variable was completely random and was out of bounds for the array indexing at this line:

        rx_ring->rx_buffer_info[ntc].skb = skb;


The reason I bring this up is because I noticed the "non_eop_descs" stat being pegged as well as the timing of the kernel panic happening was similar to this issue.  That is, it happened shortly after enabling the adapter which you mentioned has been problematic in the past.   You mentioned that an issue was fixed in 3.10.   We were not able to find the root cause of that issue so we disabled LRO and checked the "ntc" value before using it to avoid the kernel panic.  Now we are wondering if maybe the kernel panic was another sign that the adapter was in a bad state and by avoiding the kernel panic we simply allowed the system to stay up so that we now suffer from the adapter not being able to receive any packets. 

Is there a kernel compile option to disable the flow director?  Is this that it can be disabled with ethtool, but can we disable it at compile time to ensure that it is disabled before the adapter is enabled for the first time?

Regards,
Allain
?

Oops: 0000 [#2] PREEMPT SMP ^M 
 Modules linked in: bonding virtio_net ebtable_filter ebtables ipmi_devintf ipmi_si ipmi_msghandler nfsd drbd lru_cache iptable_filter ip_tables ip6table_filter ip6_tables x_tables hpilo mlx4_en(O) mlx4_ib(O) mlx4_core(O) rdma_ucm(O) ib_ucm(O) ib_uverbs(O) rdma_cm(O) iw_cm(O) ib_cm(O) ib_sa(O) ib_mad(O) ib_core(O) ib_addr(O) compat(O) coretemp kvm_intel kvm crct10dif_pclmul crct10dif_common aesni_intel iTCO_wdt aes_x86_64 iTCO_vendor_support glue_helper lrw gf128mul ablk_helper cryptd mperf lpc_ich ixgbe igb processor hwmon mdio^M 
 CPU: 20 PID: 9381 Comm: irq/285-eth7-Tx Tainted: G D O 3.10.87-ovp-rt93-r9_preempt-rt #1^M 
 Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.05.0004.051120151007 05/11/2015^M 
 task: ffff8807da4d4860 ti: ffff8807eebf2000 task.ti: ffff8807eebf2000^M 
 RIP: 0010:[<ffffffff810654a1>] [<ffffffff810654a1>] kthread_data+0x11/0x20^M 
 RSP: 0018:ffff8807eebf3988 EFLAGS: 00010002^M 
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000000c^M 
 RDX: ffff8807eebf3e90 RSI: 0000000000000435 RDI: ffff8807da4d4860^M 
 RBP: ffff8807eebf39a8 R08: 00000000000008e3 R09: ffffffff810c522f^M 
 R10: 0000000000000000 R11: 0000000000000003 R12: ffff8807da4d4860^M 
 R13: ffff8807da4d4f00 R14: ffff8807da4d4860 R15: ffff8807da4d4860^M 
 FS: 0000000000000000(0000) GS:ffff88081ef40000(0000) knlGS:0000000000000000^M 
 CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M 
 CR2: ffffffffffffffd8 CR3: 0000000001e0f000 CR4: 00000000001407e0^M 
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M 
 DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400^M 
 Stack:^M 
  ffffffff810cb8f9 0000000000000000 0000000000000000 ffffffff82080600^M 
  ffff8807eebf39d8 ffffffff81061e54 0000000000000001 0000000000000000^M 
  ffffc900216a07c0 ffff8807da4d4860 ffff8807eebf3a50 ffffffff8104421f^M 
 Call Trace:^M 
  [<ffffffff810cb8f9>] ? irq_thread_dtor+0x29/0xc0^M 
  [<ffffffff81061e54>] task_work_run+0xb4/0xe0^M 
  [<ffffffff8104421f>] do_exit+0x2df/0xb00^M 
  [<ffffffff818ee5fe>] ? printk+0x54/0x56^M 
  [<ffffffff81041821>] ? kmsg_dump+0xc1/0xd0^M 
  [<ffffffff81006045>] oops_end+0x75/0xa0^M 
  [<ffffffff818ee011>] no_context+0x281/0x28f^M 
  [<ffffffff818ee09f>] __bad_area_nosemaphore+0x80/0x1d6^M 
  [<ffffffff8107f0eb>] ? find_busiest_group+0x12b/0xa40^M 
  [<ffffffff818ee208>] bad_area_nosemaphore+0x13/0x15^M 
  [<ffffffff8103295a>] __do_page_fault+0xea/0x510^M 
  [<ffffffff81032dbe>] do_page_fault+0xe/0x10^M 
  [<ffffffff818faef2>] page_fault+0x22/0x30^M 
  [<ffffffffa02f88c0>] ? ixgbe_poll+0xec0/0x10b0 [ixgbe]^M 
  [<ffffffffa02f8a9b>] ? ixgbe_poll+0x109b/0x10b0 [ixgbe]^M 
  [<ffffffff817c2158>] net_rx_action+0x118/0x240^M 
  [<ffffffff81046d06>] do_current_softirqs+0x1a6/0x360^M 
  [<ffffffff810cb630>] ? irq_thread_fn+0x50/0x50^M 
  [<ffffffff81046f26>] local_bh_enable+0x66/0x80^M 
  [<ffffffff810cb66b>] irq_forced_thread_fn+0x3b/0x70^M 
  [<ffffffff810cb88f>] irq_thread+0x10f/0x150^M 
  [<ffffffff810cb8d0>] ? irq_thread+0x150/0x150^M 
  [<ffffffff810cb780>] ? wake_threads_waitq+0x40/0x40^M 
  [<ffffffff81065182>] kthread+0xb2/0xc0^M 
  [<ffffffff810650d0>] ? kthread_worker_fn+0x1b0/0x1b0^M 
  [<ffffffff818fb638>] ret_from_fork+0x58/0x90^M 
  [<ffffffff810650d0>] ? kthread_worker_fn+0x1b0/0x1b0^M 
 Code: 48 89 e5 5d 48 8b 40 c8 48 c1 e8 02 83 e0 01 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 c8 03 00 00 55 48 89 e5 5d <48> 8b 40 d8 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 ^M 
 RIP [<ffffffff810654a1>] kthread_data+0x11/0x20^M 
  RSP <ffff8807eebf3988>^M 
 CR2: ffffffffffffffd8^M 
 ---[ end trace 0000000000000003 ]---^M




> -----Original Message-----
> From: Skidmore, Donald C [mailto:donald.c.skidmore at intel.com]
> Sent: Monday, February 01, 2016 10:01 PM
> To: Friesen, Chris; intel-wired-lan at lists.osuosl.org; Legacy, Allain
> Subject: RE: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
> sending TX pause frames?
> 
> Hey Chris,
> 
> A colleague of mind reminded me of an issue we had years ago with a similar
> failure symptoms.  It had to do with an erratum related to receiving an Rx
> packet at the wrong time while we were initializing the flow director table.
> The driver in the 3.10 kernel, even though old should have had this fix.  But I
> am wondering if you could seeing if you could recreate the problem with
> flow director disabled?
> 
> One other quick question.  Since the switch isn't honoring the pause frames
> can I assume you enabled TxFC on the adapter manually?
> 
> Also I'll take a look at the registers to see if anything jumps out at me.
> 
> Thanks,
> -Don
> 
> > -----Original Message-----
> > From: Chris Friesen [mailto:chris.friesen at windriver.com]
> > Sent: Monday, February 01, 2016 3:57 PM
> > To: Skidmore, Donald C; intel-wired-lan at lists.osuosl.org; Legacy,
> > Allain (Wind River)
> > Subject: Re: [Intel-wired-lan] anyone aware of problem with 82599ES
> > stuck sending TX pause frames?
> >
> > On 02/01/2016 11:54 AM, Skidmore, Donald C wrote:
> > > Hey Chris,
> > >
> > > Like I mentioned earlier the only issue I was aware of anything
> > > close to this
> > was root caused to switch capability.  If you are seeing the same
> > behavior across multiple switch that pretty much rules that out.
> > Since you don't see anything in the system log we may need to get a
> > register dump (with something like ethregs) both before the failure
> > occurs and while in the error state.  This is assuming once the system
> enters the error state it remains
> > indefinitely.   Couple other things I'm wondering:
> > >
> > > - Is traffic being received/transmit while in the error state and if
> > > so how
> > much?
> > > - does a reset correct the problem or do you have to do something
> > > more
> > aggressive (i.e. reload the driver, cycle power)?
> > > - Anything else that might have been occurring around the time the
> > > system
> > enters the error state.
> >
> > Adding my coworker to the receiver list so he can chime in directly.
> >
> > The device does report a small number of received packets before it locks
> up.
> > Once it gets into the bad state the rx missed packet count increases
> > but no packets appear to be processed by the driver.
> >
> > The neighbouring switch does not have flow control enabled at all, and
> > it is ignoring the XOFF packets coming from the device and continuing
> > to send packets towards the device. The device is dropping those
> > packets. When we disable the switch port (and drop carrier) the device
> > does not exit the error state, when we re-enable the switch port the
> > device still does not exit the error state. The issue was resolved by
> > resetting the device via ifdown/ifup.
> >
> > We don't have ethregs installed, but I've included below an ethtool
> > dump from a device in the "stuck" state, followed by an ethtool
> > register-only dump from the same device during "normal" operation.
> >
> > Thanks,
> > Chris
> >
> 

