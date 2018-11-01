From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 1 Nov 2018 19:24:35 +0000
Subject: [Intel-wired-lan] [PATCH net-next] igc: Remove set but not used
 variables 'ctrl_ext, link_mode'
In-Reply-To: <1539952830-187358-1-git-send-email-yuehaibing@huawei.com>
References: <1539952830-187358-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96598671@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of YueHaibing
> Sent: Friday, October 19, 2018 5:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Neftin, Sasha
> <sasha.neftin@intel.com>
> Cc: YueHaibing <yuehaibing@huawei.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; kernel-janitors at vger.kernel.org
> Subject: [PATCH net-next] igc: Remove set but not used variables 'ctrl_ext,
> link_mode'
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/intel/igc/igc_base.c: In function
> 'igc_init_phy_params_base':
> drivers/net/ethernet/intel/igc/igc_base.c:240:6: warning:
>  variable 'ctrl_ext' set but not used [-Wunused-but-set-variable]
>   u32 ctrl_ext;
> 
> drivers/net/ethernet/intel/igc/igc_base.c: In function
> 'igc_get_invariants_base':
> drivers/net/ethernet/intel/igc/igc_base.c:290:6: warning:
>  variable 'link_mode' set but not used [-Wunused-but-set-variable]
>   u32 link_mode = 0;
> 
> It never used since introduction in
> commit c0071c7aa5fe ("igc: Add HW initialization code")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> I'm not sure that reading IGC_CTRL_EXT is necessary.
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

