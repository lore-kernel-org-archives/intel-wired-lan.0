From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jul 2017 19:16:59 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 03/13] i40e: move
	enabling	icr0 into i40e_update_enable_itr
In-Reply-To: <20170714131019.52530-3-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB24C6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 03/13] i40e: move enabling icr0
> into i40e_update_enable_itr
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> If we don't have MSI-X enabled, we handle interrupts on all icr0. This is a
> special case, so let's move the conditional into
> i40e_update_enable_itr() in order to make i40e_napi_poll easier to read
> about.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


