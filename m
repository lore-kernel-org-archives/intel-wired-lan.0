From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 May 2016 10:02:14 -0700
Subject: [Intel-wired-lan] Kernel panic on i40e when connected back to back
Message-ID: <CAKgT0Ud3-UP5+t-bTFzKxSetP5SGDu4nTuZQeM7fKyPx+bSAGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The below kernel trace is seen on my system when I have it connected
back to back with another i40e and power on the link partner:

ahduyck-xeon-server login: [ 1584.339589] BUG: unable to handle kernel
NULL pointer dereference at 0000000000000238
[ 1584.347499] IP: [<ffffffffa03bb8e4>] i40e_client_get_params+0x64/0xb0 [i40e]
[ 1584.354596] PGD 0
[ 1584.356642] Oops: 0000 [#1] SMP
[ 1584.359930] Modules linked in: xt_CHECKSUM iptable_mangle
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat tun bridge stp llc
ebtable_filter ebtables ip6table_filter ip6_tables openvswitch
nf_conntrack_ipv6 nf_nat_ipv6 nf_nat_ipv4 nf_defrag_ipv6 nf_nat
ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4
xt_conntrack nf_conntrack iptable_filter vfat fat x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper
ablk_helper cryptd snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq
snd_seq_device snd_pcm iTCO_wdt eeepc_wmi iTCO_vendor_support asus_wmi
snd_timer mei_me sb_edac ipmi_devintf snd sparse_keymap lpc_ich video
mxm_wmi edac_core pcspkr mei shpchp i2c_i801 mfd_core soundcore
ipmi_si ipmi_msghandler wmi acpi_power_meter acpi_pad nfsd auth_rpcgss
nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c mlx4_en ast
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm i40e
mlx5_core igb drm mlx4_core ahci libahci crc32c_intel dca ptp
i2c_algo_bit serio_raw libata i2c_core pps_core dm_mirror
dm_region_hash dm_log dm_mod
[ 1584.467339] CPU: 8 PID: 3498 Comm: kworker/u64:0 Not tainted 4.6.0-rc7+ #88
[ 1584.474315] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D8
WS/Z10PE-D8 WS, BIOS 3204 12/18/2015
[ 1584.482943] Workqueue: i40e i40e_service_task [i40e]
[ 1584.487940] task: ffff881038a5d700 ti: ffff8810372e8000 task.ti:
ffff8810372e8000
[ 1584.495436] RIP: 0010:[<ffffffffa03bb8e4>]  [<ffffffffa03bb8e4>]
i40e_client_get_params+0x64/0xb0 [i40e]
[ 1584.504953] RSP: 0018:ffff8810372ebbe0  EFLAGS: 00010246
[ 1584.510282] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[ 1584.517432] RDX: 0000000000000000 RSI: ffff8810372ebbee RDI: ffff88202dd5f000
[ 1584.524573] RBP: ffff8810372ebc28 R08: 0000000000000005 R09: 0000000000000000
[ 1584.531723] R10: 0000000000000000 R11: ffff88202f48040c R12: ffff88202dd5f000
[ 1584.538875] R13: ffff88202f480008 R14: ffff88202dd5f000 R15: ffff88202f480000
[ 1584.546025] FS:  0000000000000000(0000) GS:ffff88207fa00000(0000)
knlGS:0000000000000000
[ 1584.554127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1584.559884] CR2: 0000000000000238 CR3: 0000000001c06000 CR4: 00000000001406e0
[ 1584.567034] Stack:
[ 1584.569062]  ffffffffa03bc2da 0005000000000000 0005000000050000
0005000000050000
[ 1584.576558]  0005000000050000 0000000000050000 000000007f070564
0000000000000001
[ 1584.584054]  0000000000000001 ffff8810372ebd58 ffffffffa03a2368
ffff88202f4a0e10
[ 1584.591545] Call Trace:
[ 1584.594010]  [<ffffffffa03bc2da>] ?
i40e_notify_client_of_l2_param_changes+0x5a/0x150 [i40e]
[ 1584.602459]  [<ffffffffa03a2368>] i40e_handle_lldp_event+0x328/0x630 [i40e]
[ 1584.609436]  [<ffffffffa03a3657>] i40e_service_task+0xc27/0x1470 [i40e]/i4
[ 1584.616068]  [<ffffffff8108defc>] ? move_linked_works+0x5c/0x80
[ 1584.622006]  [<ffffffff81090b22>] process_one_work+0x152/0x400
[ 1584.627854]  [<ffffffff81091415>] worker_thread+0x125/0x4b0
[ 1584.633440]  [<ffffffff816901f2>] ? __schedule+0x2b2/0x830
[ 1584.638936]  [<ffffffff810912f0>] ? rescuer_thread+0x380/0x380
[ 1584.644779]  [<ffffffff81096da8>] kthread+0xd8/0xf0
[ 1584.649672]  [<ffffffff816944c2>] ret_from_fork+0x22/0x40
[ 1584.655083]  [<ffffffff81096cd0>] ? kthread_park+0x60/0x60
[ 1584.660578] Code: 44 c9 4c 63 c2 46 0f b7 84 47 14 06 00 00 88 4c
86 02 66 41 83 f8 ff 66 44 89 04 86 74 1a 48 83 c0 01 48 83 f8 08 75
ba 48 8b 07 <8b> 80 38 02 00 00 66 89 46 20 31 c0 c3 55 48 c7 c6 d8 ef
3c a0
[ 1584.680623] RIP  [<ffffffffa03bb8e4>] i40e_client_get_params+0x64/0xb0 [i40e]
[ 1584.687790]  RSP <ffff8810372ebbe0>
[ 1584.691292] CR2: 0000000000000238
[ 1584.701724] ---[ end trace ff5a92fdce3088b5 ]---

Looking over the code flow it seems like I am hitting a NULL pointer
deference in response to the function accessing vsi->netdev->mtu in
i40e_client_get_params.  I'm testing a theory now that I can avoid the
issue by switching off the DCB flag in the driver but just wanted to
bring this to your attention as I am not sure what the best solution
here is.  I suspect the code that is doing the DCB reconfiguration
could probably skip VSI devices without netdevs but I will leave that
to you guys to decide.

- Alex
