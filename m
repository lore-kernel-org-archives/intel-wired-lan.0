From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Mar 2017 16:46:33 +0000
Subject: [Intel-wired-lan] [next PATCH S63 6/6] i40e/i40evf: Change the
 way	we limit the maximum frame size for Rx
In-Reply-To: <1489511727-10959-6-git-send-email-bimmy.pujari@intel.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
 <1489511727-10959-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10406861@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, March 14, 2017 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S63 6/6] i40e/i40evf: Change the way
> we limit the maximum frame size for Rx
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch changes the way we handle the maximum frame size for the Rx
> path.  Previously we were rounding up to 2K for a 1500 MTU and then brining
> the max frame size down to MTU plus a fixed amount.  With this patch
> applied what we now do is limit the maximum frame to 1.5K minus the value
> for NET_IP_ALIGN for standard MTU, and for any MTU greater than 1500 we
> allow up to the maximum frame size.  This makes the behavior more
> consistent with the other drivers such as igb which had similar logic.  In
> addition it reduces the test matrix for MTU since we only have two max
> frame sizes that are handled for Rx now.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I23a9d3c857e7df04b0ef28c64df63e659c013f3f
> ---
> Testing Hints:
>         Verify MTU handling for MTU = 1500.  You should be able to receive
>         frames up to 1536 in size on a standard x86 system as NET_IP_ALIGN
>         is 0.
> 
>         When jumbo frames are enabled you should be able to receive anything
>         up to the maximum size supported by hardware which is 9.5K or 9726B
>         in size.
> 
>         When the "legacy-rx" private flag is set you should be able to
>         receive anything up to 9.5K in size.
> 
>         The behavior for MTU mismatches will change.  A failing case is any
>         in which we trigger a kernel panic.  Receiving a frame larger than
>         what was configured for the MTU is not a failure.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 26 ++++++++++++---------
> -
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  4 +---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  4 +---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  4 ----
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 16 ++++++++++++-
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 14 ++++++++----
>  6 files changed, 41 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
