From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 14 Sep 2016 23:57:24 +0000
Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] e1000: track BQL
 bytes regardless of skb or not
In-Reply-To: <20160912221327.5610.74333.stgit@john-Precision-Tower-5810>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221327.5610.74333.stgit@john-Precision-Tower-5810>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F90268@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of John Fastabend
> Sent: Monday, September 12, 2016 3:13 PM
> To: bblanco at plumgrid.com; john.fastabend at gmail.com;
> alexei.starovoitov at gmail.com; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; brouer at redhat.com; davem at davemloft.net
> Cc: xiyou.wangcong at gmail.com; intel-wired-lan at lists.osuosl.org;
> u9012063 at gmail.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] e1000: track BQL bytes
> regardless of skb or not
> 
> The BQL API does not reference the sk_buff nor does the driver need to
> reference the sk_buff to calculate the length of a transmitted frame.
> This patch removes an sk_buff reference from the xmit irq path and
> also allows packets sent from XDP to use BQL.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

This patch is causing all my e1000 adapters to fail a simple ftp session with really slow response (hashing on) followed by adapter resets.  I have seen this on 4 different e1000 nics now, an 82543GC, 82544GC, 82546EB and an 82545GM.  On a few occasions I get a splat captured to dmesg.  Here is an example:
--------------------------------
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:316 dev_watchdog+0x1c2/0x1d0
NETDEV WATCHDOG: eth1 (e1000): transmit queue 0 timed out
Modules linked in: e1000 e100 nfsd lockd grace nfs_acl auth_rpcgss sunrpc autofs
4 ipv6 crc_ccitt p4_clockmod dm_mirror dm_region_hash dm_log uinput sg serio_raw
 dcdbas mii i2c_piix4 i2c_core cfi_probe gen_probe cfi_util scb2_flash dm_mod(E)
 ext4(E) mbcache(E) jbd2(E) sd_mod(E) sr_mod(E) cdrom(E) aacraid(E) pata_acpi(E)
 ata_generic(E) pata_serverworks(E) [last unloaded: e1000]
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G            E   4.8.0-rc6_next-queue_dev
-queue_b0b5ade #8
Hardware name: Dell Computer Corporation PowerEdge 2650             /0D5995, BIO
S A21 10/05/2006
 00000000 c06724fb c0b6038a c0b6038a 0000013c c04596d5 c0b647ac f3d2fed0
 00000000 c0b6038a 0000013c c08bff52 c08bff52 00000009 f2922000 00000000
 f318cf00 0001e788 c045979b 00000009 00000000 f3d2feb8 c0b647ac f3d2fed0
Call Trace:
 [<c06724fb>] ? dump_stack+0x47/0x6c
 [<c04596d5>] ? __warn+0x105/0x120
 [<c08bff52>] ? dev_watchdog+0x1c2/0x1d0
 [<c08bff52>] ? dev_watchdog+0x1c2/0x1d0
 [<c045979b>] ? warn_slowpath_fmt+0x3b/0x40
 [<c08bff52>] ? dev_watchdog+0x1c2/0x1d0
 [<c04bb71b>] ? call_timer_fn+0x3b/0x140
 [<c08bfd90>] ? dev_trans_start+0x60/0x60
 [<c04bc1ab>] ? expire_timers+0x9b/0x110
 [<c04bc471>] ? run_timer_softirq+0xd1/0x260
 [<c089a1e0>] ? net_tx_action+0xe0/0x1a0
 [<c04b8597>] ? rcu_process_callbacks+0x47/0xe0
 [<c045e518>] ? __do_softirq+0xc8/0x280
 [<c045e450>] ? irq_exit+0x90/0x90
 [<c041dbd2>] ? do_softirq_own_stack+0x22/0x30
 <IRQ>  [<c045e445>] ? irq_exit+0x85/0x90
 [<c0440f80>] ? smp_apic_timer_interrupt+0x30/0x40
 [<c095f44d>] ? apic_timer_interrupt+0x2d/0x34
 [<c04251cc>] ? default_idle+0x1c/0xd0
 [<c04ce222>] ? __tick_nohz_idle_enter+0x92/0x140
 [<c0424cc6>] ? arch_cpu_idle+0x6/0x10
 [<c0495ebd>] ? cpuidle_idle_call+0x7d/0xe0
 [<c0496075>] ? cpu_idle_loop+0x155/0x210
 [<c04404a5>] ? start_secondary+0xb5/0xe0
---[ end trace fa448b49f7848a42 ]---
e1000 0000:02:06.0 eth1: Reset adapter
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
e1000 0000:02:06.0 eth1: Reset adapter
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
e1000 0000:02:06.0 eth1: Reset adapter
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
e1000 0000:02:06.0 eth1: Reset adapter
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
e1000 0000:02:06.0 eth1: Reset adapter
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
e1000 0000:02:06.0 eth1: Reset adapter
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
e1000 0000:02:06.0 eth1: Reset adapter
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
