From: Matthew Wilcox <willy@infradead.org>
Date: Sun, 31 Jan 2021 12:22:05 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 3/5] net: introduce common
 dev_page_is_reusable()
In-Reply-To: <20210131120844.7529-4-alobakin@pm.me>
References: <20210131120844.7529-1-alobakin@pm.me>
 <20210131120844.7529-4-alobakin@pm.me>
Message-ID: <20210131122205.GL308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jan 31, 2021 at 12:11:52PM +0000, Alexander Lobakin wrote:
> A bunch of drivers test the page before reusing/recycling for two
> common conditions:
>  - if a page was allocated under memory pressure (pfmemalloc page);
>  - if a page was allocated at a distant memory node (to exclude
>    slowdowns).
> 
> Introduce a new common inline for doing this, with likely() already
> folded inside to make driver code a bit simpler.

I don't see the need for the 'dev_' prefix.  That actually confuses me
because it makes me think this is tied to ZONE_DEVICE or some such.

So how about calling it just 'page_is_reusable' and putting it in mm.h
with page_is_pfmemalloc() and making the comment a little less network-centric?

Or call it something like skb_page_is_recyclable() since it's only used
by networking today.  But I bet it could/should be used more widely.

> +/**
> + * dev_page_is_reusable - check whether a page can be reused for network Rx
> + * @page: the page to test
> + *
> + * A page shouldn't be considered for reusing/recycling if it was allocated
> + * under memory pressure or at a distant memory node.
> + *
> + * Returns false if this page should be returned to page allocator, true
> + * otherwise.
> + */
> +static inline bool dev_page_is_reusable(const struct page *page)
> +{
> +	return likely(page_to_nid(page) == numa_mem_id() &&
> +		      !page_is_pfmemalloc(page));
> +}
> +
