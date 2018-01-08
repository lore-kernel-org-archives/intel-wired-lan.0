From: wangyunjian <wangyunjian@huawei.com>
Date: Mon, 8 Jan 2018 09:31:13 +0000
Subject: [Intel-wired-lan] BUG: 4.15.0-rc6 unable to handle kernel NULL
 pointer dereference in ixgbe_down
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60C7093CF@dggemm513-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm running into a NULL pointer dereference in ixgbe_down on b84449dc14d274a3f3c78cd734b702ca31aa4dd1
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master.

I think the variable adapter->vfinfo has not been protected well, when disable sriov and down nic.
Anyone has an idea to protect it?

Test script 1:
while true
do
??? ifconfig eth3 up
??? ifconfig eth3 down
done

Test script 2:
while true
do
??? echo 63 > /sys/class/net/eth3/device/sriov_numvfs
??? echo 0 > /sys/class/net/eth3/device/sriov_numvfs
done

2018-01-08T16:27:33.786608+08:00|alert|kernel[-]|[? 906.719083] BUG: unable to handle kernel NULL pointer dereference at 000000000000004c
2018-01-08T16:27:33.786642+08:00|alert|kernel[-]|[? 906.727054] IP: ixgbe_down+0x481/0x490 [ixgbe]
2018-01-08T16:27:33.786663+08:00|info|kernel[-]|[? 906.731569] PGD 0 P4D 0 
2018-01-08T16:27:33.786687+08:00|warning|kernel[-]|[? 906.734180] Oops: 0002 [#1] SMP PTI
2018-01-08T16:27:33.787249+08:00|warning|kernel[-]|[? 906.829962] CPU: 12 PID: 28819 Comm: ifconfig Tainted: G????? ?????OE??? 4.15.0-rc6+ #4
2018-01-08T16:27:33.787270+08:00|warning|kernel[-]|[? 906.838074] Hardware name: Huawei Technologies Co., Ltd. Tecal XH620?????????? /BC21THSA????????????? , BIOS TTSAV020 12/02/2011
2018-01-08T16:27:33.787294+08:00|warning|kernel[-]|[? 906.849738] RIP: 0010:ixgbe_down+0x481/0x490 [ixgbe]
2018-01-08T16:27:33.787315+08:00|warning|kernel[-]|[? 906.854773] RSP: 0018:ffffc9002757fcb0 EFLAGS: 00010246
2018-01-08T16:27:33.787336+08:00|warning|kernel[-]|[? 906.860068] RAX: 0000000000000000 RBX: ffff881ffa2208c0 RCX: 0000000000000000
2018-01-08T16:27:33.787356+08:00|warning|kernel[-]|[? 906.867268] RDX: 0000000000000000 RSI: ffff880fffb96938 RDI: ffff880fffb96938
2018-01-08T16:27:33.787377+08:00|warning|kernel[-]|[? 906.874466] RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000000046e
2018-01-08T16:27:33.787398+08:00|warning|kernel[-]|[? 906.881667] R10: 0000000000000003 R11: 0000000000000000 R12: ffff881ffa221900
2018-01-08T16:27:33.787418+08:00|warning|kernel[-]|[? 906.888867] R13: ffff881ffa221178 R14: 0000000000000040 R15: ffff881fe5934f40
2018-01-08T16:27:33.787439+08:00|warning|kernel[-]|[? 906.896069] FS:? 00007f3cadc66740(0000) GS:ffff880fffb80000(0000) knlGS:0000000000000000
2018-01-08T16:27:33.787464+08:00|warning|kernel[-]|[? 906.904275] CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2018-01-08T16:27:33.787488+08:00|warning|kernel[-]|[? 906.910093] CR2: 000000000000004c CR3: 0000000fff260005 CR4: 00000000000206e0
2018-01-08T16:27:33.787508+08:00|warning|kernel[-]|[? 906.917293] Call Trace:
2018-01-08T16:27:33.787528+08:00|warning|kernel[-]|[? 906.919824]? ixgbe_close_suspend+0x5c/0x60 [ixgbe]
2018-01-08T16:27:33.787549+08:00|warning|kernel[-]|[? 906.924690]? ixgbe_close+0x2d/0xc0 [ixgbe]
2018-01-08T16:27:33.787570+08:00|warning|kernel[-]|[? 906.928862]? __dev_close_many+0x9e/0x100
2018-01-08T16:27:33.787593+08:00|warning|kernel[-]|[? 906.932859]? __dev_change_flags+0xda/0x1e0
2018-01-08T16:27:33.787614+08:00|warning|kernel[-]|[? 906.937029]? dev_change_flags+0x23/0x60
2018-01-08T16:27:33.787636+08:00|warning|kernel[-]|[? 906.940943]? devinet_ioctl+0x670/0x740
2018-01-08T16:27:33.787659+08:00|warning|kernel[-]|[? 906.944771]? sock_do_ioctl+0x20/0x50
2018-01-08T16:27:33.787680+08:00|warning|kernel[-]|[? 906.948420]? sock_ioctl+0x1e4/0x2c0
2018-01-08T16:27:33.787699+08:00|warning|kernel[-]|[? 906.951987]? do_vfs_ioctl+0xa6/0x5f0
2018-01-08T16:27:33.787719+08:00|warning|kernel[-]|[? 906.955641]? ? __do_page_fault+0x273/0x4d0
2018-01-08T16:27:33.787740+08:00|warning|kernel[-]|[? 906.959812]? SyS_ioctl+0x74/0x80
2018-01-08T16:27:33.787759+08:00|warning|kernel[-]|[? 906.963117]? ? do_page_fault+0x33/0x120
2018-01-08T16:27:33.787780+08:00|warning|kernel[-]|[? 906.967033]? entry_SYSCALL_64_fastpath+0x1a/0x7d
2018-01-08T16:27:33.787805+08:00|warning|kernel[-]|[? 906.971725] RIP: 0033:0x7f3cad784507
2018-01-08T16:27:33.787825+08:00|warning|kernel[-]|[? 906.975374] RSP: 002b:00007fff54fdbe98 EFLAGS: 00000206
2018-01-08T16:27:33.787846+08:00|warning|kernel[-]|[? 906.975376] Code: b2 e0 bf 10 27 00 00 e8 2e 6a b4 e0 48 c7 c7 a4 89 5e a0 31 c0 e8 70 d5 b2 e0 48 63 c5 83 c5 01 48 6b c0 60 48 03 83 70 a0 01 00 <c6> 40 4c 00 e9 e3 fd ff ff 66 0f 1f 44 00 00 66 66 66 66 90 55 
2018-01-08T16:27:33.787867+08:00|alert|kernel[-]|[? 906.999682] RIP: ixgbe_down+0x481/0x490 [ixgbe] RSP: ffffc9002757fcb0
2018-01-08T16:27:33.787889+08:00|warning|kernel[-]|[? 907.006188] CR2: 000000000000004c
2018-01-08T16:27:33.787911+08:00|warning|kernel[-]|[? 907.009595] ---[ end trace 4a410621e06f2d79 ]---
