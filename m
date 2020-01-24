From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:08 +0000
Subject: [Intel-wired-lan] [PATCH S37 05/15] ice: Remove
 ice_dev_onetime_setup()
In-Reply-To: <20200122152041.41498-5-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-5-anthony.l.nguyen@intel.com>
Message-ID: <d94fe307cd6a40a3b95630b076a2391f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 05/15] ice: Remove
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


