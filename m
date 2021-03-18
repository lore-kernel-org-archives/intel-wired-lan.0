From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 18 Mar 2021 09:18:00 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix kernel oops when i40e
 driver removes VF's
In-Reply-To: <20210218111526.71493-1-eryk.roch.rybak@intel.com>
References: <20210218111526.71493-1-eryk.roch.rybak@intel.com>
Message-ID: <CY4PR11MB1576F34E5E813013AEC8FC0EAB699@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Eryk Rybak
> Sent: czwartek, 18 lutego 2021 12:15
> To: intel-wired-lan at lists.osuosl.org
> Cc: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net] i40e: Fix kernel oops when i40e driver
> removes VF's
> 
> Fix the reason of kernel oops when i40e driver removed VFs.
> Added new __I40E_VFS_RELEASING state to signalize releasing process by
> PF, that it makes possible to exit of reset VF procedure.
> Without this patch, it is possible to suspend the VFs reset by releasing VFs
> resources procedure. Retrying the reset after the timeout works on the
> freed VF memory causing a kernel oops.
> 
> Fixes: d43d60e5eb95("i40e: ensure reset occurs when disabling VF")
> Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 118473d..fe12587 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -142,6 +142,7 @@ enum i40e_state_t {
>  	__I40E_VIRTCHNL_OP_PENDING,
>  	__I40E_RECOVERY_MODE,
>  	__I40E_VF_RESETS_DISABLED,	/* disable resets during i40e_remove
> */
> +	__I40E_VFS_RELEASING,
>  	/* This must be last as it determines the size of the BITMAP */
>  	__I40E_STATE_SIZE__,
>  };
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 1b6ec9b..0c6cbe9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -137,6 +137,7 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
>   **/
>  static inline void i40e_vc_disable_vf(struct i40e_vf *vf)  {
> +	struct i40e_pf *pf = vf->pf;
>  	int i;
> 
>  	i40e_vc_notify_vf_reset(vf);
> @@ -147,6 +148,11 @@ static inline void i40e_vc_disable_vf(struct i40e_vf
> *vf)
>  	 * ensure a reset.
>  	 */
>  	for (i = 0; i < 20; i++) {
> +		/* If pf is in vfs releasing state reset vf is impossible,
> +		 * so leave it.
> +		 */
> +		if (test_bit(__I40E_VFS_RELEASING, pf->state))
> +			return;
>  		if (i40e_reset_vf(vf, false))
>  			return;
>  		usleep_range(10000, 20000);
> @@ -1574,6 +1580,8 @@ void i40e_free_vfs(struct i40e_pf *pf)
> 
>  	if (!pf->vf)
>  		return;
> +
> +	set_bit(__I40E_VFS_RELEASING, pf->state);
>  	while (test_and_set_bit(__I40E_VF_DISABLE, pf->state))
>  		usleep_range(1000, 2000);
> 
> @@ -1631,6 +1639,7 @@ void i40e_free_vfs(struct i40e_pf *pf)
>  		}
>  	}
>  	clear_bit(__I40E_VF_DISABLE, pf->state);
> +	clear_bit(__I40E_VFS_RELEASING, pf->state);
>  }
> 
>  #ifdef CONFIG_PCI_IOV
> 
Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
