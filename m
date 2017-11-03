From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 3 Nov 2017 13:10:32 -0700
Subject: [Intel-wired-lan] [next PATCH S82 6/9] i40e: Fix FLR reset
 timeout issue
In-Reply-To: <20171103110511.76793-6-alice.michael@intel.com>
References: <20171103110511.76793-1-alice.michael@intel.com>
 <20171103110511.76793-6-alice.michael@intel.com>
Message-ID: <6ade3453-b09b-49b8-4460-b4bdef4cdeec@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/3/2017 4:05 AM, Alice Michael wrote:
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch allows detection of upcoming core reset in case NIC gets
> stuck while performing FLR reset. The i40e_pf_reset() function returns
> I40E_ERR_NOT_READY when global reset was detected.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_common.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 5abc83c..c5ae565 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -1269,6 +1269,7 @@ i40e_status i40e_pf_reset(struct i40e_hw *hw)
>   	 * we don't need to do the PF Reset
>   	 */
>   	if (!cnt) {
> +		u32 reg2 = 0;
>   		if (hw->revision_id == 0)
>   			cnt = I40E_PF_RESET_WAIT_COUNT_A0;
>   		else
> @@ -1280,6 +1281,12 @@ i40e_status i40e_pf_reset(struct i40e_hw *hw)
>   			reg = rd32(hw, I40E_PFGEN_CTRL);
>   			if (!(reg & I40E_PFGEN_CTRL_PFSWR_MASK))
>   				break;
> +			reg2 = rd32(hw, I40E_GLGEN_RSTAT);
> +			if (reg2 & I40E_GLGEN_RSTAT_DEVSTATE_MASK) {
> +				hw_dbg(hw, "Core reset upcoming.\n");
> +				hw_dbg(hw, "I40E_GLGEN_RSTAT = 0x%x\n", reg2);

And my first thought at seeing this message would be "so what?"  There 
needs to be something that says this request is getting skipped.

sln

> +				return I40E_ERR_NOT_READY;
> +			}
>   			usleep_range(1000, 2000);
>   		}
>   		if (reg & I40E_PFGEN_CTRL_PFSWR_MASK) {
> 
