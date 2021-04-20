From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 20 Apr 2021 16:52:23 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix of warning message
 during remove iavf driver and fix of call stack during rmmod i40e driver
In-Reply-To: <20210416092251.272749-1-karen.sornek@intel.com>
References: <20210416092251.272749-1-karen.sornek@intel.com>
Message-ID: <e31442d4be7f4ec3da59e69d3e1d1a3fa3f7b96d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-04-16 at 11:22 +0200, Karen Sornek wrote:

The title is a bit long, can reduce it a bit?

> Restored part of reset functionality used when reset is called
> from the VF to reset itself. Without this fix warning message
> is displayed when vf is removing via sysfs.
> 
> Removes the reason of the vf crashing during reset by ensuring
> that the reset message request to pf is performed.
> Refactoring code to use one function instead of two.
> Without this patch, during stress tests, there was a possibility of
> non-execution of reset request correctly which is the cause of vf
> reinitialization errors and consequently in rmmod driver suspended
> the system.
> 
> Fixes: eeeddbb80640("i40e: drop i40e_pf *pf from
> i40e_vc_disable_vf()")

You're missing a space.
Fixes tag: Fixes: eeeddbb80640("i40e: drop i40e_pf *pf from
i40e_vc_disable_vf()")
	Has these problem(s):
		- missing space between the SHA1 and the subject

> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 53 ++++++++---------
> --
>  1 file changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index f6121a0c4..ee2c5aba4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -183,17 +183,20 @@ void i40e_vc_notify_vf_reset(struct i40e_vf
> *vf)
>  /***********************misc routines*****************************/
>  
>  /**
> - * i40e_vc_disable_vf
> + * i40e_vc_reset_vf
>   * @vf: pointer to the VF info
>   *
> - * Disable the VF through a SW reset.
> + * @notify_vf: notify vf about reset or not
> + *
> + * Reset VF handler.
>   **/
> -static inline void i40e_vc_disable_vf(struct i40e_vf *vf)
> +static inline void i40e_vc_reset_vf(struct i40e_vf *vf, bool
> notify_vf)

Please remove the inline. In c files, let the compiler decide what to
do. 
