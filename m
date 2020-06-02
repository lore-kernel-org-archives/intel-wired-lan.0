From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 2 Jun 2020 14:21:42 +0200
Subject: [Intel-wired-lan] [PATCH][v2] i40e: fix wrong index in
 i40e_xsk_umem_dma_map
In-Reply-To: <1591099973-3091-1-git-send-email-lirongqing@baidu.com>
References: <1591099973-3091-1-git-send-email-lirongqing@baidu.com>
Message-ID: <CAJ+HfNgOoFecFbA3p7QM=bFwuV1k6895w57yH4EWFtSPNZ_wQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2 Jun 2020 at 14:13, Li RongQing <lirongqing@baidu.com> wrote:
>
> The dma should be unmapped in rollback path from
> umem->pages[0].dma till umem->pages[i-1].dma which
> is last dma map address
>
> Fixes: 0a714186d3c0 "(i40e: add AF_XDP zero-copy Rx support)"
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff with v1: add description
>

Thanks! I think this should be queued for -stable.

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>


>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 0b7d29192b2c..c926438118ea 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -37,9 +37,9 @@ static int i40e_xsk_umem_dma_map(struct i40e_vsi *vsi, struct xdp_umem *umem)
>
>  out_unmap:
>         for (j = 0; j < i; j++) {
> -               dma_unmap_page_attrs(dev, umem->pages[i].dma, PAGE_SIZE,
> +               dma_unmap_page_attrs(dev, umem->pages[j].dma, PAGE_SIZE,
>                                      DMA_BIDIRECTIONAL, I40E_RX_DMA_ATTR);
> -               umem->pages[i].dma = 0;
> +               umem->pages[j].dma = 0;
>         }
>
>         return -1;
> --
> 2.16.2
>
