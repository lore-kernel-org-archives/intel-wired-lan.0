From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 8 Jun 2021 13:07:11 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe,
 xsk: clean up the resources in ixgbe_xsk_pool_enable error path
In-Reply-To: <20210607122644.59021-1-wanghai38@huawei.com>
References: <20210607122644.59021-1-wanghai38@huawei.com>
Message-ID: <CAJ8uoz2mfCGNmEaAhGZAaSs=Mrer008f3+C7MdoAySsLn=busw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 7, 2021 at 2:17 PM Wang Hai <wanghai38@huawei.com> wrote:
>
> In ixgbe_xsk_pool_enable(), if ixgbe_xsk_wakeup() fails,
> We should restore the previous state and clean up the
> resources. Add the missing clear af_xdp_zc_qps and unmap dma
> to fix this bug.
>
> Fixes: d49e286d354e ("ixgbe: add tracking of AF_XDP zero-copy state for each queue pair")
> Fixes: 4a9b32f30f80 ("ixgbe: fix potential RX buffer starvation for AF_XDP")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks Wang.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 91ad5b902673..d912f14d2ba4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -52,8 +52,11 @@ static int ixgbe_xsk_pool_enable(struct ixgbe_adapter *adapter,
>
>                 /* Kick start the NAPI context so that receiving will start */
>                 err = ixgbe_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
> -               if (err)
> +               if (err) {
> +                       clear_bit(qid, adapter->af_xdp_zc_qps);
> +                       xsk_pool_dma_unmap(pool, IXGBE_RX_DMA_ATTR);
>                         return err;
> +               }
>         }
>
>         return 0;
> --
> 2.17.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
