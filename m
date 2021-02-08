From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 8 Feb 2021 18:42:16 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix VFs not created
In-Reply-To: <20201127112301.32478-1-mateusz.palczewski@intel.com>
References: <20201127112301.32478-1-mateusz.palczewski@intel.com>
Message-ID: <CY4PR11MB15767CD15BCF51F92104E281AB8F9@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: pi?tek, 27 listopada 2020 12:23
> To: intel-wired-lan at lists.osuosl.org
> Cc: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix VFs not created
> 
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> When creating VFs they were sometimes not getting resources.
> It was caused by not executing i40e_reset_all_vfs due to flag
> __I40E_VF_DISABLE being set on PF. Because of this IAVF was never able to
> finish setup sequence never getting reset indication from PF.
> Changed test_and_set_bit __I40E_VF_DISABLE in i40e_sync_filters_subtask
> to test_bit and removed clear_bit.
> This function should not set this bit it should only check if it hasn't been
> already set.
> 
> Fixes: a7542b876075 ("i40e: check __I40E_VF_DISABLE bit in
> i40e_sync_filters_subtask")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 5bee1de..a926331 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2623,7 +2623,7 @@ static void i40e_sync_filters_subtask(struct i40e_pf
> *pf)
>  		return;
>  	if (!test_and_clear_bit(__I40E_MACVLAN_SYNC_PENDING, pf-
> >state))
>  		return;
> -	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state)) {
> +	if (test_bit(__I40E_VF_DISABLE, pf->state)) {
>  		set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  		return;
>  	}
> @@ -2641,7 +2641,6 @@ static void i40e_sync_filters_subtask(struct i40e_pf
> *pf)
>  			}
>  		}
>  	}
> -	clear_bit(__I40E_VF_DISABLE, pf->state);
>  }
> 
>  /**
> --

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
