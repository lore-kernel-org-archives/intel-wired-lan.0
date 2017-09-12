From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 20:23:50 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 02/11] i40evf: fix mac
 filter	removal timing issue
In-Reply-To: <20170907120556.45699-2-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0A1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, September 7, 2017 5:06 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S80-V3 02/11] i40evf: fix mac filter
> removal timing issue
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Due to the asynchronous nature in which mac filters are added and deleted,
> there exists a bug in which filters are erroneously removed if removed then
> added again quickly.
> 
> The events are as such:
>     - filter marked for removal
>     - same filter is re-added before watchdog that cleans up filters
>     - we skip re-adding the filter because we have it already in the list
>     - watchdog filter cleanup kicks off and filter is removed
> 
> So when we were re-adding the same filter, it didn't actually get added
> because it already existed in the list, but was marked for removal and had yet
> to actually be removed.
> 
> This patch fixes the issue by making sure that when adding a filter, if we find
> it already existing in our list, make sure it is not marked to be removed.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


