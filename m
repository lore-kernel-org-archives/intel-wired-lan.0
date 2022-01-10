From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Mon, 10 Jan 2022 18:07:11 +0200
Subject: [Intel-wired-lan] "Missing unregister,
 handled but fix driver" when changing ring settings on igc interface
Message-ID: <YdxZr0wMxvsDCpbV@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I didn't see this reported yet.  When doing e.g. this on an igc
interface (I225-V):

	# ethtool -G enp3s0 rx 512

I get a few warnings like the following:

[  225.198467] ------------[ cut here ]------------
[  225.198473] Missing unregister, handled but fix driver
[  225.198485] WARNING: CPU: 7 PID: 959 at net/core/xdp.c:168 xdp_rxq_info_reg+0x79/0xd0
[...]
[  225.198601] Call Trace:
[  225.198604]  <TASK>
[  225.198609]  igc_setup_rx_resources+0x3f/0xe0 [igc]
[  225.198617]  igc_ethtool_set_ringparam+0x30e/0x450 [igc]
[  225.198626]  ethnl_set_rings+0x18a/0x250
[  225.198631]  genl_family_rcv_msg_doit+0xca/0x110
[  225.198637]  genl_rcv_msg+0xce/0x1c0
[  225.198640]  ? rings_prepare_data+0x60/0x60
[  225.198644]  ? genl_get_cmd+0xd0/0xd0
[  225.198647]  netlink_rcv_skb+0x4e/0xf0
[  225.198652]  genl_rcv+0x24/0x40
[  225.198655]  netlink_unicast+0x20e/0x330
[  225.198659]  netlink_sendmsg+0x23f/0x480
[  225.198663]  sock_sendmsg+0x5b/0x60
[  225.198667]  __sys_sendto+0xf0/0x160
[  225.198671]  ? handle_mm_fault+0xb2/0x280
[  225.198676]  ? do_user_addr_fault+0x1eb/0x690
[  225.198680]  __x64_sys_sendto+0x20/0x30
[  225.198683]  do_syscall_64+0x38/0x90
[  225.198687]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  225.198693] RIP: 0033:0x7f7ae38ac3aa

This is on vanilla 5.16.


Thanks,
Lennert
