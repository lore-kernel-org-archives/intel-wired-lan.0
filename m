From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Jun 2017 18:29:44 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 05/13] i40e: Fix potential
 out	of bound array access
In-Reply-To: <20170607094313.32060-5-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA8F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S72-V3 05/13] i40e: Fix potential out
> of bound array access
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> This is a fix for the static code analysis issue where dcbcfg->numapps could
> be greater than size of array (i.e dcbcfg->app[I40E_DCBX_MAX_APPS]).
> The fix makes sure that the array is not accessed past the size of of the array
> (i.e. I40E_DCBX_MAX_APPS).
> 
> Copyright updated to 2017.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


