From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 4 May 2022 13:24:30 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Change type of the
 'igc_check_downshift' method
In-Reply-To: <20220423165502.838143-1-sasha.neftin@intel.com>
References: <20220423165502.838143-1-sasha.neftin@intel.com>
Message-ID: <55100897-ce8d-27b3-30ae-d959b2f0bda6@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Thank you for the patch.

Am 23.04.22 um 18:55 schrieb Sasha Neftin:
> The 'igc_check_downshift' method always return 0 value. There is no point

return*s*

> return value. Change the return type of this method to void.

Maybe also make the summary more explicit. Maybe:

Change return type of 'igc_check_downshift' to void

> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_phy.c | 6 +-----
>   drivers/net/ethernet/intel/igc/igc_phy.h | 2 +-
>   2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index 2140ad1e8443..53b77c969c85 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -141,18 +141,14 @@ void igc_power_down_phy_copper(struct igc_hw *hw)
>    * igc_check_downshift - Checks whether a downshift in speed occurred
>    * @hw: pointer to the HW structure
>    *
> - * Success returns 0, Failure returns 1
> - *
>    * A downshift is detected by querying the PHY link health.
>    */
> -s32 igc_check_downshift(struct igc_hw *hw)
> +void igc_check_downshift(struct igc_hw *hw)
>   {
>   	struct igc_phy_info *phy = &hw->phy;
>   
>   	/* speed downshift not supported */
>   	phy->speed_downgraded = false;
> -
> -	return 0;
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.h b/drivers/net/ethernet/intel/igc/igc_phy.h
> index 1b031372d206..832a7e359f18 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.h
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.h
> @@ -11,7 +11,7 @@ s32 igc_phy_hw_reset(struct igc_hw *hw);
>   s32 igc_get_phy_id(struct igc_hw *hw);
>   s32 igc_phy_has_link(struct igc_hw *hw, u32 iterations,
>   		     u32 usec_interval, bool *success);
> -s32 igc_check_downshift(struct igc_hw *hw);
> +void igc_check_downshift(struct igc_hw *hw);
>   s32 igc_setup_copper_link(struct igc_hw *hw);
>   void igc_power_up_phy_copper(struct igc_hw *hw);
>   void igc_power_down_phy_copper(struct igc_hw *hw);

The rest looks good.


Kind regards,

Paul
