From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 22 Jan 2021 09:54:06 -0800
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: add NULL pointer check
 before calling xdp_rxq_info_reg
In-Reply-To: <1611322105-30688-1-git-send-email-wangyunjian@huawei.com>
References: <1611322105-30688-1-git-send-email-wangyunjian@huawei.com>
Message-ID: <CAKgT0UcpQpGLCdRbaEzyb4Q4gC9gmefg4bMFcgrQoRwy6UJvrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 22, 2021 at 5:29 AM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> The rx_ring->q_vector could be NULL, so it needs to be checked before
> calling xdp_rxq_info_reg.
>
> Fixes: b02e5a0ebb172 ("xsk: Propagate napi_id to XDP socket Rx path")
> Addresses-Coverity: ("Dereference after null check")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

This is kind of a big escape for the driver. From what I can tell it
looks like the "ethtool -t" test now causes a NULL pointer
dereference.

As far as the patch itself it looks good to me. This should probably
be pushed for any of the other Intel drivers that follow a similar
model as I suspect they were exhibit the same symptom with "ethtool
-t" triggering a NULL pointer dereference.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

> ---
> v2:
>   * fix commit log
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 6cbbe09ce8a0..7b76b3f448f7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6586,8 +6586,9 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
>         rx_ring->next_to_use = 0;
>
>         /* XDP RX-queue info */
> -       if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> -                            rx_ring->queue_index, rx_ring->q_vector->napi.napi_id) < 0)
> +       if (rx_ring->q_vector && xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> +                                                 rx_ring->queue_index,
> +                                                 rx_ring->q_vector->napi.napi_id) < 0)
>                 goto err;
>
>         rx_ring->xdp_prog = adapter->xdp_prog;
> --
> 2.23.0
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
