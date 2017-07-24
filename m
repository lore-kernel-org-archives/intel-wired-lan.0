From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 24 Jul 2017 09:47:49 -0700
Subject: [Intel-wired-lan] [next PATCH S75-V4 04/11] i40e: synchronize
 nvmupdate command and adminq subtask
In-Reply-To: <20170721151801.30794-1-alice.michael@intel.com>
References: <20170721151801.30794-1-alice.michael@intel.com>
Message-ID: <08dfdecf-9a31-4d7b-5067-6d6f2e570604@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/21/2017 8:18 AM, Alice Michael wrote:
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 

[...]

> @@ -773,7 +782,8 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
>   		 */
>   		if (cmd->offset == 0xffff) {
>   			i40e_nvmupd_check_wait_event(hw, hw->nvm_wait_opcode);
> -			return 0;
> +			status = 0;
> +			goto exit;
>   		}
>   
>   		status = I40E_ERR_NOT_READY;
> @@ -788,6 +798,8 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
>   		*perrno = -ESRCH;
>   		break;
>   	}
> +exit:
> +	mutex_unlock(&hw->aq.arq_mutex);
>   	return status;
>   }
>   
> 

Thanks, that's better.
sln

