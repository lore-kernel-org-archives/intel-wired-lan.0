From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 30 Oct 2017 22:44:14 +0000
Subject: [Intel-wired-lan] [next PATCH S81-V3 8/9] i40e: Fix for NUP NVM
 image downgrade failure
In-Reply-To: <20171027150656.68250-8-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
 <20171027150656.68250-8-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882AD6C58@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

> -----Original Message-----
> From: Michael, Alice
> Sent: Friday, October 27, 2017 8:07 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S81-V3 8/9] i40e: Fix for NUP NVM image downgrade
> failure
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since commit 96a39aed25e6 ("i40e: Acquire NVM lock before
> reads on all devices") we've used the NVM lock
> to synchronize NVM reads even on devices which don't strictly
> need the lock.
> 
> Doing so can cause a regression on older firmware prior to 1.5,
> especially when downgrading the firmware.
> 
> Fix this by only grabbing the lock if we're running on an X722
> device (which requires the lock as it uses the AdminQ to read
> the NVM), or if we're currently running 1.5 or newer firmware.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 6 ++++++
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 8 +++++---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
>  4 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> index 9dcb2a9..9af7425 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> @@ -613,6 +613,12 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
>  		hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
>  	}
> 
> +	/* Newer versions of firmware require lock when reading the NVM */
> +	if (hw->aq.api_maj_ver > 1 ||
> +	    (hw->aq.api_maj_ver == 1 &&
> +	     hw->aq.api_min_ver >= 5))
> +		hw->flags |= I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
> +
>  	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
>  	if (hw->aq.api_maj_ver > 1 ||
>  	    (hw->aq.api_maj_ver == 1 &&
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c
> b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 0203665..13c7946 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -948,7 +948,8 @@ i40e_status i40e_init_shared_code(struct i40e_hw *hw)
>  		hw->pf_id = (u8)(func_rid & 0x7);
> 
>  	if (hw->mac.type == I40E_MAC_X722)
> -		hw->flags |= I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE;
> +		hw->flags |= I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE |
> +			     I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
> 
>  	status = i40e_init_nvm(hw);
>  	return status;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> index 0ccab0a..7689c2e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> @@ -328,15 +328,17 @@ static i40e_status __i40e_read_nvm_word(struct
> i40e_hw *hw,
>  i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
>  			       u16 *data)
>  {
> -	i40e_status ret_code;
> +	i40e_status ret_code = 0;
> 
> -	ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
> +	if (hw->flags & I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK)
> +		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
>  	if (ret_code)
>  		return ret_code;
> 
>  	ret_code = __i40e_read_nvm_word(hw, offset, data);
> 
> -	i40e_release_nvm(hw);
> +	if (hw->flags & I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK)
> +		i40e_release_nvm(hw);
> 
>  	return ret_code;
>  }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h
> b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index 00d4833..0e85687 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -629,6 +629,7 @@ struct i40e_hw {
>  #define I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE BIT_ULL(0)
>  #define I40E_HW_FLAG_802_1AD_CAPABLE        BIT_ULL(1)
>  #define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
> +#define I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK BIT_ULL(3)
>  	u64 flags;
> 
>  	/* Used in set switch config AQ command */
> --
> 2.9.5

