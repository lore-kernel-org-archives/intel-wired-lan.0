From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 21:15:17 +0000
Subject: [Intel-wired-lan] [next PATCH S89 4/8] i40e: move
 I40E_FLAG_TEMP_LINK_POLLING to state field
In-Reply-To: <20180316082637.49915-4-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
 <20180316082637.49915-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CCA6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 16, 2018 1:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S89 4/8] i40e: move
> I40E_FLAG_TEMP_LINK_POLLING to state field
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This flag is modified outside of the RTNL lock and thus should not be part of
> the pf->flags variable.
> 
> Use a state bit instead, so that we can use atomic bit operations.
> 
> This is part of a larger effort to remove cmpxchg64 in
> i40e_set_priv_flags()
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


