From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Mar 2018 22:01:48 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf/i40evf_main: Fix variable
 assignment in i40evf_parse_cls_flower
In-Reply-To: <20180215174435.GA19969@embeddedor.com>
References: <20180215174435.GA19969@embeddedor.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94B3AC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Gustavo A. R. Silva
> Sent: Thursday, February 15, 2018 9:45 AM
> To: Ramamurthy, Harshitha <harshitha.ramamurthy@intel.com>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Gustavo A. R. Silva <garsilva@embeddedor.com>
> Subject: [Intel-wired-lan] [PATCH] i40evf/i40evf_main: Fix variable
> assignment in i40evf_parse_cls_flower
> 
> It seems this is a copy-paste error and that the proper variable to use in this
> particular case is _src_ instead of _dst_.
> 
> Addresses-Coverity-ID: 1465282 ("Copy-paste error")
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


