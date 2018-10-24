From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 24 Oct 2018 13:38:57 +0300
Subject: [Intel-wired-lan] [PATCH][next] igc: fix error return handling
 from call to netif_set_real_num_tx_queues
In-Reply-To: <20181019181615.27528-1-colin.king@canonical.com>
References: <20181019181615.27528-1-colin.king@canonical.com>
Message-ID: <e0080271-fdd5-75fa-6acb-a88eeb7a163b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/19/2018 21:16, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to netif_set_real_num_tx_queues is not assigning the error
> return to variable err even though the next line checks err for an
> error.  Fix this by adding the missing err assignment.
> 
> Detected by CoverityScan, CID#1474551 ("Logically dead code")
> 
> Fixes: 3df25e4c1e66 ("igc: Add interrupt support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 9d85707e8a81..80ddbd987764 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3358,7 +3358,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   		goto err_req_irq;
>   
>   	/* Notify the stack of the actual queue counts. */
> -	netif_set_real_num_tx_queues(netdev, adapter->num_tx_queues);
> +	err = netif_set_real_num_tx_queues(netdev, adapter->num_tx_queues);
>   	if (err)
>   		goto err_set_queues;
>   
> 
Thanks for the patch. Good catch of my typo.

Acked-by: Sasha Neftin <sasha.neftin@intel.com>
