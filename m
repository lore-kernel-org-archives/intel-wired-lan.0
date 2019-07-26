From: Laatz, Kevin <kevin.laatz@intel.com>
Date: Fri, 26 Jul 2019 10:58:14 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v3 03/11] xsk: add support to
 allow unaligned chunk placement
In-Reply-To: <096504af-35a9-7604-7c06-e500224256ea@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190724051043.14348-4-kevin.laatz@intel.com>
 <E0F8C5B9-A4CD-47CD-8C72-F840161D178E@gmail.com>
 <096504af-35a9-7604-7c06-e500224256ea@intel.com>
Message-ID: <15523237-8aab-f341-3af9-57b8ab65be03@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/07/2019 10:47, Laatz, Kevin wrote:
> On 25/07/2019 16:39, Jonathan Lemon wrote:
>> On 23 Jul 2019, at 22:10, Kevin Laatz wrote:
>>
>>> Currently, addresses are chunk size aligned. This means, we are very
>>> restricted in terms of where we can place chunk within the umem. For
>>> example, if we have a chunk size of 2k, then our chunks can only be 
>>> placed
>>> at 0,2k,4k,6k,8k... and so on (ie. every 2k starting from 0).
>>>
>>> This patch introduces the ability to use unaligned chunks. With these
>>> changes, we are no longer bound to having to place chunks at a 2k (or
>>> whatever your chunk size is) interval. Since we are no longer 
>>> dealing with
>>> aligned chunks, they can now cross page boundaries. Checks for page
>>> contiguity have been added in order to keep track of which pages are
>>> followed by a physically contiguous page.
>>>
>>> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
>>> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>>
>>> ---
>>> v2:
>>> ? - Add checks for the flags coming from userspace
>>> ? - Fix how we get chunk_size in xsk_diag.c
>>> ? - Add defines for masking the new descriptor format
>>> ? - Modified the rx functions to use new descriptor format
>>> ? - Modified the tx functions to use new descriptor format
>>>
>>> v3:
>>> ? - Add helper function to do address/offset masking/addition
>>> ---
>>> ?include/net/xdp_sock.h????? | 17 ++++++++
>>> ?include/uapi/linux/if_xdp.h |? 9 ++++
>>> ?net/xdp/xdp_umem.c????????? | 18 +++++---
>>> ?net/xdp/xsk.c?????????????? | 86 ++++++++++++++++++++++++++++++-------
>>> ?net/xdp/xsk_diag.c????????? |? 2 +-
>>> ?net/xdp/xsk_queue.h???????? | 68 +++++++++++++++++++++++++----
>>> ?6 files changed, 170 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
>>> index 69796d264f06..738996c0f995 100644
>>> --- a/include/net/xdp_sock.h
>>> +++ b/include/net/xdp_sock.h
>>> @@ -19,6 +19,7 @@ struct xsk_queue;
>>> ?struct xdp_umem_page {
>>> ???? void *addr;
>>> ???? dma_addr_t dma;
>>> +??? bool next_pg_contig;
>>> ?};
>>>
>>> ?struct xdp_umem_fq_reuse {
>>> @@ -48,6 +49,7 @@ struct xdp_umem {
>>> ???? bool zc;
>>> ???? spinlock_t xsk_list_lock;
>>> ???? struct list_head xsk_list;
>>> +??? u32 flags;
>>> ?};
>>>
>>> ?struct xdp_sock {
>>> @@ -144,6 +146,15 @@ static inline void xsk_umem_fq_reuse(struct 
>>> xdp_umem *umem, u64 addr)
>>>
>>> ???? rq->handles[rq->length++] = addr;
>>> ?}
>>> +
>>> +static inline u64 xsk_umem_handle_offset(struct xdp_umem *umem, u64 
>>> handle,
>>> +???????????????????? u64 offset)
>>> +{
>>> +??? if (umem->flags & XDP_UMEM_UNALIGNED_CHUNKS)
>>> +??????? return handle |= (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
>>> +??? else
>>> +??????? return handle += offset;
>>> +}
>>
>> This should be something like 'xsk_umem_adjust_offset()', and use 
>> "+=" for both cases.
>
> I'll try to come up with a better name for this, I see how 
> "handle_offset" could be misleading :)
>
> In terms of the "+=", we can't do that for both. We need to use | for 
> the unaligned case since we store the offset in the upper 16-bits of 
> the address field so that we leave the lower 48-bits (the original 
> base address) untouched.
>
Correction, we can do "+=". With that, the lower 48-bits will still 
remain untouched though, so we still have the original address :)
>
> <...>
>
>>>
>>> ???? if (!PAGE_ALIGNED(addr)) {
>>> @@ -331,9 +335,11 @@ static int xdp_umem_reg(struct xdp_umem *umem, 
>>> struct xdp_umem_reg *mr)
>>> ???? if (chunks == 0)
>>> ???????? return -EINVAL;
>>>
>>> -??? chunks_per_page = PAGE_SIZE / chunk_size;
>>> -??? if (chunks < chunks_per_page || chunks % chunks_per_page)
>>> -??????? return -EINVAL;
>>> +??? if (!unaligned_chunks) {
>>> +??????? chunks_per_page = PAGE_SIZE / chunk_size;
>>> +??????? if (chunks < chunks_per_page || chunks % chunks_per_page)
>>> +??????????? return -EINVAL;
>>> +??? }
>>>
>>> ???? headroom = ALIGN(headroom, 64);
>>>
>>> @@ -342,13 +348,15 @@ static int xdp_umem_reg(struct xdp_umem *umem, 
>>> struct xdp_umem_reg *mr)
>>> ???????? return -EINVAL;
>>>
>>> ???? umem->address = (unsigned long)addr;
>>> -??? umem->chunk_mask = ~((u64)chunk_size - 1);
>>> +??? umem->chunk_mask = unaligned_chunks ? XSK_UNALIGNED_BUF_ADDR_MASK
>>> +??????????????????????? : ~((u64)chunk_size - 1);
>>
>> The handle needs to be cleaned (reset to base address) when removed
>> from the fill queue or recycle stack.? This will not provide the correct
>> semantics for unaligned mode.
>
> When we use aligned mode, the chunk mask is ~0x07FF which will remove 
> the low 11-bits in order to get us back to the original base address.
>
> In unaligned mode, the chunk mask is ~0xFFFF00....00 which will remove 
> the upper 16-bits. This will remove the offset from the address field 
> and, since we have not directly modified the low 48-bits (original 
> base address), leave us with the original base address.
>
> Cleaning the handle will therefore work as it does now, using the 
> appropriate mask based on which mode we are using.
>
> <...>
>
>>>
>>> ???????? if (xskq_produce_addr_lazy(umem->cq, desc->addr))
>>> @@ -243,7 +269,7 @@ static int xsk_generic_xmit(struct sock *sk, 
>>> struct msghdr *m,
>>> ???? if (xs->queue_id >= xs->dev->real_num_tx_queues)
>>> ???????? goto out;
>>>
>>> -??? while (xskq_peek_desc(xs->tx, &desc)) {
>>> +??? while (xskq_peek_desc(xs->tx, &desc, xs->umem)) {
>>> ???????? char *buffer;
>>> ???????? u64 addr;
>>> ???????? u32 len;
>>> @@ -262,6 +288,10 @@ static int xsk_generic_xmit(struct sock *sk, 
>>> struct msghdr *m,
>>>
>>> ???????? skb_put(skb, len);
>>> ???????? addr = desc.addr;
>>> +??????? if (xs->umem->flags & XDP_UMEM_UNALIGNED_CHUNKS)
>>> +??????????? addr = (addr & XSK_UNALIGNED_BUF_ADDR_MASK) |
>>> +??????????????? (addr >> XSK_UNALIGNED_BUF_OFFSET_SHIFT);
>>
>> This doesn't look right to me.? Shouldn't it be "(addr & mask) + 
>> (addr >> shift)"?
>> I'd also prefer to see this type of logic in an inline/macro
>
> Will fix in the v4, thanks!
>
> I'll look to move this to an inline function as well.
>
> <...>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190726/75ab8880/attachment-0001.html>
