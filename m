From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:58:59 +0000
Subject: [Intel-wired-lan] [PATCH S43 09/15] ice: fix signed vs unsigned
 comparisons
In-Reply-To: <20200516003644.4658-9-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-9-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165930587A3F4BBC4794073F8CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 09/15] ice: fix signed vs unsigned
> comparisons
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Fix the remaining signed vs unsigned issues, which appear when compiling
> with -Werror=sign-compare.
> 
> Many of these are because there is an external interface that is passing an int
> to us (which we can't change) but that we (rightfully) store and compare
> against as an unsigned in our data structures.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 4 ++--
> drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++----
> drivers/net/ethernet/intel/ice/ice_txrx.h | 7 ++++---
>  3 files changed, 10 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


