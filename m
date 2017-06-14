From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 14 Jun 2017 22:03:32 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 2/9] i40e: remove
 WQ_UNBOUND and the task limit of our workqueue
In-Reply-To: <20170614081742.18561-2-alice.michael@intel.com>
References: <20170614081742.18561-1-alice.michael@intel.com>
 <20170614081742.18561-2-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58829C544E@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

> -----Original Message-----
> From: Michael, Alice
> Sent: Wednesday, June 14, 2017 1:18 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S73-V2 2/9] i40e: remove WQ_UNBOUND and the task limit
> of our workqueue
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> During certain events such as a CORER, multiple devices will run a work
> task to handle some cleanup. This can cause issues due to
> a single-threaded workqueue which can mean that a device doesn't cleanup
> in time. Prevent this by removing the single-threaded restriction on the
> module workqueue. This avoids the need to add more complex yielding
> logic in our service task routine. This is also similar to what other
> drivers such as fm10k do.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 4490264..c794e27 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -12180,12 +12180,14 @@ static int __init i40e_init_module(void)
>  		i40e_driver_string, i40e_driver_version_str);
>  	pr_info("%s: %s\n", i40e_driver_name, i40e_copyright);
> 
> -	/* we will see if single thread per module is enough for now,
> -	 * it can't be any worse than using the system workqueue which
> -	 * was already single threaded
> +	/* There is no need to throttle the number of active tasks because
> +	 * each device limits its own task using a state bit for scheduling
> +	 * the service task, and the device tasks do not interfere with each
> +	 * other, so we don't set a max task limit. We must set
> WQ_MEM_RECLAIM
> +	 * since we need to be able to guarantee forward progress even under
> +	 * memory pressure.
>  	 */
> -	i40e_wq = alloc_workqueue("%s", WQ_UNBOUND |
> WQ_MEM_RECLAIM, 1,
> -				  i40e_driver_name);
> +	i40e_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
> i40e_driver_name);
>  	if (!i40e_wq) {
>  		pr_err("%s: Failed to create workqueue\n", i40e_driver_name);
>  		return -ENOMEM;
> --
> 2.9.3

