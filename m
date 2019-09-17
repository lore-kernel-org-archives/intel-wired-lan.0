From: Maxim Mikityanskiy <maxtram95@gmail.com>
Date: Tue, 17 Sep 2019 13:48:09 +0300
Subject: [Intel-wired-lan] [PATCH bpf-next] i40e: fix xdp handle
 calculations
In-Reply-To: <20190905011144.3513-1-kevin.laatz@intel.com>
References: <20190905011144.3513-1-kevin.laatz@intel.com>
Message-ID: <CAKErNvpe3htU-ETe0y0XQ=SwY047qc3Z3=aHN6g2BbkoGHNNUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 5, 2019 at 4:11 AM Kevin Laatz <kevin.laatz@intel.com> wrote:
>
> Currently, we don't add headroom to the handle in i40e_zca_free,
> i40e_alloc_buffer_slow_zc and i40e_alloc_buffer_zc. The addition of the
> headroom to the handle was removed in
> commit 2f86c806a8a8 ("i40e: modify driver for handling offsets"),

Hi, it looks to me that headroom is still broken after this commit.
i40e_run_xdp_zc adds it a second time, i.e.:

1. xdp->handle already has the headroom added (after this patch).

2. bpf_prog_run_xdp(...);

3. u64 offset = umem->headroom;
   offset += xdp->data - xdp->data_hard_start;
   xdp->handle = xsk_umem_adjust_offset(umem, xdp->handle, offset);

Step 3 adds the headroom one extra time.

I didn't look at ixgbe, it might also need to be fixed.

> which
> will break things when headroom is non-zero. This patch fixes this and uses
> xsk_umem_adjust_offset to add it appropritely based on the mode being run.
>
> Fixes: 2f86c806a8a8 ("i40e: modify driver for handling offsets")
> Reported-by: Bjorn Topel <bjorn.topel@intel.com>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>
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
