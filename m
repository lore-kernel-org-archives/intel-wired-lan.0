From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 5 Nov 2021 09:10:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 3/4] ice: tighter control
 over VSI_DOWN state
In-Reply-To: <20211026000826.156803-4-jesse.brandeburg@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
 <20211026000826.156803-4-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB336780DE37BE831D29E75D23FC8E9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
> Brandeburg
> Sent: Tuesday, October 26, 2021 5:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v1 3/4] ice: tighter control over
> VSI_DOWN state
> 
> The driver had comments to the effect of: This flag should be set before calling
> this function. While reviewing code it was found that there were several
> violations of this policy, which could introduce hard to find bugs or races.
> 
> Fix the violations of the "VSI DOWN state must be set before calling ice_down"
> and make checking the state into code with a WARN_ON.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> Testing Hints (Required if no HSD): legacy-rx private flag disable/enable forgot
> to set this previously and is a way to trigger the down/up path.
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 ++++--
>  drivers/net/ethernet/intel/ice/ice_main.c    | 7 ++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
