From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 7 Dec 2020 14:32:05 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for failed to init
 adminq while VF reset
In-Reply-To: <20201207114223.29030-1-mateusz.palczewski@intel.com>
References: <20201207114223.29030-1-mateusz.palczewski@intel.com>
Message-ID: <551e0e32-b901-4cc0-3919-c497ca3610a2@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Mateusz,


Am 07.12.20 um 12:42 schrieb Mateusz Palczewski:
> Fix for failed to init adminq: -53 while VF is resetting via MAC
> address changing procedure.
> Added sync module to avoid reading deadbeef value in reinit adminq
> during software reset.
> Without this patch it is possible to trigger VF reset procedure
> during reinit adminq. This resulted in an incorrect reading of
> value from the AQP registers and generated the -53 error.

Thank you for fixing this issue. (Blank lines between paragraphs would 
make them better readable.)

How can the problem be reproduced? Do you have a recipe do cause this?

I have some nits below, but maybe you also can use the summary below for 
the git commit message summary, so it?s a statement with a verb in 
imperative mood.

 > Fix init adminq failure while VF reset

You are adding several delays below. What is the effect on that on 
overall timings of the driver?


> Fixes: 9dc2e417383815"(i40e: split some code in i40e_reset_vf into helpers")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Reviewed-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Reviewed-by: Slawomir Laba <slawomirx.laba@intel.com>
> Reviewed-by: Karen Sornek <karen.sornek@intel.com>
> Reviewed-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 46 ++++++++++++++++++-
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  2 +
>   2 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 21ee564..afccbbc 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -1297,6 +1297,32 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
>   	return aq_ret;
>   }
>   
> +/**
> +* i40e_sync_vfr_reset
> +* @hw: pointer to hw struct
> +* @vf_id: VF identifier
> +*
> +* Before trigger hardware reset, we need to know if no other process has

Small typo:

 > Before trigger*ing a* hardware reset, ?

> +* reserved the hardware for any reset operations. This check is done by
> +* examining the status of the ADMINQ bit in VF interrupt register.

Please add how much time this delays.

> +**/
> +static int i40e_sync_vfr_reset(struct i40e_hw *hw, int vf_id)
> +{
> +	u32 reg;
> +	int i;
> +
> +	for (i = 0; i < I40E_VFR_WAIT_COUNT; i++) {
> +		reg = rd32(hw, I40E_VFINT_ICR0_ENA(vf_id)) &
> +			   I40E_VFINT_ICR0_ADMINQ_MASK;
> +		if (reg)
> +			return 0;

The variable `reg` does not seem to be needed.

> +
> +		usleep_range(10, 200);
> +	}

Should an error be logged in case of failure?

> +
> +	return -EAGAIN;
> +}
> +
>   /**
>    * i40e_trigger_vf_reset
>    * @vf: pointer to the VF structure
> @@ -1311,9 +1337,11 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
>   	struct i40e_pf *pf = vf->pf;
>   	struct i40e_hw *hw = &pf->hw;
>   	u32 reg, reg_idx, bit_idx;
> +	bool vf_active;
> +	u32 radq;
>   
>   	/* warn the VF */
> -	clear_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
> +	vf_active = test_and_clear_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
>   
>   	/* Disable VF's configuration API during reset. The flag is re-enabled
>   	 * in i40e_alloc_vf_res(), when it's safe again to access VF's VSI.
> @@ -1327,7 +1355,19 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
>   	 * just need to clean up, so don't hit the VFRTRIG register.
>   	 */
>   	if (!flr) {
> -		/* reset VF using VPGEN_VFRTRIG reg */
> +		/* Sync VFR reset before trigger next one */

triggering

> +		radq = rd32(hw, I40E_VFINT_ICR0_ENA(vf->vf_id)) &
> +			    I40E_VFINT_ICR0_ADMINQ_MASK;
> +		if (vf_active && !radq)
> +			/* waiting for finish reset by virtual driver */

waiting for virtual driver to finish reset

> +			if (i40e_sync_vfr_reset(hw, vf->vf_id))
> +				dev_info(&pf->pdev->dev,
> +					 "Reset VF %d never finished\n",

? after X ms.

Also, please add the consequences of that failure. What does it mean for 
the user, that the reset was unsuccessful?

> +					 vf->vf_id);
> +
> +		/* Reset VF using VPGEN_VFRTRIG reg. It is also setting
> +		 * in progress state in rstat1 register.
> +		 */
>   		reg = rd32(hw, I40E_VPGEN_VFRTRIG(vf->vf_id));
>   		reg |= I40E_VPGEN_VFRTRIG_VFSWR_MASK;
>   		wr32(hw, I40E_VPGEN_VFRTRIG(vf->vf_id), reg);
> @@ -1457,6 +1497,7 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
>   	i40e_cleanup_reset_vf(vf);
>   
>   	i40e_flush(hw);
> +	usleep_range(20000, 40000);

This seems unrelated to the commit?

>   	clear_bit(__I40E_VF_DISABLE, pf->state);
>   
>   	return true;
> @@ -1561,6 +1602,7 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
>   		i40e_cleanup_reset_vf(&pf->vf[v]);
>   
>   	i40e_flush(hw);
> +	usleep_range(20000, 40000);

Ditto.

>   	clear_bit(__I40E_VF_DISABLE, pf->state);
>   
>   	return true;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> index 5491215..fb4f5db 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> @@ -18,6 +18,8 @@
>   
>   #define I40E_MAX_VF_PROMISC_FLAGS	3
>   
> +#define I40E_VFR_WAIT_COUNT		100

Why is 100 chosen? The commit message does not say.

> +
>   /* Various queue ctrls */
>   enum i40e_queue_ctrl {
>   	I40E_QUEUE_CTRL_UNKNOWN = 0,
> 


Kind regards,

Paul
