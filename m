From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 21:13:46 +0000
Subject: [Intel-wired-lan] [next PATCH S89 1/8] i40e: move
 I40E_FLAG_FILTER_SYNC to a state bit
In-Reply-To: <20180316082637.49915-1-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CC36@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S89 1/8] i40e: move
> I40E_FLAG_FILTER_SYNC to a state bit
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The I40E_FLAG_FILTER_SYNC flag is modified during run time possibly when
> the RTNL lock is not held. Thus, it should not be part of pf->flags, and instead
> should be using atomic bit operations in the pf->state field.
> 
> Create a __I40E_MACVLAN_SYNC_PENDING state bit, and use it instead of
> the old I40E_FLAG_FILTER_SYNC flag.
> 
> This is part of a larger effort to remove the need for cmpxchg64 in
> i40e_set_priv_flags().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++-------
>  2 files changed, 11 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


