From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Thu,  9 Dec 2021 18:33:07 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 1/9] i40e: don't reserve
 excessive XDP_PACKET_HEADROOM on XSK Rx to skb
In-Reply-To: <da317f39-8679-96f7-ec6f-309216b02f33@redhat.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-2-alexandr.lobakin@intel.com>
 <da317f39-8679-96f7-ec6f-309216b02f33@redhat.com>
Message-ID: <20211209173307.5003-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Thu, 9 Dec 2021 09:19:46 +0100

> On 08/12/2021 15.06, Alexander Lobakin wrote:
> > {__,}napi_alloc_skb() allocates and reserves additional NET_SKB_PAD
> > + NET_IP_ALIGN for any skb.
> > OTOH, i40e_construct_skb_zc() currently allocates and reserves
> > additional `xdp->data - xdp->data_hard_start`, which is
> > XDP_PACKET_HEADROOM for XSK frames.
> > There's no need for that at all as the frame is post-XDP and will
> > go only to the networking stack core.
> 
> I disagree with this assumption, that headroom is not needed by netstack.
> Why "no need for that at all" for netstack?

napi_alloc_skb() in our particular case will reserve 64 bytes, it is
sufficient for {TCP,UDP,SCTP,...}/IPv{4,6} etc.

> 
> Having headroom is important for netstack in general.  When packet will 
> grow we avoid realloc of SKB.  Use-case could also be cpumap or veth 
> redirect, or XDP-generic, that expect this headroom.

Well, those are not common cases at all.
Allocating 256 bytes more for some hypothetical usecases (and having
320 in total) is more expensive than expanding headroom in-place.
I don't know any other drivers or ifaces which reserve
XDP_PACKET_HEADROOM just for the case of using both driver-side
and generic XDP at the same time. To be more precise, I can't
remember any driver which would check whether generic XDP is enabled
for its netdev(s).

As a second option, I was trying to get exactly XDP_PACKET_HEADROOM
of headroom, but this involves either __alloc_skb() which is slower
than napi_alloc_skb(), or

	skb = napi_alloc_skb(napi, xdp->data_end -
				   xdp->data_hard_start -
				   NET_SKB_PAD);
	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start -
			 NET_SKB_PAD);

Doesn't look good for me.

We could probably introduce a version of napi_alloc_skb() which
wouldn't reserve any headroom for you to have more control over it,
but that's more global material than these local fixes I'd say.

> 
> 
> > Pass the size of the actual data only to __napi_alloc_skb() and
> > don't reserve anything. This will give enough headroom for stack
> > processing.
> > 
> > Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index f08d19b8c554..9564906b7da8 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -245,13 +245,11 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
> >   	struct sk_buff *skb;
> >   
> >   	/* allocate a skb to store the frags */
> > -	skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
> > -			       xdp->data_end - xdp->data_hard_start,
> > +	skb = __napi_alloc_skb(&rx_ring->q_vector->napi, datasize,
> >   			       GFP_ATOMIC | __GFP_NOWARN);
> >   	if (unlikely(!skb))
> >   		goto out;
> >   
> > -	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> >   	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
> >   	if (metasize)
> >   		skb_metadata_set(skb, metasize);

Thanks,
Al
