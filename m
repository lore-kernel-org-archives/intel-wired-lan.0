From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:14:09 +0000
Subject: [Intel-wired-lan] [next PATCH S10 10/10] i40e: Refactoring VF
 MAC filters counting to make more reliable
In-Reply-To: <20190920091724.51767-10-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-10-alice.michael@intel.com>
Message-ID: <825cb60af58c4aef992832b6a9bd3760@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, September 20, 2019 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 10/10] i40e: Refactoring VF MAC
> filters counting to make more reliable
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This patch prepares ground for the next VF MAC address change fix.
> It lets untrusted VF to delete any VF mac filter, but it still doesn't let
> untrusted VF to add mac filter not setup by PF.
> It removes information duplication in num_mac mac filters counter.
> And improves exact h/w mac filters usage checking in the
> i40e_check_vf_permission() function by counting mac2add_cnt.
> It also improves logging because now all mac addresses will be validated first
> and corresponding messages will be logged.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 19 ++++++++
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 45 ++++++++-----------
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 -
>  4 files changed, 39 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


