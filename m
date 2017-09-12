From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 21:33:17 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 05/11] i40e: reduce
 lrxqthresh	from 2 to 1
In-Reply-To: <20170907120556.45699-5-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0DA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S80-V3 05/11] i40e: reduce lrxqthresh
> from 2 to 1
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The lrxq thresh value tells hardware to immediately interrupt when there are
> fewer than N*64 packets left in the ring.
> 
> Counter intuitively, empirical testing has shown that decreasing this value
> from 2 to 1, and thus changing from an immediate interrupt at fewer than
> 128 descriptors down to 64 descriptors causes a small increase in the
> maximum total packets per second we can receive. This increase occurs even
> when we're polling with interrupts masked, as the hardware must still handle
> interrupts internally even if we've disabled them in software.
> 
> Also reduce the value for any VFs we allocate.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


