From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 5 May 2016 15:24:45 -0700
Subject: [Intel-wired-lan] "Trying to free already-free IRQ" error on i40e
	next-queue/dev-queue
Message-ID: <CAKgT0UfqtZC9C1Z8ffkYfTg04A5EiA34u5-4LbBnKwtj0jvCrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

So on the latest pull of the dev-queue branch of next-queue I am
seeing the following error on shutdown when I have been using i40e:

[ 2627.661836] ------------[ cut here ]------------
[ 2627.667263] WARNING: CPU: 0 PID: 11386 at kernel/irq/manage.c:1447
__free_irq+0xa6/0x290
[ 2627.675995] Trying to free already-free IRQ 36
[ 2627.681082] Modules linked in: ip6_gre ip6_tunnel tunnel6 sit ipip
tunnel4 ip_gre gre vxlan i40evf(E) fou ip6_ud
p_tunnel udp_tunnel ip_tunnel 8021q garp mrp stp llc i40e(E) vfat fat
x86_pkg_temp_thermal intel_powerclamp coretem
p kvm_intel snd_hda_codec_realtek snd_hda_codec_generic kvm
snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_
seq irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
snd_seq_device snd_pcm iTCO_wdt mei_me eeepc_wmi ae
sni_intel asus_wmi lrw gf128mul sparse_keymap snd_timer glue_helper
ablk_helper iTCO_vendor_support cryptd video mx
m_wmi snd sb_edac lpc_ich mei i2c_i801 pcspkr edac_core shpchp
mfd_core soundcore acpi_power_meter wmi acpi_pad ip_
tables xfs libcrc32c mlx4_en ast drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops ttm igb mlx5_core drm
 mlx4_core ahci libahci dca i2c_algo_bit serio_raw libata crc32c_intel
ptp i2c_core pps_core dm_mirror dm_region_ha
sh dm_log dm_mod [last unloaded: ipmi_msghandler]
[ 2627.771305] CPU: 0 PID: 11386 Comm: kworker/u64:2 Tainted: G
    E   4.6.0-rc6+ #61
[ 2627.780388] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D8
WS/Z10PE-D8 WS, BIOS 3204 12/18/2015
[ 2627.789824] Workqueue: netns cleanup_net
[ 2627.794609]  0000000000000086 0000000022dea3b3 ffff88202fcc7ab8
ffffffff8132684f
[ 2627.802940]  ffff88202fcc7b08 0000000000000000 ffff88202fcc7af8
ffffffff81078091
[ 2627.811320]  000005a738c65700 0000000000000024 0000000000000024
ffff8820380a3e9c
[ 2627.819657] Call Trace:
[ 2627.822984]  [<ffffffff8132684f>] dump_stack+0x63/0x84
[ 2627.829040]  [<ffffffff81078091>] __warn+0xd1/0xf0
[ 2627.834766]  [<ffffffff8107810f>] warn_slowpath_fmt+0x5f/0x80
[ 2627.841442]  [<ffffffff811dc85b>] ? __slab_free+0x9b/0x280
[ 2627.847868]  [<ffffffff810d11a6>] __free_irq+0xa6/0x290
[ 2627.854024]  [<ffffffff810d1419>] free_irq+0x39/0x90
[ 2627.859908]  [<ffffffffa0197bff>] i40e_vsi_free_irq+0x18f/0x200 [i40e]
[ 2627.867364]  [<ffffffff8169354e>] ? _raw_spin_unlock_bh+0x1e/0x20
[ 2627.874385]  [<ffffffffa019ff95>] i40e_vsi_close+0x25/0x70 [i40e]
[ 2627.881449]  [<ffffffffa01a02d5>] i40e_close+0x15/0x20 [i40e]
[ 2627.888138]  [<ffffffff81582c39>] __dev_close_many+0x99/0x100
[ 2627.894827]  [<ffffffff81582d29>] dev_close_many+0x89/0x130
[ 2627.901372]  [<ffffffff81584ca5>] dev_close.part.89+0x45/0x70
[ 2627.908123]  [<ffffffff81586d51>] dev_change_net_namespace+0x391/0x3e0
[ 2627.913981] ACPI: Preparing to enter system sleep state S5
[ 2627.967435]  [<ffffffff81586e64>] default_device_exit+0xc4/0xf0
[ 2627.974358]  [<ffffffff8157e1d8>] ops_exit_list.isra.4+0x38/0x60
[ 2627.981307]  [<ffffffff8157f225>] cleanup_net+0x1b5/0x2a0
[ 2627.987655]  [<ffffffff81090b22>] process_one_work+0x152/0x400
[ 2627.994437]  [<ffffffff81091415>] worker_thread+0x125/0x4b0
[ 2628.000975]  [<ffffffff810912f0>] ? rescuer_thread+0x380/0x380
[ 2628.007735]  [<ffffffff81096da8>] kthread+0xd8/0xf0
[ 2628.013533]  [<ffffffff81693b82>] ret_from_fork+0x22/0x40
[ 2628.019851]  [<ffffffff81096cd0>] ? kthread_park+0x60/0x60
[ 2628.026255] ---[ end trace 369d10b6dd193e9b ]---

This appears to be something recent.  I hadn't seen this until today,
but I had been focusing on getting the Mellanox stuff up and running
so it may have just been that I wasn't testing it.  Still though I
would guess this was something introduced in the last couple of weeks.

I don't know if it has any impact on this issue, but my test setup has
7 VFs allocated, assigned to namespaces, and passing traffic.

Thanks.

- Alex
