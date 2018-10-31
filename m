From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 16:27:45 +0000
Subject: [Intel-wired-lan] [next PATCH S98 5/6] i40e: Use correct shift
 for vlan priority
In-Reply-To: <20181026213333.51495-5-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
 <20181026213333.51495-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328FB7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 26, 2018 2:34 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Rodriguez, Richard <richard.rodriguez@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S98 5/6] i40e: Use correct shift for vlan
> priority
> 
> From: Richard Rodriguez <richard.rodriguez@intel.com>
> 
> When using port VLAN, for VFs, and setting priority bits, the device was
> sending out incorrect priority bits, and also setting the CFI bit incorrectly.
> 
> To fix this, changed shift and mask bit definition for this function, to use the
> correct ones.
> 
> Signed-off-by: Richard Rodriguez <richard.rodriguez@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


