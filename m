From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Jul 2017 22:33:22 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 03/11] i40e: prevent
 changing	ITR if adaptive-rx/tx enabled
In-Reply-To: <20170712094614.76501-3-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
 <20170712094614.76501-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB1C20@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, July 12, 2017 2:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S75-V3 03/11] i40e: prevent changing
> ITR if adaptive-rx/tx enabled
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Currently the driver allows the user to change (or even disable) interrupt
> moderation if adaptive-rx/tx is enabled when this should not be the case.
> 
> Adaptive RX/TX will not respect the user's ITR settings so allowing the user to
> change it is weird.  This bug would also allow the user to disable interrupt
> moderation with adaptive-rx/tx enabled which doesn't make much sense
> either.
> 
> This patch makes it such that if adaptive-rx/tx is enabled, the user cannot
> make any manual adjustments to interrupt moderation.  It also makes it so
> that if ITR is disabled but adaptive-rx/tx is then enabled, ITR will be re-
> enabled.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 61 +++++++++++++++++--
> -------
>  1 file changed, 41 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


