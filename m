From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 4 Feb 2018 12:44:19 -0800
Subject: [Intel-wired-lan] [PATCH] e1000e: allocate ring descriptors
 with dma_zalloc_coherent
In-Reply-To: <866abc64-8ab1-c8fb-1167-90b8063f32d7@gmail.com>
References: <20180126102404.GA26578@poseidon.lin.mbt.kalray.eu>
 <866abc64-8ab1-c8fb-1167-90b8063f32d7@gmail.com>
Message-ID: <CAKgT0UdPg2FivYNjBaU3yW+_ju6RWVKv4UxVtaf+cdqh-RBePQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Feb 4, 2018 at 12:01 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
> On 01/26/2018 02:24 AM, Pierre-Yves Kerbrat wrote:
>> Descriptor rings were not initialized at zero when allocated
>> When area contained garbage data, it caused skb_over_panic in
>> e1000_clean_rx_irq (if data had E1000_RXD_STAT_DD bit set)
>>
>> This patch makes use of dma_zalloc_coherent to make sure the
>> ring is memset at 0 to prevent the area from containing garbage.
>>
>> Following is the signature of the panic:
>> IODDR0 at 0.0: skbuff: skb_over_panic: text:80407b20 len:64010 put:64010 head:ab46d800 data:ab46d842 tail:0xab47d24c end:0xab46df40 dev:eth0
>> IODDR0 at 0.0: BUG: failure at net/core/skbuff.c:105/skb_panic()!
>> IODDR0 at 0.0: Kernel panic - not syncing: BUG!
>> IODDR0 at 0.0:
>> IODDR0 at 0.0: Process swapper/0 (pid: 0, threadinfo=81728000, task=8173cc00 ,cpu: 0)
>> IODDR0 at 0.0: SP = <815a1c0c>
>> IODDR0 at 0.0: Stack:      00000001
>> IODDR0 at 0.0: b2d89800 815e33ac
>> IODDR0 at 0.0: ea73c040 00000001
>> IODDR0 at 0.0: 60040003 0000fa0a
>> IODDR0 at 0.0: 00000002
>> IODDR0 at 0.0:
>> IODDR0 at 0.0: 804540c0 815a1c70
>> IODDR0 at 0.0: b2744000 602ac070
>> IODDR0 at 0.0: 815a1c44 b2d89800
>> IODDR0 at 0.0: 8173cc00 815a1c08
>> IODDR0 at 0.0:
>> IODDR0 at 0.0:     00000006
>> IODDR0 at 0.0: 815a1b50 00000000
>> IODDR0 at 0.0: 80079434 00000001
>> IODDR0 at 0.0: ab46df40 b2744000
>> IODDR0 at 0.0: b2d89800
>> IODDR0 at 0.0:
>> IODDR0 at 0.0: 0000fa0a 8045745c
>> IODDR0 at 0.0: 815a1c88 0000fa0a
>> IODDR0 at 0.0: 80407b20 b2789f80
>> IODDR0 at 0.0: 00000005 80407b20
>> IODDR0 at 0.0:
>> IODDR0 at 0.0:
>> IODDR0 at 0.0: Call Trace:
>> IODDR0 at 0.0: [<804540bc>] skb_panic+0xa4/0xa8
>> IODDR0 at 0.0: [<80079430>] console_unlock+0x2f8/0x6d0
>> IODDR0 at 0.0: [<80457458>] skb_put+0xa0/0xc0
>> IODDR0 at 0.0: [<80407b1c>] e1000_clean_rx_irq+0x2dc/0x3e8
>> IODDR0 at 0.0: [<80407b1c>] e1000_clean_rx_irq+0x2dc/0x3e8
>> IODDR0 at 0.0: [<804079c8>] e1000_clean_rx_irq+0x188/0x3e8
>> IODDR0 at 0.0: [<80407b1c>] e1000_clean_rx_irq+0x2dc/0x3e8
>> IODDR0 at 0.0: [<80468b48>] __dev_kfree_skb_any+0x88/0xa8
>> IODDR0 at 0.0: [<804101ac>] e1000e_poll+0x94/0x288
>> IODDR0 at 0.0: [<8046e9d4>] net_rx_action+0x19c/0x4e8
>> IODDR0 at 0.0:   ...
>> IODDR0 at 0.0: Maximum depth to print reached. Use kstack=<maximum_depth_to_print> To specify a custom value (where 0 means to display the full backtrace)
>> IODDR0 at 0.0: ---[ end Kernel panic - not syncing: BUG!
>
> Interesting, this dates back from the driver's initial commit, I am
> surprised that not more people did not have that problem, maybe the RX
> ring usually goes through at least one filing cycle?
>
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently
> for ICH9 devices only)")

The Rx rings should have been filled long before we triggered this. I
would really want to see more of the call trace before we say this
fixes the bug. For instance I would be curious to see the link
messages and such from the interface. I'm not entirely convinced since
really this does get overwritten by the alloc_rx_buffers function.
Really in order to get into this state I think we would have to have a
significant number of skb allocations and/or the DMA mappings for the
skbs fail.

I'm okay with the patch since it is harmless and just zeroing out the
length field and DD bit in the descriptor. But I would want to know
more information about the architecture and how we got into this state
since it seems like this is an issue that could happen with numerous
possible causes and this addressing only one.

One concern I would have is that we are running into something that is
really more of a race issue, as we have seen in the past with PowerPC,
where the length was getting read before the DD bit due to the
pipeline optimizing things. In that case we had to introduce a barrer
that later became the dma_rmb().

Anyway that is just my $.02 on it. I am good with the patch itself and
I am okay with it being applied.

Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
