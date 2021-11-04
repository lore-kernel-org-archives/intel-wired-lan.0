From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Thu, 4 Nov 2021 11:09:53 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix typo in i225 LTR
 functions
In-Reply-To: <20211102072006.2757474-1-sasha.neftin@intel.com>
References: <20211102072006.2757474-1-sasha.neftin@intel.com>
Message-ID: <f63baf1e-6fa6-9a9b-a78f-a84e08adad9b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/2/2021 09:20, Sasha Neftin wrote:
> The LTR maximum value was incorrectly written using the scale from
> the LTR minimum value. This would cause incorrect values to be sent,
> in cases where the initial calculation lead to different min/max scales.
> 
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_i225.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
> index b2ef9fde97b3..b6807e16eea9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_i225.c
> +++ b/drivers/net/ethernet/intel/igc/igc_i225.c
> @@ -636,7 +636,7 @@ s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
>   		ltrv = rd32(IGC_LTRMAXV);
>   		if (ltr_max != (ltrv & IGC_LTRMAXV_LTRV_MASK)) {
>   			ltrv = IGC_LTRMAXV_LSNP_REQ | ltr_max |
> -			       (scale_min << IGC_LTRMAXV_SCALE_SHIFT);
> +			       (scale_max << IGC_LTRMAXV_SCALE_SHIFT);
>   			wr32(IGC_LTRMAXV, ltrv);
>   		}
>   	}
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>
