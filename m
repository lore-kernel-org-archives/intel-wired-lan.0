From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 20:48:42 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 09/10] i40e: Enable VF
	to	negotiate number of allocated queues
In-Reply-To: <20170714132709.52657-9-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB27AE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S77-V3 09/10] i40e: Enable VF to
> negotiate number of allocated queues
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Currently the PF allocates a default number of queues for each VF and
> cannot be changed.  This patch enables the VF to request a different number
> of queues allocated to it.  This patch also adds a new virtchnl op and capability
> flag to facilitate this negotiation.
> 
> After the PF receives a request message, it will set a requested number of
> queues for that VF.  Then when the VF resets, its VSI will get a new number
> of queues allocated to it.
> 
> This is a best effort request and since we only allocate a guaranteed default
> number, if the VF tries to ask for more than the guaranteed number, there
> may not be enough in HW to accommodate it unless other queues for other
> VFs are freed. It should also be noted decreasing the number queues
> allocated to a VF to below the default will NOT enable the allocation of more
> than 32 VFs per PF and will not free queues guaranteed to each VF by
> default.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 75
> ++++++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  1 +
>  include/linux/avf/virtchnl.h                       | 20 ++++++
>  4 files changed, 97 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


