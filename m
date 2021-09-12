From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Sun, 12 Sep 2021 15:41:49 -0500
Subject: [Intel-wired-lan] [PATCH] ice: Prefer kcalloc over open coded
 arithmetic
In-Reply-To: <20210905065020.8402-1-len.baker@gmx.com>
References: <20210905065020.8402-1-len.baker@gmx.com>
Message-ID: <8cd5adaf-6f83-d3df-abd2-b668d29b50a1@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 9/5/21 01:50, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> In this case this is not actually dynamic sizes: both sides of the
> multiplication are constant values. However it is best to refactor this
> anyway, just to keep the open-coded math idiom out of code.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

BTW... Len, feel free to CC me on all your patches related to KSPP work. :)

Thanks
--
Gustavo

> ---
>  drivers/net/ethernet/intel/ice/ice_arfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
> index 88d98c9e5f91..3071b8e79499 100644
> --- a/drivers/net/ethernet/intel/ice/ice_arfs.c
> +++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
> @@ -513,7 +513,7 @@ void ice_init_arfs(struct ice_vsi *vsi)
>  	if (!vsi || vsi->type != ICE_VSI_PF)
>  		return;
> 
> -	arfs_fltr_list = kzalloc(sizeof(*arfs_fltr_list) * ICE_MAX_ARFS_LIST,
> +	arfs_fltr_list = kcalloc(ICE_MAX_ARFS_LIST, sizeof(*arfs_fltr_list),
>  				 GFP_KERNEL);
>  	if (!arfs_fltr_list)
>  		return;
> --
> 2.25.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
