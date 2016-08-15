From: Matthew Garrett <mjg59@coreos.com>
Date: Mon, 15 Aug 2016 13:34:55 -0700
Subject: [Intel-wired-lan] ixgbe panic on ethtool after interface down/up
Message-ID: <CAPeXnHs=7G_R8spwEsZmiFV2Yu19bbumQBC4OZemsOGBMVwMuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We're seeing the following panic on ixgbe after running ethtool -K
ens802f0 l2-fwd-offload on:

[    8.742204] IPv6: ADDRCONF(NETDEV_CHANGE): ens802f0: link becomes ready
[    8.918942] ixgbe 0000:04:00.1 ens802f1: NIC Link is Down
[    8.925409] ixgbe 0000:04:00.0: removed PHC on ens802f0
[    9.023777] ixgbe 0000:04:00.1: removed PHC on ens802f1
[    9.279275] ixgbe 0000:04:00.0: Multiqueue Enabled: Rx Queue count
= 2, Tx Queue count = 2
[    9.311083] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000010
[    9.320450] IP: [<ffffffffc0371eac>]
ixgbe_alloc_rx_buffers+0x7c/0xc40 [ixgbe]
[    9.329043] PGD 0
[    9.331626] Oops: 0000 [#1] SMP
[    9.335646] Modules linked in: macvlan dummy mousedev nls_ascii
nls_cp437 vfat fat hid_generic usbhid hid br_netfilter bridge stp llc
ext4 crc16 mbcache jbd2 sd_mod coretemp x86_pkg_temp_thermal kvm
irqbypass crc32c_intel jitterentropy_rng hmac drbg ehci_pci ahci
ipmi_ssif aesni_intel ehci_hcd ipmi_devintf igb libahci aes_x86_64
i2c_algo_bit glue_helper sb_edac i2c_i801 ixgbe lrw gf128mul mei_me
hwmon libata ablk_helper ptp usbcore cryptd pps_core mei edac_core
usb_common scsi_mod i2c_core mdio ipmi_si evdev ipmi_msghandler
tpm_tis tpm button sch_fq_codel ip_tables autofs4
[    9.399082] CPU: 14 PID: 1394 Comm: systemd-network Tainted: G
    I     4.5.0-coreos-r1 #2
[    9.409362] Hardware name: Radisys TOCP-CSLED-CFG1/S2600TP, BIOS
SE5C610.86B.01.01.0009.060120151350 06/01/2015
[    9.421102] task: ffff882027479d40 ti: ffff882035ca4000 task.ti:
ffff882035ca4000
[    9.429944] RIP: 0010:[<ffffffffc0371eac>]  [<ffffffffc0371eac>]
ixgbe_alloc_rx_buffers+0x7c/0xc40 [ixgbe]
[    9.441264] RSP: 0018:ffff882035ca77d8  EFLAGS: 00010246
[    9.447481] RAX: 0000000000000200 RBX: 0000000000000000 RCX: 0000000000000000
[    9.455706] RDX: 0000000000000000 RSI: 00000000000001ff RDI: ffff882034cdb680
[    9.463933] RBP: ffff882035ca7810 R08: ffff882035ca4000 R09: 0000000000000000
[    9.472159] R10: 0000000000000005 R11: 0000000000000000 R12: 000000000000fe00
[    9.480376] R13: 0000000000000000 R14: 00000000000001ff R15: ffff882034cdb680
[    9.488604] FS:  00007f9a92e97880(0000) GS:ffff88203eec0000(0000)
knlGS:0000000000000000
[    9.498074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.504742] CR2: 0000000000000010 CR3: 0000002032b2d000 CR4: 00000000001406e0
[    9.512969] Stack:
[    9.515457]  ffff882034cdb680 ffff882035ca77f0 0000000000000009
ffff881033de4840
[    9.524455]  ffff882034cdb680 00000000000010a8 ffff881033de5680
ffff882035ca7860
[    9.533444]  ffffffffc037434b ffff881033de4840 0000000000000000
0000000200000080
[    9.542432] Call Trace:
[    9.545412]  [<ffffffffc037434b>] ixgbe_configure_rx_ring+0x2eb/0x4d0 [ixgbe]
[    9.553639]  [<ffffffffc037495a>] ixgbe_del_mac_filter+0x19a/0x1040 [ixgbe]
[    9.561667]  [<ffffffffc037a6b0>] ixgbe_setup_tc+0x2d0/0x3b0 [ixgbe]
[    9.569017]  [<ffffffffc01a9066>] macvlan_link_register+0x246/0x820 [macvlan]
[    9.577248]  [<ffffffffa1462665>] ? call_netdevice_notifiers_info+0x35/0x60
[    9.585280]  [<ffffffffa146c4e8>] __dev_open+0xc8/0x140
[    9.591366]  [<ffffffffa146c7fd>] __dev_change_flags+0x9d/0x160
[    9.598231]  [<ffffffffa146c8e9>] dev_change_flags+0x29/0x70
[    9.604809]  [<ffffffffa147ac37>] do_setlink+0x627/0xb80
[    9.610997]  [<ffffffffa1168084>] ? __alloc_pages_nodemask+0x184/0xbc0
[    9.618540]  [<ffffffffa130e950>] ? nla_parse+0xa0/0x100
[    9.624731]  [<ffffffffa1519acc>] ? inet6_validate_link_af+0x4c/0x70
[    9.632081]  [<ffffffffa147b255>] rtnl_setlink+0xc5/0x120
[    9.638358]  [<ffffffffa1498b4b>] ? __netlink_ns_capable+0x3b/0x40
[    9.649522]  [<ffffffffa1479751>] rtnetlink_rcv_msg+0xa1/0x230
[    9.656281]  [<ffffffffa11c1cdd>] ? __kmalloc_node_track_caller+0x23d/0x2e0
[    9.664313]  [<ffffffffa149a9a7>] ? __netlink_lookup+0xc7/0x110
[    9.671177]  [<ffffffffa14796b0>] ? rtnetlink_rcv+0x30/0x30
[    9.677650]  [<ffffffffa149d844>] netlink_rcv_skb+0xa4/0xc0
[    9.684112]  [<ffffffffa14796a8>] rtnetlink_rcv+0x28/0x30
[    9.690391]  [<ffffffffa149cffc>] netlink_unicast+0x12c/0x1b0
[    9.697058]  [<ffffffffa149d552>] netlink_sendmsg+0x4d2/0x5f0
[    9.703728]  [<ffffffffa144c7e8>] sock_sendmsg+0x38/0x50
[    9.709914]  [<ffffffffa144cca2>] SYSC_sendto+0x102/0x190
[    9.716197]  [<ffffffffa1112611>] ? __audit_syscall_entry+0xb1/0x100
[    9.723551]  [<ffffffffa1003176>] ? do_audit_syscall_entry+0x66/0x70
[    9.730901]  [<ffffffffa10038bf>] ? syscall_trace_enter_phase1+0x11f/0x140
[    9.738830]  [<ffffffffa144d88e>] SyS_sendto+0xe/0x10
[    9.744724]  [<ffffffffa156c06e>] entry_SYSCALL_64_fastpath+0x12/0x71
[    9.752169] Code: d0 49 83 c5 10 48 83 c3 20 49 89 45 f0 66 41 83
c4 01 0f 84 2d 01 00 00 66 41 83 ee 01 41 c7 45 08 00 00 00 00 0f 84
e7 00 00 00 <48> 83 7b 10 00 75 c5 65 8b 05 76 e9 c9 3f 48 98 31 c9 31
f6 48
[    9.778648] RIP  [<ffffffffc0371eac>]
ixgbe_alloc_rx_buffers+0x7c/0xc40 [ixgbe]
[    9.787320]  RSP <ffff882035ca77d8>
[    9.791459] CR2: 0000000000000010
[    9.795451] ---[ end trace 91a56010b1e73881 ]---
[    9.852329] Kernel panic - not syncing: Fatal exception

This is immediately after ip link set ens802f0 down; ip link set
ens802f0 up. It looks like ixgbe_alloc_mapped_page() is being passed
NULL for *bi. Is this some sort of race in the bringup code? Executing
ethtool later in boot works fine.
