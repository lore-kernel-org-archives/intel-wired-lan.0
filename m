From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 20:53:18 +0000
Subject: [Intel-wired-lan] [next PATCH S95 01/12] i40e: Fix VF's link
 state notification
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB2FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:12 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S95 01/12] i40e: Fix VF's link state
> notification
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> This patch moves saving old link status information after the call to
> i40e_get_link_status(). Mentioned function updates both old and the new
> link info, so reading it before results in not notifying VF about the PF link
> state change.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 -----
>  1 file changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


