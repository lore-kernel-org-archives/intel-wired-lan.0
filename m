From: Shannon Nelson <snelson@pensando.io>
Date: Wed, 9 Dec 2020 10:01:00 -0800
Subject: [Intel-wired-lan] [PATCH 1/1] fix possible array overflow on
 receiving too many fragments for a packet
In-Reply-To: <20201208040638.40627-1-ruc_zhangxiaohui@163.com>
References: <20201208040638.40627-1-ruc_zhangxiaohui@163.com>
Message-ID: <fcf79346-5463-b736-c109-44db76eec1c9@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/7/20 8:06 PM, Xiaohui Zhang wrote:
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>
> If the hardware receives an oversized packet with too many rx fragments,
> skb_shinfo(skb)->frags can overflow and corrupt memory of adjacent pages.
> This becomes especially visible if it corrupts the freelist pointer of
> a slab page.
> I found these two code fragments were very similar to the vulnerable code
> in CVE-2020-12465, so I submitted these two patches.
>
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_txrx.c        | 4 +++-
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index eae75260f..f0a252208 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -821,9 +821,11 @@ ice_add_rx_frag(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
>   	unsigned int truesize = ice_rx_pg_size(rx_ring) / 2;
>   #endif
>   
> +	struct skb_shared_info *shinfo = skb_shinfo(skb);

This declaration should be up directly below the #endif and a blank line 
inserted before the code.

>   	if (!size)
>   		return;
> -	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
> +	if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags))
> +		skb_add_rx_frag(skb, shinfo, rx_buf->page,
>   			rx_buf->page_offset, size, truesize);
>   
>   	/* page is being used so we must update the page offset */
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 169ac4f54..d30e83a4b 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -74,6 +74,7 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
>   	struct device *dev = q->lif->ionic->dev;
>   	struct ionic_page_info *page_info;
>   	struct sk_buff *skb;
> +	struct skb_shared_info *shinfo = skb_shinfo(skb);

As the kernel test robot has suggested, this is using an uninitialized 
skb and will likely cause great unhappiness.

Also, this needs to follow the "reverse xmas tree" formatting style for 
declarations.


>   	unsigned int i;
>   	u16 frag_len;
>   	u16 len;
> @@ -102,7 +103,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
>   
>   		dma_unmap_page(dev, dma_unmap_addr(page_info, dma_addr),
>   			       PAGE_SIZE, DMA_FROM_DEVICE);
> -		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +		if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags))
> +			skb_add_rx_frag(skb, shinfo->nr_frags,
>   				page_info->page, 0, frag_len, PAGE_SIZE);

I'm still not convinced this is necessary here, and I'm still not 
thrilled with the result of just quietly dropping the fragments.

A better answer here might be to check the ARRAY_SIZE against 
comp->num_sg_elements before allocating the skb, and if too big, then 
return NULL - this gets the check done before any allocations are made, 
and the packet will be properly dropped and the drop statistic incremented.

sln

>   		page_info->page = NULL;
>   		page_info++;

