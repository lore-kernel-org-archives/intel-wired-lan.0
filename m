From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 16 Jun 2021 16:27:50 -0700
Subject: [Intel-wired-lan] [PATCH][next] ice: remove redundant continue
 statement in a for-loop
In-Reply-To: <20210615142847.60161-1-colin.king@canonical.com>
References: <20210615142847.60161-1-colin.king@canonical.com>
Message-ID: <2a347503-9879-0a13-555b-a007acfdec3c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 6/15/2021 7:28 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement in the for-loop is redundant. Re-work the hw_lock
> check to remove it.
> 
> Addresses-Coverity: ("Continue has no effect")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Yep, that logic makes more sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 267312fad59a..3eca0e4eab0b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -410,13 +410,11 @@ bool ice_ptp_lock(struct ice_hw *hw)
>  	for (i = 0; i < MAX_TRIES; i++) {
>  		hw_lock = rd32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
>  		hw_lock = hw_lock & PFTSYN_SEM_BUSY_M;
> -		if (hw_lock) {
> -			/* Somebody is holding the lock */
> -			usleep_range(10000, 20000);
> -			continue;
> -		} else {
> +		if (!hw_lock)
>  			break;
> -		}
> +
> +		/* Somebody is holding the lock */
> +		usleep_range(10000, 20000);
>  	}
>  
>  	return !hw_lock;
> 
