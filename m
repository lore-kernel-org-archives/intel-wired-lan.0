From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 22 Dec 2021 15:44:07 +0100
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Increase delay to 1 s
 after global EMP reset
In-Reply-To: <20211028135114.202530-1-jedrzej.jagielski@intel.com>
References: <20211028135114.202530-1-jedrzej.jagielski@intel.com>
Message-ID: <34349ed6-84b3-bba9-244f-fb190069e84c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jedrzej,


Am 28.10.21 um 15:51 schrieb Jedrzej Jagielski:
> Recently simplified i40e_rebuild causes that FW sometimes
> is not ready after NVM update, the ping does not return.

What commit is that exactly, simplifying `i40e_rebuild()`?

> Increase the delay in case of EMP reset.
> Old delay of 300 ms was introduced for specific cards for 710 series.
> Now it works for all the cards and delay was increased.

Please give one example of a card with firmware, that has problems with 
300 ms, and needs a higher delay.

> Fixes: 1fa51a650e1d ("i40e: Add delay after EMP reset for firmware to recover")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> ---
> V2: Fix commit msg
> ---
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 85b076123663..1cec920bff28 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -10492,15 +10492,9 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>   	}
>   	i40e_get_oem_version(&pf->hw);
>   
> -	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
> -	    ((hw->aq.fw_maj_ver == 4 && hw->aq.fw_min_ver <= 33) ||
> -	     hw->aq.fw_maj_ver < 4) && hw->mac.type == I40E_MAC_XL710) {
> -		/* The following delay is necessary for 4.33 firmware and older
> -		 * to recover after EMP reset. 200 ms should suffice but we
> -		 * put here 300 ms to be sure that FW is ready to operate
> -		 * after reset.
> -		 */
> -		mdelay(300);
> +	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state)) {
> +		/* The following delay is necessary for firmware update. */
> +		mdelay(1000);
>   	}

Increasing the delay by 700 ms or even 1 s for the currently working 
cards, is not ok, in my opinion a regression. I guess an allow list 
needs to be added, with the cards currently working fine with a delay of 
300 ms, or can something be polled to not need a hard delay at all?

>   
>   	/* re-verify the eeprom if we just had an EMP reset */


Kind regards,

Paul
