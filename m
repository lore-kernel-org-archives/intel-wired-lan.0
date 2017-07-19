From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jul 2017 18:57:46 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 01/13] i40e: Fix for
 unused	value issue found by static analysis
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB24A4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 01/13] i40e: Fix for unused
> value issue found by static analysis
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes an issue where an error return value is set, but without an
> immediate exit, the value can be overwritten by the following code
> execution.  The condition  at this point is not fatal, so remove the error
> assignment and comment the intent for future code maintainers
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


