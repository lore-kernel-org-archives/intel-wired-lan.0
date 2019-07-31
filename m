From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Wed, 31 Jul 2019 11:10:52 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 07/11] mlx5e: modify
 driver for handling offsets
In-Reply-To: <20190730085400.10376-8-kevin.laatz@intel.com>
References: <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190730085400.10376-1-kevin.laatz@intel.com>
 <20190730085400.10376-8-kevin.laatz@intel.com>
Message-ID: <7568C727-8F36-4127-9D86-A4C37494C55D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 30 Jul 2019, at 1:53, Kevin Laatz wrote:

> With the addition of the unaligned chunks option, we need to make sure 
> we
> handle the offsets accordingly based on the mode we are currently 
> running
> in. This patch modifies the driver to appropriately mask the address 
> for
> each case.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
>
> ---
> v3:
>   - Use new helper function to handle offset
>
> v4:
>   - fixed headroom addition to handle. Using 
> xsk_umem_adjust_headroom()
>     now.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c    | 8 ++++++--
>  drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 3 ++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c 
> b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index b0b982cf69bb..d5245893d2c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -122,6 +122,7 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct 
> mlx5e_dma_info *di,
>  		      void *va, u16 *rx_headroom, u32 *len, bool xsk)
>  {
>  	struct bpf_prog *prog = READ_ONCE(rq->xdp_prog);
> +	struct xdp_umem *umem = rq->umem;
>  	struct xdp_buff xdp;
>  	u32 act;
>  	int err;
> @@ -138,8 +139,11 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct 
> mlx5e_dma_info *di,
>  	xdp.rxq = &rq->xdp_rxq;
>
>  	act = bpf_prog_run_xdp(prog, &xdp);
> -	if (xsk)
> -		xdp.handle += xdp.data - xdp.data_hard_start;
> +	if (xsk) {
> +		u64 off = xdp.data - xdp.data_hard_start;
> +
> +		xdp.handle = xsk_umem_handle_offset(umem, xdp.handle, off);

Shouldn't this be xdp_umem_adjust_offset()?


> +	}
>  	switch (act) {
>  	case XDP_PASS:
>  		*rx_headroom = xdp.data - xdp.data_hard_start;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c 
> b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> index 6a55573ec8f2..7c49a66d28c9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> @@ -24,7 +24,8 @@ int mlx5e_xsk_page_alloc_umem(struct mlx5e_rq *rq,
>  	if (!xsk_umem_peek_addr_rq(umem, &handle))
>  		return -ENOMEM;
>
> -	dma_info->xsk.handle = handle + rq->buff.umem_headroom;
> +	dma_info->xsk.handle = xsk_umem_adjust_offset(umem, handle,
> +						      rq->buff.umem_headroom);
>  	dma_info->xsk.data = xdp_umem_get_data(umem, dma_info->xsk.handle);
>
>  	/* No need to add headroom to the DMA address. In striding RQ case, 
> we
> -- 
> 2.17.1
