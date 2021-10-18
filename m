From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 18 Oct 2021 15:44:05 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] ice: compact the file ice_nvm.c
In-Reply-To: <20211018131713.3478-1-yanjun.zhu@linux.dev>
References: <20211018131713.3478-1-yanjun.zhu@linux.dev>
Message-ID: <c1903730-9508-1fef-4232-3a5b62f28d7c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Yanjun,


Am 18.10.21 um 15:17 schrieb yanjun.zhu at linux.dev:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The function ice_aq_nvm_update_empr is not used, so remove it.

Thank you for the patch. Could you please make the commit message 
summary more descriptive? Maybe:

> ice: Remove unused `ice_aq_nvm_update_empr()`

If you find out, what commit removed the usage, that would be also good 
to document, but it?s not that important.


Kind regards,

Paul


> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   drivers/net/ethernet/intel/ice/ice_nvm.c | 16 ----------------
>   drivers/net/ethernet/intel/ice/ice_nvm.h |  1 -
>   2 files changed, 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
> index fee37a5844cf..bad374bd7ab3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> @@ -1106,22 +1106,6 @@ enum ice_status ice_nvm_write_activate(struct ice_hw *hw, u8 cmd_flags)
>   	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>   }
>   
> -/**
> - * ice_aq_nvm_update_empr
> - * @hw: pointer to the HW struct
> - *
> - * Update empr (0x0709). This command allows SW to
> - * request an EMPR to activate new FW.
> - */
> -enum ice_status ice_aq_nvm_update_empr(struct ice_hw *hw)
> -{
> -	struct ice_aq_desc desc;
> -
> -	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_nvm_update_empr);
> -
> -	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
> -}
> -
>   /* ice_nvm_set_pkg_data
>    * @hw: pointer to the HW struct
>    * @del_pkg_data_flag: If is set then the current pkg_data store by FW
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
> index c6f05f43d593..925225905491 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.h
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
> @@ -39,7 +39,6 @@ enum ice_status
>   ice_aq_erase_nvm(struct ice_hw *hw, u16 module_typeid, struct ice_sq_cd *cd);
>   enum ice_status ice_nvm_validate_checksum(struct ice_hw *hw);
>   enum ice_status ice_nvm_write_activate(struct ice_hw *hw, u8 cmd_flags);
> -enum ice_status ice_aq_nvm_update_empr(struct ice_hw *hw);
>   enum ice_status
>   ice_nvm_set_pkg_data(struct ice_hw *hw, bool del_pkg_data_flag, u8 *data,
>   		     u16 length, struct ice_sq_cd *cd);
> 
