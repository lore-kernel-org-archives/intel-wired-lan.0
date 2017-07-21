From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 18:00:23 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 02/10] i40evf: lower
 message	level
In-Reply-To: <20170714132709.52657-2-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB26F6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Williams, Mitch A <mitch.a.williams@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S77-V3 02/10] i40evf: lower message
> level
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> We see this message regularly on VF reset or unload (which invokes a reset).
> It's essentially meaningless unless it's happening constantly.
> To prevent consternation, lower the log level to debug so it's not seen under
> normal circumstance.
> 
> Testing Hints (required if no HSD): Load and unload VF driver, observe dmesg
> in VM.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


