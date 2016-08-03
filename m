From: Shannon Nelson <sln@onemain.com>
Date: Wed, 3 Aug 2016 11:10:27 -0700
Subject: [Intel-wired-lan] [next PATCH S41 3/5] i40e: Add support for
 HMC resource and profile for X722
In-Reply-To: <1470244815-31174-4-git-send-email-bimmy.pujari@intel.com>
References: <1470244815-31174-1-git-send-email-bimmy.pujari@intel.com>
 <1470244815-31174-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <9ec72b71-66c8-7c54-457f-c09e409fc540@onemain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 08/03/2016 10:20 AM, Bimmy Pujari wrote:
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
>
> This patch adds support for HMC resource and profile cmds for X722
> firmware.
>
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Icc332101f38ab15d1bfa167823100eb4f6822f7e
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 23 ++++++++++++++++++++++
>   .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 23 ++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> index 11cf1a5..aabacc3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> @@ -204,6 +204,11 @@ enum i40e_admin_queue_opc {
>   	i40e_aqc_opc_suspend_port_tx				= 0x041B,
>   	i40e_aqc_opc_resume_port_tx				= 0x041C,
>   	i40e_aqc_opc_configure_partition_bw			= 0x041D,
> +	/* hmc */
> +	i40e_aqc_opc_query_hmc_resource_profile	= 0x0500,
> +	i40e_aqc_opc_set_hmc_resource_profile	= 0x0501,

Hmmm - I see these already in the 4.5 kernel source I have lying around, 
are you sure you need this patch?

> +
> +	/* phy commands*/

This comment is already here

>   
>   	/* phy commands*/
>   	i40e_aqc_opc_get_phy_abilities		= 0x0600,
> @@ -1582,6 +1587,24 @@ struct i40e_aqc_configure_partition_bw_data {
>   
>   I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
>   
> +/* Get and set the active HMC resource profile and status.
> + * (direct 0x0500) and (direct 0x0501)
> + */
> +struct i40e_aq_get_set_hmc_resource_profile {
> +	u8	pm_profile;
> +	u8	pe_vf_enabled;
> +	u8	reserved[14];
> +};
> +
> +I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
> +
> +enum i40e_aq_hmc_profile {
> +	/* I40E_HMC_PROFILE_NO_CHANGE	= 0, reserved */
> +	I40E_HMC_PROFILE_DEFAULT	= 1,
> +	I40E_HMC_PROFILE_FAVOR_VF	= 2,
> +	I40E_HMC_PROFILE_EQUAL		= 3,
> +};
> +

Yep, these are already there as well.

sln

>   /* Get PHY Abilities (indirect 0x0600) uses the generic indirect struct */
>   
>   /* set in param0 for get phy abilities to report qualified modules */
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> index 3114dcf..c07e3a3 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> @@ -204,6 +204,11 @@ enum i40e_admin_queue_opc {
>   	i40e_aqc_opc_suspend_port_tx				= 0x041B,
>   	i40e_aqc_opc_resume_port_tx				= 0x041C,
>   	i40e_aqc_opc_configure_partition_bw			= 0x041D,
> +	/* hmc */
> +	i40e_aqc_opc_query_hmc_resource_profile	= 0x0500,
> +	i40e_aqc_opc_set_hmc_resource_profile	= 0x0501,
> +
> +	/* phy commands*/
>   
>   	/* phy commands*/
>   	i40e_aqc_opc_get_phy_abilities		= 0x0600,
> @@ -1579,6 +1584,24 @@ struct i40e_aqc_configure_partition_bw_data {
>   
>   I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
>   
> +/* Get and set the active HMC resource profile and status.
> + * (direct 0x0500) and (direct 0x0501)
> + */
> +struct i40e_aq_get_set_hmc_resource_profile {
> +	u8	pm_profile;
> +	u8	pe_vf_enabled;
> +	u8	reserved[14];
> +};
> +
> +I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
> +
> +enum i40e_aq_hmc_profile {
> +	/* I40E_HMC_PROFILE_NO_CHANGE	= 0, reserved */
> +	I40E_HMC_PROFILE_DEFAULT	= 1,
> +	I40E_HMC_PROFILE_FAVOR_VF	= 2,
> +	I40E_HMC_PROFILE_EQUAL		= 3,
> +};
> +
>   /* Get PHY Abilities (indirect 0x0600) uses the generic indirect struct */
>   
>   /* set in param0 for get phy abilities to report qualified modules */

