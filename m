From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:25:14 +0000
Subject: [Intel-wired-lan] [next PATCH S70 06/12] i40e: reduce wait time
 for	adminq command completion
In-Reply-To: <20170413084555.6962-6-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BED4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 06/12] i40e: reduce wait time for
> adminq command completion
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When sending an adminq command, we wait for the command to complete
> in a loop. This loop waits for an entire millisecond, when in practice the
> adminq command is processed often much faster.
> 
> Change the loop to use i40e_usec_delay instead, and wait for 50 usecs each
> time instead. This appears to be about the minimum time required, based on
> some manual observation and testing.
> 
> The primary benefit of this change is reducing latency of various operations in
> the PF driver, especially when related to having a large number of VFs
> enabled.
> 
> For example, on Linux, when instantiating 128 VFs, the time to finish the
> operation dropped from about 9 seconds down to under 6 seconds.
> Additionally, the time it takes to finish a PF reset with 128 VFs dropped from
> 5.1 seconds down to 0.7 seconds.
> 
> As the examples above show, a significant portion of the delay is wasted
> waiting for admiqn operations which have already finished.
> 
> This patch shouldn't cause impact to functionality, as we still check and keep
> waiting until the command does get processed. The only expected change is
> an increase in CPU utilization as we now check for completion far more times.
> However, in practice the commands appear to generally be complete within
> the first delay window anyways.
> 
> Previously for NDIS we used i40e_msec_stall since i40e_msec_delay would
> cause the CPU to be yielded. We can now just use i40e_usec_delay instead
> because this function will behave correctly for both NDIS and non-NDIS code.
> Thus, we can simply drop the #ifdef logic entirely.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: If8af8388e100da0a14eaf9e1af3afadf73a958cf
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 4 ++--
> drivers/net/ethernet/intel/i40evf/i40e_adminq.h | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


