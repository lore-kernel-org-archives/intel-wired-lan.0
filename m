From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Apr 2017 16:04:30 +0000
Subject: [Intel-wired-lan] [next PATCH S71 02/10] i40e: Reprogram
	port	offloads after reset
In-Reply-To: <20170419132559.20459-2-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA11FE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 02/10] i40e: Reprogram port
> offloads after reset
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch corrects a major oversight in that we were not reprogramming the
> ports after a reset.  As a result we completely lost all of the Rx tunnel
> offloads on receive including Rx checksum, RSS on inner headers, and ATR.
> 
> The fix for this is pretty standard as all we needed to do is reset the filter bits
> to pending for all active filters and schedule the sync event.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


