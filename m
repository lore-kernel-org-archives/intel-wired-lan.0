From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 21:14:47 +0000
Subject: [Intel-wired-lan] [next PATCH S89 3/8] i40e: move AUTO_DISABLED
 flags into the state field
In-Reply-To: <20180316082637.49915-3-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
 <20180316082637.49915-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CC96@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S89 3/8] i40e: move AUTO_DISABLED
> flags into the state field
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The two Flow Directory auto disable flags are used at run time to mark when
> the flow director features needed to be disabled. Thus the flags could
> change even when the RTNL lock is not held.
> 
> They also have some code constructions which really should be test_and_set
> or test_and_clear using atomic bit operations.
> 
> Create new state fields to mark this, and stop including them in
> pf->flags.
> 
> This is part of a larger effort to remove the need for cmpxchg64 in
> i40e_set_priv_flags().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  5 +++--
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 23 +++++++++--------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 21 +++++++++++++--------
>  4 files changed, 27 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


