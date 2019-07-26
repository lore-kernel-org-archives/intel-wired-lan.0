From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:47:48 +0000
Subject: [Intel-wired-lan] [next PATCH S8 08/12] i40e: Remove function
 i40e_update_dcb_config()
In-Reply-To: <20190723100144.57435-8-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CEC9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 23, 2019 3:02 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 08/12] i40e: Remove function
> i40e_update_dcb_config()
> 
> From: Grzegorz Siwik <grzegorz.siwik@intel.com>
> 
> This patch removes function i40e_update_dcb_config(). Instead of
> i40e_update_dcb_config() we use i40e_init_dcb(), which implements the
> correct nvm read.
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 46 +--------------------
>  1 file changed, 1 insertion(+), 45 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


