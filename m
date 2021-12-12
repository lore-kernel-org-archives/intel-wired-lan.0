From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Sun, 12 Dec 2021 13:13:02 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add locking to prevent panic
 when setting sriov_numvfs to zero
In-Reply-To: <20211117104645.279469-1-radoslawx.tyl@intel.com>
References: <20211117104645.279469-1-radoslawx.tyl@intel.com>
Message-ID: <DM8PR11MB5621D7CAE11D1959F38F6DD5AB739@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Still is Call trace:

[  +0.000004] WARNING: CPU: 48 PID: 9330 at kernel/softirq.c:362 __local_bh_enable_ip+0x68/0x70
[  +0.000015] Modules linked in: ixgbevf(+) xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun intel_rapl_msr sd_mod t10_pi sg intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl pcspkr wmi_bmof ahci libahci i40e libata joydev ipmi_ssif ccp sp5100_tco k10temp i2c_piix4 acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter ip_tables rpcsec_gss_krb5 bridge stp llc rfkill drm_kms_helper syscopyarea sysfillrect sysimgblt ixgbe fb_sys_fops mdio drm tg3 dca i2c_algo_bit wmi sctp libcrc32c crc32c_intel ip6_udp_tunnel udp_tunnel fuse
[  +0.000063] CPU: 48 PID: 9330 Comm: systemd-udevd Kdump: loaded Not tainted 5.16.0-rc4_next-queue_dev-queue-01129-gac735b4b67a1 #1
[  +0.000004] Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS 2.2.5 04/08/2021
[  +0.000005] RIP: 0010:__local_bh_enable_ip+0x68/0x70
[  +0.000004] Code: 85 c0 75 05 e8 60 d4 f1 ff c3 48 c7 c7 0e 0d 24 9d e8 cc 5f a4 00 65 66 8b 05 54 b1 14 64 66 85 c0 74 cc e8 0a ff ff ff eb c5 <0f> 0b eb a7 0f 1f 40 00 0f 1f 44 00 00 53 bf 00 00 01 00 e8 b0 b7
[  +0.000002] RSP: 0018:ffffb1860d3c0e00 EFLAGS: 00010006
[  +0.000002] RAX: 0000000080010202 RBX: 000000000000003f RCX: 000000000000000e
[  +0.000003] RDX: 0000000000000003 RSI: 0000000000000201 RDI: ffffffffc0501e95
[  +0.000001] RBP: 0000000000000001 R08: 0000000080000000 R09: 0000000000000000
[  +0.000001] R10: 0000000000000000 R11: ffffb1860d3c0ad0 R12: 0000000000000002
[  +0.000002] R13: 000000000000003f R14: ffff9fbcd09fca40 R15: ffff9fbcd09fdb80
[  +0.000001] FS:  00007ff5037a0180(0000) GS:ffff9fd45f800000(0000) knlGS:0000000000000000
[  +0.000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 0000555fda5f6d00 CR3: 00000018a4aee000 CR4: 0000000000350ee0
[  +0.000002] Call Trace:
[  +0.000009]  <IRQ>
[  +0.000007]  ixgbe_msg_task+0x4a5/0x15c0 [ixgbe]
[  +0.000058]  ixgbe_msix_other+0x15d/0x2e0 [ixgbe]
[  +0.000011]  __handle_irq_event_percpu+0x39/0x180
[  +0.000007]  handle_irq_event_percpu+0x30/0x70
[  +0.000002]  handle_irq_event+0x34/0x60
[  +0.000003]  handle_edge_irq+0x9a/0x1c0
[  +0.000006]  __common_interrupt+0x65/0x100
[  +0.000004]  common_interrupt+0xb4/0xd0
[  +0.000007]  </IRQ>
[  +0.000001]  <TASK>
[  +0.000001]  asm_common_interrupt+0x1e/0x40
[  +0.000009] RIP: 0010:sha256_ni_transform+0x4e/0x330
[  +0.000008] Code: 66 0f 3a 0f ca 08 66 0f 3a 0e d7 f0 66 44 0f 6f 05 e7 fc 2a 01 48 8d 05 e0 fb 2a 01 66 44 0f 6f c9 66 44 0f 6f d2 f3 0f 6f 06 <66> 41 0f 38 00 c0 66 0f 6f d8 66 0f fe 00 0f 38 cb d1 66 0f 70 c0
[  +0.000002] RSP: 0018:ffffb18622917b80 EFLAGS: 00000287
[  +0.000001] RAX: ffffffff9d17eb40 RBX: ffff9fbcd096b980 RCX: ffff9fbcd096b9b0
[  +0.000002] RDX: ffffb18627ec7140 RSI: ffffb18627c37440 RDI: ffff9fbcd096b988
[  +0.000001] RBP: ffff9fbcd096b988 R08: 0000000000000018 R09: 0000000000000000
[  +0.000002] R10: 000000000000000c R11: 0000000000000004 R12: ffff9fc3fbd10540
[  +0.000001] R13: ffffffff9becef20 R14: 00000000003b4140 R15: ffffb18627b13000
[  +0.000001]  ? sha256_ssse3_update+0x30/0x30
[  +0.000004]  sha256_finup+0x27c/0x320
[  +0.000004]  pkcs7_digest.isra.2+0xd8/0x250
[  +0.000009]  pkcs7_verify+0x83/0x570
[  +0.000003]  verify_pkcs7_message_sig+0x62/0x100
[  +0.000006]  verify_pkcs7_signature+0x59/0x70
[  +0.000003]  mod_verify_sig+0x84/0xb0
[  +0.000008]  load_module+0x10f/0x1cb0
[  +0.000003]  ? __kernel_read+0x150/0x2d0
[  +0.000007]  ? kernel_read_file+0x25b/0x2d0
[  +0.000010]  ? __do_sys_finit_module+0xaa/0x110
[  +0.000002]  __do_sys_finit_module+0xaa/0x110
[  +0.000004]  do_syscall_64+0x3a/0x80
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  +0.000003] RIP: 0033:0x7ff50238552d
[  +0.000004] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 79 2c 00 f7 d8 64 89 01 48
[  +0.000002] RSP: 002b:00007ffc37e250b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  +0.000003] RAX: ffffffffffffffda RBX: 0000555fda5974d0 RCX: 00007ff50238552d
[  +0.000001] RDX: 0000000000000000 RSI: 00007ff502ef986d RDI: 0000000000000007
[  +0.000001] RBP: 00007ff502ef986d R08: 0000000000000000 R09: 00007ffc37e251e0
[  +0.000001] R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
[  +0.000001] R13: 0000555fda65e570 R14: 0000000000020000 R15: 0000000000000000
[  +0.000003]  </TASK>
[  +0.000001] ---[ end trace 6eabda8081b2ba26 ]---
[  +0.008823] ixgbe 0000:a1:00.0 eth0: VF 0 requested invalid api version 6
[  +0.001006] ixgbevf 0000:a1:10.0: MAC address not assigned by administrator.
[  +0.000003] ixgbevf 0000:a1:10.0: Assigning random MAC address
[  +0.001449] ixgbevf 0000:a1:10.0: 8e:00:3e:e2:c7:17
[  +0.000003] ixgbevf 0000:a1:10.0: MAC: 1
[  +0.000001] ixgbevf 0000:a1:10.0: Intel(R) 82599 Virtual Function
