From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 16 Sep 2021 22:27:09 +0000
Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix displaying queue
 statistics shown by ethtool
In-Reply-To: <20210915082107.24204-1-jedrzej.jagielski@intel.com>
References: <20210915082107.24204-1-jedrzej.jagielski@intel.com>
Message-ID: <d57cbbe65c1b2750c815e7725e9f3cd2896030a3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-09-15 at 08:21 +0000, Jedrzej Jagielski wrote:
> Driver provided too many lines as an output to ethtool -S command.
> Return actual length of string set of ethtool stats. Instead of
> predefined
> maximal value use the actual value on netdev, iterate over active
> queues.
> Without this patch, ethtool -S report would produce additional
> erroneous lines.
> 
> Without this change in statistics after showing them by ethtool -S
> will be displayed queues that are not configured.
> 
> Fixes: 6dba41cd02fc ("i40evf: update ethtool stats code and use
> helper functions")
> Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
> Signed-off-by: Przemyslaw Patynowski <
> przemyslawx.patynowski at intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---

<snip>

> @@ -357,17 +364,19 @@ static void iavf_get_ethtool_stats(struct
> net_device *netdev,
>  	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
>  
>  	rcu_read_lock();
> -	for (i = 0; i < IAVF_MAX_REQ_QUEUES; i++) {
> +	/* As num_active_queues describe both tx and rx queues, we can
> use
> +	 * it to iterate over rings' stats.
> +	 */
> +	for (i = 0; i < adapter->num_active_queues; i++) {
> +
>  		struct iavf_ring *ring;

CHECK: Blank lines aren't necessary after an open brace '{'
#56: FILE: drivers/net/ethernet/intel/iavf/iavf_ethtool.c:371:
+       for (i = 0; i < adapter->num_active_queues; i++) {
+

>  
> -		/* Avoid accessing un-allocated queues */
> -		ring = (i < adapter->num_active_queues ?
> -			&adapter->tx_rings[i] : NULL);
> +		/* Tx rings stats */
> +		ring = &adapter->tx_rings[i];
>  		iavf_add_queue_stats(&data, ring);
>  
> -		/* Avoid accessing un-allocated queues */
> -		ring = (i < adapter->num_active_queues ?
> -			&adapter->rx_rings[i] : NULL);
> +		/* Rx rings stats */
> +		ring = &adapter->rx_rings[i];
>  		iavf_add_queue_stats(&data, ring);
>  	}
>  	rcu_read_unlock();
