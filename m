From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:19:37 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 2/9] i40evf: Clean-up
 flags for promisc mode to avoid high polling rate
In-Reply-To: <20171114120052.86665-2-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
 <20171114120052.86665-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEEA2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S82-V4 2/9] i40evf: Clean-up flags for
> promisc mode to avoid high polling rate
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> If you enabled and disabled promiscuous mode on a VF you could easily put it
> into a state where it would start firing interrupts on all queues at a rate of 50+
> interrupts per second even though there was no traffic present.
> The issue seems to have been a stray admin queue feature flag set that was
> leaving us in a high polling rate for the adminq task.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


