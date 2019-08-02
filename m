From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 2 Aug 2019 17:07:24 +0000
Subject: [Intel-wired-lan] [PATCH][net-next] ice: fix potential infinite
 loop
In-Reply-To: <20190802155217.16996-1-colin.king@canonical.com>
References: <20190802155217.16996-1-colin.king@canonical.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A18401096DB0DF@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Colin King
> Sent: Friday, August 02, 2019 8:52 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][net-next] ice: fix potential infinite loop
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The loop counter of a for-loop is a u8 however this is being compared
> to an int upper bound and this can lead to an infinite loop if the
> upper bound is greater than 255 since the loop counter will wrap back
> to zero. Fix this potential issue by making the loop counter an int.
> 
> Addresses-Coverity: ("Infinite loop")

Actually, num_alloc_vfs should probably be a u16 instead of an int since num_alloc_vfs cannot exceed 256.

Which Coverity scan reported this and what options are used in the analysis?

> Fixes: c7aeb4d1b9bf ("ice: Disable VFs until reset is completed")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index c26e6a102dac..088543d50095 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -488,7 +488,7 @@ static void
>  ice_prepare_for_reset(struct ice_pf *pf)
>  {
>  	struct ice_hw *hw = &pf->hw;
> -	u8 i;
> +	int i;
> 
>  	/* already prepared for reset */
>  	if (test_bit(__ICE_PREPARED_FOR_RESET, pf->state))
> --
> 2.20.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
