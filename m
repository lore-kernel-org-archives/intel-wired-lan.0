From: Jin, Michael <michael.jin@intel.com>
Date: Tue, 8 May 2018 14:06:37 +0000
Subject: [Intel-wired-lan] [RFC PATCH] ixgbevf: NULL pointer dereference
 with ixgbevf-4.3.5
Message-ID: <3D4403E82C837A468A5FE1A42FAEDB7E85A49E67@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi All,
?
Recently, we met a NULL pointer dereference issue with ixgbevf-4.3.5 on Docker application, and the issue occurred when running the following test script for many times. Below is the main dmesg dump for the issue. Sometimes, it is triggered soon, and sometimes it will take much long time. From the call trace dump below, rx_ring->rx_buffer_info is dereferenced with NULL pointer.

We find that the bit __IXGBEVF_RESET_REQUESTED is set when the issue occurs. Specifically, we observe the bit __IXGBEVF_RESET_REQUESTED is set in the path ixgbevf_watchdog_subtask()-->ixgbevf_watchdog_update_link(), which means it returns error when checking VF link. We did also see the mailbox timeout message. 

Hence we suspect that there might be the following race condition in ixgbevf driver code.

When the VF interface is closed by the cmd "ip link set <dev>down", it will call ixgbevf_close() -> ixgbevf_down(), and __IXGBEVF_DOWN will be set and rx_ring->rx_buffer_info will be freed in the end.
Assuming, *Simultaneously*, before the __IXGBEVF_DOWN bit is set in the device close path, the ixgbevf_reset_subtask() has been scheduled to run and it will sleep on rtnl_lock() ahead of ixgbevf_reinit_locked() because rtnl_lock is being hold by the device close path now, then the device close path continues to run to the end, which leads to the free of rx_ring->rx_buffer_info and rtnl_lock being released also, then the ixgbevf_reset_subtask() wakes up and gets the rtnl_lock to resume running, finally it will call ixgbevf_up() and triggers the NULL pointer dereference of rx_ring->rx_buffer_info.
?
With the following patch, no issue triggered with more than 24 hours test.  
I talked with ixgbe maintainer Emil, and he also agreed that there might be some issue here and suggested posting the patch here for the review first. 
Any suggestions are highly appreciated! 

diff --git a/src/ixgbevf_main.c b/src/ixgbevf_main.c
index 6a3720f..6b9a6c2 100644
--- a/src/ixgbevf_main.c
+++ b/src/ixgbevf_main.c
@@ -3264,15 +3264,18 @@ static void ixgbevf_reset_subtask(struct ixgbevf_adapter *adapter)
????????????? if (!test_and_clear_bit(__IXGBEVF_RESET_REQUESTED, &adapter->state))
???????????????????????????? return;
?
+???????????? rtnl_lock();
+
????????????? /* If we're already down or resetting, just bail */
????????????? if (test_bit(__IXGBEVF_DOWN, &adapter->state) ||
????????????? ????test_bit(__IXGBEVF_REMOVING, &adapter->state) ||
-????????????? ??? test_bit(__IXGBEVF_RESETTING, &adapter->state))
+???????????? ??? test_bit(__IXGBEVF_RESETTING, &adapter->state)) {
+??????????????????????????? rtnl_unlock();
???????????????????????????? return;
+???????????? }
?
?????????????? adapter->tx_timeout_count++;
?
-????????????? rtnl_lock();
????????????? ixgbevf_reinit_locked(adapter);
????????????? rtnl_unlock();
?
?
[Dmesg]
[20319807.586045] ixgbe 0000:06:00.1 eth1: NIC Link is Down
[20319807.586210] ixgbe 0000:06:00.1 eth1: initiating reset due to lost link with pending Tx work
[20319807.586309] br3: port 1(eth1.3) entered disabled state
[20319808.812588] ixgbe 0000:06:00.1 eth1: Reset adapter
[20319811.436790] ixgbe 0000:06:00.1 eth1: MNG_VETO bit detected.
[20319812.145398] ixgbe 0000:06:00.1 eth1: NIC Link is Up 10 Gbps, Flow Control: None
[20319812.145611] br3: port 1(eth1.3) entered forwarding state
[20319812.145614] br3: port 1(eth1.3) entered forwarding state
[20319812.175264] ixgbe 0000:06:00.1 eth1: NIC Link is Down
[20319812.379548] ixgbe 0000:06:00.1 eth1: NIC Link is Up 10 Gbps, Flow Control: None
[20319827.183400] br3: port 1(eth1.3) entered forwarding state
[22033255.541345] patch_make_funcs_list addr is 0xffffffffa02d5680
[22033255.541351] kpatch funcs_nr = 0x1
[22033255.541352] p_func name: kmem_alloc, objname: xfs
[22033255.541353] new_addr: ffffffffa02d5920, new_size: 112, old_addr: 0, old_size: eb
[22033255.541356] p_dynrela name: current_task, objname: xfs
[22033255.541357] dest: ffffffffa02d5956, src: 0, type: b, external: 1, addend: 0
[22033255.541358] p_dynrela name: __kmalloc, objname: xfs
[22033255.541359] dest: ffffffffa02d5987, src: 0, type: 2, external: 1, addend: -4
[22033255.541360] p_dynrela name: congestion_wait, objname: xfs
[22033255.541361] dest: ffffffffa02d59bb, src: 0, type: 2, external: 1, addend: -4
[22033255.541362] p_dynrela name: __vmalloc, objname: xfs
[22033255.541363] dest: ffffffffa02d59d9, src: 0, type: 2, external: 1, addend: -4
[22033255.541364] p_dynrela name: xfs_err, objname: xfs
[22033255.541365] dest: ffffffffa02d5a20, src: 0, type: 2, external: 0, addend: -4
[22033255.541366] p_dynrela name: dump_stack, objname: xfs
[22033255.541367] dest: ffffffffa02d5a25, src: 0, type: 2, external: 1, addend: -4
[22033255.631344] patching module 'xfs'
[22033255.633228] loaded patch module 'tpatch_0019_xfs_replace_kmalloc_with_vmalloc_0041'
[22916478.873328] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[22916478.893713] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[22916478.908107] ixgbe 0000:06:00.1: setting MAC 14:05:0a:3c:1a:7b on VF 0
[22916478.908110] ixgbe 0000:06:00.1: Reload the VF driver to make this change effective.
[22916478.908216] ixgbe 0000:06:00.1: Setting VLAN 3, QOS 0x0 on VF 0
[22916478.990598] ixgbevf: dev15: ixgbevf_configure_tx_ring: Could not enable Tx Queue 0
[22916479.070661] ixgbevf: dev15: ixgbevf_configure_tx_ring: Could not enable Tx Queue 1
[22916479.075329] ixgbe 0000:06:00.1 eth1: Failed to obtain mailbox lock for VF0
[22916480.070836] ixgbevf 0000:06:10.1 dev15: Polling for VF0 mailbox ack timedout
[22916480.073371] IPv6: ADDRCONF(NETDEV_UP): dev15: link is not ready
[22916480.073373] 8021q: adding VLAN 0 to HW filter on device dev15
[22916480.073876] VF could not set VLAN 0
[22916480.155570] ixgbe 0000:06:00.1 eth1: VF Reset msg received from vf 0
[22916480.403044] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[22916480.403047] 8021q: adding VLAN 0 to HW filter on device eth1
[22916480.403558] ixgbe 0000:06:00.1 eth1: VF 0 attempted to override administratively set VLAN configuration.Reload the VF driver to resume operations
[22916480.404048] VF could not set VLAN 0
[22916480.487831] ixgbe 0000:06:00.1 eth1: VF Reset msg received from vf 0
[22916480.525090] ixgbevf 0000:06:10.1: NIC Link is Up 10 Gbps
[22916480.525121] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[22916481.120212] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[22916481.164557] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[22916483.261231] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[22916484.285297] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[22916487.477212] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[22916487.501250] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[24644083.539531] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[24644083.559059] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[24644083.573529] ixgbe 0000:06:00.1: setting MAC 14:05:0a:3c:1a:7c on VF 1
[24644083.573532] ixgbe 0000:06:00.1: Reload the VF driver to make this change effective.
[24644083.573555] ixgbe 0000:06:00.1: Setting VLAN 3, QOS 0x0 on VF 1
[24644083.652390] ixgbevf: eth3: ixgbevf_configure_tx_ring: Could not enable Tx Queue 0
[24644083.732453] ixgbevf: eth3: ixgbevf_configure_tx_ring: Could not enable Tx Queue 1
[24644083.739700] ixgbe 0000:06:00.1 eth1: Failed to obtain mailbox lock for VF1
[24644083.743212] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[24644083.743214] 8021q: adding VLAN 0 to HW filter on device eth3
[24644084.736722] ixgbevf 0000:06:10.3 eth3: Polling for VF0 mailbox ack timedout
[24644084.736729] VF could not set VLAN 0
[24644084.817355] ixgbe 0000:06:00.1 eth1: VF Reset msg received from vf 1
[24644084.854580] ixgbevf 0000:06:10.3: NIC Link is Up 10 Gbps
[24644084.933449] ixgbe 0000:06:00.1 eth1: VF Reset msg received from vf 1
[24644085.165845] ixgbevf 0000:06:10.3: NIC Link is Up 10 Gbps
[24644085.169838] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[24644085.169842] 8021q: adding VLAN 0 to HW filter on device eth1
[24644085.170355] ixgbe 0000:06:00.1 eth1: VF 1 attempted to override administratively set VLAN configuration.Reload the VF driver to resume operations
[24644085.170843] VF could not set VLAN 0
[24644085.170865] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[24644086.179500] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[24644086.198607] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[24644086.213736] ixgbe 0000:06:00.1: setting MAC 14:05:0a:3c:1a:7d on VF 2
[24644086.213739] ixgbe 0000:06:00.1: Reload the VF driver to make this change effective.
[24644086.213763] ixgbe 0000:06:00.1: Setting VLAN 3, QOS 0x0 on VF 2
[24644086.252615] EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[24644086.277719] EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: discard,nodiscard
[24644086.295186] ixgbevf: eth4: ixgbevf_configure_tx_ring: Could not enable Tx Queue 0
[24644086.375248] ixgbevf: eth4: ixgbevf_configure_tx_ring: Could not enable Tx Queue 1
[24644087.373883] ixgbevf 0000:06:10.5 eth4: Polling for VF0 mailbox ack timedout
[24644087.378939] IPv6: ADDRCONF(NETDEV_UP): eth4: link is not ready
[24644087.378942] 8021q: adding VLAN 0 to HW filter on device eth4
[24644087.378948] ixgbe 0000:06:00.1 eth1: Failed to obtain mailbox lock for VF2
[24644087.379943] VF could not set VLAN 0
[24644087.463497] ixgbe 0000:06:00.1 eth1: VF Reset msg received from vf 2
[24644087.570082] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[24644087.667669] IP: [<ffffffffa025e248>] ixgbevf_alloc_rx_buffers+0x68/0x1c0 [ixgbevf]
[24644087.762074] PGD 0 
[24644087.789551] Oops: 0000 [#1] SMP 
[24644087.831707] Modules linked in: tpatch_0019_xfs_replace_kmalloc_with_vmalloc_0041(O)(kaixuxia) tpatch_0012_Fix_waiting_for_lo_to_become_free_0041(O)(t_zhipingdu) sunrpc xt_multiport fuse tpatch ixgbevf dm_thin_pool dm_bio_prison dm_persistent_data dm_bufio tcp_diag inet_diag iptable_filter ip_tables binfmt_misc xfs dm_mirror dm_region_hash dm_log ipip ip_tunnel tunnel4 acpi_cpufreq mperf crc32_pclmul crc32c_intel aesni_intel ablk_helper cryptd lrw gf128mul glue_helper shpchp ixgbe ptp pps_core acpi_pad
[24644088.372528] CPU: 0 PID: 39057 Comm: kworker/0:1 Tainted: G     U     O 3.10.104-1-0041.tl1 #1
[24644088.486603] Hardware name: INSPUR SA5112M4/Shuyu, BIOS 4.0.7 11/06/2015
[24644088.569145] Workqueue: events ixgbevf_service_task [ixgbevf]
[24644088.640334] task: ffff880fe5c4e400 ti: ffff88100f60e000 task.ti: ffff88100f60e000
[24644088.733597] RIP: 0010:[<ffffffffa025e248>]  [<ffffffffa025e248>] ixgbevf_alloc_rx_buffers+0x68/0x1c0 [ixgbevf]
[24644088.857141] RSP: 0018:ffff88100f60fc68  EFLAGS: 00010287
[24644088.924069] RAX: 0000000000000200 RBX: 0000000000000000 RCX: 0000000000000200
[24644089.013164] RDX: 0000000000000000 RSI: 00000000000001ff RDI: ffff880fba4331c0
[24644089.102259] RBP: ffff88100f60fca8 R08: ffff88100f60e010 R09: 0000000000000000
[24644089.191357] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[24644089.280453] R13: ffff880fba4331c0 R14: 00000000000001ff R15: 00000000fffffe00
[24644089.369548] FS:  0000000000000000(0000) GS:ffff88103fc00000(0000) knlGS:0000000000000000
[24644089.470093] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24644089.542224] CR2: 0000000000000008 CR3: 0000000001f21000 CR4: 00000000001407f0
[24644089.631321] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[24644089.720415] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[24644089.809510] Stack:
[24644089.836885]  0000000000000000 ffff880fdd2f9ac0 ffff88100f60fc88 ffff880fba4331c0
[24644089.929417]  ffff880fdd2f97c0 0000000000000009 ffff880fdd2f9ac0 0000000000001028
[24644090.021946]  ffff88100f60fd08 ffffffffa025e5bf ffff880f00000000 ffff881000000000
[24644090.114478] Call Trace:
[24644090.147063]  [<ffffffffa025e5bf>] ixgbevf_configure_rx_ring+0x21f/0x260 [ixgbevf]
[24644090.240320]  [<ffffffffa025e6a7>] ixgbevf_configure_rx+0xa7/0x1d0 [ixgbevf]
[24644090.327337]  [<ffffffffa025e91b>] ixgbevf_configure+0x14b/0x180 [ixgbevf]
[24644090.411952]  [<ffffffffa025e966>] ixgbevf_up+0x16/0x30 [ixgbevf]
[24644090.487207]  [<ffffffffa025ea27>] ixgbevf_reinit_locked+0x67/0x90 [ixgbevf]
[24644090.574218]  [<ffffffffa025f074>] ixgbevf_service_task+0x154/0x1a0 [ixgbevf]
[24644090.662275]  [<ffffffff81065bcd>] process_one_work+0x17d/0x4c0
[24644090.735445]  [<ffffffff810670cf>] worker_thread+0x11f/0x3a0
[24644090.805494]  [<ffffffff81066fb0>] ? manage_workers+0x120/0x120
[24644090.878666]  [<ffffffff8106cc6e>] kthread+0xce/0xe0
[24644090.940388]  [<ffffffff8106cba0>] ? kthread_freezable_should_stop+0x70/0x70
[24644091.027404]  [<ffffffff81ac72b8>] ret_from_fork+0x58/0x90
[24644091.095366]  [<ffffffff8106cba0>] ? kthread_freezable_should_stop+0x70/0x70
[24644091.182383] Code: 00 00 00 45 0f b7 ff 44 89 f8 48 8d 1c 40 49 89 c4 0f b7 47 4c 49 c1 e4 04 4c 03 67 20 48 c1 e3 03 48 03 5f 28 41 29 c7 0f 1f 00 <48> 83 7b 08 00 74 7c 48 8b 13 8b 43 10 89 c0 41 83 c7 01 48 8d 
[24644091.418858] RIP  [<ffffffffa025e248>] ixgbevf_alloc_rx_buffers+0x68/0x1c0 [ixgbevf]
[24644091.514304]  RSP <ffff88100f60fc68>
[24644091.559374] CR2: 0000000000000008
?
[Test Script]
ip netns add ns1
?
Starting Docker:
##setupVF
echo 8 > /sys/class/net/eth0/device/sriov_numvfs
ip link set dev eth0 vf 0 mac 4a:c0:33:f4:c1:ee
ip link set dev eth0 vf 0 vlan 3
ip link set [vf 0 name] up
ip link set [vf 0 name] netns ns1
ip netns exec ns1 ip link set [vf 0 name] name eth0 
ip netns exec ns1 ip link set eth0 up
ip netns exec ns1 ip address add 192.168.0.111/24 dev eth0
?
Stopping Docker:
##releaseVF
?
ip netns exec ns1 ip link set eth0 down
ip netns exec ns1 ip link set eth0 name [vf 0 name]
ip netns exec ns1 ip link set [vf 0 name] netns 1
?


Best Regards,
Michael


