From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Jul 2017 22:50:04 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 05/11] i40e: Store
	the	requested FEC information
In-Reply-To: <20170712094614.76501-5-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
 <20170712094614.76501-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB1C5C@ORSMSX104.amr.corp.intel.com>
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
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S75-V3 05/11] i40e: Store the
> requested FEC information
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> Store information about FEC modes, that were requested. It will be used in
> printing link status information function and this way there is no need to call
> admin queue there.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 1 +
>  3 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


