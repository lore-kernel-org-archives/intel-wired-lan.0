From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 5 Sep 2019 11:30:17 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next] ixgbe: fix xdp handle
 calculations
In-Reply-To: <20190905011217.3567-1-kevin.laatz@intel.com>
References: <20190905011217.3567-1-kevin.laatz@intel.com>
Message-ID: <CAJ+HfNhBmP6sUt+vidOzk1GDNRmXqhvqgN72s5Ce3ysRd=YYQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 5 Sep 2019 at 11:28, Kevin Laatz <kevin.laatz@intel.com> wrote:
>
> Currently, we don't add headroom to the handle in ixgbe_zca_free,
> ixgbe_alloc_buffer_slow_zc and ixgbe_alloc_buffer_zc. The addition of the
> headroom to the handle was removed in
> commit d8c3061e5edd ("ixgbe: modify driver for handling offsets"), which
> will break things when headroom isvnon-zero. This patch fixes this and uses
> xsk_umem_adjust_offset to add it appropritely based on the mode being run.
>
> Fixes: d8c3061e5edd ("ixgbe: modify driver for handling offsets")
> Reported-by: Bjorn Topel <bjorn.topel@intel.com>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 17061c799f72..ad802a8909e0 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -248,7 +248,8 @@ void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
>         bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
>         bi->addr += hr;
>
> -       bi->handle = (u64)handle;
> +       bi->handle = xsk_umem_adjust_offset(rx_ring->xsk_umem, (u64)handle,
> +                                           rx_ring->xsk_umem->headroom);
>  }
>
>  static bool ixgbe_alloc_buffer_zc(struct ixgbe_ring *rx_ring,
> @@ -274,7 +275,7 @@ static bool ixgbe_alloc_buffer_zc(struct ixgbe_ring *rx_ring,
>         bi->addr = xdp_umem_get_data(umem, handle);
>         bi->addr += hr;
>
> -       bi->handle = handle;
> +       bi->handle = xsk_umem_adjust_offset(umem, handle, umem->headroom);
>
>         xsk_umem_discard_addr(umem);
>         return true;
> @@ -301,7 +302,7 @@ static bool ixgbe_alloc_buffer_slow_zc(struct ixgbe_ring *rx_ring,
>         bi->addr = xdp_umem_get_data(umem, handle);
>         bi->addr += hr;
>
> -       bi->handle = handle;
> +       bi->handle = xsk_umem_adjust_offset(umem, handle, umem->headroom);
>
>         xsk_umem_discard_addr_rq(umem);
>         return true;
> --
> 2.17.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
