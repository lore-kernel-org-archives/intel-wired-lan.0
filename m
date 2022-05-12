From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 May 2022 10:09:27 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: correct SDP0 check of
 SFP cage for X550
In-Reply-To: <20220425131758.4749-1-jeffd@silicom-usa.com>
References: <20220420205130.23616-1-jeffd@silicom-usa.com>
 <20220425131758.4749-1-jeffd@silicom-usa.com>
Message-ID: <fd59c0e8-7f84-a09a-f673-339919b4a056@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 4/25/2022 6:17 AM, Jeff Daly wrote:
> SDP0 for X550 NICs is active low to indicate the presence of an SFP in the
> cage (MOD_ABS#).  Invert the results of the logical AND to set
> sfp_cage_full variable correctly.

Hi Jeff,

Adding our developer and adding his response here:

"
Our analysis (using 0x15c4) showed that every time the cage is empty SDP 
indicates 0 and when cage is full it indicates 1. No matter what 
transceiver we used, from those we have. The same happens even we don't 
use the device which fall into crosstalk fix e.g 0x15c2.

When proposed patch was applied, the devices are no longer able to 
negotiate speed. So basically this patch should not be accepted.

NACK

BR,
Piotr
"

> Fixes: aac9e053f104 ("ixgbe: cleanup crosstalk fix")
> Suggested-by: Stephen Douthit <stephend@silicom-usa.com>
> Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index 4c26c4b92f07..13482d4e24e2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -3299,17 +3299,17 @@ s32 ixgbe_check_mac_link_generic(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
>   	 * the SFP+ cage is full.
>   	 */
>   	if (ixgbe_need_crosstalk_fix(hw)) {
> -		u32 sfp_cage_full;
> +		bool sfp_cage_full;
>   
>   		switch (hw->mac.type) {
>   		case ixgbe_mac_82599EB:
> -			sfp_cage_full = IXGBE_READ_REG(hw, IXGBE_ESDP) &
> -					IXGBE_ESDP_SDP2;
> +			sfp_cage_full = !!(IXGBE_READ_REG(hw, IXGBE_ESDP) &
> +					   IXGBE_ESDP_SDP2);
>   			break;
>   		case ixgbe_mac_X550EM_x:
>   		case ixgbe_mac_x550em_a:
> -			sfp_cage_full = IXGBE_READ_REG(hw, IXGBE_ESDP) &
> -					IXGBE_ESDP_SDP0;
> +			sfp_cage_full = !(IXGBE_READ_REG(hw, IXGBE_ESDP) &
> +					  IXGBE_ESDP_SDP0);
>   			break;
>   		default:
>   			/* sanity check - No SFP+ devices here */
