From: Vasil Kolev <vk@storpool.com>
Date: Thu, 19 Jul 2018 15:39:17 +0300
Subject: [Intel-wired-lan] Crash in ixgbe with VFs and flow director on
 interface flap
Message-ID: <20180719153917.699af02a@nymphadora.home.ludost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

We're seeing a kernel crash which seems to be present up to the latest
upstream release of ixgbe.

Short description:

- create one VF
- enable ntuples with ethtool
- direct some traffic to the VF (as described in
  http://dpdk.org/doc/guides/howto/flow_bifurcation.html)
- have some traffic running back and forth;
- trigger with flapping the link of the interface


The issue seems to be in ixgbe_fdir_filter_restore(), as there
adapter->rx_ring[filter->action]->reg_idx gets dereferenced, but
filter->action is outside of the rx_ring array, as it has a VF
identifier in the upper 32 bits.

One guess is that something like the code in
ixgbe_add_ethtool_fdir_entry() would suffice to fix the issue. 

Here is an example crash:

[54077.799180] ixgbe 0000:03:00.0 sp0: SR-IOV enabled with 2 VFs
[54077.799468] ixgbe 0000:03:00.0: removed PHC on sp0
[54077.883648] ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count = 4, Tx Queue count = 4 XDP Queue count = 0
[54077.906268] ixgbe 0000:03:00.0: registered PHC device on sp0
[54078.085166] ixgbe 0000:03:00.0 sp0: detected SFP+: 3
[54078.123127] pci 0000:04:10.0: [8086:10ed] type 00 class 0x020000
[54078.130007] pci 0000:04:10.2: [8086:10ed] type 00 class 0x020000
[54078.746825] ixgbe 0000:03:00.0 sp0: NIC Link is Up 10 Gbps, Flow Control: RX
[54409.698093] ixgbe 0000:03:00.0 sp0: detected SFP+: 3
[54410.462019] ixgbe 0000:03:00.0 sp0: NIC Link is Up 10 Gbps, Flow Control: RX
[54532.583590] ixgbe 0000:03:00.0 sp0: NIC Link is Down
[54538.151833] ixgbe 0000:03:00.0 sp0: NIC Link is Up 10 Gbps, Flow Control: RX
[55027.919623] ixgbe 0000:03:00.0 sp0: NIC Link is Down
[55027.919717] ixgbe 0000:03:00.0 sp0: initiating reset to clear Tx work after link loss
[55028.710958] ixgbe 0000:03:00.0 sp0: Reset adapter
[55030.954213] BUG: unable to handle kernel paging request at ffff9bd7a1e00f20
[55030.954253] IP: ixgbe_configure+0x895/0xd00 [ixgbe]
[55030.954271] PGD 1c1f3f067 P4D 1c1f3f067 PUD 0 
[55030.954291] Oops: 0000 [#1] SMP PTI
[55030.954305] Modules linked in: ixgbe 8021q garp mrp stp llc ipmi_ssif ipmi_si kvm_intel joydev kvm irqbypass input_leds ipmi_devintf ipmi_msghandler acpi_pad sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc ast ttm aesni_intel drm_kms_helper ahci syscopyarea aes_x86_64 sysfillrect crypto_simd sysimgblt glue_helper fb_sys_fops cryptd drm libahci igb dca i2c_algo_bit ptp mdio pps_core video [last unloaded: ixgbe]
[55030.954551] CPU: 1 PID: 30265 Comm: kworker/u8:1 Not tainted 4.15.0-23-generic #25-Ubuntu
[55030.954579] Hardware name: Supermicro SYS-5038ML-H8TRF/X10SLD, BIOS 2.00 04/24/2014
[55030.954615] Workqueue: ixgbe ixgbe_service_task [ixgbe]
[55030.954639] RIP: 0010:ixgbe_configure+0x895/0xd00 [ixgbe]
[55030.954659] RSP: 0018:ffffb8ba01da7dc8 EFLAGS: 00010216
[55030.954679] RAX: 0000000100000001 RBX: ffff9bcfa1e008c0 RCX: 000000000000007f
[55030.954704] RDX: ffffb8ba02680000 RSI: ffff9bcfabb862a0 RDI: ffff9bcfa1e01900
[55030.954729] RBP: ffffb8ba01da7de8 R08: 0000320ce47a1400 R09: 0000000000000000
[55030.954755] R10: 0000000000000000 R11: 0000000000001e8d R12: ffff9bcfa1e01900
[55030.954780] R13: 0000000000000000 R14: ffff9bcfa1e02788 R15: ffff9bcfa1e02720
[55030.954805] FS:  0000000000000000(0000) GS:ffff9bcfdfc80000(0000) knlGS:0000000000000000
[55030.954834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[55030.954855] CR2: ffff9bd7a1e00f20 CR3: 00000001c180a006 CR4: 00000000001606e0
[55030.954880] Call Trace:
[55030.954899]  ixgbe_reinit_locked+0xa9/0xe0 [ixgbe]
[55030.954930]  ixgbe_service_task+0xbc/0x1310 [ixgbe]
[55030.954952]  process_one_work+0x1de/0x410
[55030.954968]  worker_thread+0x32/0x410
[55030.954984]  kthread+0x121/0x140
[55030.954997]  ? process_one_work+0x410/0x410
[55030.955015]  ? kthread_create_worker_on_cpu+0x70/0x70
[55030.955036]  ret_from_fork+0x35/0x40
[55030.955050] Code: 80 1e 00 00 48 85 c0 0f 85 37 04 00 00 48 8b b3 80 1e 00 00 48 85 f6 74 36 48 8b 46 40 4c 8b 2e b9 7f 00 00 00 48 83 f8 7f 74 0c <48> 8b 84 c3 58 06 00 00 0f b6 48 5f 0f b7 56 3c 4c 89 e7 48 83 
[55030.955146] RIP: ixgbe_configure+0x895/0xd00 [ixgbe] RSP: ffffb8ba01da7dc8
[55030.955980] CR2: ffff9bd7a1e00f20


And the position in ixgbe_configure(), which is in the inlined
ixgbe_fdir_filter_restore():


crash> info line *(ixgbe_configure+0x895)
Line 5259 of
"/build/linux-uT8zSN/linux-4.15.0/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c"
starts at address 0xffffffffc09b9b35 <ixgbe_configure+2197> and ends at
0xffffffffc09b9b3d <ixgbe_configure+2205>.


which looks like this:

 5245 static void ixgbe_fdir_filter_restore(struct ixgbe_adapter *adapter)
 5246 {
 5247         struct ixgbe_hw *hw = &adapter->hw;
 5248         struct hlist_node *node2;
 5249         struct ixgbe_fdir_filter *filter;
 5250 
 5251         spin_lock(&adapter->fdir_perfect_lock);
 5252 
 5253         if (!hlist_empty(&adapter->fdir_filter_list))
 5254                 ixgbe_fdir_set_input_mask_82599(hw, &adapter->fdir_mask);
 5255 
 5256         hlist_for_each_entry_safe(filter, node2,
 5257                                   &adapter->fdir_filter_list, fdir_node) {
 5258                 ixgbe_fdir_write_perfect_filter_82599(hw,
 5259                                 &filter->filter,
 5260                                 filter->sw_idx,
 5261                                 (filter->action == IXGBE_FDIR_DROP_QUEUE) ?
 5262                                 IXGBE_FDIR_DROP_QUEUE :
 5263                                 adapter->rx_ring[filter->action]->reg_idx);
 5264         }
 5265 
 5266         spin_unlock(&adapter->fdir_perfect_lock);
 5267 }


-- 
Vasil Kolev
Debugger
StorPool
skype: vasil_kolev
