From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Jan 2018 22:51:18 +0000
Subject: [Intel-wired-lan] [next PATCH S86-V2 5/8] i40e: do not force
 filter failure in overflow promiscuous
In-Reply-To: <20180122170039.14144-5-alice.michael@intel.com>
References: <20180122170039.14144-1-alice.michael@intel.com>
 <20180122170039.14144-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A0FC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, January 22, 2018 9:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86-V2 5/8] i40e: do not force filter
> failure in overflow promiscuous
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Broadcast filters can now cause overflow promiscuous to trigger when adding
> "too many" VLANs to all the ports of a device and the driver needs a way to
> exit overflow promiscuous once triggered.
> 
> Currently the driver looks to see if there are "too many" filters and/or we
> have any failed filters to determine when it is safe to exit overflow
> promiscuous.  If we trigger overflow promiscuous with broadcast filters, any
> new filters added will be "auto-failed" until we exit overflow promiscuous.
> Since the user can't manually remove the failed broadcast filters for VLANs
> (nor should we expect the user to do such), there is no way to exit overflow
> promiscuous without reloading the driver.
> 
> The easiest way to do this is to remove the shortcut to "auto-fail"
> filters in overflow promscuous.  If the user removes the VLANs, the failed
> filters will be removed and since we're no longer "auto-failing"
> new filters, we'll eventually get a good set of filters and exit overflow
> promiscuous.
> 
> This has the side benefit of making filter state more explicit in that if a filter
> says it's failed we know for a fact it failed and not just assuming it will if we're
> in overflow promiscuous.  This is nice because if the user removes some
> filters and then adds some, even if we're in overflow promiscuous, the filter
> might succeed; we were just assuming it won't because the user hasn't
> rectified other existing failed filters.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


