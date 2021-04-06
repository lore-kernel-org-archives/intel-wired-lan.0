From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Tue, 6 Apr 2021 14:36:19 +0200
Subject: [Intel-wired-lan] [igb] netconsole triggers warning in
 netpoll_poll_dev
Message-ID: <20210406123619.rhvtr73xwwlbu2ll@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello.

I've raised this here [1] first, but was suggested to engage igb devs,
so here we are.

I'm experiencing the following woes while using netconsole regularly:

```
[22038.710800] ------------[ cut here ]------------
[22038.710801] igb_poll+0x0/0x1440 [igb] exceeded budget in poll
[22038.710802] WARNING: CPU: 12 PID: 40362 at net/core/netpoll.c:155 netpoll_poll_dev+0x18a/0x1a0
[22038.710802] Modules linked in: blocklayoutdriver rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc nfs_ssc fscache uinput netconsole rfcomm nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher af_alg nf_tables tun bnep nfnetlink iwlmvm snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio mac80211 snd_hda_codec_hdmi snd_hda_intel nls_iso8859_1 snd_intel_dspcfg soundwire_intel vfat libarc4 soundwire_generic_allocation soundwire_cadence fat intel_rapl_msr snd_hda_codec intel_rapl_common iwlwifi snd_hda_core soundwire_bus snd_usb_audio snd_soc_core eeepc_wmi btusb asus_wmi snd_usbmidi_lib btrtl edac_mce_amd sparse_keymap btbcm video wmi_bmof mxm_wmi kvm_amd snd_hwdep snd_compress btintel snd_rawmidi ac97_bus cfg80211 uvcvideo bluetooth snd_pcm_dmaengine snd_seq_device snd_pcm videobuf2_vmalloc kvm videobuf2_memops snd_timer videobuf2_v4l2 joydev igb mousedev ecdh_generic snd irqbypass pl2303 ipmi_devintf ecc videobuf2_common soundcore
[22038.710820]  r8169 ipmi_msghandler rapl crc16 k10temp rfkill sp5100_tco dca i2c_piix4 tpm_crb realtek mdio_devres tpm_tis libphy tpm_tis_core pinctrl_amd wmi acpi_cpufreq mac_hid tcp_bbr2 vhost_vsock vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock v4l2loopback videodev mc nct6775 hwmon_vid crypto_user fuse ip_tables x_tables xfs dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c crc32c_generic dm_crypt cbc encrypted_keys trusted tpm hid_logitech_hidpp hid_logitech_dj usbhid dm_mod raid10 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel md_mod crypto_simd cryptd glue_helper ccp amdgpu rng_core xhci_pci xhci_pci_renesas drm_ttm_helper ttm gpu_sched i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm agpgart
[22038.710835] CPU: 12 PID: 40362 Comm: systemd-sleep Not tainted 5.11.0-pf7 #1
[22038.710836] Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 3302 03/05/2021
[22038.710836] RIP: 0010:netpoll_poll_dev+0x18a/0x1a0
[22038.710837] Code: 6e ff 80 3d d2 9d f8 00 00 0f 85 5c ff ff ff 48 8b 73 28 48 c7 c7 0c b8 21 84 89 44 24 04 c6 05 b6 9d f8 00 01 e8 84 21 1c 00 <0f> 0b 8b 54 24 04 e9 36 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
[22038.710838] RSP: 0018:ffffb24106e37ba0 EFLAGS: 00010086
[22038.710838] RAX: 0000000000000000 RBX: ffff9599d2929c50 RCX: ffff959f8ed1ac30
[22038.710839] RDX: 0000000000000000 RSI: 0000000000000023 RDI: ffff959f8ed1ac28
[22038.710839] RBP: ffff9598981d4058 R08: 0000000000000019 R09: ffffb24206e3796d
[22038.710839] R10: ffffffffffffffff R11: ffffb24106e37968 R12: ffff959887e51ec8
[22038.710840] R13: 000000000000000c R14: 00000000ffffffff R15: ffff9599d2929c60
[22038.710840] FS:  00007f3ade370a40(0000) GS:ffff959f8ed00000(0000) knlGS:0000000000000000
[22038.710841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22038.710841] CR2: 0000000000000000 CR3: 00000003017b0000 CR4: 0000000000350ee0
[22038.710841] Call Trace:
[22038.710842]  netpoll_send_skb+0x185/0x240
[22038.710842]  write_msg+0xe5/0x100 [netconsole]
[22038.710842]  console_unlock+0x37d/0x640
[22038.710842]  ? __schedule+0x2e5/0xc90
[22038.710843]  suspend_devices_and_enter+0x2ac/0x7f0
[22038.710843]  pm_suspend.cold+0x321/0x36c
[22038.710843]  state_store+0xa6/0x140
[22038.710844]  kernfs_fop_write_iter+0x124/0x1b0
[22038.710844]  new_sync_write+0x16a/0x200
[22038.710844]  vfs_write+0x21c/0x2e0
[22038.710844]  __x64_sys_write+0x6d/0xf0
[22038.710845]  do_syscall_64+0x33/0x40
[22038.710845]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[22038.710845] RIP: 0033:0x7f3adece10f7
[22038.710846] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[22038.710847] RSP: 002b:00007ffc51c555b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[22038.710847] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f3adece10f7
[22038.710848] RDX: 0000000000000004 RSI: 00007ffc51c556a0 RDI: 0000000000000004
[22038.710848] RBP: 00007ffc51c556a0 R08: 000055ea374302a0 R09: 00007f3aded770c0
[22038.710849] R10: 00007f3aded76fc0 R11: 0000000000000246 R12: 0000000000000004
[22038.710849] R13: 000055ea3742c430 R14: 0000000000000004 R15: 00007f3adedb3700
[22038.710849] ---[ end trace 6eae54fbf23807f8 ]---
```

This one happened during suspend/resume cycle (on resume), followed by:

```
[22038.868669] igb 0000:05:00.0 enp5s0: Reset adapter
[22040.998673] igb 0000:05:00.0 enp5s0: Reset adapter
[22043.819198] igb 0000:05:00.0 enp5s0: igb: enp5s0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
```

I've bumped into a similar issue in BZ 211911 [2] (see c#16),
and in c#17 it was suggested it was a separate unrelated issue,
hence I'm raising a new concern.

Please help in finding out why this woe happens and in fixing it.

Thanks.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212573
[2] https://bugzilla.kernel.org/show_bug.cgi?id=211911

-- 
  Oleksandr Natalenko (post-factum)
