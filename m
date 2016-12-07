From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Wed, 07 Dec 2016 14:48:44 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] i40e: Update driver to
 support napi_complete_done changes
In-Reply-To: <20161207161037.83528.61516.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161207161037.83528.61516.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <584891CC.6010800@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 12/7/2016 8:10 AM, Alexander Duyck wrote:
> Recently napi_complete_done was updated so that it will return zero if we
> are using the queue vector for busy polling.  When this is the case we
> don't need to re-enable interrupts as the busy polling will reschedule the
> NAPI instance when it is finally done polling.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c |    9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index e88e335..52f2c45 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2033,12 +2033,15 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>   		}
>   	}
>   
> +	/* Work is done so exit the polling mode,
> +	 * if not busy polling re-enable interrupts.
> +	 */
> +	if (!napi_complete_done(napi, work_done))
> +		return 0;
> +

Alex,
The return here should be
     return min(work_done, budget - 1);
similar to the other fix you submitted for i40e_napi_poll()


>   	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
>   		q_vector->arm_wb_state = false;
>   
> -	/* Work is done so exit the polling mode and re-enable the interrupt */
> -	napi_complete_done(napi, work_done);
> -
>   	/* If we're prematurely stopping polling to fix the interrupt
>   	 * affinity we want to make sure polling starts back up so we
>   	 * issue a call to i40e_force_wb which triggers a SW interrupt.
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161207/a3349679/attachment-0001.html>
