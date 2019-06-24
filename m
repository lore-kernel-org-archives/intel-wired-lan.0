From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon, 24 Jun 2019 16:31:42 +0200
Subject: [Intel-wired-lan] [PATCH 03/11] xdp: add offset param to
 zero_copy_allocator
In-Reply-To: <20190620090958.2135-4-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190620090958.2135-4-kevin.laatz@intel.com>
Message-ID: <CAJ+HfNgkJJZhbUbK-DU70tNMRjT62WVO5_asCiX28zGQkHhmsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 20 Jun 2019 at 19:25, Kevin Laatz <kevin.laatz@intel.com> wrote:
>
> This patch adds an offset parameter for zero_copy_allocator.
>
> This change is required for the unaligned chunk mode which will come later
> in this patch set. The offset parameter is required for calculating the
> original handle in unaligned mode since we can't easily mask back to it
> like in the aligned case.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>


> ---
>  include/net/xdp.h |  3 ++-
>  net/core/xdp.c    | 11 ++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 0f25b3675c5c..ea801fd2bf98 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -53,7 +53,8 @@ struct xdp_mem_info {
>  struct page_pool;
>
>  struct zero_copy_allocator {
> -       void (*free)(struct zero_copy_allocator *zca, unsigned long handle);
> +       void (*free)(struct zero_copy_allocator *zca, unsigned long handle,
> +                       off_t off);
>  };
>
>  struct xdp_rxq_info {
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 4b2b194f4f1f..a77a7162d213 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
>   * of xdp_frames/pages in those cases.
>   */
>  static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
> -                        unsigned long handle)
> +                        unsigned long handle, off_t off)
>  {
>         struct xdp_mem_allocator *xa;
>         struct page *page;
> @@ -353,7 +353,7 @@ static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
>                 rcu_read_lock();
>                 /* mem->id is valid, checked in xdp_rxq_info_reg_mem_model() */
>                 xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
> -               xa->zc_alloc->free(xa->zc_alloc, handle);
> +               xa->zc_alloc->free(xa->zc_alloc, handle, off);
>                 rcu_read_unlock();
>         default:
>                 /* Not possible, checked in xdp_rxq_info_reg_mem_model() */
> @@ -363,19 +363,20 @@ static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
>
>  void xdp_return_frame(struct xdp_frame *xdpf)
>  {
> -       __xdp_return(xdpf->data, &xdpf->mem, false, 0);
> +       __xdp_return(xdpf->data, &xdpf->mem, false, 0, 0);
>  }
>  EXPORT_SYMBOL_GPL(xdp_return_frame);
>
>  void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
>  {
> -       __xdp_return(xdpf->data, &xdpf->mem, true, 0);
> +       __xdp_return(xdpf->data, &xdpf->mem, true, 0, 0);
>  }
>  EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
>
>  void xdp_return_buff(struct xdp_buff *xdp)
>  {
> -       __xdp_return(xdp->data, &xdp->rxq->mem, true, xdp->handle);
> +       __xdp_return(xdp->data, &xdp->rxq->mem, true, xdp->handle,
> +                       xdp->data - xdp->data_hard_start);
>  }
>  EXPORT_SYMBOL_GPL(xdp_return_buff);
>
> --
> 2.17.1
>
