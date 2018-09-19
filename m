From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 19 Sep 2018 08:28:08 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: off by one in
 ixgbevf_ipsec_tx()
In-Reply-To: <20180919103529.GC9238@mwanda>
References: <20180919103529.GC9238@mwanda>
Message-ID: <c7622bdf-c209-1871-68a1-744f0987dba3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/19/2018 3:35 AM, Dan Carpenter wrote:
> The ipsec->tx_tbl[] array has IXGBE_IPSEC_MAX_SA_COUNT elements so the >
> should be a >=.
> 
> Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>

> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> index 997cea675a37..4fcbeffce52b 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> @@ -470,7 +470,7 @@ int ixgbevf_ipsec_tx(struct ixgbevf_ring *tx_ring,
>   	}
>   
>   	sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
> -	if (unlikely(sa_idx > IXGBE_IPSEC_MAX_SA_COUNT)) {
> +	if (unlikely(sa_idx >= IXGBE_IPSEC_MAX_SA_COUNT)) {
>   		netdev_err(tx_ring->netdev, "%s: bad sa_idx=%d handle=%lu\n",
>   			   __func__, sa_idx, xs->xso.offload_handle);
>   		return 0;
> 
