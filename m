From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 20:58:05 +0000
Subject: [Intel-wired-lan] [next PATCH S90 6/8] i40e: avoid overflow in
 i40e_ptp_adjfreq()
In-Reply-To: <20180420084140.8081-6-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
 <20180420084140.8081-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A976988@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, April 20, 2018 1:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S90 6/8] i40e: avoid overflow in
> i40e_ptp_adjfreq()
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When operating at 1GbE, the base incval for the PTP clock is so large that
> multiplying it by numbers close to the max_adj can overflow the u64.
> 
> Rather than attempting to limit the max_adj to a value small enough to avoid
> overflow, instead calculate the incvalue adjustment based on the 40GbE
> incvalue, and then multiply that by the scaling factor for the link speed.
> 
> This sacrifices a small amount of precision in the adjustment but we avoid
> erratic behavior of the clock due to the overflow caused if ppb is very near
> the maximum adjustment.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h     |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 41 ++++++++++++++++++++--
> --------
>  2 files changed, 28 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


