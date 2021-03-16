From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 16 Mar 2021 01:27:02 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: fix rtnl locking when
 setting up pf switch
In-Reply-To: <20210312112115.14607-1-mateusz.palczewski@intel.com>
References: <20210312112115.14607-1-mateusz.palczewski@intel.com>
Message-ID: <SN6PR11MB3229E92D49C32DD80C5771B8C66B9@SN6PR11MB3229.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Friday, March 12, 2021 3:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: fix rtnl locking when setting up pf
> switch
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> A recent change that made i40e use new udp_tunnel infrastructure uses a
> method that expects to be called under rtnl_lock.
> 
> Not all codepaths however made that lock when calling i40e_setup_pf_switch.
> 
> Fix a stacktrace by adding additional rtnl locking and unlocking.
> 
> Fixes: 40a98cb6f01f ("i40e: convert to new udp_tunnel infrastructure")
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 71f14c4..8c2072c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -31,7 +31,7 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi);
> static void i40e_handle_reset_warning(struct i40e_pf *pf, bool lock_acquired);
> static int i40e_add_vsi(struct i40e_vsi *vsi);  static int i40e_add_veb(struct
> i40e_veb *veb, struct i40e_vsi *vsi); -static int i40e_setup_pf_switch(struct
> i40e_pf *pf, bool reinit);
> +static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool
> +lock_acquired);
>  static int i40e_setup_misc_vector(struct i40e_pf *pf);  static void
> i40e_determine_queue_usage(struct i40e_pf *pf);  static int
> i40e_setup_pf_filter_control(struct i40e_pf *pf); @@ -10576,7 +10576,7 @@
> static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
> 
>  	if (!lock_acquired)
>  		rtnl_lock();
> -	ret = i40e_setup_pf_switch(pf, reinit);
> +	ret = i40e_setup_pf_switch(pf, reinit, true);
>  	if (ret)
>  		goto end_unlock;
> 
> @@ -14659,7 +14659,7 @@ int i40e_fetch_switch_configuration(struct i40e_pf
> *pf, bool printconfig)
>   *
>   * Returns 0 on success, negative value on failure
>   **/
> -static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
> +static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool
> +lock_acquired)

The new parameter needs to be documented:

drivers/net/ethernet/intel/i40e/i40e_main.c:14680: warning: Function parameter or member 'lock_acquired' not described in 'i40e_setup_pf_switch'  
