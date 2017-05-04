From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 4 May 2017 20:31:54 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix pf-flags overwrite bug
 introduced in hw_disabled_flags removal patch.
In-Reply-To: <1493923609-15708-1-git-send-email-sridhar.samudrala@intel.com>
References: <1493923609-15708-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857E20AE3@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Samudrala, Sridhar
> Sent: Thursday, May 04, 2017 11:47 AM
> To: intel-wired-lan at lists.osuosl.org; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH] i40e: Fix pf-flags overwrite bug introduced in hw_disabled_flags
> removal patch.
> 
> Commit 	47994c119a36 (i40e: remove hw_disabled_flags in favor of
> using separate flag bits) causes pf->flags overwrite when setting
> I40E_FLAG_HW_ATR_EVICT_CAPABLE flag.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>


This doesn't match what's out of tree. I will send a patch in a few minutes to match what we do out-of-tree, which resolves this.

Thanks,
Jake

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index e4eb978..c05221c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8822,9 +8822,9 @@ static int i40e_sw_init(struct i40e_pf *pf)
>  		    (pf->hw.aq.api_min_ver > 4))) {
>  		/* Supported in FW API version higher than 1.4 */
>  		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
> -		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
> +		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
>  	} else {
> -		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
> +		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
>  	}
> 
>  	pf->eeprom_version = 0xDEAD;
> --
> 1.8.3.1

