From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Mar 2018 23:32:26 +0000
Subject: [Intel-wired-lan] [PATCH S88 8/8] i40e: Fix the polling
 mechanism of GLGEN_RSTAT.DEVSTATE
In-Reply-To: <20180314181918.21582-8-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
 <20180314181918.21582-8-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C31D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, March 14, 2018 11:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [PATCH S88 8/8] i40e: Fix the polling mechanism of
> GLGEN_RSTAT.DEVSTATE
> 
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> 
> This fixes the polling mechanism of GLGEN_RSTAT.DEVSTATE in the PF Reset
> path when Global Reset is in progress. While the driver is polling for the end
> of the PF Reset and the Global Reset is triggered, abandon the PF Reset path
> and prepare for the upcoming Global Reset.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 35
> ++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


