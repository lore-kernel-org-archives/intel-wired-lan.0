From: Shannon Nelson <sln@onemain.com>
Date: Mon, 25 Jul 2016 16:51:03 -0700
Subject: [Intel-wired-lan] [next PATCH S40 06/13] i40e: Fix static
 analysis tool warning
In-Reply-To: <1469488555-28187-7-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
 <1469488555-28187-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <38f68e13-aff7-d2b1-4f19-4c841b4f1752@onemain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 07/25/2016 04:15 PM, Bimmy Pujari wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
>
> This patch fixes a problem where a static analysis tool generates a warning
> for "INVARIANT_CONDITION: Expression 'enabled_tc' used in the condition
> always yields the same result."
>
> Without this patch, the driver will not pass the static analysis tool checks
> without generating warnings.

That checker is obviously seeing that i40e_get_iscsi_tc_map() is 
defaulting the map to 0x1 which I believe wasn't the case when this was 
first written.  If that is ever changed it could now cause a bug here.  
You might default enabled_tc here in i40e_pf_get_num_tc() just to be 
sure there's no problem in the future.

sln

>
> This patch fixes the problem by eliminating the irrelevant check and redundant
> assignment for the value of enabled_tc.
>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Change-ID: Ia7d44cb050f507df7de333e96369d322e08bf408
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index b6f9b11..c130149 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4608,8 +4608,6 @@ static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)
>   	else
>   		return 1; /* Only TC0 */
>   
> -	/* At least have TC0 */
> -	enabled_tc = (enabled_tc ? enabled_tc : 0x1);
>   	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
>   		if (enabled_tc & BIT(i))
>   			num_tc++;

