From: Sumit Gemini1 <sumit.gemini1@globallogic.com>
Date: Mon, 24 Oct 2016 11:41:58 +0530
Subject: [Intel-wired-lan] Deadlock in igb network driver.
Message-ID: <CAAooqb0rOOkSORQshJ5JQrfe3u4WJ6=XxaXNY8Z157C6q1UHhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have one issue, at customer machine the user space process is hogging up
the processor (soft lockup)along with 2 kernel process and dump stack trace
showing RIP at _ticket_spin_lock in all 3 process.

As i know "If an user-space process had caused the soft-lockup, a line
identifying the process by its pid would logged, followed by the contents
of various CPU-registers without a call-trace of any sorts" but in my case
i am getting dump stack trace for user process too.

is it coming from a misbehaving user space app? is it normal functionality
of soft lockup? if is it functionality of soft lockup then how to resolve
the issue?

Any help will be highly appreciated.

it is x86_64 machine and kernel is 3.1.10. I know all 3 process are waiting
for _ticket_spin_lock. see :-

Aug 26 09:31:58 at-vie01a-cq21b kernel: [115452.492033] BUG: soft
lockup - CPU#3 stuck for 22s! [virtio_shm/5/3:7874]
Aug 26 09:32:00 at-vie01a-cq21b kernel: [115455.404215] BUG: soft
lockup - CPU#31 stuck for 23s! [kni_thread:6605]
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172014] BUG: soft
lockup - CPU#0 stuck for 22s! [gis:14145]

here gis is my user space process but has call trace.

Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172014] BUG: soft
lockup - CPU#0 stuck for 22s! [gis:14145]
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172017] Modules linked
in: xt_sharedlimit xt_hashlimit ip_set_hash_ipport
ip_set_hash_ipportip xt_NOTRACK ip_set_bitmap_port xt_sctp
nf_conntrack_ipv6 nf_defrag_ipv6 xt_CT arpt_mangle ip_set_hash_ipnet
xt_NFLOG xt_limit xt_hashcounter ip_set_hash_ipip xt_set
ip_set_hash_ip deflate ctr twofish_x86_64 twofish_common camellia
serpent blowfish cast5 des_generic cbc xcbc rmd160 crypto_null af_key
iptable_mangle ip_set arptable_filter arp_tables iptable_raw
iptable_nat nfnetlink_log nfnetlink ipt_ULOG ipt_PORTMAP af_packet
zlib zlib_deflate sha512_generic sha256_generic sha1_generic md5
icp_qa_al pcie8120 rte_kni pfe_pep virtio_rte virtio_shm virtio_vtnet
virtio_uio igb_uio virtio_ring virtio uio xt_tcpudp xt_state
xt_pkttype nf_conntrack_control bonding binfmt_misc iptable_filter
ip6table_filter ip6_tables nf_nat_ftp nf_nat nf_conntrack_ftp
nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables x_tables mperf ipmi_devintf
ipmi_si ipmi_msghandler edd nf_conntrack_proto_sctp nf_conntrack sctp
8021q garp stp llc gb_sys usb_storage uas iTCO_wdt ioatdma pcspkr
iTCO_vendor_support ixgbe igb wmi i2c_i801 mdio dca sg button
container ipv6 autofs4 usbhid ehci_hcd megasr(P) usbcore processor
thermal_sys
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172098] CPU 0
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172099] Modules linked
in: xt_sharedlimit xt_hashlimit ip_set_hash_ipport
ip_set_hash_ipportip xt_NOTRACK ip_set_bitmap_port xt_sctp
nf_conntrack_ipv6 nf_defrag_ipv6 xt_CT arpt_mangle ip_set_hash_ipnet
xt_NFLOG xt_limit xt_hashcounter ip_set_hash_ipip xt_set
ip_set_hash_ip deflate ctr twofish_x86_64 twofish_common camellia
serpent blowfish cast5 des_generic cbc xcbc rmd160 crypto_null af_key
iptable_mangle ip_set arptable_filter arp_tables iptable_raw
iptable_nat nfnetlink_log nfnetlink ipt_ULOG ipt_PORTMAP af_packet
zlib zlib_deflate sha512_generic sha256_generic sha1_generic md5
icp_qa_al pcie8120 rte_kni pfe_pep virtio_rte virtio_shm virtio_vtnet
virtio_uio igb_uio virtio_ring virtio uio xt_tcpudp xt_state
xt_pkttype nf_conntrack_control bonding binfmt_misc iptable_filter
ip6table_filter ip6_tables nf_nat_ftp nf_nat nf_conntrack_ftp
nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables x_tables mperf ipmi_devintf
ipmi_si ipmi_msghandler edd nf_conntrack_proto_sctp nf_conntrack sctp
8021q garp stp llc gb_sys usb_storage uas iTCO_wdt ioatdma pcspkr
iTCO_vendor_support ixgbe igb wmi i2c_i801 mdio dca sg button
container ipv6 autofs4 usbhid ehci_hcd megasr(P) usbcore processor
thermal_sys
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172163]
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172166] Pid: 14145,
comm: gis Tainted: P 3.1.10-gb20-default #1 Intel Corporation
S2600CO/S2600CO
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172170] RIP:
0010:[<ffffffff8102064d>] [<ffffffff8102064d>]
__ticket_spin_lock+0x15/0x1b
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172178] RSP:
0000:ffff88043ee03cf0 EFLAGS: 00000293
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172180] RAX:
00000000000069bf RBX: 00000000020110ac RCX: 000000000000000e
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172182] RDX:
00000000000069bc RSI: 000000000000000e RDI: ffff88041e56a484
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172184] RBP:
ffff88041e56a484 R08: ffff88041e56a740 R09: ffff8804154a5840
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172187] R10:
00007f0afce77000 R11: 0000000000000000 R12: ffff88043ee03c68
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172189] R13:
ffffffff813f831e R14: ffff88041e56a484 R15: ffff88041e568280
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172192] FS:
00007f0afd70b700(0000) GS:ffff88043ee00000(0000)
knlGS:0000000000000000
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172194] CS: 0010 DS:
0000 ES: 0000 CR0: 0000000080050033
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172196] CR2:
00007f54f6b88098 CR3: 000000042427e000 CR4: 00000000000406f0
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172199] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172201] DR3:
0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172204] Process gis
(pid: 14145, threadinfo ffff88037537e000, task ffff88036a8fe180)
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172205] Stack:
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172207]
ffffffff8106b766 ffffffffa05e3a1e 0000000101b72e68 ffff8808260ae680
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172213]
0000002e1e568280 ffff880420450000 ffff88041f887a00 ffff880420450000
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172218]
ffffffff8192a870 0000000000000608 0000000000000000 ffffffff81928b00
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172224] Call Trace:
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172233]
[<ffffffff8106b766>] do_raw_spin_lock+0x5/0x8
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172240]
[<ffffffffa05e3a1e>] packet_rcv+0x254/0x2ab [af_packet]
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172257]
[<ffffffff81337bbf>] __netif_receive_skb+0x2e1/0x36b
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172262]
[<ffffffff81339722>] netif_receive_skb+0x7e/0x84
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172266]
[<ffffffff8133979e>] napi_skb_finish+0x1c/0x31
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172277]
[<ffffffffa031adee>] igb_clean_rx_irq+0x30d/0x39e [igb]
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172298]
[<ffffffffa031aecd>] igb_poll+0x4e/0x74 [igb]
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172313]
[<ffffffff81339c88>] net_rx_action+0x65/0x178
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172319]
[<ffffffff81045c73>] __do_softirq+0xb2/0x19d
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172324]
[<ffffffff813f9aac>] call_softirq+0x1c/0x30
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172329]
[<ffffffff81003931>] do_softirq+0x3c/0x7b
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172333]
[<ffffffff81045f98>] irq_exit+0x3c/0xac
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172337]
[<ffffffff81003655>] do_IRQ+0x82/0x98
Aug 26 09:32:01 at-vie01a-cq21b kernel: [115456.172342]
[<ffffffff813f24ee>] common_interrupt+0x6e/0x6e

someone suggest me it is a problem in the igb network interface driver

Please help me in this issue.

Thanks

~Sumit Gemini





-- 

Name | Title
GlobalLogic
P +x.xxx.xxx.xxxx  M +x.xxx.xxx.xxxx  S skype
www.globallogic.com
<http://www.globallogic.com/>
http://www.globallogic.com/email_disclaimer.txt
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161024/fe250d60/attachment.html>
