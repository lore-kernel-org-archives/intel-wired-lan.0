From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 15 Dec 2020 13:48:51 +0100
Subject: [Intel-wired-lan] [PATCH v5 2/4] e1000e: bump up timeout to
 wait when ME un-configures ULP mode
In-Reply-To: <20201214192935.895174-3-mario.limonciello@dell.com>
References: <20201214192935.895174-1-mario.limonciello@dell.com>
 <20201214192935.895174-3-mario.limonciello@dell.com>
Message-ID: <0a037084-d2ec-a92c-7ba4-c270072a9ad7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

On 12/14/20 8:29 PM, Mario Limonciello wrote:
> Per guidance from Intel ethernet architecture team, it may take
> up to 1 second for unconfiguring ULP mode.
> 
> However in practice this seems to be taking up to 2 seconds on
> some Lenovo machines.  Detect scenarios that take more than 1 second
> but less than 2.5 seconds and emit a warning on resume for those
> scenarios.
> 
> Suggested-by: Aaron Ma <aaron.ma@canonical.com>
> Suggested-by: Sasha Netfin <sasha.neftin@intel.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> CC: Mark Pearson <markpearson@lenovo.com>
> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
> BugLink: https://bugs.launchpad.net/bugs/1865570
> Link: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200323191639.48826-1-aaron.ma at canonical.com/
> Link: https://lkml.org/lkml/2020/12/13/15
> Link: https://lkml.org/lkml/2020/12/14/708
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 9aa6fad8ed47..fdf23d20c954 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1240,6 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>  		return 0;
>  
>  	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
> +		struct e1000_adapter *adapter = hw->adapter;
> +		bool firmware_bug = false;
> +
>  		if (force) {
>  			/* Request ME un-configure ULP mode in the PHY */
>  			mac_reg = er32(H2ME);
> @@ -1248,16 +1251,23 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>  			ew32(H2ME, mac_reg);
>  		}
>  
> -		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
> +		/* Poll up to 2.5 seconds for ME to clear ULP_CFG_DONE.
> +		 * If this takes more than 1 second, show a warning indicating a firmware
> +		 * bug */
>  		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
> -			if (i++ == 30) {
> +			if (i++ == 250) {
>  				ret_val = -E1000_ERR_PHY;
>  				goto out;
>  			}
> +			if (i > 100 && !firmware_bug)
> +				firmware_bug = true;
>  
>  			usleep_range(10000, 11000);
>  		}
> -		e_dbg("ULP_CONFIG_DONE cleared after %dmsec\n", i * 10);
> +		if (firmware_bug)
> +			e_warn("ULP_CONFIG_DONE took %dmsec.  This is a firmware bug\n", i * 10);
> +		else
> +			e_dbg("ULP_CONFIG_DONE cleared after %dmsec\n", i * 10);
>  
>  		if (force) {
>  			mac_reg = er32(H2ME);
> 

