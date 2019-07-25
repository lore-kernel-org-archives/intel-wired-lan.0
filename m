From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Thu, 25 Jul 2019 10:15:55 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v3 06/11] mlx5e: modify
 driver for handling offsets
In-Reply-To: <20190724051043.14348-7-kevin.laatz@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190724051043.14348-7-kevin.laatz@intel.com>
Message-ID: <c5704b74-8efe-af2a-68e6-716fa89a5665@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-24 08:10, Kevin Laatz wrote:
> With the addition of the unaligned chunks option, we need to make sure we
> handle the offsets accordingly based on the mode we are currently running
> in. This patch modifies the driver to appropriately mask the address for
> each case.
> 
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> 
> ---
> v3:
>    - Use new helper function to handle offset
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c    | 8 ++++++--
>   drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c | 9 +++++++--
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index b0b982cf69bb..d5245893d2c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -122,6 +122,7 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct mlx5e_dma_info *di,
>   		      void *va, u16 *rx_headroom, u32 *len, bool xsk)
>   {
>   	struct bpf_prog *prog = READ_ONCE(rq->xdp_prog);
> +	struct xdp_umem *umem = rq->umem;
>   	struct xdp_buff xdp;
>   	u32 act;
>   	int err;
> @@ -138,8 +139,11 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct mlx5e_dma_info *di,
>   	xdp.rxq = &rq->xdp_rxq;
>   
>   	act = bpf_prog_run_xdp(prog, &xdp);
> -	if (xsk)
> -		xdp.handle += xdp.data - xdp.data_hard_start;
> +	if (xsk) {
> +		u64 off = xdp.data - xdp.data_hard_start;
> +
> +		xdp.handle = xsk_umem_handle_offset(umem, xdp.handle, off);
> +	}

What's missed is that umem_headroom is added to handle directly in 
mlx5e_xsk_page_alloc_umem. In my understanding umem_headroom should go 
to the offset part (high 16 bits) of the handle, to 
xsk_umem_handle_offset has to support increasing the offset.

>   	switch (act) {
>   	case XDP_PASS:
>   		*rx_headroom = xdp.data - xdp.data_hard_start;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> index 35e188cf4ea4..f596e63cba00 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> @@ -61,6 +61,7 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>   	struct mlx5e_xdp_xmit_data xdptxd;
>   	bool work_done = true;
>   	bool flush = false;
> +	u64 addr, offset;
>   
>   	xdpi.mode = MLX5E_XDP_XMIT_MODE_XSK;
>   
> @@ -82,8 +83,12 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>   			break;
>   		}
>   
> -		xdptxd.dma_addr = xdp_umem_get_dma(umem, desc.addr);
> -		xdptxd.data = xdp_umem_get_data(umem, desc.addr);
> +		/* for unaligned chunks need to take offset from upper bits */
> +		offset = (desc.addr >> XSK_UNALIGNED_BUF_OFFSET_SHIFT);
> +		addr = (desc.addr & XSK_UNALIGNED_BUF_ADDR_MASK);
> +
> +		xdptxd.dma_addr = xdp_umem_get_dma(umem, addr + offset);
> +		xdptxd.data = xdp_umem_get_data(umem, addr + offset);

Why can't these calculations be encapsulated into 
xdp_umem_get_{dma,data}? I think they are common for all drivers, aren't 
they?

Even if there is some reason not to put this bitshifting stuff into 
xdp_umem_get_* functions, I suggest to encapsulate it into a function 
anyway, because it's a good idea to keep those calculations in a single 
place.

>   		xdptxd.len = desc.len;
>   
>   		dma_sync_single_for_device(sq->pdev, xdptxd.dma_addr,
> 

