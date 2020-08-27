From: Li,Rongqing <lirongqing@baidu.com>
Date: Thu, 27 Aug 2020 10:54:59 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: use kvzalloc instead of kzalloc
 for rx/tx_bi buffer
In-Reply-To: <cadd738c-b7a3-fd68-4883-2f23a07fb0ae@gmail.com>
References: <1598514788-31039-1-git-send-email-lirongqing@baidu.com>
 <6d89955c-78a2-fa00-9f39-78648d3558a0@gmail.com>
 <4557d3ad541b4272bc1286480af5e562@baidu.com>
 <cadd738c-b7a3-fd68-4883-2f23a07fb0ae@gmail.com>
Message-ID: <0c34de62642e412fbb7ff4bf2c1b123a@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Eric Dumazet [mailto:eric.dumazet at gmail.com]
> Sent: Thursday, August 27, 2020 5:55 PM
> To: Li,Rongqing <lirongqing@baidu.com>; Eric Dumazet
> <eric.dumazet@gmail.com>; netdev at vger.kernel.org;
> intel-wired-lan at lists.osuosl.org
> Subject: Re: [PATCH] iavf: use kvzalloc instead of kzalloc for rx/tx_bi buffer
> 
> 
> 
> On 8/27/20 1:53 AM, Li,Rongqing wrote:
> >
> >
> >> -----Original Message-----
> >> From: Eric Dumazet [mailto:eric.dumazet at gmail.com]
> >> Sent: Thursday, August 27, 2020 4:26 PM
> >> To: Li,Rongqing <lirongqing@baidu.com>; netdev at vger.kernel.org;
> >> intel-wired-lan at lists.osuosl.org
> >> Subject: Re: [PATCH] iavf: use kvzalloc instead of kzalloc for
> >> rx/tx_bi buffer
> >>
> >>
> >>
> >> On 8/27/20 12:53 AM, Li RongQing wrote:
> >>> when changes the rx/tx ring to 4096, kzalloc may fail due to a
> >>> temporary shortage on slab entries.
> >>>
> >>> kvmalloc is used to allocate this memory as there is no need to have
> >>> this memory area physical continuously.
> >>>
> >>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> >>> ---
> >>
> >>
> >> Well, fallback to vmalloc() overhead because order-1 pages are not
> >> readily available when the NIC is setup (usually one time per boot)
> >> is adding TLB cost at run time, for billions of packets to come, maybe for
> months.
> >>
> >> Surely trying a bit harder to get order-1 pages is desirable.
> >>
> >>  __GFP_RETRY_MAYFAIL is supposed to help here.
> >
> > Could we add __GFP_RETRY_MAYFAIL to kvmalloc, to ensure the allocation
> success ?
> 
> __GFP_RETRY_MAYFAIL does not _ensure_ the allocation success.
> 
> The idea here is that for large allocations (bigger than PAGE_SIZE),
> kvmalloc_node() will not force __GFP_NORETRY, meaning that page allocator
> will not bailout immediately in case of memory pressure.
> 
> This gives a chance for page reclaims to happen, and eventually the high order
> page allocation will succeed under normal circumstances.
> 
> It is a trade-off, and only worth it for long living allocations.

Thanks, Eric; 
I will change it as below, that kmalloc will be used in most time, and ensure allocation success if fail to reclaim memory under memory pressure.

@@ -622,7 +622,7 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)
        /* warn if we are about to overwrite the pointer */
        WARN_ON(tx_ring->tx_bi);
        bi_size = sizeof(struct iavf_tx_buffer) * tx_ring->count;
-       tx_ring->tx_bi = kzalloc(bi_size, GFP_KERNEL);
+       tx_ring->tx_bi = kvzalloc(bi_size, GFP_KERNEL|__GFP_RETRY_MAYFAIL);
        if (!tx_ring->tx_bi)
                goto err;
 
@@ -643,7 +643,7 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)


-Li
