From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:59:31 +0000
Subject: [Intel-wired-lan] [PATCH S51 04/13] ice: remove page_reuse
 statistic
In-Reply-To: <20200730001922.52568-4-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-4-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145BB5401A7E9715E8CD6988C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 04/13] ice: remove page_reuse statistic
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The page reuse statistic wasn't even being displayed to the user, even
> though the driver counted it. Don't waste the struct space and hot-path
> cycles since the driver doesn't display it.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 --
> drivers/net/ethernet/intel/ice/ice_txrx.h | 1 -
>  2 files changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


