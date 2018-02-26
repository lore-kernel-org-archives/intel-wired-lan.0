From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 26 Feb 2018 15:55:52 +0000
Subject: [Intel-wired-lan] [PATCH 2/9] ixgbevf: only DMA sync frame
 length
In-Reply-To: <20171211183654.21524.84943.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183654.21524.84943.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64BD824A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Emil Tantilov
> Sent: Monday, December 11, 2017 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/9] ixgbevf: only DMA sync frame length
> 
> Based on commit 64f2525ca4e7 ("igb: Only DMA sync frame length")
> 
> On some architectures synching a buffer for DMA may be expensive.
> Instead of the entire 2K receive buffer only synchronize the length of
> the frame, which will typically be the MTU or smaller.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 7ffd429..0cc2688 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -803,12 +803,12 @@ static bool ixgbevf_can_reuse_rx_page(struct
> ixgbevf_rx_buffer *rx_buffer,
>   **/
>  static bool ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
>  				struct ixgbevf_rx_buffer *rx_buffer,
> +				u16 size,
>  				union ixgbe_adv_rx_desc *rx_desc,
>  				struct sk_buff *skb)
>  {
>  	struct page *page = rx_buffer->page;
>  	unsigned char *va = page_address(page) + rx_buffer->page_offset;
> -	unsigned int size = le16_to_cpu(rx_desc->wb.upper.length);
>  #if (PAGE_SIZE < 8192)
>  	unsigned int truesize = IXGBEVF_RX_BUFSZ;
>  #else
> @@ -856,6 +856,7 @@ static struct sk_buff *ixgbevf_fetch_rx_buffer(struct
> ixgbevf_ring *rx_ring,
>  {
>  	struct ixgbevf_rx_buffer *rx_buffer;
>  	struct page *page;
> +	u16 size = le16_to_cpu(rx_desc->wb.upper.length);
> 
>  	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
>  	page = rx_buffer->page;
> @@ -890,11 +891,11 @@ static struct sk_buff *ixgbevf_fetch_rx_buffer(struct
> ixgbevf_ring *rx_ring,
>  	dma_sync_single_range_for_cpu(rx_ring->dev,
>  				      rx_buffer->dma,
>  				      rx_buffer->page_offset,
> -				      IXGBEVF_RX_BUFSZ,
> +				      size,
>  				      DMA_FROM_DEVICE);
> 
>  	/* pull page into skb */
> -	if (ixgbevf_add_rx_frag(rx_ring, rx_buffer, rx_desc, skb)) {
> +	if (ixgbevf_add_rx_frag(rx_ring, rx_buffer, size, rx_desc, skb)) {
>  		/* hand second half of page back to the ring */
>  		ixgbevf_reuse_rx_page(rx_ring, rx_buffer);
>  	} else {
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

