From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 2 Dec 2020 00:22:19 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix check for PF state
 (vf disable)
In-Reply-To: <20201123144517.15180-1-mateusz.palczewski@intel.com>
References: <20201123144517.15180-1-mateusz.palczewski@intel.com>
Message-ID: <7c6c477abb7dd93d02f091797362895e3a86f18c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2020-11-23 at 14:45 +0000, Mateusz Palczewski wrote:
> Adding missing comments to previously applied patch.
> 
> When PF state bit for __I40e_VF_DISABLE is set,
> it doesn't mean necessary that the VF called in
> i40e_reset_vf is disabled. It is rather impossible to
> call a reset on a disabled VF, so return false and
> repeat the request after a while.

The title and description doesn't match the patch. The description
isn't really explaining the comment.

> Fixes: 8d38e0cd5211("i40e: Fix removing driver while bare-metal VFs
> pass traffic")
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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
