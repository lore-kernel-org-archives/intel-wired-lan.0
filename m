From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 7 Jun 2019 20:12:33 +0000
Subject: [Intel-wired-lan] [PATCH][next][V2] ixgbe: fix potential u32
 overflow on shift
In-Reply-To: <20190607181920.23339-1-colin.king@canonical.com>
References: <20190607181920.23339-1-colin.king@canonical.com>
Message-ID: <02874ECE860811409154E81DA85FBB589674F4D9@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Colin King [mailto:colin.king at canonical.com]
> Sent: Friday, June 07, 2019 11:19 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; David S . Miller <davem@davemloft.net>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH][next][V2] ixgbe: fix potential u32 overflow on shift
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The u32 variable rem is being shifted using u32 arithmetic however
> it is being passed to div_u64 that expects the expression to be a u64.
> The 32 bit shift may potentially overflow, so cast rem to a u64 before
> shifting to avoid this.  Also remove comment about overflow.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: cd4583206990 ("ixgbe: implement support for SDP/PPS output on X550
> hardware")
> Fixes: 68d9676fc04e ("ixgbe: fix PTP SDP pin setup on X540 hardware")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: update comment

Thanks Colin!

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Regards,
Jake

> 
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> index 2c4d327fcc2e..0be13a90ff79 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> @@ -205,11 +205,8 @@ static void ixgbe_ptp_setup_sdp_X540(struct
> ixgbe_adapter *adapter)
>  	 */
>  	rem = (NS_PER_SEC - rem);
> 
> -	/* Adjust the clock edge to align with the next full second. This
> -	 * assumes that the cycle counter shift is small enough to avoid
> -	 * overflowing when shifting the remainder.
> -	 */
> -	clock_edge += div_u64((rem << cc->shift), cc->mult);
> +	/* Adjust the clock edge to align with the next full second. */
> +	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
>  	trgttiml = (u32)clock_edge;
>  	trgttimh = (u32)(clock_edge >> 32);
> 
> @@ -291,11 +288,8 @@ static void ixgbe_ptp_setup_sdp_X550(struct
> ixgbe_adapter *adapter)
>  	 */
>  	rem = (NS_PER_SEC - rem);
> 
> -	/* Adjust the clock edge to align with the next full second. This
> -	 * assumes that the cycle counter shift is small enough to avoid
> -	 * overflowing when shifting the remainder.
> -	 */
> -	clock_edge += div_u64((rem << cc->shift), cc->mult);
> +	/* Adjust the clock edge to align with the next full second. */
> +	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
> 
>  	/* X550 hardware stores the time in 32bits of 'billions of cycles' and
>  	 * 32bits of 'cycles'. There's no guarantee that cycles represents
> --
> 2.20.1

