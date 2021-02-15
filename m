From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 15 Feb 2021 08:46:08 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix VFs not created
In-Reply-To: <20201127112301.32478-1-mateusz.palczewski@intel.com>
References: <20201127112301.32478-1-mateusz.palczewski@intel.com>
Message-ID: <7305a403-4163-4af9-5f20-b73d54a98fc8@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[+cc Stefan as author of commit under Fixes:]

Am 27.11.20 um 12:23 schrieb Mateusz Palczewski:
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> When creating VFs they were sometimes not getting resources.
> It was caused by not executing i40e_reset_all_vfs due to
> flag __I40E_VF_DISABLE being set on PF. Because of this
> IAVF was never able to finish setup sequence never
> getting reset indication from PF.
> Changed test_and_set_bit __I40E_VF_DISABLE in
> i40e_sync_filters_subtask to test_bit and removed clear_bit.
> This function should not set this bit it should only check
> if it hasn't been already set.
> 
> Fixes: a7542b876075 ("i40e: check __I40E_VF_DISABLE bit in i40e_sync_filters_subtask")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 5bee1de..a926331 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2623,7 +2623,7 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
>   		return;
>   	if (!test_and_clear_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state))
>   		return;
> -	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state)) {
> +	if (test_bit(__I40E_VF_DISABLE, pf->state)) {
>   		set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>   		return;
>   	}
> @@ -2641,7 +2641,6 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
>   			}
>   		}
>   	}
> -	clear_bit(__I40E_VF_DISABLE, pf->state);
>   }
>   
>   /**
