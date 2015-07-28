From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 20:51:53 +0000
Subject: [Intel-wired-lan] [next PATCH S9 06/15] i40e: count drops
	in	netstat interface
In-Reply-To: <1437684884-222825-7-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4D7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Verified-by: Andrew Bowers <andrewx.bowers@intel.com>

Present in git log, code changes present in tree, netstat -I shows rx_dropped counter

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 06/15] i40e: count drops in netstat
> interface
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The i40e rx_dropped counter was not showing up in netstat -i.
> Add the right counter to be updated with the stats.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I4dd552e9995836099184f9d9a08e90edb591155f
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index fe3bfb8..a6a5f45 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -361,6 +361,7 @@ static struct rtnl_link_stats64
> *i40e_get_netdev_stats_struct(
>  	stats->tx_errors	= vsi_stats->tx_errors;
>  	stats->tx_dropped	= vsi_stats->tx_dropped;
>  	stats->rx_errors	= vsi_stats->rx_errors;
> +	stats->rx_dropped	= vsi_stats->rx_dropped;
>  	stats->rx_crc_errors	= vsi_stats->rx_crc_errors;
>  	stats->rx_length_errors	= vsi_stats->rx_length_errors;
> 
> --
> 1.9.3
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
