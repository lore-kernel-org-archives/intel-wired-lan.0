From: li yang <aliethemail1820@gmail.com>
Date: Tue, 21 Jun 2016 17:51:03 +0800
Subject: [Intel-wired-lan] ixgbevf-3.1.2: kernel panic due to NULL pointer
 dereference in the function ixgbevf_alloc_rx_buffers
Message-ID: <CAEwh2tKgnFCdo2O-j5F5mDLQDyR+8khYGPo2VpAGk+E_CJB96w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Driver experts,



Recently, we met a kernel panic issue due to NULL pointer dereference in
the function ixgbevf_alloc_rx_buffers when adding the VF into docker. We
can reproduce the issue with a simple script as follows on certain brand
server with high possibility, and other brand server with low possibility.

Driver and kernel information: ixgbe-4.3.15 + ixgbevf-3.1.2 + RHEL
kernel-3.0.10-327


Two steps to reproduce the issue:

1)  Enable SR-IOV

      sudo sh -c 'echo 63 > /sys/bus/pci/devices/0000:03:00.0/sriov_numvfs'


2)  Bring VF interface up and down in one command line:

     sudo ifconfig eth66 up; sudo ifconfig eth66 down

 The kernel panic occurs. The stack dump shows when the interface is up, it
will call ixgbevf_open(), and simultaneously ixgbevf_service_task() will
also be scheduled once with the RESET flag set.



ixgbevf_service_task->ixgbevf_reset_subtask->ixgbevf_reinit_locked->ixgbevf_up->

ixgbe_configure->ixgbevf_configure_rx->ixgbevf_configure_rx_ring->

ixgbevf_alloc_rx_buffers->ixgbevf_alloc_mapped_page



then the ixgbevf_close() may meet the NULL pointer dereference (bi=
&rx_ring->rx_buffer_info[i])?



Similar issue reported in the community

http://thread.gmane.org/gmane.linux.network/410804




The following patch can prevent the kernel panic happening.  But not sure
why the race condition occurs there and what's the correct fix?



static int ixgbevf_close(struct net_device *netdev)

{

struct ixgbevf_adapter *adapter = netdev_priv(netdev);



+      while(test_and_set_bit(__IXGBEVF_SERVICE_SCHED, &adapter->state))

+                msleep(1);



ixgbevf_down(adapter);

ixgbevf_free_irq(adapter);



ixgbevf_free_all_tx_resources(adapter);

ixgbevf_free_all_rx_resources(adapter);

+      clear_bit(__IXGBEVF_SERVICE_SCHED, &adapter->state);



return 0;

}







2016-05-27 16:09:49        [11007.427399] VF could not set VLAN 0

2016-05-27 16:09:49        [11007.434971] VF could not set VLAN 0

2016-05-27 16:09:49        [11007.438482] eth0: Couldn't add bond vlan ids
to eth6

2016-05-27 16:12:08        [11146.639627] ixgbevf: eth8:
ixgbevf_configure_tx_ring: Could not enable Tx Queue 0

2016-05-27 16:12:08        [11146.666603] ixgbevf: eth8:
ixgbevf_configure_tx_ring: Could not enable Tx Queue 1

2016-05-27 16:12:08        [11146.685081] VF could not set VLAN 0

2016-05-27 16:12:08        [11146.692181] VF could not set VLAN 0

2016-05-27 16:12:08        [11146.695732] eth0: Couldn't add bond vlan ids
to eth8

2016-05-27 16:12:08        [11146.777091] BUG: unable to handle kernel NULL
pointer dereference at 0000000000000008

2016-05-27 16:12:08        [11146.785010] IP: []
ixgbevf_alloc_rx_buffers+0x60/0x160 [ixgbevf]

2016-05-27 16:12:08        [11146.792650] PGD 0

2016-05-27 16:12:08        [11146.794694] Oops: 0000 [#1] SMP

2016-05-27 16:12:08        [11146.797986] Modules linked in: ixgbe(OE)
bonding ixgbevf(OE) 8021q garp mrp openvswitch dccp_diag dccp tcp_diag
udp_diag inet_diag xt_nat veth libcrc32c ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack nf_nat nf_conntrack
bridge stp llc overlay() intel_powerclamp coretemp intel_rapl kvm_intel kvm
crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper
ablk_helper cryptd vxlan ip6_udp_tunnel iTCO_wdt iTCO_vendor_support
udp_tunnel lpc_ich ipmi_devintf i2c_i801 mfd_core ses mei_me mei enclosure
sg ipmi_si pcspkr ipmi_msghandler ntb shpchp wmi ip_tables ext4 mbcache
jbd2 sd_mod crc_t10dif crct10dif_generic ast syscopyarea sysfillrect
sysimgblt drm_kms_helper ttm igb ahci mpt2sas drm isci libahci ptp pps_core
libsas dca i2c_algo_bit crct10dif_pclmul raid_class crct10dif_common libata
i2c_core crc32c_intel scsi_transport_sas [last unloaded: ixgbe]

2016-05-27 16:12:08        [11146.883741] CPU: 0 PID: 14580 Comm:
kworker/0:1 Tainted: G OE ------------ T 3.10.0-327.ali2000.alios7.x86_64
#1

2016-05-27 16:12:08        [11146.894941] Hardware name: Inspur
SA5212H2/YZMB-00101-108, BIOS 2.0.3 03/26/2014

2016-05-27 16:12:08        [11146.902376] Workqueue: events
ixgbevf_service_task [ixgbevf]

2016-05-27 16:12:08        [11146.908102] task: ffff8817f00eae40 ti:
ffff8817ebfc0000 task.ti: ffff8817ebfc0000

2016-05-27 16:12:08        [11146.915626] RIP: 0010:[] []
ixgbevf_alloc_rx_buffers+0x60/0x160 [ixgbevf]

2016-05-27 16:12:08        [11146.925700] RSP: 0018:ffff8817ebfc3d08
EFLAGS: 00010287

2016-05-27 16:12:08        [11146.931042] RAX: 0000000000000200 RBX:
0000000000000000 RCX: 0000000000000000

2016-05-27 16:12:08        [11146.938213] RDX: 0000000000000000 RSI:
00000000000001ff RDI: ffff8817fa391a40

2016-05-27 16:12:08        [11146.945385] RBP: ffff8817ebfc3d40 R08:
ffff8817ebfc0000 R09: 0000000000000001

2016-05-27 16:12:08        [11146.952565] R10: 0000000000000000 R11:
0000000000000001 R12: 0000000000000000

2016-05-27 16:12:08        [11146.959740] R13: 00000000fffffe00 R14:
00000000000001ff R15: ffff8817fa391a40

2016-05-27 16:12:08        [11146.966909] FS: 0000000000000000(0000)
GS:ffff88181f200000(0000) knlGS:0000000000000000

2016-05-27 16:12:08        [11146.975046] CS: 0010 DS: 0000 ES: 0000 CR0:
0000000080050033

2016-05-27 16:12:08        [11146.980821] CR2: 0000000000000008 CR3:
0000000001942000 CR4: 00000000000407f0

2016-05-27 16:12:08        [11146.987998] DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000

2016-05-27 16:12:08        [11146.995175] DR3: 0000000000000000 DR6:
00000000ffff0ff0 DR7: 0000000000000400

2016-05-27 16:12:08        [11147.002351] Stack:

2016-05-27 16:12:08        [11147.004387] ffff8817d5a22bc0 ffff8817ebfc3d20
ffff8817d5a228c0 0000000000000009

2016-05-27 16:12:08        [11147.011923] ffff8817d5a22bc0 ffff8817fa391a40
0000000000001028 ffff8817ebfc3db0

2016-05-27 16:12:08        [11147.021668] ffffffffa058da23 0000000100000002
00000000ffff6000 0000000000000000

2016-05-27 16:12:08        [11147.031375] Call Trace:

2016-05-27 16:12:08        [11147.036043] [] ixgbevf_configure+0x5b3/0x740
[ixgbevf]

2016-05-27 16:12:08        [11147.045082] []
ixgbevf_reinit_locked+0x93/0xd0 [ixgbevf]

2016-05-27 16:12:08        [11147.054239] []
ixgbevf_service_task+0x2f7/0x3d0 [ixgbevf]

2016-05-27 16:12:08        [11147.063441] [] process_one_work+0x17b/0x470

2016-05-27 16:12:08        [11147.071390] [] worker_thread+0x11b/0x400

2016-05-27 16:12:08        [11147.079050] [] ? rescuer_thread+0x400/0x400

2016-05-27 16:12:08        [11147.086972] [] kthread+0xcf/0xe0

2016-05-27 16:12:08        [11147.093875] [] ?
kthread_create_on_node+0x140/0x140

2016-05-27 16:12:08        [11147.102482] [] ret_from_fork+0x58/0x90

2016-05-27 16:12:08        [11147.109946] [] ?
kthread_create_on_node+0x140/0x140

2016-05-27 16:12:08        [11147.118523] Code: c5 41 89 f6 49 89 c4 48 8d
14 40 48 8b 47 28 49 c1 e4 04 4c 03 67 20 48 8d 1c d0 0f b7 47 4c 41 29 c5
66 0f 1f 84 00 00 00 00 00 <48> 83 7b 08 00 74 75 48 8b 03 8b 53 10 89 d2
49 83 c4 10 48 83

2016-05-27 16:12:08        [11147.142787] RIP []
ixgbevf_alloc_rx_buffers+0x60/0x160 [ixgbevf]

2016-05-27 16:12:09        [11147.152654] RSP

2016-05-27 16:12:09        [11147.158327] CR2: 0000000000000008

2016-05-27 16:12:09        [11147.634988] ---[ end trace 6ad8ae4378f2f860
]---
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160621/58a3a6fc/attachment-0001.html>
