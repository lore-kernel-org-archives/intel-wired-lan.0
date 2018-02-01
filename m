From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Feb 2018 12:29:24 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: remove redundant
 initialization of variable 'dma'.
In-Reply-To: <20180201183539.24776-1-colin.king@canonical.com>
References: <20180201183539.24776-1-colin.king@canonical.com>
Message-ID: <CAKgT0UdjYMWV4x7-yy4pkA_8cNY+Bvc4WvJ0yKYRKO5dWf9mTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 1, 2018 at 10:35 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable dma is initialized with a value that is never read, later
> on it is re-assigned a new value, hence the initialization is redundant
> and can be removed.
>
> Cleans up clang warning:
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:584:13: warning: Value
> stored to 'dma' during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 9b3d43d28106..be50facec93f 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -558,7 +558,7 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
>                                       struct ixgbevf_rx_buffer *bi)
>  {
>         struct page *page = bi->page;
> -       dma_addr_t dma = bi->dma;
> +       dma_addr_t dma;
>
>         /* since we are recycling buffers we should seldom need to alloc */
>         if (likely(page))
> --
> 2.15.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
