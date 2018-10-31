From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 21:37:48 +0000
Subject: [Intel-wired-lan] [next PATCH] i40e: prevent overlapping
 tx_timeout recover
In-Reply-To: <20181029182721.19003-1-alice.michael@intel.com>
References: <20181029182721.19003-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3291C6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, October 29, 2018 11:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH] i40e: prevent overlapping tx_timeout
> recover
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> If a TX hang occurs, we attempt to recover by incrementally resetting.
> If we're starved for CPU time, it's possible the reset doesn't actually
> complete (or even fire) before another tx_timeout fires causing us to fly
> through the different resets without actually doing them.
> 
> This adds a bit to set and check if a timeout recovery is already pending and,
> if so, bail out of tx_timeout.  The bit will get cleared at the end of
> i40e_rebuild when reset is complete.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
>  2 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


