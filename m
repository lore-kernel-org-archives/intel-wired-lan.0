From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:26:50 +0000
Subject: [Intel-wired-lan] [PATCH S27 15/15] ice: change work limit to a
 constant
In-Reply-To: <20190808143938.4968-15-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-15-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4116CA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 15/15] ice: change work limit to a
> constant
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver has supported a transmit work limit that was configurable from
> ethtool for a long time, but there are no good use cases for having it be a
> variable that can be changed at run time.  In addition, this variable was noted
> to be causing performance overhead due to cache misses.
> 
> Just remove the variable and let the code use a constant so that the
> functionality is maintained (a limit on the number of transmits that will be
> cleaned in any one call to the clean routines) without the cache miss.
> 
> Removes code, removes a variable, removes testing surface. Yay.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  3 ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 ++------------
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  2 +-
>  3 files changed, 3 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


