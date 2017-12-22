From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 16:45:13 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 5/9] i40e: Fix for
 blinking activity instead of link LEDs
In-Reply-To: <20171218101703.75823-1-alice.michael@intel.com>
References: <20171218101703.75823-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CAB31@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, December 18, 2017 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Kuchta, Michal <michal.kuchta@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S83-V5 5/9] i40e: Fix for blinking
> activity instead of link LEDs
> 
> From: Michal Kuchta <michal.kuchta@intel.com>
> 
> This fix solves an issue occurring while calling i40e_led_set function from the
> driver with "blink" parameter set as TRUE. This call resulted in Activity LED
> blinking instead of Link LED, which may lead to errors in physically identyfying
> the port, since Activity LED may be blinking for different reasons aswell.
> 
> Signed-off-by: Michal Kuchta <michal.kuchta@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


