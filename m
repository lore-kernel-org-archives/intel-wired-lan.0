From: nick black <dankamongmen@gmail.com>
Date: Sun, 27 Feb 2022 05:45:54 -0500
Subject: [Intel-wired-lan] igb oops in __igb_open, possibly pm related
Message-ID: <YhtWYuTYkIdBL7+o@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hey there! I've got a Gigabyte Aorus Master TRX40 motherboard
with an onboard I211 (rev 03). It's worked beautifully up until
recently, when I overhauled the containing machine (this
included installing a monoblock onto the motherboard). I'm now
getting this oops reliably on startup:

[   78.205687] RTNL: assertion failed at net/core/dev.c (2968)
[   78.206255] WARNING: CPU: 0 PID: 7 at net/core/dev.c:2968 netif_set_real_num_rx_queues+0x73/0x90
[   78.206818] Modules linked in: ctr(E) ccm(E) wireguard(E) libchacha20poly1305(E) chacha_x86_64(E) poly1305_x86_64(E) ip6_udp_tunnel(E) udp_tunnel(E) libblake2s(E) blake2s_x86_64(E) libblake2s_generic(E) curve25519_x86_64(E) libcurve25519_generic(E) libchacha(E) nvme_fabrics(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) cpufreq_userspace(E) cpufreq_conservative(E) cpufreq_powersave(E) ip6table_filter(E) xt_state(E) ip6table_nat(E) xt_conntrack(E) ip6_tables(E) iptable_nat(E) xt_MASQUERADE(E) nf_nat(E) nf_conntrack(E) iptable_filter(E) nf_defrag_ipv6(E) xt_multiport(E) nf_defrag_ipv4(E) btusb(E) iwlmvm(E) btrtl(E) btbcm(E) btintel(E) cdc_acm(E) mac80211(E) libarc4(E) bluetooth(E) iwlwifi(E) ecdh_generic(E) joydev(E) cfg80211(E) rfkill(E) intel_rapl_msr(E) edac_mce_amd(E) edac_core(E) intel_rapl_common(E) iosf_mbi(E) wmi_bmof(E) mxm_wmi(E) snd_usb_audio(E) kvm_amd(E) snd_usbmidi_lib(E) snd_hwdep(E) snd_rawmidi(E) snd_seq_device(E) evdev(E) kvm(E) mc(E) irqbypass(E)
[   78.206838]  crct10dif_pclmul(E) ghash_clmulni_intel(E) aesni_intel(E) libaes(E) crypto_simd(E) zfs(POE) cryptd(E) snd_pcm_oss(E) snd_mixer_oss(E) snd_pcm(E) snd_timer(E) snd(E) zunicode(POE) soundcore(E) pcspkr(E) efi_pstore(E) zzstd(OE) nls_ascii(E) zlua(OE) nls_cp437(E) zavl(POE) vfat(E) tcp_bbr(E) icp(POE) fat(E) sch_fq(E) zcommon(POE) znvpair(POE) pkcs8_key_parser(E) spl(OE) nvidia_drm(POE) ccp(E) sp5100_tco(E) watchdog(E) sg(E) tpm_crb(E) drm_kms_helper(E) cec(E) tpm_tis(E) tpm_tis_core(E) nvidia_modeset(POE) tpm(E) wmi(E) rng_core(E) button(E) acpi_cpufreq(E) nvidia(POE) drivetemp(E) k10temp(E) it87(E) hwmon_vid(E) cpuid(E) ipmi_devintf(E) ipmi_msghandler(E) msr(E) i2c_dev(E) fuse(E) drm(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) btrfs(E) zstd_compress(E) efivarfs(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) raid0(E)
[   78.211382]  hid_logitech_hidpp(E) hid_logitech_dj(E) hid_generic(E) usbhid(E) hid(E) igb(E) crc32_pclmul(E) atlantic(E) xhci_pci(E) i2c_algo_bit(E) crc32c_intel(E) dca(E) macsec(E) xhci_hcd(E) ptp(E) pps_core(E) usbcore(E) usb_common(E) nvme(E) nvme_core(E)
[   78.217976] CPU: 0 PID: 7 Comm: kworker/0:1 Tainted: P        W  OE     5.16.9nlb2 #1
[   78.218621] Hardware name: Gigabyte Technology Co., Ltd. TRX40 AORUS MASTER/TRX40 AORUS MASTER, BIOS F6 11/23/2021
[   78.219281] Workqueue: pm pm_runtime_work
[   78.219936] RIP: 0010:netif_set_real_num_rx_queues+0x73/0x90
[   78.220595] Code: eb de 80 3d c7 f6 ec 00 00 75 e1 ba 98 0b 00 00 48 c7 c6 ec 71 57 ae 48 c7 c7 10 e4 4e ae c6 05 ab f6 ec 00 01 e8 1a 47 1b 00 <0f> 0b eb be b8 ea ff ff ff c3 b8 ea ff ff ff eb a5 66 66 2e 0f 1f
[   78.221941] RSP: 0018:ffffc242000a7cc8 EFLAGS: 00010282
[   78.222622] RAX: 0000000000000000 RBX: ffff9f8069808000 RCX: 0000000000000027
[   78.223309] RDX: ffff9fbe4d01c708 RSI: 0000000000000001 RDI: ffff9fbe4d01c700
[   78.224000] RBP: 0000000000000002 R08: 0000000000000000 R09: ffffc242000a7af0
[   78.224697] R10: ffffc242000a7ae8 R11: ffff9fbf4f0c09a8 R12: ffff9f8069808000
[   78.225391] R13: ffff9f8069808e90 R14: ffff9f8069808000 R15: 0000000000000000
[   78.226090] FS:  0000000000000000(0000) GS:ffff9fbe4d000000(0000) knlGS:0000000000000000
[   78.226797] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.227508] CR2: 00007f248407cb60 CR3: 0000001875e0a000 CR4: 0000000000350ef0
[   78.228231] Call Trace:
[   78.228946]  <TASK>
[   78.229654]  __igb_open+0x439/0x690 [igb]
[   78.230373]  __igb_resume+0x1d8/0x200 [igb]
[   78.231092]  pci_pm_runtime_resume+0xaa/0xc0
[   78.231807]  ? pci_pm_restore+0xe0/0xe0
[   78.232523]  __rpm_callback+0x46/0x150
[   78.233236]  rpm_callback+0x35/0x70
[   78.233946]  ? pci_pm_restore+0xe0/0xe0
[   78.234658]  rpm_resume+0x4f8/0x790
[   78.235366]  ? process_one_work+0x1e8/0x390
[   78.236081]  pm_runtime_work+0x6c/0xa0
[   78.236787]  process_one_work+0x1e8/0x390
[   78.237489]  worker_thread+0x53/0x3c0
[   78.238176]  ? process_one_work+0x390/0x390
[   78.238847]  kthread+0x143/0x160
[   78.239500]  ? set_kthread_struct+0x40/0x40
[   78.240143]  ret_from_fork+0x22/0x30
[   78.240764]  </TASK>
[   78.241366] ---[ end trace aef746301a0d8746 ]---

this immediately follows another oops, one which doesn't point
at igb, but i'll include for completeness:

[   78.167184] ------------[ cut here ]------------
[   78.167638] RTNL: assertion failed at net/core/dev.c (2920)
[   78.168094] WARNING: CPU: 0 PID: 7 at net/core/dev.c:2920 netif_set_real_num_tx_queues+0x1a8/0x1c0
[   78.168547] Modules linked in: ctr(E) ccm(E) wireguard(E) libchacha20poly1305(E) chacha_x86_64(E) poly1305_x86_64(E) ip6_udp_tunnel(E) udp_tunnel(E) libblake2s(E) blake2s_x86_64(E) libblake2s_generic(E) curve25519_x86_64(E) libcurve25519_generic(E) libchacha(E) nvme_fabrics(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) cpufreq_userspace(E) cpufreq_conservative(E) cpufreq_powersave(E) ip6table_filter(E) xt_state(E) ip6table_nat(E) xt_conntrack(E) ip6_tables(E) iptable_nat(E) xt_MASQUERADE(E) nf_nat(E) nf_conntrack(E) iptable_filter(E) nf_defrag_ipv6(E) xt_multiport(E) nf_defrag_ipv4(E) btusb(E) iwlmvm(E) btrtl(E) btbcm(E) btintel(E) cdc_acm(E) mac80211(E) libarc4(E) bluetooth(E) iwlwifi(E) ecdh_generic(E) joydev(E) cfg80211(E) rfkill(E) intel_rapl_msr(E) edac_mce_amd(E) edac_core(E) intel_rapl_common(E) iosf_mbi(E) wmi_bmof(E) mxm_wmi(E) snd_usb_audio(E) kvm_amd(E) snd_usbmidi_lib(E) snd_hwdep(E) snd_rawmidi(E) snd_seq_device(E) evdev(E) kvm(E) mc(E) irqbypass(E)id456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) raid0(E) fe ff ff 66 0f 1f 44
[   78.197106]  ? pci_pm_restore+0xe0/0xe0
[   78.197824]  rpm_resume+0x4f8/0x790
[   78.198536]  ? process_one_work+0x1e8/0x390
[   78.199247]  pm_runtime_work+0x6c/0xa0
[   78.199951]  process_one_work+0x1e8/0x390
[   78.200655]  worker_thread+0x53/0x3c0
[   78.201340]  ? process_one_work+0x390/0x390
[   78.202009]  kthread+0x143/0x160
[   78.202660]  ? set_kthread_struct+0x40/0x40
[   78.203297]  ret_from_fork+0x22/0x30
[   78.203918]  </TASK>
[   78.204521] ---[ end trace aef746301a0d8745 ]---

the interface no longer seems to see any incoming packets. has
anyone ever seen an I211 fail in this fashion (i.e., it can be
detected just fine, but then can't see frames)? is it likely
that i damaged it, or that some new hardware is somehow
conflicting with it, or is there simply a kernel bug i've
suddenly started tripping?

i'm happy to compile and test any experiments you'd like. please
cc me, as i am not subscribed to this list.

[schwarzgerat](0) $ ethtool -i igb
driver: igb
version: 5.16.9nlb2
firmware-version:  0. 6-1
expansion-rom-version:
bus-info: 0000:44:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
[schwarzgerat](0) $

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
