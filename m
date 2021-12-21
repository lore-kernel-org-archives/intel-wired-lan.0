From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 21 Dec 2021 08:32:27 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Minimize amount of
 busy-waiting during AQ send
In-Reply-To: <20211116131329.626045-1-jedrzej.jagielski@intel.com>
References: <20211116131329.626045-1-jedrzej.jagielski@intel.com>
Message-ID: <ecdb8ef3-ccce-d17c-86d6-56f7e1e85606@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Dawid, dear Jedrzej,


Am 16.11.21 um 14:13 schrieb Jedrzej Jagielski:
> The i40e_asq_send_command will now use a non blocking
> usleep_range if possible (non-atomic context), instead of busy-waiting
> udelay. The usleep_range function uses hrtimers to provide better
> performance and remove the negative impact of busy-waiting in

remove*s*

> time-critical environments.

Please re-flow the paragraph for 75 characters per line.

> 1. Rename i40e_asq_send_command to i40e_asq_send_command_atomic
>     and add 5th parameter to inform if called from an atomic context.
>     Call inside usleep_range (if non-atomic) or udelay (if atomic).

I prefer if `i40e_asq_send_command_atomic()` implicitly assumes it?s an 
atomic context without a fifth a parameter. To make it more clear, maybe 
even introduce `i40e_asq_send_command_nonatomic()`.

> 2. Change i40e_asq_send_command to invoke
>     i40e_asq_send_command_atomic(..., false).
> 
> 3. Change two functions:
>      - i40e_aq_set_vsi_uc_promisc_on_vlan
>      - i40e_aq_set_vsi_mc_promisc_on_vlan
>     to explicitly use i40e_asq_send_command_atomic(..., true)
>     instead of i40e_asq_send_command, as they use spinlocks and do some
>     work in an atomic context.
>     All other calls to i40e_asq_send_command remain unchanged.

How can it be tested, that the busy-waiting is reduced? What perf(?) 
commands need to be executed?

> Title: Minimize amount of busy-waiting during AQ send

Tag not needed.

> Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq.c | 29 ++++++++++++++-----
>   drivers/net/ethernet/intel/i40e/i40e_common.c |  6 ++--
>   .../net/ethernet/intel/i40e/i40e_prototype.h  | 14 +++++----
>   3 files changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> index 593912b17609..7abef88801fb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> @@ -769,21 +769,22 @@ static bool i40e_asq_done(struct i40e_hw *hw)
>   }
>   
>   /**
> - *  i40e_asq_send_command - send command to Admin Queue
> + *  i40e_asq_send_command_atomic - send command to Admin Queue
>    *  @hw: pointer to the hw struct
>    *  @desc: prefilled descriptor describing the command (non DMA mem)
>    *  @buff: buffer to use for indirect commands
>    *  @buff_size: size of buffer for indirect commands
>    *  @cmd_details: pointer to command details structure
> + *  @is_atomic_context: is the function called in an atomic context?
>    *
>    *  This is the main send command driver routine for the Admin Queue send
>    *  queue.  It runs the queue, cleans the queue, etc
>    **/
> -i40e_status i40e_asq_send_command(struct i40e_hw *hw,
> -				struct i40e_aq_desc *desc,
> -				void *buff, /* can be NULL */
> -				u16  buff_size,
> -				struct i40e_asq_cmd_details *cmd_details)
> +i40e_status
> +i40e_asq_send_command_atomic(struct i40e_hw *hw, struct i40e_aq_desc *desc,
> +			     void *buff, /* can be NULL */ u16  buff_size,
> +			     struct i40e_asq_cmd_details *cmd_details,
> +			     bool is_atomic_context)
>   {
>   	i40e_status status = 0;
>   	struct i40e_dma_mem *dma_buff = NULL;
> @@ -910,7 +911,12 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
>   			 */
>   			if (i40e_asq_done(hw))
>   				break;
> -			udelay(50);
> +
> +			if (is_atomic_context)
> +				udelay(50);
> +			else
> +				usleep_range(40, 60);
> +

Please mention in the commit message, why the range is 40 to 60 and not 
10 to 50 for example? I would have expected the upper bound to remain 50.

>   			total_delay += 50;
>   		} while (total_delay < hw->aq.asq_cmd_timeout);
>   	}
> @@ -967,6 +973,15 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
>   	return status;
>   }
>   
> +i40e_status
> +i40e_asq_send_command(struct i40e_hw *hw, struct i40e_aq_desc *desc,
> +		      void *buff, /* can be NULL */ u16  buff_size,
> +		      struct i40e_asq_cmd_details *cmd_details)
> +{
> +	return i40e_asq_send_command_atomic(hw, desc, buff, buff_size,
> +					    cmd_details, false);
> +}
> +
>   /**
>    *  i40e_fill_default_direct_cmd_desc - AQ descriptor helper function
>    *  @desc:     pointer to the temp descriptor (non DMA mem)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index b4d3fed0d2f2..f81a674c8d40 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -2073,7 +2073,8 @@ enum i40e_status_code i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
>   	cmd->seid = cpu_to_le16(seid);
>   	cmd->vlan_tag = cpu_to_le16(vid | I40E_AQC_SET_VSI_VLAN_VALID);
>   
> -	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
> +	status = i40e_asq_send_command_atomic(hw, &desc, NULL, 0,
> +					      cmd_details, true);
>   
>   	return status;
>   }
> @@ -2114,7 +2115,8 @@ enum i40e_status_code i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
>   	cmd->seid = cpu_to_le16(seid);
>   	cmd->vlan_tag = cpu_to_le16(vid | I40E_AQC_SET_VSI_VLAN_VALID);
>   
> -	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
> +	status = i40e_asq_send_command_atomic(hw, &desc, NULL, 0,
> +					      cmd_details, true);
>   
>   	return status;
>   }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> index aaea297640e0..9241b6005ad3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> @@ -22,11 +22,15 @@ void i40e_adminq_init_ring_data(struct i40e_hw *hw);
>   i40e_status i40e_clean_arq_element(struct i40e_hw *hw,
>   					     struct i40e_arq_event_info *e,
>   					     u16 *events_pending);
> -i40e_status i40e_asq_send_command(struct i40e_hw *hw,
> -				struct i40e_aq_desc *desc,
> -				void *buff, /* can be NULL */
> -				u16  buff_size,
> -				struct i40e_asq_cmd_details *cmd_details);
> +i40e_status
> +i40e_asq_send_command(struct i40e_hw *hw, struct i40e_aq_desc *desc,
> +		      void *buff, /* can be NULL */ u16  buff_size,
> +		      struct i40e_asq_cmd_details *cmd_details);
> +i40e_status
> +i40e_asq_send_command_atomic(struct i40e_hw *hw, struct i40e_aq_desc *desc,
> +			     void *buff, /* can be NULL */ u16  buff_size,
> +			     struct i40e_asq_cmd_details *cmd_details,
> +			     bool is_atomic_context);
>   
>   /* debug function for adminq */
>   void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
> 
> base-commit: 12d9cd00f10317ab4e34e150f2137f3061ecaa8f


Kind regards,

Paul
