From: Jonathan Toppins <jtoppins@redhat.com>
Date: Fri, 28 Jan 2022 10:02:27 -0500
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix KASAN error in LAG
 NETDEV_UNREGISTER handler
In-Reply-To: <20220118210820.1055792-1-david.m.ertman@intel.com>
References: <20220118210820.1055792-1-david.m.ertman@intel.com>
Message-ID: <97261624-d64f-4b82-2c11-a2dd5934c6f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/18/22 16:08, Dave Ertman wrote:
> Currently, the same handler is called for both a NETDEV_BONDING_INFO
> LAG unlink notification as for a NETDEV_UNREGISTER call.  This is
> causing a problem though, since the netdev_notifier_info passed has
> a different structure depending on which event is passed.  The problem
> manifests as a call trace from a BUG: KASAN stack-out-of-bounds error.
> 
> Fix this by creating a handler specific to NETDEV_UNREGISTER that only
> is passed valid elements in the netdev_notifier_info struct for the
> NETDEV_UNREGISTER event.
> 
> Also included is the removal of an unbalanced dev_put on the peer_netdev
> and related braces.
> 
> Fixes: 6a8b357278f5 ("ice: Respond to a NETDEV_UNREGISTER event for LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Acked-by: Jonathan Toppins <jtoppins@redhat.com>

> 
> ---
> 
> v2: also remove unneeded if block
> ---
>   drivers/net/ethernet/intel/ice/ice_lag.c | 34 +++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index e375ac849aec..4f954db01b92 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -204,17 +204,39 @@ ice_lag_unlink(struct ice_lag *lag,
>   		lag->upper_netdev = NULL;
>   	}
>   
> -	if (lag->peer_netdev) {
> -		dev_put(lag->peer_netdev);
> -		lag->peer_netdev = NULL;
> -	}
> -
> +	lag->peer_netdev = NULL;
>   	ice_set_sriov_cap(pf);
>   	ice_set_rdma_cap(pf);
>   	lag->bonded = false;
>   	lag->role = ICE_LAG_NONE;
>   }
>   
> +/**
> + * ice_lag_unregister - handle netdev unregister events
> + * @lag: LAG info struct
> + * @netdev: netdev reporting the event
> + */
> +static void ice_lag_unregister(struct ice_lag *lag, struct net_device *netdev)
> +{
> +	struct ice_pf *pf = lag->pf;
> +
> +	/* check to see if this event is for this netdev
> +	 * check that we are in an aggregate
> +	 */
> +	if (netdev != lag->netdev || !lag->bonded)
> +		return;
> +
> +	if (lag->upper_netdev) {
> +		dev_put(lag->upper_netdev);
> +		lag->upper_netdev = NULL;
> +		ice_set_sriov_cap(pf);
> +		ice_set_rdma_cap(pf);
> +	}
> +	/* perform some cleanup in case we come back */
> +	lag->bonded = false;
> +	lag->role = ICE_LAG_NONE;
> +}
> +
>   /**
>    * ice_lag_changeupper_event - handle LAG changeupper event
>    * @lag: LAG info struct
> @@ -307,7 +329,7 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
>   		ice_lag_info_event(lag, ptr);
>   		break;
>   	case NETDEV_UNREGISTER:
> -		ice_lag_unlink(lag, ptr);
> +		ice_lag_unregister(lag, netdev);
>   		break;
>   	default:
>   		break;

