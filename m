From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 11 Jun 2021 17:12:45 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: xsk: fix for metasize when
 construct skb by xdp_buff
In-Reply-To: <20210609122244.52647-1-xuanzhuo@linux.alibaba.com>
References: <20210609122244.52647-1-xuanzhuo@linux.alibaba.com>
Message-ID: <20210611151245.GA31289@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 09, 2021 at 08:22:44PM +0800, Xuan Zhuo wrote:
> We should copy data_meta to the skb space.  Then use __skb_pull to
> correct skb->data

This looks like a bug that has been sitting over here for sometime. Have
you encountered this during your virtio-net's AF_XDP ZC work? I'm all ears
how you spotted this.

Anyway, other drivers needs such fixing too. Are you willing to do that or
should we take it on our side?

Magnus is OOO today, I'd like to get his final ack on that.

From me:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks!

> 
> Fixes: d0bcacd0a1309 ("ixgbe: add AF_XDP zero-copy Rx support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index f72d2978263b..ee88107fa57a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -204,7 +204,7 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
>  					      struct ixgbe_rx_buffer *bi)
>  {
>  	unsigned int metasize = bi->xdp->data - bi->xdp->data_meta;
> -	unsigned int datasize = bi->xdp->data_end - bi->xdp->data;
> +	unsigned int datasize = bi->xdp->data_end - bi->xdp->data_meta;
>  	struct sk_buff *skb;
>  
>  	/* allocate a skb to store the frags */
> @@ -214,10 +214,12 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
>  	if (unlikely(!skb))
>  		return NULL;
>  
> -	skb_reserve(skb, bi->xdp->data - bi->xdp->data_hard_start);
> -	memcpy(__skb_put(skb, datasize), bi->xdp->data, datasize);
> -	if (metasize)
> +	skb_reserve(skb, bi->xdp->data_meta - bi->xdp->data_hard_start);
> +	memcpy(__skb_put(skb, datasize), bi->xdp->data_meta, datasize);
> +	if (metasize) {
> +		__skb_pull(skb, metasize);
>  		skb_metadata_set(skb, metasize);
> +	}
>  
>  	xsk_buff_free(bi->xdp);
>  	bi->xdp = NULL;
> -- 
> 2.31.0
> 
