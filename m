From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:32:54 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 05/15] ice: Remove
 ice_dev_onetime_setup()
In-Reply-To: <20200206092013.23388-5-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-5-anthony.l.nguyen@intel.com>
Message-ID: <d8b1f4d3c9ac45f5af6af52b9fe0de9c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 05/15] ice: Remove
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
>  drivers/net/ethernet/intel/ice/ice_common.c     | 16 ----------------
>  drivers/net/ethernet/intel/ice/ice_common.h     |  2 --
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  1 -
>  drivers/net/ethernet/intel/ice/ice_lib.c        |  1 -
>  4 files changed, 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


