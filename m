From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Jul 2017 18:10:35 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 08/13] i40e/i40evf:
	rename	bytes_per_int to bytes_per_usec
In-Reply-To: <20170714131019.52530-8-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB25DF@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S76-V2 08/13] i40e/i40evf: rename
> bytes_per_int to bytes_per_usec
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This value is not calculating bytes_per_int, which would actually just be
> bytes/ITR_COUNTDOWN_START, but rather it's calculating bytes/usecs.
> 
> Rename the variable for clarity so that future developers understand what
> the value is actually calculating.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 12 ++++++------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


