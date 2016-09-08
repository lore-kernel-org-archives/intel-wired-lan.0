From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 8 Sep 2016 20:57:29 +0000
Subject: [Intel-wired-lan] [next PATCH S45 08/10] i40e: check
 conflicting ntuple/sideband rules when re-enabling ATR
In-Reply-To: <1473210312-29592-9-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857B969E0@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

> -----Original Message-----
> From: Pujari, Bimmy
> Sent: Tuesday, September 06, 2016 6:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S45 08/10] i40e: check conflicting ntuple/sideband
> rules when re-enabling ATR
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In i40e_fdir_check_and_reenable(), the driver performs some checks to
> determine whether it is safe to re-enable FD Sideband and FD ATR
> support. The current check will only determine if there is available
> space in the flow director table. However, this ignores the fact that
> ATR should be disabled when there are TCP/IPv4 sideband rules in effect.
> Add the missing check, and update the info message printed when
> I40E_DEBUG_FD is enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ibb9c63e5be95d63c53a498fdd5dbf69f54a00e08
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 9ab15e2d..3be9675 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -5923,13 +5923,17 @@ void i40e_fdir_check_and_reenable(struct
> i40e_pf *pf)
>  				dev_info(&pf->pdev->dev, "FD
> Sideband/ntuple is being enabled since we have space in the table now\n");
>  		}
>  	}
> -	/* Wait for some more space to be available to turn on ATR */
> +
> +	/* Wait for some more space to be available to turn on ATR. We
> also
> +	 * must check that no existing ntuple rules for TCP are in effect
> +	 */
>  	if (fcnt_prog < (fcnt_avail - I40E_FDIR_BUFFER_HEAD_ROOM * 2)) {
>  		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
> -		    (pf->auto_disable_flags &
> I40E_FLAG_FD_ATR_ENABLED)) {
> +		    (pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED)
> &&
> +		    (pf->fd_tcp_rule == 0)) {
>  			pf->auto_disable_flags &=
> ~I40E_FLAG_FD_ATR_ENABLED;
>  			if (I40E_DEBUG_FD & pf->hw.debug_mask)
> -				dev_info(&pf->pdev->dev, "ATR is being
> enabled since we have space in the table now\n");
> +				dev_info(&pf->pdev->dev, "ATR is being
> enabled since we have space in the table and there are no conflicting ntuple
> rules\n");
>  		}
>  	}
> 
> --
> 2.4.11

