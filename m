From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Wed, 3 Mar 2021 10:08:43 +0200
Subject: [Intel-wired-lan] [PATCH net v1 1/2] igc: Fix Pause Frame
 Advertising
In-Reply-To: <20210219163648.14581-2-muhammad.husaini.zulkifli@intel.com>
References: <20210219163648.14581-1-muhammad.husaini.zulkifli@intel.com>
 <20210219163648.14581-2-muhammad.husaini.zulkifli@intel.com>
Message-ID: <610f7dee-34db-9d22-cdfa-59f533211b48@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 19/02/2021 18:36, Muhammad Husaini Zulkifli wrote:
> Fix Pause Frame Advertising when getting the advertisement via ethtool.
> Remove setting the "advertising" bit in link_ksettings during default
> case when tx and rx are in off state with Auto Negotiatiate off.
> 
> Below is the original output of advertisement link during tx and rx off:
> Advertised pause frame use: Symmetric Receive-only
> 
> Expected output:
> Advertised pause frame use: No
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Malli C <mallikarjuna.chilakala@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 824a6c454bca..67a4aed45fc2 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1725,9 +1725,7 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>   						     Asym_Pause);
>   		break;
>   	default:
> -		ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
> -		ethtool_link_ksettings_add_link_mode(cmd, advertising,
> -						     Asym_Pause);
> +		break;
>   	}
>   
>   	status = pm_runtime_suspended(&adapter->pdev->dev) ?
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
