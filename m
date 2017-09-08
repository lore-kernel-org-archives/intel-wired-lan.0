From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Sep 2017 23:09:46 +0000
Subject: [Intel-wired-lan] [PATCH v4] i40e/i40evf: organize and
 re-number	feature flags
In-Reply-To: <20170907221912.1804-1-jacob.e.keller@intel.com>
References: <20170907221912.1804-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9CD7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Thursday, September 7, 2017 3:19 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v4] i40e/i40evf: organize and re-number
> feature flags
> 
> Now that we've reduced the number of flags, organize similar flags together
> and re-number them accordingly.
> 
> Since we don't yet have more than 32 flags, we'll use a u32 for both the
> hw_features and flag field. Should we gain more flags in the future, we may
> need to convert to a u64 or separate flags out into two fields.
> 
> One alternative approach considered, but not implemented here, was to use
> an enumeration for the flag variables, and create a macro
> I40E_FLAG() which used string concatenation to generate BIT_ULL values.
> This has the advantage of making the actual bit values compile-time dynamic
> so that we do not need to worry about matching the order to the bit value.
> However, this does produce a high level of code churn, and makes it more
> difficult to read a dumped flags value when debugging.
> 
> v3: rebased patch based on the current dev-queue branch
> 
> v4: fix bug with cmpxchg
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I8653fff69453cd547d6fe98d29dfa9d8710387d1
> ---
> 
> V2 of the patch was supposed to fix the issue with flags unnecessarily being
> u64, but the patch contents did not get converted properly. Fix this up to use
> a u32, which also resolves the issue of cmpxchg.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         | 100 ++++++++++++-------------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   6 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h     |  32 ++++----
>  3 files changed, 69 insertions(+), 69 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



