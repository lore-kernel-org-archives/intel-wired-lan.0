From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Tue, 29 Jun 2021 18:55:59 +0200
Subject: [Intel-wired-lan] [PATCH net v2] xdp,
 net: fix for construct skb by xdp inside xsk zc rx
In-Reply-To: <20210628104721.GA57589@ranger.igk.intel.com>
References: <20210617145534.101458-1-xuanzhuo@linux.alibaba.com>
 <20210628104721.GA57589@ranger.igk.intel.com>
Message-ID: <f5ce5610-443c-a2d9-43ef-d203f9afb0d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 28/06/2021 12.47, Maciej Fijalkowski wrote:

> +static __always_inline struct sk_buff *
> +xdp_construct_skb(struct xdp_buff *xdp, struct napi_struct *napi)
> +{

I don't like the generic name "xdp_construct_skb".

What about calling it "xdp_copy_construct_skb", because below is 
memcpy'ing the data.

Functions that use this call free (or recycle) the memory backing the 
packet, after calling this function.

(I'm open to other naming suggestions)


> +	unsigned int metasize;
> +	unsigned int datasize;
> +	unsigned int headroom;
> +	struct sk_buff *skb;
> +	unsigned int len;
> +
> +	/* this include metasize */
> +	datasize = xdp->data_end  - xdp->data_meta;
> +	metasize = xdp->data      - xdp->data_meta;
> +	headroom = xdp->data_meta - xdp->data_hard_start;
> +	len      = xdp->data_end  - xdp->data_hard_start;
> +
> +	/* allocate a skb to store the frags */
> +	skb = __napi_alloc_skb(napi, len, GFP_ATOMIC | __GFP_NOWARN);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb_reserve(skb, headroom);
> +	memcpy(__skb_put(skb, datasize), xdp->data_meta, datasize);
> +	if (metasize) {
> +		__skb_pull(skb, metasize);
> +		skb_metadata_set(skb, metasize);
> +	}
> +
> +	return skb;
> +}

