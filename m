From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:10:30 +0000
Subject: [Intel-wired-lan] [next PATCH S57 04/11] i40evf: free rings
	in	remove function
In-Reply-To: <1481586257-28872-5-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA499A4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, December 12, 2016 3:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S57 04/11] i40evf: free rings in remove
> function
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When the i40evf_remove() calls netdev close, the device doesn't actually
> close - it schedules the work for the watchdog to perform. Since we're
> stopping the watchdog, this work doesn't get done. However, we're
> resetting the part, so we can free resources after the reset request has gone
> through. This plugs a memory leak.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Id5335dcaf76ce00d2a4c3d26e9faf711d7f051cf
> ---
> Testing Hints : Load/unload test
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


