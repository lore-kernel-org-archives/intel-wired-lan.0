From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:14:33 +0000
Subject: [Intel-wired-lan] [PATCH S25 11/12] ice: Remove
 ice_dev_onetime_setup()
In-Reply-To: <20190725095401.24590-11-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-11-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EAFE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 11/12] ice: Remove
> ice_dev_onetime_setup()
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> ice_dev_onetime_setup contains driver workarounds needed for firmware
> limitations. These issues have now been resolved in newer NVMs so remove
> the function.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 16 ----------------
> drivers/net/ethernet/intel/ice/ice_common.h |  2 --
>  drivers/net/ethernet/intel/ice/ice_lib.c    |  1 -
>  3 files changed, 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


