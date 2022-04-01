From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 1 Apr 2022 16:13:15 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Fix memory leak in
 ice_get_orom_civd_data()
In-Reply-To: <20220401080051.16846-1-niejianglei2021@163.com>
References: <20220401080051.16846-1-niejianglei2021@163.com>
Message-ID: <275930a5-6f6e-4a93-6ac4-d5f99075d672@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/1/2022 1:00 AM, Jianglei Nie wrote:
> Line 637 allocates a memory chunk for orom_data by vzmalloc(). But

References to lile numbers don't age very well.
suggest you s/Line 637/ice_get_orom_civd_data()/

> when ice_read_flash_module() fails, the allocated memory is not freed,
> which will lead to a memory leak.
> 
> We can fix it by freeing the orom_data when ce_read_flash_module() fails.

s/We can fix/Fix/

actual patch LGTM
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_nvm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
> index 4eb0599714f4..13cdb5ea594d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> @@ -641,6 +641,7 @@ ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
>   	status = ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR, 0,
>   				       orom_data, hw->flash.banks.orom_size);
>   	if (status) {
> +		vfree(orom_data);
>   		ice_debug(hw, ICE_DBG_NVM, "Unable to read Option ROM data\n");
>   		return status;
>   	}

