From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 1 Sep 2021 10:57:09 +0200
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix displaying queue
 statistics shown by ethtool
In-Reply-To: <20210901082657.25109-1-jedrzej.jagielski@intel.com>
References: <20210901082657.25109-1-jedrzej.jagielski@intel.com>
Message-ID: <09fab5e6-532f-85a1-3232-223d4870551f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Witold, dear Jedrzej,


Am 01.09.21 um 10:26 schrieb Jedrzej Jagielski:
> Change the number of used queues amount in the NIC statistics. The
> defined number was displaced with actual amount of queues. This fixes

Maybe add the variable names in brackets after it?

> problem with displaying queues statistics, that were not configured.

Example outputs showing the problem might be helpful and useful for testing.

> Fixes: 6dba41cd02fc ("i40evf: update ethtool stats code and use helper functions")
> Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 7cbe59beeebb..6d67cd3b96bd 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -404,10 +404,10 @@ static void iavf_get_stat_strings(struct net_device *netdev, u8 *data)
>   
>   	iavf_add_stat_strings(&data, iavf_gstrings_stats);
>   
> -	/* Queues are always allocated in pairs, so we just use num_tx_queues
> -	 * for both Tx and Rx queues.
> -	 */
> -	for (i = 0; i < netdev->num_tx_queues; i++) {
> +	/* Queues are always allocated in pairs, so we just use
> +	* real_num_tx_queues for both Tx and Rx queues.
> +	*/

The alignment of the comment characters looks off.

> +	for (i = 0; i < netdev->real_num_tx_queues; i++) {
>   		iavf_add_stat_strings(&data, iavf_gstrings_queue_stats,
>   				      "tx", i);
>   		iavf_add_stat_strings(&data, iavf_gstrings_queue_stats,
> 


Kind regards,

Paul
