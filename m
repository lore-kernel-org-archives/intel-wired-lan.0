From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 1 Oct 2020 07:03:04 +0000
Subject: [Intel-wired-lan] [PATCH] e1000: do not panic on malformed
 rx_desc
In-Reply-To: <20200908162231.4592-1-ztong0001@gmail.com>
References: <20200908162231.4592-1-ztong0001@gmail.com>
Message-ID: <DM6PR11MB28906E70A61ADFD7A3BF1AE7BC300@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tong
> Zhang
> Sent: Tuesday, September 8, 2020 9:23 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: ztong0001 at gmail.com
> Subject: [Intel-wired-lan] [PATCH] e1000: do not panic on malformed rx_desc
> 
> length may be corrupted in rx_desc and lead to panic, so check the
> sanity before passing it to skb_put
> 
> [  167.667701] skbuff: skb_over_panic: text:ffffffffb1e32cc1 len:60224
> put:60224 head:ffff888055ac5000 data:ffff888055ac5040 tail:0xeb80 end:0x6c0
> dev:e
> th0
> [  167.668429] ------------[ cut here ]------------
> [  167.668661] kernel BUG at net/core/skbuff.c:109!
> [  167.668910] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> [  167.669220] CPU: 1 PID: 170 Comm: sd-resolve Tainted: G        W         5.8.0+
> #1
> [  167.670161] RIP: 0010:skb_panic+0xc4/0xc6
> [  167.670363] Code: 89 f0 48 c7 c7 60 f2 de b2 55 48 8b 74 24 18 4d 89 f9 56 48
> 8b 54 24 18 4c 89 e6 52 48 8b 44 24 18 4c 89 ea 50 e8 31 c5 2a ff <0f>
> 0b 4c 8b 64 24 18 e8 f1 b4 48 ff 48 c7 c1 00 fc de b2 44 89 ee
> [  167.671272] RSP: 0018:ffff88806d109c68 EFLAGS: 00010286
> [  167.671527] RAX: 000000000000008c RBX: ffff888065e9af40 RCX:
> 0000000000000000
> [  167.671878] RDX: 1ffff1100da24c91 RSI: 0000000000000008 RDI:
> ffffed100da21380
> [  167.672227] RBP: ffff88806bde4000 R08: 000000000000008c R09:
> ffffed100da25cfb
> [  167.672583] R10: ffff88806d12e7d7 R11: ffffed100da25cfa R12:
> ffffffffb2defc40
> [  167.672931] R13: ffffffffb1e32cc1 R14: 000000000000eb40 R15:
> ffff888055ac5000
> [  167.673286] FS:  00007fc5f5375700(0000) GS:ffff88806d100000(0000)
> knlGS:0000000000000000
> [  167.673681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  167.673973] CR2: 0000000000cb3008 CR3: 0000000063d36000 CR4:
> 00000000000006e0
> [  167.674330] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  167.674677] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  167.675035] Call Trace:
> [  167.675168]  <IRQ>
> [  167.675315]  ? e1000_clean_rx_irq+0x311/0x630
> [  167.687459]  skb_put.cold+0x1f/0x1f
> [  167.687637]  e1000_clean_rx_irq+0x311/0x630
> [  167.687852]  e1000e_poll+0x19a/0x4d0
> [  167.688038]  ? e1000_watchdog_task+0x9d0/0x9d0
> [  167.688262]  ? credit_entropy_bits.constprop.0+0x6f/0x1c0
> [  167.688527]  net_rx_action+0x26e/0x650
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Again, regression tested.  I was not able to trigger the panic with or without patch.
