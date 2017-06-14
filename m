From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Jun 2017 18:38:24 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 10/13] i40e: fix
	disabling	overflow promiscuous mode
In-Reply-To: <20170607094313.32060-10-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB112@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S72-V3 10/13] i40e: fix disabling
> overflow promiscuous mode
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> There exists a bug in which the driver does not correctly exit overflow
> promiscuous mode.  This can occur if "too many" mac filters are added,
> putting the driver into overflow promiscuous mode, and the filters are then
> removed.  When the failed filters are removed, the driver reports exiting
> overflow promiscuous mode which is correct, however traffic continues to
> be received as if in promiscuous mode still.
> 
> The bug occurs because the conditional for toggling promiscuous mode was
> set to only execute when promiscuous mode was enabled and not when it
> was disabled as well.  This patch fixes the conditional to correctly execute
> when promiscuous mode is toggled and not just enabled.  Without this
> patch, the driver is unable to correctly exit overflow promiscuous mode.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


