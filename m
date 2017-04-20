From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Apr 2017 23:01:28 +0000
Subject: [Intel-wired-lan] [next PATCH S71 05/10] i40e: separate PF and
 VSI	state flags
In-Reply-To: <20170419132559.20459-5-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1171@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 05/10] i40e: separate PF and VSI
> state flags
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Avoid using the same named flags for both vsi->state and pf->state. This
> makes code review easier, as it is more likely that future authors will use the
> correct state field when checking bits. Previous commits already found issues
> with at least one check, and possibly others may be incorrect.
> 
> This reduces confusion as it is more clear what each flag represents, and
> which flags are valid for which state field.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h          |  12 ++-
>  drivers/net/ethernet/intel/i40e/i40e_client.c   |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c  |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 104 ++++++++++++---------
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     |   8 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |   8 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |   7 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  10 +--
>  8 files changed, 83 insertions(+), 74 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


