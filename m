From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 21:14:15 +0000
Subject: [Intel-wired-lan] [next PATCH S89 2/8] i40e: move
 I40E_FLAG_UDP_FILTER_SYNC to the state field
In-Reply-To: <20180316082637.49915-2-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
 <20180316082637.49915-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CC86@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S89 2/8] i40e: move
> I40E_FLAG_UDP_FILTER_SYNC to the state field
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This flag is modified during run time, possibly even when the RTNL lock is not
> held. Additionally it has a few places which should be using test_and_set or
> test_and_clear atomic bit operations.
> 
> Create a new state bit __I40E_UDP_SYNC_PENDING and use it instead of the
> ole I40E_FLAG_UDP_FILTER_SYNC flag.
> 
> This is part of a larger effort to remove the need for using cmpxchg64 in
> i40e_set_priv_flags.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


