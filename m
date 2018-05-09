From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 9 May 2018 09:22:10 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix memory leak on ipsec
 allocation
In-Reply-To: <20180509135848.20530-1-colin.king@canonical.com>
References: <20180509135848.20530-1-colin.king@canonical.com>
Message-ID: <4adefe2d-dcae-f310-18cd-5e3269b8b593@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/9/2018 6:58 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error clean up path kfree's adapter->ipsec and should be
> instead kfree'ing ipsec. Fix this.  Also, the err1 error exit path
> does not need to kfree ipsec because this failure path was for
> the failed allocation of ipsec.
> 
> Detected by CoverityScan, CID#146424 ("Resource Leak")
> 
> Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Yep, thanks, good catch.

Acked-by: Shannon Nelson <shannon.nelson@oracle.com>


> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 41af2b81e960..195c0b65eee2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -919,8 +919,8 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>   	kfree(ipsec->ip_tbl);
>   	kfree(ipsec->rx_tbl);
>   	kfree(ipsec->tx_tbl);
> +	kfree(ipsec);
>   err1:
> -	kfree(adapter->ipsec);
>   	netdev_err(adapter->netdev, "Unable to allocate memory for SA tables");
>   }
>   
> 
