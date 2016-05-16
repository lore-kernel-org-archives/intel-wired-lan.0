From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 16 May 2016 11:06:51 -0700
Subject: [Intel-wired-lan] Panic on next-queue i40e when rebooting
Message-ID: <CAKgT0UdGQJEs+pGKEeq0bGP81jZxKABwSkpv0M=CemzQDOdhfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'm seeing the trace below every time I reboot after having run a
performance test of some sort between the PF and VFs.  I didn't see it
for a brief period, but it came back.

I'm suspecting the issue is pseudo-intermittent but now i am seeing it
more often then not.  This was captured on the latest next-queue pull
as of this morning.

Note I have a serial console running to this system and that is the
only way I am able to see it.  If I use a screen the message is wiped
before it can be seen due to the reboot.


[  866.930128] ------------[ cut here ]------------
[  866.936559] WARNING: CPU: 13 PID: 3001 at kernel/irq/manage.c:1447
__free_irq+0xa6/0x290
[  866.946376] Trying to free already-free IRQ 36
[  866.952530] Modules linked in: ip6_gre ip6_tunnel tunnel6 sit ipip
tunnel4 ip_gre gre vxlan i40evf(E) fou ip6_udp_tunnel udp_tunnel
ip_tunnel 8021q garp mrp i40e(E) xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun bridge stp llc ebtable_filter ebtables
ip6table_filter ip6_tables openvswitch nf_conntrack_ipv6[  866.982120]
reboot: Restarting system
[  866.982122] reboot: machine restart
[  866.993767]  nf_nat_ipv6 nf_nat_ipv4 nf_defrag_ipv6 nf_nat
ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4
xt_conntrack nf_conntrack vfat fat x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper
ablk_helper cryptd snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq
snd_seq_device snd_pcm eeepc_wmi asus_wmi iTCO_wdt mei_me
iTCO_vendor_support snd_timer sparse_keymap sb_edac video mxm_wmi snd
lpc_ich pcspkr edac_core mei i2c_i801 mfd_core soundcore shpchp
acpi_pad wmi acpi_power_meter nfsd auth_rpcgss nfs_acl lockd grace
sunrpc xfs libcrc32c mlx4_en ast drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops ttm mlx5_core drm mlx4_core ahci igb
libahci libata ptp dca i2c_algo_bit crc32c_intel serio_raw i2c_core
pps_core dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
ipmi_msghandler]
[  867.094276] CPU: 13 PID: 3001 Comm: kworker/u64:2 Tainted: G
    E   4.6.0-rc7+ #81
[  867.105027] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D8
WS/Z10PE-D8 WS, BIOS 3204 12/18/2015
[  867.116179] Workqueue: netns cleanup_net
[  867.122674]  0000000000000086 000000007263e04d ffff881fd67d3ab8
ffffffff81326aaf
[  867.132778]  ffff881fd67d3b08 0000000000000000 ffff881fd67d3af8
ffffffff81078091
[  867.142881]  000005a738f795c0 0000000000000024 0000000000000024
ffff882032cfc89c
[  867.153041] Call Trace:
[  867.158146]  [<ffffffff81326aaf>] dump_stack+0x63/0x84
[  867.165975]  [<ffffffff81078091>] __warn+0xd1/0xf0
[  867.173470]  [<ffffffff8107810f>] warn_slowpath_fmt+0x5f/0x80
[  867.181941]  [<ffffffff811dc96b>] ? __slab_free+0x9b/0x280
[  867.190160]  [<ffffffff810d1116>] __free_irq+0xa6/0x290
[  867.198109]  [<ffffffff810d1389>] free_irq+0x39/0x90
[  867.205800]  [<ffffffffa030abff>] i40e_vsi_free_irq+0x18f/0x200 [i40e]
[  867.215083]  [<ffffffff81693e6e>] ? _raw_spin_unlock_bh+0x1e/0x20
[  867.223956]  [<ffffffffa0312f95>] i40e_vsi_close+0x25/0x70 [i40e]
[  867.232849]  [<ffffffffa03132d5>] i40e_close+0x15/0x20 [i40e]
[  867.241397]  [<ffffffff81583429>] __dev_close_many+0x99/0x100
[  867.249961]  [<ffffffff81583519>] dev_close_many+0x89/0x130
[  867.258333]  [<ffffffff81585495>] dev_close.part.89+0x45/0x70
[  867.266868]  [<ffffffff81587541>] dev_change_net_namespace+0x391/0x3e0
[  867.276178]  [<ffffffff81587654>] default_device_exit+0xc4/0xf0
[  867.284860]  [<ffffffff8157e9c8>] ops_exit_list.isra.4+0x38/0x60
[  867.293646]  [<ffffffff8157fa15>] cleanup_net+0x1b5/0x2a0
[  867.301817]  [<ffffffff81090b22>] process_one_work+0x152/0x400
[  867.310401]  [<ffffffff81091415>] worker_thread+0x125/0x4b0
[  867.318714]  [<ffffffff816901f2>] ? __schedule+0x2b2/0x830
[  867.326938]  [<ffffffff810912f0>] ? rescuer_thread+0x380/0x380
[  867.335500]  [<ffffffff81096da8>] kthread+0xd8/0xf0
[  867.343101]  [<ffffffff816944c2>] ret_from_fork+0x22/0x40
[  867.351220]  [<ffffffff81096cd0>] ? kthread_park+0x60/0x60
[  867.359443] ---[ end trace 0882627aa3958ad9 ]---
