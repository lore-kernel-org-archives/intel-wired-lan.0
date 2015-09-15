From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Tue, 15 Sep 2015 17:21:28 +0000
Subject: [Intel-wired-lan] ixgbevf_poll causes a crash in
	tcp_clean_rtx_queue
In-Reply-To: <E5721A05874A4CD0B11DF5B6955871B6@alyakaslap>
References: <E5721A05874A4CD0B11DF5B6955871B6@alyakaslap>
Message-ID: <F6FB0E698C9B3143BDF729DF222866469133F363@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hey Alex,

I haven't personally seen such a crash but have asked my validation team to attempt to create your set up and see if we can see your crash.  By any chance did you capture the crash dump/log before the crash occurred?

Thanks,
-Don <donald.c.skidmore@intel.com>


> -----Original Message-----
> From: Alex Lyakas [mailto:alex at zadarastorage.com]
> Sent: Sunday, September 06, 2015 11:24 AM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Skidmore, Donald C; Tantilov, Emil S; Yair Hershko; Yaron Presente
> Subject: ixgbevf_poll causes a crash in tcp_clean_rtx_queue
> 
> Greetings Intel developers,
> We had two kernel crashes involving ixgbevf in [1] and [2], both are quite
> similar.
> 
> The crashes happened within a virtual machine guest, running a mainline
> kernel 3.8.13.
> 
> The host running this VM has a 82599EB Intel NIC, spawning 32 VFs on each
> port. Four VFs (two from each NIC port) are assigned to the VM. Then within
> the VM, we create two bonding interfaces, each one enslaving two VFs from
> different ports. One of the VF pairs also has 8021q interfaces are created on
> top (using vconfig), and the bond is created on top of the 8021q interfaces.
> We are not sure which bond interface and which VF experienced the crash.
> 
> Bond is in active-backup mode with failover-mac setting set to 1. They also
> have miimon set to 100 and updelay set to 60000.
> 
> Can you perhaps advise what might be causing these crashes? For now, it
> happened only twice, and we don't have a repro scenario.
> 
> Thanks,
> Alex.
> 
> 
> 
> [1]
> [224281.913038] BUG: unable to handle kernel paging request at
> 00000000a5676903
> [224281.914047] IP: [<ffffffff8162a043>] tcp_clean_rtx_queue+0xb3/0x6e0
> [224281.914884] PGD 3c4ae7067 PUD 0 [224281.915351] Oops: 0000 [#1] SMP
> [224281.915861] Modules linked in: dm_crypt(OF) dm_queue_length
> xt_multiport xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state
> nf_conntrack iptable_filter ip_tables x_tables ib_iser(OF) rdma_cm(OF)
> ib_cm(OF)
> iw_cm(OF) ib_sa(OF) ib_mad(OF) ib_core(OF) ib_addr(OF) compat(OF)
> iscsi_tcp(OF) libiscsi_tcp(OF) libiscsi(OF) scsi_transport_iscsi(OF) xfrm_user
> xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 8021q garp stp llc
> bonding dm_zcache(OF) xfs(OF) btrfs(OF) raid456(OF) async_pq async_xor
> xor async_memcpy async_raid6_recov raid6_pq async_tx raid1(OF) deflate
> zlib_deflate ctr twofish_generic twofish_avx_x86_64 twofish_x86_64_3way
> twofish_x86_64 twofish_common camellia_generic
> camellia_aesni_avx_x86_64
> camellia_x86_64 serpent_avx_x86_64 serpent_sse2_x86_64 glue_helper
> serpent_generic blowfish_generic blowfish_x86_64 blowfish_common
> cast5_avx_x86_64 cast5_generic cast_common des_generic xcbc
> iscsi_scst(OF)
> rmd160 scst_vdisk(OF) libcrc32c crypto_null scst(OF) af_key xfrm_algo kvm
> ghash_clmulni_intel aesni_intel ablk_helper cryptd lrw aes_x86_64 xts
> gf128mul nfsd(OF) nfs_acl auth_rpcgss nfs fscache lockd sunrpc microcode
> virtio_balloon psmouse dm_multipath(OF) scsi_dh dm_iostat(OF) serio_raw
> cirrus ttm drm_kms_helper drm sysimgblt sysfillrect syscopyarea i2c_piix4
> mac_hid lp parport floppy ixgbevf(OF) [224281.916964] CPU 0
> [224281.916964] Pid: 0, comm: swapper/0 Tainted: GF          O
> 3.8.13-030813-generic #201305111843 Bochs Bochs [224281.916964] RIP:
> 0010:[<ffffffff8162a043>]  [<ffffffff8162a043>]
> tcp_clean_rtx_queue+0xb3/0x6e0
> [224281.916964] RSP: 0018:ffff88040f003a00  EFLAGS: 00010206
> [224281.916964] RAX: 00000000a5676900 RBX: ffff88040803e200 RCX:
> ffffffffffffffff
> [224281.916964] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
> 000000000000000f
> [224281.916964] RBP: ffff88040f003a90 R08: 0000000000000401 R09:
> ffffea000e995700
> [224281.916964] R10: ffffffff815d0098 R11: 0000000023020a0a R12:
> ffff8803a5676a10
> [224281.916964] R13: 0000000000000004 R14: 0000000000000015 R15:
> 0000000000000000
> [224281.916964] FS:  0000000000000000(0000) GS:ffff88040f000000(0000)
> knlGS:0000000000000000
> [224281.916964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [224281.916964] CR2: 00000000a5676903 CR3: 0000000408884000 CR4:
> 00000000000406f0
> [224281.916964] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [224281.916964] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [224281.916964] Process swapper/0 (pid: 0, threadinfo ffffffff81c00000, task
> ffffffff81c15440)
> [224281.916964] Stack:
> [224281.916964]  0000000000000020 ffff880407017d80 000000000f003a90
> 4f28c84d00000000
> [224281.916964]  0000000000000000 0000000003566c56 ffff88040803e310
> 0000000003566c56
> [224281.916964]  ffff88040f003a80 ffffffff81658526 0000000000000000
> ffff88040f003aa0
> [224281.916964] Call Trace:
> [224281.916964]  <IRQ>
> [224281.916964]  [<ffffffff81658526>] ? __fib_lookup+0x46/0x70
> [224281.916964]  [<ffffffff8162aa12>] tcp_ack+0x3a2/0x600 [224281.916964]
> [<ffffffff8162b05c>] tcp_rcv_established+0xec/0x770 [224281.916964]
> [<ffffffff81635314>] tcp_v4_do_rcv+0x134/0x220 [224281.916964]
> [<ffffffff81636f09>] tcp_v4_rcv+0x569/0x840 [224281.916964]
> [<ffffffff81610b36>] ip_local_deliver_finish+0xe6/0x280
> [224281.916964]  [<ffffffff81610e5a>] ip_local_deliver+0x4a/0x90
> [224281.916964]  [<ffffffff81610809>] ip_rcv_finish+0x119/0x360
> [224281.916964]  [<ffffffff816110bd>] ip_rcv+0x21d/0x300 [224281.916964]
> [<ffffffff815dddca>] __netif_receive_skb+0x5fa/0x760 [224281.916964]
> [<ffffffff8163729e>] ? tcp4_gro_receive+0x9e/0x110 [224281.916964]
> [<ffffffff815ddf53>] netif_receive_skb+0x23/0x90 [224281.916964]
> [<ffffffff815de698>] napi_gro_receive+0xe8/0x140 [224281.916964]
> [<ffffffffa0004967>] ixgbevf_poll+0x5b7/0x980 [ixgbevf] [224281.916964]
> [<ffffffff815df544>] net_rx_action+0x134/0x260 [224281.916964]
> [<ffffffff81045136>] ? native_safe_halt+0x6/0x10 [224281.916964]
> [<ffffffff810623f0>] __do_softirq+0xc0/0x240 [224281.916964]
> [<ffffffff816ed43e>] ? _raw_spin_lock+0xe/0x20 [224281.916964]
> [<ffffffff816f771c>] call_softirq+0x1c/0x30 [224281.916964]
> [<ffffffff81016775>] do_softirq+0x65/0xa0 [224281.916964]
> [<ffffffff810626ce>] irq_exit+0x8e/0xb0 [224281.916964]  [<ffffffff816f7fb3>]
> do_IRQ+0x63/0xe0 [224281.916964]  [<ffffffff816eda2d>]
> common_interrupt+0x6d/0x6d [224281.916964]  <EOI> [224281.916964]
> [<ffffffff81083ea8>] ? hrtimer_start+0x18/0x20 [224281.916964]
> [<ffffffff81045136>] ? native_safe_halt+0x6/0x10 [224281.916964]
> [<ffffffff8101cc33>] default_idle+0x53/0x1f0 [224281.916964]
> [<ffffffff8101dad9>] cpu_idle+0xd9/0x120 [224281.916964]
> [<ffffffff816c0f82>] rest_init+0x72/0x80 [224281.916964]
> [<ffffffff81d04c63>] start_kernel+0x3d1/0x3de [224281.916964]
> [<ffffffff81d04724>] ? do_early_param+0x87/0x87 [224281.916964]
> [<ffffffff81d04397>] x86_64_start_reservations+0x131/0x135
> [224281.916964]  [<ffffffff81d04120>] ? early_idt_handlers+0x120/0x120
> [224281.916964]  [<ffffffff81d04468>] x86_64_start_kernel+0xcd/0xdc
> [224281.916964] Code: 83 c0 04 00 00 41 3b 44 24 44 41 0f b6 54 24 4d 0f 88
> a2 03 00 00 41 8b 84 24 d8 00 00 00 49 8b 8c 24 e0 00 00 00 be 01 00 00 00 <0f>
> b7 44 01 04 0f b6 d2 f6 c2 82 0f 84 44 03 00 00 f6 c2 02 74 [224281.916964] RIP
> [<ffffffff8162a043>] tcp_clean_rtx_queue+0xb3/0x6e0 [224281.916964]  RSP
> <ffff88040f003a00> [224281.916964] CR2: 00000000a5676903 [224281.999140]
> ---[ end trace 8606b25aec0e4b97 ]---
> 
> [2]
> [5203941.564514] BUG: unable to handle kernel paging request at
> 0000000003783103
> [5203941.565966] IP: [<ffffffff8162a043>] tcp_clean_rtx_queue+0xb3/0x6e0
> [5203941.566783] PGD 37e3c4067 PUD 24b912067 PMD 0 [5203941.567405]
> Oops: 0000 [#1] SMP [5203941.568009] CPU 0
> [5203941.568009] Pid: 4251, comm: dmsetup Tainted: GF       W  O
> 3.8.13-030813-generic #201305111843 Bochs Bochs [5203941.568009] RIP:
> 0010:[<ffffffff8162a043>]  [<ffffffff8162a043>]
> tcp_clean_rtx_queue+0xb3/0x6e0
> [5203941.568009] RSP: 0000:ffff88040f003a00  EFLAGS: 00010206
> [5203941.568009] RAX: 0000000003783100 RBX: ffff880344cadb00 RCX:
> ffffffffffffffff
> [5203941.568009] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
> ffff880344cadb00
> [5203941.568009] RBP: ffff88040f003a90 R08: 0000000000000402 R09:
> 0000000000000002
> [5203941.568009] R10: 000000000000000f R11: 0000000023020a0a R12:
> ffff880403783210
> [5203941.568009] R13: 0000000000000000 R14: 0000000000000000 R15:
> 00000000ffffffff
> [5203941.568009] FS:  00007f49bf0b57c0(0000) GS:ffff88040f000000(0000)
> knlGS:0000000000000000
> [5203941.568009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [5203941.568009] CR2: 0000000003783103 CR3: 000000028032d000 CR4:
> 00000000000406f0
> [5203941.568009] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [5203941.568009] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [5203941.568009] Process dmsetup (pid: 4251, threadinfo ffff8802d6958000,
> task ffff8803bfa01740) [5203941.568009] Stack:
> [5203941.568009]  0000000000000020 ffff880403f9ce40 000000000f003a90
> 281c1e1300000000
> [5203941.568009]  0000000000000000 000000024d8a5137 ffff880344cadc10
> 00000000ffffffff [5203941.568009]  ffff88040f003a80 ffffffff81658526
> 0000000000000000
> ffff88040f003aa0
> [5203941.568009] Call Trace:
> [5203941.568009]  <IRQ>
> [5203941.568009] [5203941.568009]  [<ffffffff81658526>] ?
> __fib_lookup+0x46/0x70
> [5203941.568009]  [<ffffffff8162aa12>] tcp_ack+0x3a2/0x600
> [5203941.568009]  [<ffffffff8162b05c>] tcp_rcv_established+0xec/0x770
> [5203941.568009]  [<ffffffff81635314>] tcp_v4_do_rcv+0x134/0x220
> [5203941.568009]  [<ffffffff81636f09>] tcp_v4_rcv+0x569/0x840
> [5203941.568009]  [<ffffffff81610b36>] ip_local_deliver_finish+0xe6/0x280
> [5203941.568009]  [<ffffffff81610e5a>] ip_local_deliver+0x4a/0x90
> [5203941.568009]  [<ffffffff81610809>] ip_rcv_finish+0x119/0x360
> [5203941.568009]  [<ffffffff816110bd>] ip_rcv+0x21d/0x300 [5203941.568009]
> [<ffffffff815dddca>] __netif_receive_skb+0x5fa/0x760 [5203941.568009]
> [<ffffffff8163729e>] ? tcp4_gro_receive+0x9e/0x110 [5203941.568009]
> [<ffffffff815ddf53>] netif_receive_skb+0x23/0x90 [5203941.568009]
> [<ffffffff815de698>] napi_gro_receive+0xe8/0x140 [5203941.568009]
> [<ffffffffa0779967>] ixgbevf_poll+0x5b7/0x980 [ixgbevf] [5203941.568009]
> [<ffffffff815df544>] net_rx_action+0x134/0x260 [5203941.568009]
> [<ffffffff8107f8c1>] ? __wake_up_bit+0x31/0x40 [5203941.568009]
> [<ffffffff810623f0>] __do_softirq+0xc0/0x240 [5203941.568009]
> [<ffffffff816ed43e>] ? _raw_spin_lock+0xe/0x20 [5203941.568009]
> [<ffffffff816f771c>] call_softirq+0x1c/0x30 [5203941.568009]
> [<ffffffff81016775>] do_softirq+0x65/0xa0 [5203941.568009]
> [<ffffffff810626ce>] irq_exit+0x8e/0xb0 [5203941.568009]
> [<ffffffff816f7fb3>] do_IRQ+0x63/0xe0 [5203941.568009]
> [<ffffffff816eda2d>] common_interrupt+0x6d/0x6d [5203941.568009]  <EOI>
> [5203941.568009] [5203941.568009]  [<ffffffff8107f8c1>] ?
> __wake_up_bit+0x31/0x40
> [5203941.568009]  [<ffffffff811350f7>] unlock_page+0x27/0x30
> [5203941.568009]  [<ffffffff8115bbf9>] __do_fault+0x419/0x520
> [5203941.568009]  [<ffffffff81142a34>] ? lru_cache_add_lru+0x24/0x50
> [5203941.568009]  [<ffffffff8115f896>] handle_pte_fault+0x96/0x230
> [5203941.568009]  [<ffffffff811374d1>] ? generic_file_aio_read+0xe1/0x220
> [5203941.568009]  [<ffffffff81160e60>] handle_mm_fault+0x2a0/0x3e0
> [5203941.568009]  [<ffffffff816f158f>] __do_page_fault+0x1af/0x560
> [5203941.568009]  [<ffffffff816f194e>] do_page_fault+0xe/0x10
> [5203941.568009]  [<ffffffff816f1025>] do_async_page_fault+0x35/0x90
> [5203941.568009]  [<ffffffff816edd48>] async_page_fault+0x28/0x30
> [5203941.568009] Code: 83 c0 04 00 00 41 3b 44 24 44 41 0f b6 54 24 4d 0f 88
> a2 03 00 00 41 8b 84 24 d8 00 00 00 49 8b 8c 24 e0 00
> 00 00 be 01 00 00 00 <0f> b7 44 01 04 0f b6 d2 f6 c2 82 0f 84 44 03 00 00 f6
> c2 02 74
> [5203941.568009] RIP  [<ffffffff8162a043>] tcp_clean_rtx_queue+0xb3/0x6e0
> [5203941.568009]  RSP <ffff88040f003a00> [5203941.568009] CR2:
> 0000000003783103 [5203941.653756] ---[ end trace 363b7b17527d87fe ]---

