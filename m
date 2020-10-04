From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 4 Oct 2020 08:58:39 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: do not panic on malformed
 rx_desc
In-Reply-To: <ee2f6552-aee1-a601-7d24-ed18b6c756ed@intel.com>
References: <20200908162330.4681-1-ztong0001@gmail.com>
 <d8c2fdeb-0ae1-5633-7cef-61607fb22d39@intel.com>
 <ee2f6552-aee1-a601-7d24-ed18b6c756ed@intel.com>
Message-ID: <2b44c5f0-4749-ca10-4d51-1ea9cc20793c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/1/2020 11:02, Neftin, Sasha wrote:
> Hello Tong,
> On 9/10/2020 11:22, Neftin, Sasha wrote:
>> On 9/8/2020 19:23, Tong Zhang wrote:
>>> length may be corrupted in rx_desc and lead to panic, so check the
>>> sanity before passing it to skb_put
>>>
>> Tong, what is scenario caused to skb panic? How it is happen on your 
>> system? Can you please share the test hint and your setup with us?
> Please, share your scenario and setup details (HW settings, BIOS, 
> Kernel, etc...). We would like to understand how exactly length 
> corruption is happen.
> 
Since no way to reproduce the problem, I would recommend dropping this 
patch.
> Thanks,
> Sasha
> 
>>> [? 103.840572] skbuff: skb_over_panic: text:ffffffff8f432cc1 
>>> len:61585 put:61585 head:ffff88805642b800 data:ffff88805642b840 
>>> tail:0xf0d1 end:0x6c0 dev:e
>>> th0
>>> [? 103.841283] ------------[ cut here ]------------
>>> [? 103.841515] kernel BUG at net/core/skbuff.c:109!
>>> [? 103.841749] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
>>> [? 103.842063] CPU: 1 PID: 276 Comm: ping Tainted: G??????? W 5.8.0+ #4
>>> [? 103.842857] RIP: 0010:skb_panic+0xc4/0xc6
>>> [? 103.843022] Code: 89 f0 48 c7 c7 60 f2 3e 90 55 48 8b 74 24 18 4d 
>>> 89 f9 56 48 8b 54 24 18 4c 89 e6 52 48 8b 44 24 18 4c 89 ea 50 e8 01 
>>> c5 2a ff <0f>
>>> 0b 4c 8b 64 24 18 e8 c1 b4 48 ff 48 c7 c1 e0 fc 3e 90 44 89 ee
>>> [? 103.843766] RSP: 0018:ffff88806d109c58 EFLAGS: 00010282
>>> [? 103.843976] RAX: 000000000000008c RBX: ffff8880683407c0 RCX: 
>>> 0000000000000000
>>> [? 103.844262] RDX: 1ffff1100da24c91 RSI: 0000000000000008 RDI: 
>>> ffffed100da2137e
>>> [? 103.844548] RBP: ffff88806bdcc000 R08: 000000000000008c R09: 
>>> ffffed100da25cfb
>>> [? 103.844834] R10: ffff88806d12e7d7 R11: ffffed100da25cfa R12: 
>>> ffffffff903efd20
>>> [? 103.845123] R13: ffffffff8f432cc1 R14: 000000000000f091 R15: 
>>> ffff88805642b800
>>> [? 103.845410] FS:? 00007efcd06852c0(0000) GS:ffff88806d100000(0000) 
>>> knlGS:0000000000000000
>>> [? 103.845734] CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [? 103.845966] CR2: 00007efccf94f8dc CR3: 0000000064810000 CR4: 
>>> 00000000000006e0
>>> [? 103.846254] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>> 0000000000000000
>>> [? 103.846539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>> 0000000000000400
>>> [? 103.846823] Call Trace:
>>> [? 103.846925]? <IRQ>
>>> [? 103.847013]? ? e1000_clean_rx_irq+0x311/0x630
>>> [? 103.847190]? skb_put.cold+0x2b/0x4d
>>> [? 103.847334]? e1000_clean_rx_irq+0x311/0x630
>>>
>>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>>> ---
>>> ? drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
>>> ? 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> index 664e8ccc88d2..f12bd00b2dbf 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> @@ -1047,6 +1047,10 @@ static bool e1000_clean_rx_irq(struct 
>>> e1000_ring *rx_ring, int *work_done,
>>> ????????????? }
>>> ????????????? /* else just continue with the old one */
>>> ????????? }
>>> +??????? /* check length sanity */
>>> +??????? if (skb->tail + length > skb->end) {
>>> +??????????? length = skb->end - skb->tail;
>>> +??????? }
>>> ????????? /* end copybreak code */
>>> ????????? skb_put(skb, length);
>>>
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
Thanks,
Sasha
