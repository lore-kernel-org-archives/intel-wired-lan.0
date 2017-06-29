From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Jun 2017 20:47:20 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 08/10] i40e/i40evf:
 organize	and re-number feature flags
In-Reply-To: <20170623082451.32671-8-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC1C9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S74-V2 08/10] i40e/i40evf: organize
> and re-number feature flags
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Now that we've reduced the number of flags, organize similar flags together
> and re-number them accordingly.
> 
> Also ensure that the flags variable is actually a u64 to guarantee 64bits of
> space on all architectures.
> 
> One alternative approach considered, but not implemented here, was to use
> an enumeration for the flag variables, and create a macro
> I40E_FLAG() which used string concatenation to generate BIT_ULL values.
> This has the advantage of making the actual bit values compile-time dynamic
> so that we do not need to worry about matching the order to the bit value.
> However, this does produce a high level of code churn, and makes it more
> difficult to read a dumped flags value when debugging.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> Change-ID: I8653fff69453cd547d6fe98d29dfa9d8710387d1
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h     | 57 +++++++++++++++-------------
> --
>  drivers/net/ethernet/intel/i40evf/i40evf.h | 30 ++++++++--------
>  2 files changed, 44 insertions(+), 43 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


