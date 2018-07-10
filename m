From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Tue, 10 Jul 2018 13:17:21 +0200
Subject: [Intel-wired-lan] Issue with driver i40e stat strings count mismatch
Message-ID: <20180710131721.657e55a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Intel-fokes,

Your i40e driver have issues with it's ethtool stats.  A warning
triggers at drivers/net/ethernet/intel/i40e/i40e_ethtool.c line 1907
(see splash below) in func i40e_get_stat_strings().


[ 5077.779518] ------------[ cut here ]------------
[ 5077.784493] stat strings count mismatch!
[ 5077.784529] WARNING: CPU: 0 PID: 2293 at drivers/net/ethernet/intel/i40e/i40e_ethtool.c:1907 i40e_get_strings+0x477/0x4b0 [i40e]
[ 5077.800941] Modules linked in: act_gact cls_u32 sch_ingress xt_tcpudp iptable_raw ip_tables x_tables tun nfnetlink bridge stp llc bpfilter sunrpc coretemp kvm_intel kvm irqbypass intel_cstate intel_uncore intel_rapl_perf pcspkr i2c_i801 wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad sch_fq_codel ixgbe mlx5_core mlxfw i40e devlink hid_generic igb mdio i2c_algo_bit ptp sd_mod i2c_core pps_core [last unloaded: x_tables]
[ 5077.839833] CPU: 0 PID: 2293 Comm: ethtool Not tainted 4.18.0-rc3-net-next-EdwardCree01+ #484
[ 5077.848962] Hardware name: Supermicro Super Server/X10SRi-F, BIOS 2.0a 08/01/2016
[ 5077.857049] RIP: 0010:i40e_get_strings+0x477/0x4b0 [i40e]
[ 5077.862776] Code: 98 49 39 c4 0f 84 2e fc ff ff 80 3d b3 da 03 00 00 0f 85 21 fc ff ff 48 c7 c7 24 42 19 a0 c6 05 9f da 03 00 01 e8 e9 9c ee e0 <0f> 0b e9 07 fc ff ff 48 83 c4 10 48 c7 c1 80 01 19 a0 be 20 00 00 
[ 5077.882506] RSP: 0018:ffffc90003af3c18 EFLAGS: 00010296
[ 5077.888063] RAX: 000000000000001c RBX: ffffc90003ce1440 RCX: 0000000000000006
[ 5077.895528] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff88087ca15530
[ 5077.902991] RBP: ffffc90003ce1440 R08: 000000000000001c R09: 0000000000000411
[ 5077.910453] R10: 000fffffffe00000 R11: ffffffff82a4e66d R12: ffffffffffffcbc0
[ 5077.917913] R13: ffff88087c50f000 R14: 0000000000000008 R15: ffffffffa0199620
[ 5077.925376] FS:  00007f7a84bcb740(0000) GS:ffff88087ca00000(0000) knlGS:0000000000000000
[ 5077.934061] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5077.940133] CR2: 000055c7d709b000 CR3: 000000081acd0004 CR4: 00000000003606f0
[ 5077.947609] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5077.955070] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5077.962531] Call Trace:
[ 5077.965309]  dev_ethtool+0xf4e/0x2430
[ 5077.969305]  ? get_page_from_freelist+0x2bb/0x1240
[ 5077.974428]  ? dev_ioctl+0x1e9/0x3c0
[ 5077.978332]  dev_ioctl+0x1e9/0x3c0
[ 5077.982062]  sock_do_ioctl+0xa8/0x140
[ 5077.986057]  ? sock_ioctl+0x1c0/0x300
[ 5077.990051]  sock_ioctl+0x1c0/0x300
[ 5077.993864]  ? __handle_mm_fault+0xa82/0xfd0
[ 5077.998462]  ? do_vfs_ioctl+0x8d/0x5e0
[ 5078.002550]  do_vfs_ioctl+0x8d/0x5e0
[ 5078.006456]  ? handle_mm_fault+0xd0/0x210
[ 5078.010790]  ksys_ioctl+0x70/0x80
[ 5078.014429]  __x64_sys_ioctl+0x16/0x20
[ 5078.018505]  do_syscall_64+0x42/0xf0
[ 5078.022411]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5078.027789] RIP: 0033:0x7f7a84394dc7
[ 5078.031703] Code: b3 66 90 48 8b 05 d9 00 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 00 2d 00 f7 d8 64 89 01 48 
[ 5078.051437] RSP: 002b:00007ffd64d68338 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 5078.059596] RAX: ffffffffffffffda RBX: 000055c7d7099260 RCX: 00007f7a84394dc7
[ 5078.067062] RDX: 00007ffd64d684e0 RSI: 0000000000008946 RDI: 0000000000000003
[ 5078.074524] RBP: 00007ffd64d684d0 R08: ffffffffffffffb0 R09: 000055c7d7099260
[ 5078.081986] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000001a2
[ 5078.089447] R13: 0000000000000001 R14: 0000000000000000 R15: 00007ffd64d684e0
[ 5078.096911] ---[ end trace faf82a00c0d8b6b1 ]---

$ gdb ./drivers/net/ethernet/intel/i40e/i40e.ko
[...]
Reading symbols from ./drivers/net/ethernet/intel/i40e/i40e.ko...done.
(gdb) list *(i40e_get_strings)+0x477
0x17787 is in i40e_get_strings (drivers/net/ethernet/intel/i40e/i40e_ethtool.c:1906).
1901			snprintf(data, ETH_GSTRING_LEN,
1902				 "port.rx_priority_%u_xon_2_xoff", i);
1903			data += ETH_GSTRING_LEN;
1904		}
1905	
1906		WARN_ONCE(p - data != i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
1907			  "stat strings count mismatch!");
1908	}
1909	
1910	static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
