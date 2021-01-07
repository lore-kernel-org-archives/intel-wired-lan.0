From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 7 Jan 2021 20:10:14 +0100
Subject: [Intel-wired-lan] [PATCH net v1] igc: Don't clear the large
 buffer bit before memory release
In-Reply-To: <20210107185654.1826-1-vedang.patel@intel.com>
References: <20210107185654.1826-1-vedang.patel@intel.com>
Message-ID: <20210107191014.GA36516@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 07, 2021 at 10:56:54AM -0800, Vedang Patel wrote:
> When XDP is enabled, it uses large buffers to accomodate headroom and
> tailroom required by XDP infrastructure. But, it clears the large buffer
> bit before unmapping the buffer.
> 
> dma_unmap_page_attrs() (called by igc_clean_rx_ring_page_shared()) needs
> size of the buffer to unmap. If the large buffer bit is cleared before
> calling igc_clean_rx_ring_page_shared(), all of the memory won't be
> unmapped.
> 
> Fixes: 2e739318416b ("igc: Add initial XDP support")
> 
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 0bcdf05d03f0..b96b745fdb65 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -418,13 +418,13 @@ static void igc_clean_rx_ring_xsk_pool(struct igc_ring *ring)
>   */
>  static void igc_clean_rx_ring(struct igc_ring *ring)
>  {
> -	clear_ring_uses_large_buffer(ring);
> -
>  	if (ring->xsk_pool)
>  		igc_clean_rx_ring_xsk_pool(ring);
>  	else
>  		igc_clean_rx_ring_page_shared(ring);

This code is not yet upstreamed AFAICT. Probably you should ask Andre to
include this fix onto igc's AFXDP support?

>  
> +	clear_ring_uses_large_buffer(ring);
> +
>  	ring->next_to_alloc = 0;
>  	ring->next_to_clean = 0;
>  	ring->next_to_use = 0;
> -- 
> 2.17.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
