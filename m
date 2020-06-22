From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Mon, 22 Jun 2020 20:23:05 +0000
Subject: [Intel-wired-lan] [PATCH][next] ice: Use struct_size() helper
In-Reply-To: <20200619175611.GA27719@embeddedor>
References: <20200619175611.GA27719@embeddedor>
Message-ID: <BYAPR11MB27429F471B0D17894F6900E4B5970@BYAPR11MB2742.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Gustavo A. R. Silva
> Sent: Friday, June 19, 2020 10:56 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] ice: Use struct_size() helper
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This is already fixed in an in-process patch-set that converts one-element arrays to flexible-arrays
that Jeff Kirsher has mentioned before and should be pushed shortly.

> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> index 4420fc02f7e7..d92c4d70dbcd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> @@ -1121,8 +1121,7 @@ static enum ice_status ice_get_pkg_info(struct
> ice_hw *hw)
>  	u16 size;
>  	u32 i;
> 
> -	size = sizeof(*pkg_info) + (sizeof(pkg_info->pkg_info[0]) *
> -				    (ICE_PKG_CNT - 1));
> +	size = struct_size(pkg_info, pkg_info, ICE_PKG_CNT - 1);
>  	pkg_info = kzalloc(size, GFP_KERNEL);
>  	if (!pkg_info)
>  		return ICE_ERR_NO_MEMORY;
> --
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
