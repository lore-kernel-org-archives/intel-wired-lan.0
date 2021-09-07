From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Tue, 7 Sep 2021 12:54:33 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix refreshing iavf
 adapter stats on ethtool request
In-Reply-To: <f4a7fedd-968f-f683-f3ac-a444a927d397@molgen.mpg.de>
References: <20210903064846.71507-1-jedrzej.jagielski@intel.com>
 <f4a7fedd-968f-f683-f3ac-a444a927d397@molgen.mpg.de>
Message-ID: <BN6PR11MB1379FBBAAE7D9B2E528C0641F0D39@BN6PR11MB1379.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Paul,

" Should the summary have a net prefix or so? Also shorter:

> iavf: Refresh iavf adapter stats on ethtool request"

Shouldn't the commit title begin begins with one from the words <fix/add/del/refactor>?

"Should that be `iavf_schedule_request_stats()`?"
This function is invoked only from iavf_get_ethtool_stats.

Best regards,
J?drzej


-----Original Message-----
From: Paul Menzel <pmenzel@molgen.mpg.de> 
Sent: pi?tek, 3 wrze?nia 2021 09:43
To: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH net v1] iavf: Fix refreshing iavf adapter stats on ethtool request

Dear Jedrzej,


Am 03.09.21 um 08:48 schrieb Jedrzej Jagielski:

Should the summary have a net prefix or so? Also shorter:

> iavf: Refresh iavf adapter stats on ethtool request


> Currently iavf adapter statistics are refreshed only in a watchdog 
> task, triggered approximately every two seconds, which causes some 
> ethtool requests to return outdated values.
> 
> Add explicit statistics refresh when requested by ethtool -S.
> 
> Fixes: b476b0030e61 ("iavf: Move commands processing to the separate 
> function")
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf.h         |  2 ++
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  3 +++
>   drivers/net/ethernet/intel/iavf/iavf_main.c    | 18 ++++++++++++++++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h 
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 21c95775509a..afe6b0d24a9a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -306,6 +306,7 @@ struct iavf_adapter {
>   #define IAVF_FLAG_AQ_DEL_FDIR_FILTER		BIT(26)
>   #define IAVF_FLAG_AQ_ADD_ADV_RSS_CFG		BIT(27)
>   #define IAVF_FLAG_AQ_DEL_ADV_RSS_CFG		BIT(28)
> +#define IAVF_FLAG_AQ_REQUEST_STATS		BIT(29)
>   
>   	/* OS defined structs */
>   	struct net_device *netdev;
> @@ -399,6 +400,7 @@ int iavf_up(struct iavf_adapter *adapter);
>   void iavf_down(struct iavf_adapter *adapter);
>   int iavf_process_config(struct iavf_adapter *adapter);
>   void iavf_schedule_reset(struct iavf_adapter *adapter);
> +void iavf_schedule_request_stats(struct iavf_adapter *adapter);
>   void iavf_reset(struct iavf_adapter *adapter);
>   void iavf_set_ethtool_ops(struct net_device *netdev);
>   void iavf_update_stats(struct iavf_adapter *adapter); diff --git 
> a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c 
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 7cbe59beeebb..21c4d4180f3e 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -354,6 +354,9 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
>   	struct iavf_adapter *adapter = netdev_priv(netdev);
>   	unsigned int i;
>   
> +	/* Explicitly request stats refresh */
> +	iavf_schedule_request_stats(adapter);
> +
>   	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
>   
>   	rcu_read_lock();
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c 
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 80437ef26391..e7ac6356772b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -165,6 +165,19 @@ void iavf_schedule_reset(struct iavf_adapter *adapter)
>   	}
>   }
>   
> +/**
> + * iavf_schedule_request_stats - Set the flags and schedule 
> +statistics request
> + * @adapter: board private structure
> + *
> + * Sets IAVF_FLAG_AQ_REQUEST_STATS flag so iavf_watchdog_task() will 
> +explicitly
> + * request and refresh ethtool stats
> + **/
> +void iavf_schedule_request_stats(struct iavf_adapter *adapter) {
> +	adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_STATS;
> +	queue_work(iavf_wq, &adapter->watchdog_task.work); }
> +
>   /**
>    * iavf_tx_timeout - Respond to a Tx Hang
>    * @netdev: network interface device structure @@ -1700,6 +1713,11 
> @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
>   		iavf_del_adv_rss_cfg(adapter);
>   		return 0;
>   	}
> +	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_STATS) {
> +		iavf_request_stats(adapter);

Should that be `iavf_schedule_request_stats()`?

> +		return IAVF_SUCCESS;
> +	}
> +
>   	return -EAGAIN;
>   }


Kind regards,

Paul
