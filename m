From: Nitka, Grzegorz <grzegorz.nitka@intel.com>
Date: Fri, 15 Oct 2021 14:41:05 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix missing error code in
 ice_ena_vfs()
In-Reply-To: <1634292249-63098-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1634292249-63098-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Message-ID: <DM4PR11MB528003D5122D7831F9A5F72A92B99@DM4PR11MB5280.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jiapeng Chong
> Sent: Friday, October 15, 2021 12:04 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; kuba at kernel.org; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH] ice: Fix missing error code in ice_ena_vfs()
> 
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c:1979 ice_ena_vfs()
> warn: missing error code 'ret'.

Seems to be already addressed by Dan Carpenter with this patch:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20211013080012.GB6010 at kili/

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 1c54c839935b ("ice: enable/disable switchdev when managing VFs")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 4d0b643..b2a018c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -1975,8 +1975,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16
> num_vfs)
> 
>  	clear_bit(ICE_VF_DIS, pf->state);
> 
> -	if (ice_eswitch_configure(pf))
> +	if (ice_eswitch_configure(pf)) {
> +		ret = -EINVAL;
>  		goto err_unroll_sriov;
> +	}
> 
>  	return 0;
> 
> --
> 1.8.3.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
