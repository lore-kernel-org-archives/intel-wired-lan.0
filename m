From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 13 Nov 2020 22:01:03 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix check for PF state
 (vf disable)
In-Reply-To: <20201113101411.25092-1-mateusz.palczewski@intel.com>
References: <20201113101411.25092-1-mateusz.palczewski@intel.com>
Message-ID: <ccb2f9563068920c9072d1942febceb6b00639e5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2020-11-13 at 10:14 +0000, Mateusz Palczewski wrote:
> When PF state bit for __I40e_VF_DISABLE is set,
> it doesn't mean necessary that the VF called in
> i40e_reset_vf is disabled. It is rather impossible to
> call a reset on a disabled VF, so return false and
> repeat the request after a while.

False is already being returned. This patch is only adding a comment.

> Fixes: 8d38e0c("i40e: Fix removing driver while bare-metal VFs pass
> traffic")

The fixes tags should have 12 chars.

> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/301695

This Reviewed-on shouldn't be here.

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Tested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 8951740..d30a57f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -1423,6 +1423,8 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool
> flr)
>  
>  	/* If the VFs have been disabled, this means something else is
>  	 * resetting the VF, so we shouldn't continue.
> +	 * This is a global state of a PF, so it is possible that
> +	 * a different VF is in reset.
>  	 */
>  	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state))
>  		return false;
