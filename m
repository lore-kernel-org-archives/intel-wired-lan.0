From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Jun 2017 18:07:28 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 08/13] i40e: genericize
 the	partition bandwidth control
In-Reply-To: <20170607094313.32060-8-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAAB5C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Shannon Nelson <shannon.nelson@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S72-V3 08/13] i40e: genericize the
> partition bandwidth control
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Partition bandwidth control is not in just one form of MFP (multi-function
> partitioning), so make the code more generic and be sure to nudge the Tx
> scheduler for all MFP.
> 
> Copyright updated to 2017.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 13 +++++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 41 ++++++++++++++----------
> -----
>  2 files changed, 26 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


