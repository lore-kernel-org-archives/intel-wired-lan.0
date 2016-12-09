From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Fri, 09 Dec 2016 15:22:26 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3] i40e/i40evf: Update
 driver to support napi_complete_done changes
In-Reply-To: <20161208001248.13098.93773.stgit@localhost.localdomain>
References: <20161208001248.13098.93773.stgit@localhost.localdomain>
Message-ID: <584B3CB2.9070806@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 12/7/2016 4:14 PM, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> Recently napi_complete_done was updated so that it will return zero if we
> are using the queue vector for busy polling.  When this is the case we
> don't need to re-enable interrupts as the busy polling will reschedule the
> NAPI instance when it is finally done polling.

This patch is causing a regression with memcached when using epoll with 
busy polling.
I think we need to do more investigation before pushing or re-working 
this patch.

Thanks
Sridhar

> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>
> v2: Updated code to place the IRQ enabling inside the if statment
>      This made it so that we are consistent with the recent return value changes
>
> v3: Added i40evf changes as well
>
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   32 +++++++++++++------------
>   drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   28 ++++++++++++----------
>   2 files changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index e88e335c34ef..f9ef8c2676e2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2033,22 +2033,24 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>   		}
>   	}
>   
> -	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
> -		q_vector->arm_wb_state = false;
> -
> -	/* Work is done so exit the polling mode and re-enable the interrupt */
> -	napi_complete_done(napi, work_done);
> -
> -	/* If we're prematurely stopping polling to fix the interrupt
> -	 * affinity we want to make sure polling starts back up so we
> -	 * issue a call to i40e_force_wb which triggers a SW interrupt.
> +	/* Work is done so exit the polling mode,
> +	 * if not busy polling re-enable interrupts.
>   	 */
> -	if (!clean_complete)
> -		i40e_force_wb(vsi, q_vector);
> -	else if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED))
> -		i40e_irq_dynamic_enable_icr0(vsi->back, false);
> -	else
> -		i40e_update_enable_itr(vsi, q_vector);
> +	if (napi_complete_done(napi, work_done)) {
> +		if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
> +			q_vector->arm_wb_state = false;
> +
> +		/* If we're prematurely stopping polling to fix the interrupt
> +		 * affinity we want to make sure polling starts back up so we
> +		 * issue a call to i40e_force_wb which triggers a SW interrupt.
> +		 */
> +		if (!clean_complete)
> +			i40e_force_wb(vsi, q_vector);
> +		else if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED))
> +			i40e_irq_dynamic_enable_icr0(vsi->back, false);
> +		else
> +			i40e_update_enable_itr(vsi, q_vector);
> +	}
>   
>   	return min(work_done, budget - 1);
>   }
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> index 4870cb50dc33..3097a91bd4aa 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> @@ -1494,20 +1494,22 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
>   		}
>   	}
>   
> -	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
> -		q_vector->arm_wb_state = false;
> -
> -	/* Work is done so exit the polling mode and re-enable the interrupt */
> -	napi_complete_done(napi, work_done);
> -
> -	/* If we're prematurely stopping polling to fix the interrupt
> -	 * affinity we want to make sure polling starts back up so we
> -	 * issue a call to i40evf_force_wb which triggers a SW interrupt.
> +	/* Work is done so exit the polling mode,
> +	 * if not busy polling re-enable interrupts.
>   	 */
> -	if (!clean_complete)
> -		i40evf_force_wb(vsi, q_vector);
> -	else
> -		i40e_update_enable_itr(vsi, q_vector);
> +	if (napi_complete_done(napi, work_done)) {
> +		if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
> +			q_vector->arm_wb_state = false;
> +
> +		/* If we're prematurely stopping polling to fix the interrupt
> +		 * affinity we want to make sure polling starts back up so we
> +		 * issue a call to i40evf_force_wb which triggers a SW interrupt.
> +		 */
> +		if (!clean_complete)
> +			i40evf_force_wb(vsi, q_vector);
> +		else
> +			i40e_update_enable_itr(vsi, q_vector);
> +	}
>   
>   	return min(work_done, budget - 1);
>   }
>

