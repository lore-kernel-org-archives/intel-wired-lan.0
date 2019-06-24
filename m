From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon, 24 Jun 2019 16:29:45 +0200
Subject: [Intel-wired-lan] [PATCH 01/11] i40e: simplify Rx buffer recycle
In-Reply-To: <20190620090958.2135-2-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190620090958.2135-2-kevin.laatz@intel.com>
Message-ID: <CAJ+HfNh5bqmjXFQ5r0h-K10H+ZaSEYoi0Xx5j+2VJ_rq+Ktu-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 20 Jun 2019 at 19:25, Kevin Laatz <kevin.laatz@intel.com> wrote:
>
> Currently, the dma, addr and handle are modified when we reuse Rx buffers
> in zero-copy mode. However, this is not required as the inputs to the
> function are copies, not the original values themselves. As we use the
> copies within the function, we can use the original 'old_bi' values
> directly without having to mask and add the headroom.
>

I like that the required change was turned into a cleanup! Nice!

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>

> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 1b17486543ac..c89e692e8663 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -419,8 +419,6 @@ static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
>                                     struct i40e_rx_buffer *old_bi)
>  {
>         struct i40e_rx_buffer *new_bi = &rx_ring->rx_bi[rx_ring->next_to_alloc];
> -       unsigned long mask = (unsigned long)rx_ring->xsk_umem->chunk_mask;
> -       u64 hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
>         u16 nta = rx_ring->next_to_alloc;
>
>         /* update, and store next to alloc */
> @@ -428,14 +426,9 @@ static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
>         rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
>
>         /* transfer page from old buffer to new buffer */
> -       new_bi->dma = old_bi->dma & mask;
> -       new_bi->dma += hr;
> -
> -       new_bi->addr = (void *)((unsigned long)old_bi->addr & mask);
> -       new_bi->addr += hr;
> -
> -       new_bi->handle = old_bi->handle & mask;
> -       new_bi->handle += rx_ring->xsk_umem->headroom;
> +       new_bi->dma = old_bi->dma;
> +       new_bi->addr = old_bi->addr;
> +       new_bi->handle = old_bi->handle;
>
>         old_bi->addr = NULL;
>  }
> --
> 2.17.1
>
