From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 1 Oct 2020 09:22:31 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] e1000: remove unused and
 incorrect code
In-Reply-To: <20200918184152.604967-1-jesse.brandeburg@intel.com>
References: <20200918184152.604967-1-jesse.brandeburg@intel.com>
Message-ID: <c270e596-b5db-005b-fa18-cd374981429c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jesse,


Am 18.09.20 um 20:41 schrieb Jesse Brandeburg:
> The e1000_clear_vfta function was triggering a warning in kbuild-bot
> testing. It's actually a bug but has no functional impact.
> 
> drivers/net/ethernet/intel/e1000/e1000_hw.c:4415:58: warning: Same expression in both branches of ternary operator. [duplicateExpressionTernary]
> 
> Fix this warning by removing the offending code and simplifying
> the routine to do exactly what it did before, no functional
> change.

It looks like this fixes commit 1532ecea (e1000: drop dead pcie code 
from e1000) removing support for e1000_82573?

> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> 
> NOTE: I don't recommend this go to stable as there is no functional
> change.
> ---
>   drivers/net/ethernet/intel/e1000/e1000_hw.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> index 2120dacfd55c..c5d702543daa 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> @@ -4403,17 +4403,9 @@ void e1000_write_vfta(struct e1000_hw *hw, u32 offset, u32 value)
>   static void e1000_clear_vfta(struct e1000_hw *hw)

(Why is the diff also mentioning the function before `void 
e1000_write_vfta()`?)

>   {
>   	u32 offset;
> -	u32 vfta_value = 0;
> -	u32 vfta_offset = 0;
> -	u32 vfta_bit_in_reg = 0;
>   
>   	for (offset = 0; offset < E1000_VLAN_FILTER_TBL_SIZE; offset++) {
> -		/* If the offset we want to clear is the same offset of the
> -		 * manageability VLAN ID, then clear all bits except that of the
> -		 * manageability unit
> -		 */
> -		vfta_value = (offset == vfta_offset) ? vfta_bit_in_reg : 0;
> -		E1000_WRITE_REG_ARRAY(hw, VFTA, offset, vfta_value);
> +		E1000_WRITE_REG_ARRAY(hw, VFTA, offset, 0);
>   		E1000_WRITE_FLUSH();
>   	}
>   }

It?d be great if you updated the commit description.


Kind regards,

Paul
