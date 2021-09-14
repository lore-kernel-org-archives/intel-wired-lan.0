From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 14 Sep 2021 16:40:24 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Fix newline at the
 end of NL_SET_ERR_MSG_MOD
In-Reply-To: <20210830141220.5547-1-wojciech.drewek@intel.com>
References: <20210830141220.5547-1-wojciech.drewek@intel.com>
Message-ID: <dc1070b9-a2b0-2932-0150-5cb78ba104f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/30/2021 7:12 AM, Wojciech Drewek wrote:
> Newline character is not needed at the end of NL_SET_ERR_MSG_MOD.
> 
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 34fe725b4a53..e01b16419923 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -670,7 +670,7 @@ static int ice_del_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
>  	err = ice_rem_adv_rule_by_id(&pf->hw, &rule_rem);
>  	if (err) {
>  		if (err == ICE_ERR_DOES_NOT_EXIST) {
> -			NL_SET_ERR_MSG_MOD(fltr->extack, "filter does not exist\n");
> +			NL_SET_ERR_MSG_MOD(fltr->extack, "Filter does not exist");
>  			return -ENOENT;
>  		}
>  		NL_SET_ERR_MSG_MOD(fltr->extack, "Failed to delete TC flower filter");
> 
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
