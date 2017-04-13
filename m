From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 13 Apr 2017 17:21:07 +0000
Subject: [Intel-wired-lan] [next PATCH S70 03/12] i40e: don't hold RTNL
 lock while waiting for VF reset to finish
In-Reply-To: <20170413084555.6962-3-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-3-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857E014D4@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

Thanks,
Jake

> -----Original Message-----
> From: Michael, Alice
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S70 03/12] i40e: don't hold RTNL lock while waiting for VF
> reset to finish
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We made some effort to reduce the RTNL lock scope when resetting and
> rebuilding the PF. Unfortunately we still held the RTNL lock during the
> VF reset operation, which meant that multiple PFs could not reset in
> parallel due to the global lock. For now, further reduce the scope by
> not holding the RTNL lock while resetting VFs. This allows multiple PFs
> to reset in a timely manner.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I2fbf823a0063f24dff67676cad09f0bbf83ee4ce
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 4b507ce..1c06693 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7151,6 +7151,10 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit,
> bool lock_acquired)
>  	/* restart the VSIs that were rebuilt and running before the reset */
>  	i40e_pf_unquiesce_all_vsi(pf);
> 
> +	/* Release the RTNL lock before we start resetting VFs */
> +	if (!lock_acquired)
> +		rtnl_unlock();
> +
>  	if (pf->num_alloc_vfs) {
>  		for (v = 0; v < pf->num_alloc_vfs; v++)
>  			i40e_reset_vf(&pf->vf[v], true);
> @@ -7159,9 +7163,12 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit,
> bool lock_acquired)
>  	/* tell the firmware that we're starting */
>  	i40e_send_version(pf);
> 
> +	/* We've already released the lock, so don't do it again */
> +	goto end_core_reset;
> +
>  end_unlock:
> -if (!lock_acquired)
> -	rtnl_unlock();
> +	if (!lock_acquired)
> +		rtnl_unlock();
>  end_core_reset:
>  	clear_bit(__I40E_RESET_FAILED, &pf->state);
>  clear_recovery:
> --
> 2.9.3

