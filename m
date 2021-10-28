From: Michael, Alice <alice.michael@intel.com>
Date: Thu, 28 Oct 2021 23:01:28 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix adopting new
 combined setting
In-Reply-To: <20211027155156.54453-1-michal.maloszewski@intel.com>
References: <20211027155156.54453-1-michal.maloszewski@intel.com>
Message-ID: <MWHPR11MB00624E2C73773F8865759A11E4869@MWHPR11MB0062.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Maloszewski
> Sent: Wednesday, October 27, 2021 8:52 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Maloszewski, Michal <michal.maloszewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix adopting new combined
> setting
> 
> New combined setting is fixed adopt after VF reset.
> This has been implemented by call reinit interrupt scheme during VF reset.
> Without this fix new combined setting has never been adopted.
> 
> Fixes: 129cf89e5856 ("iavf: rename functions and structs to new name")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 80437ef26..355f98924 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2233,7 +2233,8 @@ continue_reset:
>  			 err);
>  	adapter->aq_required = 0;
> 
> -	if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
> +	if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
> +	    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
>  		err = iavf_reinit_interrupt_scheme(adapter);
>  		if (err)
>  			goto reset_err;
> @@ -2304,10 +2305,11 @@ continue_reset:
>  		if (err)
>  			goto reset_err;
> 
> -		if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
> -			err = iavf_request_traffic_irqs(adapter, netdev->name);
> -			if (err)
> -				goto reset_err;
> +	if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
> +	    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
> +		err = iavf_request_traffic_irqs(adapter, netdev->name);
> +		if (err)
> +			goto reset_err;
> 
>  			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
>  		}

This chunk seems to be what is producing this error, please fix this and re-submit;
>> drivers/net/ethernet/intel/iavf/iavf_main.c:2288:3: error: this 'if' 
>> clause does not guard... [-Werror=misleading-indentation]
    2288 |   if (err)
         |   ^~
   drivers/net/ethernet/intel/iavf/iavf_main.c:2291:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2291 |    adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
         |    ^~~~~~~
   cc1: all warnings being treated as errors

> @@ -2321,6 +2323,8 @@ continue_reset:
>  		adapter->state = __IAVF_DOWN;
>  		wake_up(&adapter->down_waitqueue);
>  	}
> +
> +	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
>  	mutex_unlock(&adapter->client_lock);
>  	mutex_unlock(&adapter->crit_lock);
> 
> --
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
