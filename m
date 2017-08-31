From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 31 Aug 2017 19:03:04 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 05/13] i40e: fix
	incorrect	register definition
In-Reply-To: <20170829093242.41026-5-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9501@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Williams, Mitch A <mitch.a.williams@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S79-V2 05/13] i40e: fix incorrect
> register definition
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This register was defined incorrectly. Fix the increment value to 8, and
> replace the iterator with _i to make the definition consistent with other
> statistics registers.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_register.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


