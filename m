From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 22 Jan 2021 13:36:50 +0100
Subject: [Intel-wired-lan] [PATCH net] ixgbe: add NULL pointer check
 before calling xdp_rxq_info_reg
In-Reply-To: <1611314635-25592-1-git-send-email-wangyunjian@huawei.com>
References: <1611314635-25592-1-git-send-email-wangyunjian@huawei.com>
Message-ID: <3d93455e-cfe5-4f03-0b25-bc1c61fb693d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Yunjian,


Thank you for looking at these issue.

Am 22.01.21 um 12:23 schrieb wangyunjian:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> The rx_ring->q_vector could be NULL, so it need to be checked before
> calling xdp_rxq_info_reg.

A small nit: need*s*

> Fixes: b02e5a0ebb172 ("xsk: Propagate napi_id to XDP socket Rx path")
> Addresses-Coverity: ("Dereference after null check")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 6cbbe09ce8a0..7b76b3f448f7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6586,8 +6586,9 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
>   	rx_ring->next_to_use = 0;
>   
>   	/* XDP RX-queue info */
> -	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> -			     rx_ring->queue_index, rx_ring->q_vector->napi.napi_id) < 0)
> +	if (rx_ring->q_vector && xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> +						  rx_ring->queue_index,
> +						  rx_ring->q_vector->napi.napi_id) < 0)

Unrelated, but I always wonder, if there shouldn?t be more logging for 
the error cases.

>   		goto err;
>   
>   	rx_ring->xdp_prog = adapter->xdp_prog;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
