From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 5 Sep 2019 11:29:55 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next] i40e: fix xdp handle
 calculations
In-Reply-To: <20190905011144.3513-1-kevin.laatz@intel.com>
References: <20190905011144.3513-1-kevin.laatz@intel.com>
Message-ID: <CAJ+HfNib5qSX13wquSe8WbuZ3CMQCyeS2cdhqPG7NTjqvSq2Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 5 Sep 2019 at 11:27, Kevin Laatz <kevin.laatz@intel.com> wrote:
>
> Currently, we don't add headroom to the handle in i40e_zca_free,
> i40e_alloc_buffer_slow_zc and i40e_alloc_buffer_zc. The addition of the
> headroom to the handle was removed in
> commit 2f86c806a8a8 ("i40e: modify driver for handling offsets"), which
> will break things when headroom is non-zero. This patch fixes this and uses
> xsk_umem_adjust_offset to add it appropritely based on the mode being run.
>
> Fixes: 2f86c806a8a8 ("i40e: modify driver for handling offsets")
> Reported-by: Bjorn Topel <bjorn.topel@intel.com>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>

Thanks Kevin!

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index eaca6162a6e6..0373bc6c7e61 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -267,7 +267,7 @@ static bool i40e_alloc_buffer_zc(struct i40e_ring *rx_ring,
>         bi->addr = xdp_umem_get_data(umem, handle);
>         bi->addr += hr;
>
> -       bi->handle = handle;
> +       bi->handle = xsk_umem_adjust_offset(umem, handle, umem->headroom);
>
>         xsk_umem_discard_addr(umem);
>         return true;
> @@ -304,7 +304,7 @@ static bool i40e_alloc_buffer_slow_zc(struct i40e_ring *rx_ring,
>         bi->addr = xdp_umem_get_data(umem, handle);
>         bi->addr += hr;
>
> -       bi->handle = handle;
> +       bi->handle = xsk_umem_adjust_offset(umem, handle, umem->headroom);
>
>         xsk_umem_discard_addr_rq(umem);
>         return true;
> @@ -469,7 +469,8 @@ void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
>         bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
>         bi->addr += hr;
>
> -       bi->handle = (u64)handle;
> +       bi->handle = xsk_umem_adjust_offset(rx_ring->xsk_umem, (u64)handle,
> +                                           rx_ring->xsk_umem->headroom);
>  }
>
>  /**
> --
> 2.17.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
