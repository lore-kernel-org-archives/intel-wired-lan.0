From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 31 Aug 2017 19:03:52 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 06/13] i40e/i40evf:
	use	DECLARE_BITMAP for state
In-Reply-To: <20170829093242.41026-6-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9512@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S79-V2 06/13] i40e/i40evf: use
> DECLARE_BITMAP for state
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> When using set_bit and friends, we should be using actual bitmaps, and fix all
> the locations where we might access it.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   | 3 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 3 ++-
>  3 files changed, 6 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


